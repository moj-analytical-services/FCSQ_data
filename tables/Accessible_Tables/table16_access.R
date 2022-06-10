# Code to fill in Table 16 - from the CSV

# Import ##########################################################################################

#Tidying the hard code data. Dashes are replaced with na_value and everybody except Year and Quarter made numeric.
# Removing Quarter column used in Excel
dv_hard_full <- dv_hard_code_csv %>% filter(!is.na(Year)) %>% 
  mutate(across(c(7, 12), ~ str_replace(.x, "-", as.character(na_value)))) %>% 
  mutate(across(c(4:12), ~ as.numeric(.x)))
  
colnames(dv_hard_full) <- c('num_quarter', 
                            'Year',
                            'Quarter',
                            'Non-Molestation Orders applied for',
                            'Occupation Orders applied for',
                            'Orders applied for',
                            'Cases started',
                            'blank',
                            'Non-Molestation Orders made',
                            'Occupation Orders made',
                            'Orders made',
                            'Cases concluding'
                            )

# Hard coded annual section
dv_hard_annual_part <- dv_hard_full %>% filter(is.na(Quarter)) %>% transmute(Year = Year,
                                 Quarter = NA,
                                 `Application Type` = 'All',
                                 `Non-Molestation Orders applied for`,
                                 `Occupation Orders applied for`,
                                 `Orders applied for`,
                                 `Applications made` = na_value,
                                 `Cases started` = na_value,
                                 `Non-Molestation Orders made`,
                                 `Occupation Orders made`,
                                 `Orders made`,
                                 `Cases concluding`)

#Hard coded quarterly section
dv_hard_qtr_part <- dv_hard_full %>% filter(!is.na(Quarter)) %>% 
  transmute(Year,
           Quarter,
          `Application Type` = 'All',
          `Non-Molestation Orders applied for`,
           `Occupation Orders applied for`,
          `Orders applied for`,
           `Applications made` = na_value,
           `Cases started` = na_value,
           `Non-Molestation Orders made`,
           `Occupation Orders made`,
          `Orders made`,
          `Cases concluding`)
  
# Processing ######################################################################################

# annual ########################################


#Regular Annual #############

# Exparte Non Molestation Applications
dv_exp_apps_nmo_year <- dv_csv %>%
  filter(Type == 'Orders applied for', Order_type == 'Non-Molestation', Exparte_or_on_notice == 'Exparte') %>%
  group_by(Year) %>%
  summarise(`Exparte Non-Molestation Orders applied for`= sum(Total))

# On notice Non Molestation Applications
dv_on_apps_nmo_year <- dv_csv %>%
  filter(Type == 'Orders applied for', Order_type == 'Non-Molestation', Exparte_or_on_notice == 'On Notice') %>%
  group_by(Year) %>%
  summarise(`On Notice Non-Molestation Orders applied for`= sum(Total))

# All Non Molestation Applications
dv_apps_nmo_year <- dv_csv %>%
  filter(Type == 'Orders applied for', Order_type == 'Non-Molestation') %>%
  group_by(Year) %>%
  summarise(`Total Non-Molestation Orders applied for`= sum(Total))

# Exparte Occupation Applications
dv_exp_apps_oo_year <- dv_csv %>%
  filter(Type == 'Orders applied for', Order_type == 'Occupation', Exparte_or_on_notice == 'Exparte') %>%
  group_by(Year) %>%
  summarise(`Exparte Occupation Orders applied for`= sum(Total))

# On Notice Occupation Applications
dv_on_apps_oo_year <- dv_csv %>%
  filter(Type == 'Orders applied for', Order_type == 'Occupation', Exparte_or_on_notice == 'On Notice') %>%
  group_by(Year) %>%
  summarise(`On Notice Occupation Orders applied for`= sum(Total))

# All Occupation Applications
dv_apps_oo_year <- dv_csv %>%
  filter(Type == 'Orders applied for', Order_type == 'Occupation') %>%
  group_by(Year) %>%
  summarise(`Total Occupation Orders applied for`= sum(Total))

