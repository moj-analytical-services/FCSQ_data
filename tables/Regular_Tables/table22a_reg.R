#Table 22a

# Quarterly #

dol_case_starts_qtr <- dol_hc_csv %>% 
  filter(Count_type == 'Cases Started') %>% 
  group_by(Year, Quarter) %>% 
  summarise(case_starts = sum_na(Count))

dol_under_12_qtr <- dol_hc_csv %>% 
  filter(Count_type == 'Child_Age', Ageband == '0-12 years') %>% 
  group_by(Year, Quarter) %>% 
  summarise(under_12 = sum_na(Count))

dol_under_15_qtr <- dol_hc_csv %>% 
  filter(Count_type == 'Child_Age', Ageband == '13-15 years') %>% 
  group_by(Year, Quarter) %>% 
  summarise(under_15 = sum_na(Count))

dol_under_18_qtr <- dol_hc_csv %>% 
  filter(Count_type == 'Child_Age', Ageband == '16-18 years') %>% 
  group_by(Year, Quarter) %>% 
  summarise(under_18 = sum_na(Count))

dol_unknown_qtr <- dol_hc_csv %>% 
  filter(Count_type == 'Child_Age', Ageband == 'Unknown') %>% 
  group_by(Year, Quarter) %>% 
  summarise(unknown = sum_na(Count))

dol_total_child_qtr <- dol_hc_csv %>% 
  filter(Count_type == 'Child_Gender') %>% 
  group_by(Year, Quarter) %>% 
  summarise(total_child = sum_na(Count))

dol_applications_qtr <- dol_hc_csv %>% 
  filter(Count_type == 'Applications') %>% 
  group_by(Year, Quarter) %>% 
  summarise(total_apps = sum_na(Count))

# Joining the columns together
dol_tables <- list(dol_case_starts_qtr, dol_under_12_qtr, dol_under_15_qtr, dol_under_18_qtr, dol_unknown_qtr, 
                   dol_total_child_qtr, dol_applications_qtr)

dol_tables_qtr <- reduce(dol_tables, left_join, by = c('Year', 'Quarter'))

t22a_reg_qtr <- dol_tables_qtr %>% 
  mutate(Quarter = paste0('Q', Quarter)) %>% 
  relocate(Quarter, .after = Year) %>%  
  mutate(across(where(is.numeric), ~ replace_na(.x, 0)))

# time period
timeperiod22a <- paste0("Quarterly Q3 2023 - Q", pub_quarter," ", pub_year)
