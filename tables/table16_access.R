# Code to fill in Table 16 - from the CSV

# Import ##########################################################################################

dv_csv <- read_using(readr::read_csv, paste0(csv_folder, "CSV Domestic Violence National", " ", pub_year, " Q", pub_quarter, ".csv"), na = na_keys) %>% rename_with(str_to_title)


# Processing ######################################################################################

# annual ########################################

# cases
dv_case_starts_year <- dv_csv %>%
  filter(Type=="Cases started") %>%
  group_by(Year) %>%
  summarise(`Cases started` =sum(Total))

dv_case_disps_year <- dv_csv %>%
  filter(Type=='Cases concluded') %>%
  group_by(Year) %>%
  summarise(`Cases concluding`= sum(Total))

# applications
dv_apps_all_year <- dv_csv %>%
  filter(Type=='Orders applied for') %>%
  group_by(Year) %>%
  summarise(`Total Orders applied for` = sum(Total))

dv_app_event_all_year <- dv_csv %>%
  filter(Type=='Application events') %>%
  group_by(Year) %>%
  summarise(`Applications made` = sum(Total))

dv_exp_apps_nmo_year <- dv_csv %>%
  filter(Type=='Orders applied for', Order_type=='Non-Molestation', Exparte_or_on_notice == 'Exparte') %>%
  group_by(Year) %>%
  summarise(`Exparte Non-Molestation Orders applied for`= sum(Total))

dv_on_apps_nmo_year <- dv_csv %>%
  filter(Type=='Orders applied for', Order_type=='Non-Molestation', Exparte_or_on_notice == 'On notice') %>%
  group_by(Year) %>%
  summarise(`On notice Non-Molestation Orders applied for`= sum(Total))

dv_exp_apps_oo_year <- dv_csv %>%
  filter(Type=='Orders applied for', Order_type=='Occupation', Exparte_or_on_notice == 'Exparte') %>%
  group_by(Year) %>%
  summarise(`Exparte Occupation Orders applied for`= sum(Total))

dv_on_apps_oo_year <- dv_csv %>%
  filter(Type=='Orders applied for', Order_type=='Occupation', Exparte_or_on_notice == 'On notice') %>%
  group_by(Year) %>%
  summarise(`On notice Occupation Orders applied for`= sum(Total))

# orders
dv_ords_all_year <- dv_csv %>%
  filter(Type=='Orders made') %>%
  group_by(Year) %>%
  summarise(`Total Orders made` = sum(Total))

dv_exp_ords_nmo_year <- dv_csv %>%
  filter(Type=='Orders made', Order_type=='Non-Molestation', Exparte_or_on_notice == 'Exparte') %>%
  group_by(Year) %>%
  summarise(`Exparte Non-Molestation Orders made`= sum(Total))

dv_on_ords_nmo_year <- dv_csv %>%
  filter(Type=='Orders made', Order_type=='Non-Molestation', Exparte_or_on_notice == 'On Notice') %>%
  group_by(Year) %>%
  summarise(`On notice Non-Molestation Orders made`= sum(Total))

dv_exp_ords_oo_year <- dv_csv %>%
  filter(Type=='Orders made', Order_type=='Occupation', Exparte_or_on_notice == 'Exparte') %>%
  group_by(Year) %>%
  summarise(`Exparte Occupation Orders made`= sum(Total))

dv_on_ords_oo_year <- dv_csv %>%
  filter(Type=='Orders made', Order_type=='Occupation', Exparte_or_on_notice == 'On Notice') %>%
  group_by(Year) %>%
  summarise(`On notice Occupation Orders made`= sum(Total))

#list of tables in order
dv_tables <- list(dv_exp_apps_nmo_year, dv_on_apps_nmo_year, dv_exp_apps_oo_year, dv_on_apps_oo_year,
                  dv_apps_all_year, dv_app_event_all_year, dv_case_starts_year,
                  dv_exp_ords_nmo_year, dv_on_ords_nmo_year, dv_exp_ords_oo_year, dv_on_ords_oo_year,
                  dv_ords_all_year, dv_case_disps_year)