# All Orders applied for
dv_apps_all_year <- dv_csv %>%
  filter(Type == 'Orders applied for') %>%
  group_by(Year) %>%
  summarise(`Total Orders applied for` = sum(Total))

# All Applications made
dv_app_event_all_year <- dv_csv %>%
  filter(Type == 'Application events') %>%
  group_by(Year) %>%
  summarise(`Applications made` = sum(Total))

# cases started
dv_case_starts_year <- dv_csv %>%
  filter(Type == "Cases started") %>%
  group_by(Year) %>%
  summarise(`Cases started` = sum(Total))

# orders

# Exparte Non Molestation Orders
dv_exp_ords_nmo_year <- dv_csv %>%
  filter(Type == 'Orders made', Order_type == 'Non-Molestation', Exparte_or_on_notice == 'Exparte') %>%
  group_by(Year) %>%
  summarise(`Exparte Non-Molestation Orders made`= sum(Total))

# On Notice Non Molestation Orders
dv_on_ords_nmo_year <- dv_csv %>%
  filter(Type == 'Orders made', Order_type == 'Non-Molestation', Exparte_or_on_notice == 'On Notice') %>%
  group_by(Year) %>%
  summarise(`On Notice Non-Molestation Orders made`= sum(Total))

# All Non Molestation Orders
dv_ords_nmo_year <- dv_csv %>%
  filter(Type == 'Orders made', Order_type == 'Non-Molestation') %>%
  group_by(Year) %>%
  summarise(`Total Non-Molestation Orders made`= sum(Total))

# Exparte Occupation Orders
dv_exp_ords_oo_year <- dv_csv %>%
  filter(Type == 'Orders made', Order_type == 'Occupation', Exparte_or_on_notice == 'Exparte') %>%
  group_by(Year) %>%
  summarise(`Exparte Occupation Orders made`= sum(Total))

# On Notice Occupation Orders
dv_on_ords_oo_year <- dv_csv %>%
  filter(Type == 'Orders made', Order_type == 'Occupation', Exparte_or_on_notice == 'On Notice') %>%
  group_by(Year) %>%
  summarise(`On Notice Occupation Orders made`= sum(Total))

# All Occupation Orders
dv_ords_oo_year <- dv_csv %>%
  filter(Type == 'Orders made', Order_type == 'Occupation') %>%
  group_by(Year) %>%
  summarise(`Total Occupation Orders made`= sum(Total))

# All Orders made
dv_ords_all_year <- dv_csv %>%
  filter(Type == 'Orders made') %>%
  group_by(Year) %>%
  summarise(`Total Orders made` = sum(Total))

# Cases Closed
dv_case_disps_year <- dv_csv %>%
  filter(Type == 'Cases concluded') %>%
  group_by(Year) %>%
  summarise(`Cases concluding`= sum(Total))

#list of tables in order
dv_tables <- list(dv_exp_apps_nmo_year, dv_on_apps_nmo_year, dv_apps_nmo_year, 
                  dv_exp_apps_oo_year, dv_on_apps_oo_year, dv_apps_oo_year,
                  dv_apps_all_year, dv_app_event_all_year, dv_case_starts_year,
                  dv_exp_ords_nmo_year, dv_on_ords_nmo_year, dv_ords_nmo_year,
                  dv_exp_ords_oo_year, dv_on_ords_oo_year, dv_ords_oo_year,
                  dv_ords_all_year, dv_case_disps_year)
# combined
dv_joined_year <- reduce(dv_tables, left_join, by = 'Year')
dv_accessible_year <- dv_joined_year %>%
  filter(Year <= annual_year) %>% 
  mutate(Quarter = NA) %>% 
  relocate(Quarter, .after = Year)
 

# quarter #######################################

# Exparte Non Molestation Applications
dv_exp_apps_nmo_qtr <- dv_csv %>%
  filter(Type == 'Orders applied for', Order_type == 'Non-Molestation', Exparte_or_on_notice == 'Exparte') %>%
  group_by(Year, Quarter) %>%
  summarise(`Exparte Non-Molestation Orders applied for`= sum(Total))

