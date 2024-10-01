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

dol_total_orders_made_qtr <- dol_hc_csv %>% 
  filter(Count_type == 'Orders') %>% 
  group_by(Year, Quarter) %>% 
  summarise(total_ords = sum_na(Count))

dol_final_orders_made_qtr <- dol_hc_csv %>% 
  filter(Count_type == 'Final Order Made') %>% 
  group_by(Year, Quarter) %>% 
  summarise(total_final = sum_na(Count))

dol_less_than_3_span_qtr <- dol_hc_csv %>% 
  filter(Count_type == 'Final Order Made', Spanband == '0-3 months') %>% 
  group_by(Year, Quarter) %>% 
  summarise(less_than_3 = sum_na(Count))

dol_less_than_6_span_qtr <- dol_hc_csv %>% 
  filter(Count_type == 'Final Order Made', Spanband == '3-6 months') %>% 
  group_by(Year, Quarter) %>% 
  summarise(less_than_6 = sum_na(Count))

dol_less_than_9_span_qtr <- dol_hc_csv %>% 
  filter(Count_type == 'Final Order Made', Spanband == '6-9 months') %>% 
  group_by(Year, Quarter) %>% 
  summarise(less_than_9 = sum_na(Count))

dol_less_than_12_span_qtr <- dol_hc_csv %>% 
  filter(Count_type == 'Final Order Made', Spanband == '9-12 months') %>% 
  group_by(Year, Quarter) %>% 
  summarise(less_than_12 = sum_na(Count))

dol_over_12_span_qtr <- dol_hc_csv %>% 
  filter(Count_type == 'Final Order Made', Spanband == 'Over 12 months') %>% 
  group_by(Year, Quarter) %>% 
  summarise(over_12 = sum_na(Count))
  


# Joining the columns together
dol_tables <- list(dol_case_starts_qtr, dol_under_12_qtr, dol_under_15_qtr, dol_under_18_qtr, dol_unknown_qtr, 
                   dol_total_child_qtr, dol_applications_qtr, 
                   dol_total_orders_made_qtr, dol_final_orders_made_qtr,
                   dol_less_than_3_span_qtr, dol_less_than_6_span_qtr, dol_less_than_9_span_qtr, dol_less_than_12_span_qtr, 
                   dol_over_12_span_qtr)

dol_tables_qtr <- reduce(dol_tables, left_join, by = c('Year', 'Quarter'))

t22a_reg_qtr <- dol_tables_qtr %>% 
  mutate(Quarter = paste0('Q', Quarter), blank1 = NA) %>% 
  relocate(blank1, .after = total_apps) %>% 
  relocate(Quarter, .after = Year) %>%  
  mutate(across(where(is.numeric), ~ replace_na(.x, 0)))

#Splitting data into two for formatting purposes as it doesn't start from full year
t22a_reg_qtr_a <- t22a_reg_qtr %>% filter(Year == 2023)
t22a_reg_qtr_b <- t22a_reg_qtr %>% filter(Year != 2023)


# time period
timeperiod22a <- paste0("Quarterly Q3 2023 - Q", pub_quarter," ", pub_year)