# combined
dv_joined_year <- reduce(dv_tables, left_join, by = 'Year')
dv_accessible_year <- dv_joined_year %>% 
  mutate(Qtr = '[z]') %>% 
  relocate(Qtr, .after = Year)
 

# quarter #######################################

# cases
dv_case_starts_year <- dv_csv %>%
  filter(Type=="Cases started") %>%
  group_by(Year) %>%
  summarise(`Cases started` =sum(Total))

dv_case_disps_year <- dv_csv %>%
  filter(Type=='Cases concluded') %>%
  group_by(Year) %>%
  summarise(`Cases concluding`= sum(Total))

# applications
dv_apps_all_year <- dv_csv %>%
  filter(Type=='Orders applied for') %>%
  group_by(Year) %>%
  summarise(`Total Orders applied for` = sum(Total))

dv_app_event_all_year <- dv_csv %>%
  filter(Type=='Application events') %>%
  group_by(Year) %>%
  summarise(`Applications made` = sum(Total))

dv_exp_apps_nmo_year <- dv_csv %>%
  filter(Type=='Orders applied for', Order_type=='Non-Molestation', Exparte_or_on_notice == 'Exparte') %>%
  group_by(Year) %>%
  summarise(`Exparte Non-Molestation Orders applied for`= sum(Total))

dv_on_apps_nmo_year <- dv_csv %>%
  filter(Type=='Orders applied for', Order_type=='Non-Molestation', Exparte_or_on_notice == 'On notice') %>%
  group_by(Year) %>%
  summarise(`On notice Non-Molestation Orders applied for`= sum(Total))

dv_exp_apps_oo_year <- dv_csv %>%
  filter(Type=='Orders applied for', Order_type=='Occupation', Exparte_or_on_notice == 'Exparte') %>%
  group_by(Year) %>%
  summarise(`Exparte Occupation Orders applied for`= sum(Total))

dv_on_apps_oo_year <- dv_csv %>%
  filter(Type=='Orders applied for', Order_type=='Occupation', Exparte_or_on_notice == 'On notice') %>%
  group_by(Year) %>%
  summarise(`On notice Occupation Orders applied for`= sum(Total))

# orders
dv_ords_all_year <- dv_csv %>%
  filter(Type=='Orders made') %>%
  group_by(Year) %>%
  summarise(`Total Orders made` = sum(Total))

dv_exp_ords_nmo_year <- dv_csv %>%
  filter(Type=='Orders made', Order_type=='Non-Molestation', Exparte_or_on_notice == 'Exparte') %>%
  group_by(Year) %>%
  summarise(`Exparte Non-Molestation Orders made`= sum(Total))

dv_on_ords_nmo_year <- dv_csv %>%
  filter(Type=='Orders made', Order_type=='Non-Molestation', Exparte_or_on_notice == 'On Notice') %>%
  group_by(Year) %>%
  summarise(`On notice Non-Molestation Orders made`= sum(Total))

dv_exp_ords_oo_year <- dv_csv %>%
  filter(Type=='Orders made', Order_type=='Occupation', Exparte_or_on_notice == 'Exparte') %>%
  group_by(Year) %>%
  summarise(`Exparte Occupation Orders made`= sum(Total))

dv_on_ords_oo_year <- dv_csv %>%
  filter(Type=='Orders made', Order_type=='Occupation', Exparte_or_on_notice == 'On Notice') %>%
  group_by(Year) %>%
  summarise(`On notice Occupation Orders made`= sum(Total))

#list of tables in order
dv_tables <- list(dv_exp_apps_nmo_year, dv_on_apps_nmo_year, dv_exp_apps_oo_year, dv_on_apps_oo_year,
                  dv_apps_all_year, dv_app_event_all_year, dv_case_starts_year,
                  dv_exp_ords_nmo_year, dv_on_ords_nmo_year, dv_exp_ords_oo_year, dv_on_ords_oo_year,
                  dv_ords_all_year, dv_case_disps_year)
# combined
dv_joined_year <- reduce(dv_tables, left_join, by = 'Year')
dv_accessible_year <- dv_joined_year %>% 
  mutate(Qtr = '[z]') %>% 
  relocate(Qtr, .after = Year)

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
                      starting_row = 15, 
                      quarterly_format = c(2))