# On notice Non Molestation Applications
dv_on_apps_nmo_qtr <- dv_csv %>%
  filter(Type == 'Orders applied for', Order_type == 'Non-Molestation', Exparte_or_on_notice == 'On Notice') %>%
  group_by(Year, Quarter) %>%
  summarise(`On Notice Non-Molestation Orders applied for`= sum(Total))

# All Non Molestation Applications
dv_apps_nmo_qtr <- dv_csv %>%
  filter(Type == 'Orders applied for', Order_type == 'Non-Molestation') %>%
  group_by(Year, Quarter) %>%
  summarise(`Total Non-Molestation Orders applied for`= sum(Total))

# Exparte Occupation Applications
dv_exp_apps_oo_qtr <- dv_csv %>%
  filter(Type == 'Orders applied for', Order_type == 'Occupation', Exparte_or_on_notice == 'Exparte') %>%
  group_by(Year, Quarter) %>%
  summarise(`Exparte Occupation Orders applied for`= sum(Total))

# On Notice Occupation Applications
dv_on_apps_oo_qtr <- dv_csv %>%
  filter(Type == 'Orders applied for', Order_type == 'Occupation', Exparte_or_on_notice == 'On Notice') %>%
  group_by(Year, Quarter) %>%
  summarise(`On Notice Occupation Orders applied for`= sum(Total))

# All Occupation Applications
dv_apps_oo_qtr <- dv_csv %>%
  filter(Type == 'Orders applied for', Order_type == 'Occupation') %>%
  group_by(Year, Quarter) %>%
  summarise(`Total Occupation Orders applied for`= sum(Total))

# All Orders applied for
dv_apps_all_qtr <- dv_csv %>%
  filter(Type == 'Orders applied for') %>%
  group_by(Year, Quarter) %>%
  summarise(`Total Orders applied for` = sum(Total))

# All Applications made
dv_app_event_all_qtr <- dv_csv %>%
  filter(Type == 'Application events') %>%
  group_by(Year, Quarter) %>%
  summarise(`Applications made` = sum(Total))

# cases started
dv_case_starts_qtr <- dv_csv %>%
  filter(Type == "Cases started") %>%
  group_by(Year, Quarter) %>%
  summarise(`Cases started` = sum(Total))

# orders

# Exparte Non Molestation Orders
dv_exp_ords_nmo_qtr <- dv_csv %>%
  filter(Type == 'Orders made', Order_type == 'Non-Molestation', Exparte_or_on_notice == 'Exparte') %>%
  group_by(Year, Quarter) %>%
  summarise(`Exparte Non-Molestation Orders made`= sum(Total))

# On Notice Non Molestation Orders
dv_on_ords_nmo_qtr <- dv_csv %>%
  filter(Type == 'Orders made', Order_type == 'Non-Molestation', Exparte_or_on_notice == 'On Notice') %>%
  group_by(Year, Quarter) %>%
  summarise(`On Notice Non-Molestation Orders made`= sum(Total))

# All Non Molestation Orders
dv_ords_nmo_qtr <- dv_csv %>%
  filter(Type == 'Orders made', Order_type == 'Non-Molestation') %>%
  group_by(Year, Quarter) %>%
  summarise(`Total Non-Molestation Orders made`= sum(Total))

# Exparte Occupation Orders
dv_exp_ords_oo_qtr <- dv_csv %>%
  filter(Type == 'Orders made', Order_type == 'Occupation', Exparte_or_on_notice == 'Exparte') %>%
  group_by(Year, Quarter) %>%
  summarise(`Exparte Occupation Orders made`= sum(Total))

# On Notice Occupation Orders
dv_on_ords_oo_qtr <- dv_csv %>%
  filter(Type == 'Orders made', Order_type == 'Occupation', Exparte_or_on_notice == 'On Notice') %>%
  group_by(Year, Quarter) %>%
  summarise(`On Notice Occupation Orders made`= sum(Total))

# All Occupation Orders
dv_ords_oo_qtr <- dv_csv %>%
  filter(Type == 'Orders made', Order_type == 'Occupation') %>%
  group_by(Year, Quarter) %>%
  summarise(`Total Occupation Orders made`= sum(Total))

