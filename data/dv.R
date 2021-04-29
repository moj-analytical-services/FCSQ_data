# DV

# Contained in a function so that the data doesn't overload R
dv_function <- function(){
  
  # Calling the SQL code for the extracts 
  source(paste0(path_to_project, "dv_sql.R"))
  
  # Applications - table of all applications and whether NMO/OO and Ex-parte/On notice  
  dv_all_apps <- dbtools::read_sql(sql_dv_all_apps)
  
  # Orders - table of all orders and whether NMO/OO, Ex-parte/On notice and with POA/not POA
  dv_all_ords <- dbtools::read_sql(sql_dv_all_ords)
  
  # Cases started  - grouping applications to one entry per case, with the earliest receipt date and the court code from the first application
  dv_case_starts <- case_groups(event_data = dv_all_apps, start_end = 'start')
  
  # Cases disposed - grouping orders to one entry per case, with the latest receipt date and the court code from the latest order
  dv_case_disps <- case_groups(event_data = dv_all_ords, start_end = 'end')
  
  # DV National CSV - group the apps/ords/cases started/cases disposed up and then put them together by year/quarter/order type/notice type/POA
  dv_csv_national <-
    bind_rows(                                                                                       # stacking the separate tables together and adding any columns not currently included
      
      dv_all_apps %>%
        dtplyr::lazy_dt() %>%
        mutate(event_type = 'Application', poa = 'n/a') %>%
        as.data.table(),
      
      dv_all_ords %>%
        dtplyr::lazy_dt() %>%
        mutate(event_type = 'Order') %>%
        as.data.table(),
      
      dv_case_starts %>%
        dtplyr::lazy_dt() %>%
        mutate(event_type = 'Cases started', order_type = 'n/a', notice_type = 'n/a', poa = 'n/a') %>%
        as.data.table(),
      
      dv_case_disps %>%
        dtplyr::lazy_dt() %>%
        mutate(event_type = 'Cases concluded', order_type = 'n/a', notice_type = 'n/a', poa = 'n/a') %>%
        as.data.table()) %>%
    
    dtplyr::lazy_dt() %>%
    group_by(year, quarter, order_type, notice_type,event_type,poa) %>%                             # grouping up by year/quarter/order type/notice type/event type/poa
    summarise(total = n()) %>%                                                                      # creating a count of the number of rows in each group
    relocate(event_type) %>%                                                                        # moving the event_type column to the start
    filter((year != exclude_year | quarter != exclude_quarter) & year > year_cut_off) %>%           # removing the data from the incomplete quarter, and the old data
    filter_all(any_vars(!is.na(.))) %>%                                                             # removing rows with only n/as (dtplyr adds null rows)
    arrange(event_type, year, quarter, order_type, notice_type, poa) %>%                            # reordering the rows
    ungroup() %>%                                                                                   # added to reduce file size
    as.data.table()
  
  # Exporting the Domestic Violence CSV
  if(is_test == FALSE){
    
    write_df_to_csv_in_s3(dv_csv_national_v3, glue("{csv_folder}DV_National_{pub_year}_Q{pub_quarter}.csv"), overwrite = TRUE, row.names = FALSE)
  }
  
  
  # DV component of DFJ CSV - grouping to a start and end entry for each year, quarter and DFJ, with numbers for apps/ords and case starts/ends
  dv_csv_dfj <-
    bind_rows(                                                                                      # stacking the separate tables together and adding any columns not currently included
      
      dv_all_apps %>%
        dtplyr::lazy_dt() %>%
        group_by(year, quarter, court_code) %>%
        summarise(count = n()) %>%
        mutate(stage = 'Start', cases = 0) %>%
        as.data.table(),
      
      dv_all_ords %>%
        dtplyr::lazy_dt() %>%
        group_by(year, quarter, court_code) %>%
        summarise(count = n()) %>%
        mutate(stage = 'End', cases = 0) %>%
        as.data.table(),
      
      dv_case_starts %>%
        dtplyr::lazy_dt() %>%
        group_by(year, quarter, court_code) %>%
        summarise(cases = n()) %>%
        mutate(stage = 'Start', count = 0) %>%
        as.data.table(),
      
      dv_case_disps %>%
        dtplyr::lazy_dt() %>%
        group_by(year, quarter, court_code) %>%
        summarise(cases = n()) %>%
        mutate(stage = 'End', count = 0) %>%
        as.data.table()) %>%
    
    dtplyr::lazy_dt() %>%
    left_join(court_lookup,by=c('court_code'='CODE')) %>%                                          # joining on the court lookup to then get the DFJ and region
    group_by(stage, year, quarter, DFJ_New, Region) %>%                                            # group for one recore per stage/year/quarter/DFJ/Region
    summarise(count = sum(count), cases = sum(cases)) %>%                                          # have a count of individual events and of overall cases
    filter((year != exclude_year | quarter != exclude_quarter) & year > year_cut_off) %>%          # remove unpublished quarter and earlier data
    filter_all(any_vars(!is.na(.))) %>%                                                            # removing rows with only n/as (dtplyr adds null rows)
    mutate(category = 'Domestic Violence') %>%                                                     # add category name
    relocate(category) %>%                                                                         # move category name to the start
    rename(region = Region, dfj = DFJ_New) %>%                                                     # rename columns
    ungroup() %>%                                                                                  # reduces file size
    arrange(year, quarter, region, dfj) %>%                                                        # reorder the rows
    as.data.table()
  
  data.table::fwrite(dv_csv_dfj, paste0(path_to_project, "temp/dv_csv_dfj_temp"))
}

dv_function()