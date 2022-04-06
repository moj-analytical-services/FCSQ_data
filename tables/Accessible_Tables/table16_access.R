# Code to fill in Table 16 - from the CSV

# Import ##########################################################################################


#dv_hard_code_csv <- read_using(readr::read_csv, glue("{csv_folder}DV_Hard_Code.csv")) %>% rename_with(str_to_title)


# Processing ######################################################################################

# annual ########################################

#Hard Code Annual #############


#Regular Annual #############
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
  filter(Type=='Orders applied for', Order_type=='Non-Molestation', Exparte_or_on_notice == 'On Notice') %>%
  group_by(Year) %>%
  summarise(`On Notice Non-Molestation Orders applied for`= sum(Total))

dv_exp_apps_oo_year <- dv_csv %>%
  filter(Type=='Orders applied for', Order_type=='Occupation', Exparte_or_on_notice == 'Exparte') %>%
  group_by(Year) %>%
  summarise(`Exparte Occupation Orders applied for`= sum(Total))

dv_on_apps_oo_year <- dv_csv %>%
  filter(Type=='Orders applied for', Order_type=='Occupation', Exparte_or_on_notice == 'On Notice') %>%
  group_by(Year) %>%
  summarise(`On Notice Occupation Orders applied for`= sum(Total))

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
  summarise(`On Notice Non-Molestation Orders made`= sum(Total))

dv_exp_ords_oo_year <- dv_csv %>%
  filter(Type=='Orders made', Order_type=='Occupation', Exparte_or_on_notice == 'Exparte') %>%
  group_by(Year) %>%
  summarise(`Exparte Occupation Orders made`= sum(Total))

dv_on_ords_oo_year <- dv_csv %>%
  filter(Type=='Orders made', Order_type=='Occupation', Exparte_or_on_notice == 'On Notice') %>%
  group_by(Year) %>%
  summarise(`On Notice Occupation Orders made`= sum(Total))

#list of tables in order
dv_tables <- list(dv_exp_apps_nmo_year, dv_on_apps_nmo_year, dv_exp_apps_oo_year, dv_on_apps_oo_year,
                  dv_apps_all_year, dv_app_event_all_year, dv_case_starts_year,
                  dv_exp_ords_nmo_year, dv_on_ords_nmo_year, dv_exp_ords_oo_year, dv_on_ords_oo_year,
                  dv_ords_all_year, dv_case_disps_year)
# combined
dv_joined_year <- reduce(dv_tables, left_join, by = 'Year')
dv_accessible_year <- dv_joined_year %>% 
  mutate(Quarter = '[z]') %>% 
  relocate(Quarter, .after = Year)
 

# quarter #######################################

# cases
dv_case_starts_qtr <- dv_csv %>%
  filter(Type == "Cases started") %>%
  group_by(Year, Quarter) %>%
  summarise(`Cases started` = sum(Total))

dv_case_disps_qtr <- dv_csv %>%
  filter(Type=='Cases concluded') %>%
  group_by(Year, Quarter) %>%
  summarise(`Cases concluding` = sum(Total))

# applications
dv_apps_all_qtr <- dv_csv %>%
  filter(Type=='Orders applied for') %>%
  group_by(Year, Quarter) %>%
  summarise(`Total Orders applied for` = sum(Total))

dv_app_event_all_qtr <- dv_csv %>%
  filter(Type=='Application events') %>%
  group_by(Year, Quarter) %>%
  summarise(`Applications made` = sum(Total))

dv_exp_apps_nmo_qtr <- dv_csv %>%
  filter(Type=='Orders applied for', Order_type=='Non-Molestation', Exparte_or_on_notice == 'Exparte') %>%
  group_by(Year, Quarter) %>%
  summarise(`Exparte Non-Molestation Orders applied for` = sum(Total))

dv_on_apps_nmo_qtr <- dv_csv %>%
  filter(Type=='Orders applied for', Order_type=='Non-Molestation', Exparte_or_on_notice == 'On Notice') %>%
  group_by(Year, Quarter) %>%
  summarise(`On Notice Non-Molestation Orders applied for`= sum(Total))

dv_exp_apps_oo_qtr <- dv_csv %>%
  filter(Type=='Orders applied for', Order_type=='Occupation', Exparte_or_on_notice == 'Exparte') %>%
  group_by(Year, Quarter) %>%
  summarise(`Exparte Occupation Orders applied for`= sum(Total))

dv_on_apps_oo_qtr <- dv_csv %>%
  filter(Type=='Orders applied for', Order_type=='Occupation', Exparte_or_on_notice == 'On Notice') %>%
  group_by(Year, Quarter) %>%
  summarise(`On Notice Occupation Orders applied for`= sum(Total))

# orders
dv_ords_all_qtr <- dv_csv %>%
  filter(Type=='Orders made') %>%
  group_by(Year, Quarter) %>%
  summarise(`Total Orders made` = sum(Total))

dv_exp_ords_nmo_qtr <- dv_csv %>%
  filter(Type=='Orders made', Order_type=='Non-Molestation', Exparte_or_on_notice == 'Exparte') %>%
  group_by(Year, Quarter) %>%
  summarise(`Exparte Non-Molestation Orders made`= sum(Total))

dv_on_ords_nmo_qtr <- dv_csv %>%
  filter(Type=='Orders made', Order_type=='Non-Molestation', Exparte_or_on_notice == 'On Notice') %>%
  group_by(Year, Quarter) %>%
  summarise(`On Notice Non-Molestation Orders made`= sum(Total))

dv_exp_ords_oo_qtr <- dv_csv %>%
  filter(Type=='Orders made', Order_type=='Occupation', Exparte_or_on_notice == 'Exparte') %>%
  group_by(Year, Quarter) %>%
  summarise(`Exparte Occupation Orders made`= sum(Total))

dv_on_ords_oo_qtr <- dv_csv %>%
  filter(Type=='Orders made', Order_type=='Occupation', Exparte_or_on_notice == 'On Notice') %>%
  group_by(Year, Quarter) %>%
  summarise(`On Notice Occupation Orders made`= sum(Total))

#list of tables in order
dv_tables_qtr <- list(dv_exp_apps_nmo_qtr, dv_on_apps_nmo_qtr, dv_exp_apps_oo_qtr, dv_on_apps_oo_qtr,
                  dv_apps_all_qtr, dv_app_event_all_qtr, dv_case_starts_qtr,
                  dv_exp_ords_nmo_qtr, dv_on_ords_nmo_qtr, dv_exp_ords_oo_qtr, dv_on_ords_oo_qtr,
                  dv_ords_all_qtr, dv_case_disps_qtr)
# combined
dv_joined_qtr <- reduce(dv_tables_qtr, left_join, by = c('Year', 'Quarter'))
dv_accessible_qtr <- dv_joined_qtr %>% 
  mutate(Quarter = paste0('Q', Quarter ))

t16_accessible <- bind_rows(dv_accessible_year, dv_accessible_qtr)
