# Code to fill in Table 16 - from the CSV

# Import ##########################################################################################

s3tools::download_file_from_s3(glue(paste0(csv_folder, "/DV_National_{pub_year}_Q{pub_quarter}.csv")), paste0(path_to_project,"csvs/dv_csv_national"), overwrite = TRUE)
dv_csv_national <- read_csv(paste0(path_to_project,"csvs/dv_csv_national"))

# Processing ######################################################################################

# annual ########################################

# cases
dv_case_starts_year <- dv_csv_national %>%
  filter(event_type=="Cases started") %>%
  group_by(year) %>%
  summarise(dv_cs=sum(total))

dv_case_disps_year <- dv_csv_national %>%
  filter(event_type=='Cases concluded') %>%
  group_by(year) %>%
  summarise(dv_cd=sum(total))

# applications
dv_apps_all_year <- dv_csv_national %>%
  filter(event_type=='Application') %>%
  group_by(year) %>%
  summarise(dv_a=sum(total))

dv_apps_nmo_year <- dv_csv_national %>%
  filter(event_type=='Application', order_type=='Non-molestation') %>%
  group_by(year) %>%
  summarise(dv_a_nmo=sum(total))

dv_apps_oo_year <- dv_csv_national %>%
  filter(event_type=='Application', order_type=='Occupation') %>%
  group_by(year) %>%
  summarise(dv_a_oo=sum(total))

# orders
dv_ords_all_year <- dv_csv_national %>%
  filter(event_type=='Order') %>%
  group_by(year) %>%
  summarise(dv_o=sum(total))

dv_ords_nmo_year <- dv_csv_national %>%
  filter(event_type=='Order', order_type=='Non-molestation') %>%
  group_by(year) %>%
  summarise(dv_o_nmo=sum(total))

dv_ords_oo_year <- dv_csv_national %>%
  filter(event_type=='Order', order_type=='Occupation') %>%
  group_by(year) %>%
  summarise(dv_o_oo=sum(total))

# combined
dv_year <- 
  dv_apps_nmo_year %>%
  left_join(dv_apps_oo_year, by='year') %>%
  left_join(dv_apps_all_year, by='year') %>%
  left_join(dv_case_starts_year, by='year') %>%
  mutate(blank1=NA) %>%
  left_join(dv_ords_nmo_year, by='year') %>%
  left_join(dv_ords_oo_year, by='year') %>%
  left_join(dv_ords_all_year, by='year') %>%
  left_join(dv_case_disps_year, by='year') %>%
  mutate(quarter=NA) %>%
  relocate(year, quarter)

# quarter #######################################

# cases
dv_case_starts_quarter <- dv_csv_national %>%
  filter(event_type=='Cases started') %>%
  group_by(year, quarter) %>%
  summarise(dv_cs=sum(total))

dv_case_disps_quarter <- dv_csv_national %>%
  filter(event_type=='Cases concluded') %>%
  group_by(year, quarter) %>%
  summarise(dv_cd=sum(total))

# applications
dv_apps_all_quarter <- dv_csv_national %>%
  filter(event_type=='Application') %>%
  group_by(year, quarter) %>%
  summarise(dv_a=sum(total))

dv_apps_nmo_quarter <- dv_csv_national %>%
  filter(event_type=='Application', order_type=='Non-molestation') %>%
  group_by(year, quarter) %>%
  summarise(dv_a_nmo=sum(total))

dv_apps_oo_quarter <- dv_csv_national %>%
  filter(event_type=='Application', order_type=='Occupation') %>%
  group_by(year, quarter) %>%
  summarise(dv_a_oo=sum(total))

# orders
dv_ords_all_quarter <- dv_csv_national %>%
  filter(event_type=='Order') %>%
  group_by(year, quarter) %>%
  summarise(dv_o=sum(total))

dv_ords_nmo_quarter <- dv_csv_national %>%
  filter(event_type=='Order', order_type=='Non-molestation') %>%
  group_by(year, quarter) %>%
  summarise(dv_o_nmo=sum(total))

dv_ords_oo_quarter <- dv_csv_national %>%
  filter(event_type=='Order', order_type=='Occupation') %>%
  group_by(year, quarter) %>%
  summarise(dv_o_oo=sum(total))

# combined
dv_quarter <- 
  dv_apps_nmo_quarter %>%
  left_join(dv_apps_oo_quarter, by=c('year','quarter')) %>%
  left_join(dv_apps_all_quarter, by=c('year','quarter')) %>%
  left_join(dv_case_starts_quarter, by=c('year','quarter')) %>%
  mutate(blank1=NA) %>%
  left_join(dv_ords_nmo_quarter, by=c('year','quarter')) %>%
  left_join(dv_ords_oo_quarter, by=c('year','quarter')) %>%
  left_join(dv_ords_all_quarter, by=c('year','quarter')) %>%
  left_join(dv_case_disps_quarter, by=c('year','quarter')) %>%
  mutate(quarter=paste0("Q", quarter))

# Content #########################################################################################

# time period
if(pub_quarter==4){
  
  timeperiod16 <- paste0("Annually 2003 - ", pub_year, " and quarterly Q1 2009 - Q", pub_quarter," ", pub_year)
  
} else {
  
  timeperiod16 <- paste0("Annually 2003 - ", pub_year-1, " and quarterly Q1 2009 - Q", pub_quarter," ", pub_year)
}

# notes
notes16 <- c("Source:",
             "HMCTS FamilyMan system",
             "",
             "Notes:",
             "1) '-' indicates data not currently available due to data processing issues.",
             "2) A CSV file accompanies this table, which provides data in a machine-readable format that allows a wider range of breakdowns to be produced (including those given in previous publications, for example by ex-party/on notice and whether power of arrest is attached to order). If you require assistance on using this CSV file, please contact the Statistics team using the details provided at the end of the bulletin.",
             "3) For domestic violence cases there is no widely used marker for the conclusion of a case; here cases are considered to be concluded in the quarter of the last definitive order in the case.",
             "4) Some figures may have been revised from previous publications. Minimal changes may be observed in earlier years, whilst larger changes may be seen in more recent quarters.")

# Output ##########################################################################################

# time period
openxlsx::writeData(wb = template,
                    sheet = 'Table_16',
                    x = timeperiod16,
                    startRow = 3,
                    colNames = F)

# data
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_16', 
                      tables = list(dv_year, dv_quarter), 
                      notes = notes16, 
                      starting_row = 14, 
                      quarterly_format = c(2))