# All Orders made
dv_ords_all_qtr <- dv_csv %>%
  filter(Type == 'Orders made') %>%
  group_by(Year, Quarter) %>%
  summarise(`Total Orders made` = sum(Total))

# Cases Closed
dv_case_disps_qtr <- dv_csv %>%
  filter(Type == 'Cases concluded') %>%
  group_by(Year, Quarter) %>%
  summarise(`Cases concluding`= sum(Total))

#list of tables in order
dv_qtr_tables <- list(dv_exp_apps_nmo_qtr, dv_on_apps_nmo_qtr, dv_apps_nmo_qtr, 
                  dv_exp_apps_oo_qtr, dv_on_apps_oo_qtr, dv_apps_oo_qtr,
                  dv_apps_all_qtr, dv_app_event_all_qtr, dv_case_starts_qtr,
                  dv_exp_ords_nmo_qtr, dv_on_ords_nmo_qtr, dv_ords_nmo_qtr,
                  dv_exp_ords_oo_qtr, dv_on_ords_oo_qtr, dv_ords_oo_qtr,
                  dv_ords_all_qtr, dv_case_disps_qtr)


# combined
dv_joined_qtr <- reduce(dv_qtr_tables, left_join, by = c('Year', 'Quarter'))
dv_accessible_qtr <- dv_joined_qtr %>% 
  mutate(Quarter = paste0('Q', Quarter ))

full_t16 <- bind_rows(dv_accessible_year, dv_accessible_qtr)


# Formatting

t16_exparte_part <- full_t16 %>% transmute(Year = Year,
                       Quarter = Quarter,
                       `Application Type` = 'Exparte',
                       `Non-Molestation Orders applied for` = `Exparte Non-Molestation Orders applied for`,
                       `Occupation Orders applied for` = `Exparte Occupation Orders applied for`,
                       `Orders applied for` = `Non-Molestation Orders applied for` + `Occupation Orders applied for`,
                       `Applications made` = na_value,
                       `Cases started` = na_value,
                       `Non-Molestation Orders made` = `Exparte Non-Molestation Orders made`,
                       `Occupation Orders made` = `Exparte Occupation Orders made`,
                       `Orders made` = `Non-Molestation Orders made` + `Occupation Orders made`,
                       `Cases concluding` = na_value)

t16_onnotice_part <- full_t16 %>% transmute(Year = Year,
                                           Quarter = Quarter,
                                           `Application Type` = 'On Notice',
                                           `Non-Molestation Orders applied for` = `On Notice Non-Molestation Orders applied for`,
                                           `Occupation Orders applied for` = `On Notice Occupation Orders applied for`,
                                           `Orders applied for` = `Non-Molestation Orders applied for` + `Occupation Orders applied for`,
                                           `Applications made` = na_value,
                                           `Cases started` = na_value,
                                           `Non-Molestation Orders made` = `On Notice Non-Molestation Orders made`,
                                           `Occupation Orders made` = `On Notice Occupation Orders made`,
                                           `Orders made` = `Non-Molestation Orders made` + `Occupation Orders made`,
                                           `Cases concluding` = na_value)

t16_all_part <- full_t16 %>% transmute(Year = Year,
                                       Quarter = Quarter,
                                       `Application Type` = 'All',
                                       `Non-Molestation Orders applied for` = `Total Non-Molestation Orders applied for`,
                                       `Occupation Orders applied for` = `Total Occupation Orders applied for`,
                                       `Orders applied for` = `Non-Molestation Orders applied for` + `Occupation Orders applied for`,
                                       `Applications made`,
                                       `Cases started`,
                                       `Non-Molestation Orders made` = `Total Non-Molestation Orders made`,
                                       `Occupation Orders made` = `Total Occupation Orders made`,
                                       `Orders made` = `Non-Molestation Orders made` + `Occupation Orders made`,
                                       `Cases concluding`)

#Combining with the earlier hard coded data
t16_complete_all_part <- bind_rows(dv_hard_annual_part, t16_all_part %>% filter(is.na(Quarter)), 
                                   dv_hard_qtr_part, t16_all_part %>% filter(!is.na(Quarter)))

t16_accessible <- bind_rows(t16_complete_all_part, t16_exparte_part, t16_onnotice_part)