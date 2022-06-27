#Table 17

#YEAR	QUARTER	TYPE	CATEGORY	SUB_CATEGORY	POA	TOTAL
#Adding to have the correct years available

# Annually #################################################
fmpo_years <- fmpo_csv %>% distinct(Year) %>% filter(Year > 2008)

# Under 17
fmpo_under_17_year <- fmpo_csv %>% 
  filter(Type == 'Application', Sub_category == '17 or under') %>% 
  group_by(Year) %>% 
  summarise(under_17 = sum_na(Total))

# Over 17
fmpo_over_17_year <- fmpo_csv %>% 
  filter(Type == 'Application', Sub_category == 'Over 17') %>% 
  group_by(Year) %>% 
  summarise(over_17 = sum_na(Total))

# Unknown
fmpo_unknown_age_year <- fmpo_csv %>% 
  filter(Type == 'Application', Sub_category == 'Unknown') %>% 
  group_by(Year) %>% 
  summarise(unknown_age = sum_na(Total))

# Person to be protected app type
fmpo_ptbp_year <- fmpo_csv %>% 
  filter(Type == 'Application', Sub_category == 'Person to be protected') %>% 
  group_by(Year) %>% 
  summarise(ptbp = sum_na(Total))

# Relevant 3rd party
fmpo_rel_third_year <- fmpo_csv %>% 
  filter(Type == 'Application', Sub_category == 'Relevant 3rd party') %>% 
  group_by(Year) %>% 
  summarise(rel_third = sum_na(Total))

# Other 3rd party
fmpo_other_third_year <- fmpo_csv %>% 
  filter(Type == 'Application', Sub_category == 'Other 3rd party') %>% 
  group_by(Year) %>% 
  summarise(other_third = sum_na(Total))

# Other app type
fmpo_other_apps_year <- fmpo_csv %>% 
  filter(Type == 'Application', Sub_category == 'Other') %>% 
  group_by(Year) %>% 
  summarise(other = sum_na(Total))

# Total Applications made
fmpo_apps_year <- fmpo_csv %>% 
  filter(Type == 'Application', Category == 'All') %>% 
  group_by(Year) %>% 
  summarise(total_apps = sum_na(Total))

# Total cases started
fmpo_case_start_year <- fmpo_csv %>% 
  filter(Type == 'Cases started') %>% 
  group_by(Year) %>% 
  summarise(case_start = sum_na(Total))

# Orders made with POA
fmpo_ord_poa_year <- fmpo_csv %>% 
  filter(Type == 'Disposal', Category == 'Order made', Poa == 'Yes') %>% 
  group_by(Year) %>% 
  summarise(ord_poa = sum_na(Total))

# Orders made without POA
fmpo_ord_nopoa_year <- fmpo_csv %>% 
  filter(Type == 'Disposal', Category == 'Order made', Poa == 'No') %>% 
  group_by(Year) %>% 
  summarise(ord_nopoa = sum_na(Total))

# Total Orders made
fmpo_ords_year <- fmpo_csv %>% 
  filter(Type == 'Disposal', Category == 'Order made') %>% 
  group_by(Year) %>% 
  summarise(total_ords = sum_na(Total))

# Other disposals
fmpo_other_disp_year <- fmpo_csv %>% 
  filter(Type == 'Disposal', Category == 'Other Order') %>% 
  group_by(Year) %>% 
  summarise(other_disps = sum_na(Total))

# All disposals
fmpo_all_disp_year <- fmpo_csv %>% 
  filter(Type == 'Disposal', Category == 'All') %>% 
  group_by(Year) %>% 
  summarise(total_disps = sum_na(Total))

# Total cases stared
fmpo_case_close_year <- fmpo_csv %>% 
  filter(Type == 'Cases concluded') %>% 
  group_by(Year) %>% 
  summarise(case_close = sum_na(Total))

# Joining the columns together
fmpo_annual_tables <- list(fmpo_years, fmpo_under_17_year, fmpo_over_17_year, fmpo_unknown_age_year,
                           fmpo_ptbp_year, fmpo_rel_third_year, fmpo_other_third_year, fmpo_other_apps_year,
                           fmpo_apps_year, fmpo_case_start_year,
                           fmpo_ord_poa_year, fmpo_ord_nopoa_year, fmpo_ords_year,
                           fmpo_other_disp_year, fmpo_all_disp_year, fmpo_case_close_year)

fmpo_joined_year <- reduce(fmpo_annual_tables, left_join, by = 'Year') 

#Creating the regular part of Table 17
t17_reg_year <- fmpo_joined_year %>% filter(Year <= annual_year) %>% 
  mutate(Quarter = NA, 
         blank1 = NA,
        blank2 = NA) %>% 
  relocate(Quarter, .after = Year) %>% 
  relocate(blank1, .after = unknown_age) %>% 
  relocate(blank2, .after = case_start) %>% 
  mutate(across(where(is.numeric), ~ replace_na(.x, 0)))

# Quarterly #################################################
fmpo_qtrs <- fmpo_csv %>% distinct(Year, Quarter) %>% 
  filter(Year > 2008 | (Year == 2008 && Quarter == 4))

# Under 17
fmpo_under_17_qtr <- fmpo_csv %>% 
  filter(Type == 'Application', Sub_category == '17 or under') %>% 
  group_by(Year, Quarter) %>% 
  summarise(under_17 = sum_na(Total))

# Over 17
fmpo_over_17_qtr <- fmpo_csv %>% 
  filter(Type == 'Application', Sub_category == 'Over 17') %>% 
  group_by(Year, Quarter) %>% 
  summarise(over_17 = sum_na(Total))

# Unknown
fmpo_unknown_age_qtr <- fmpo_csv %>% 
  filter(Type == 'Application', Sub_category == 'Unknown') %>% 
  group_by(Year, Quarter) %>% 
  summarise(unknown_age = sum_na(Total))

# Person to be protected app type
fmpo_ptbp_qtr <- fmpo_csv %>% 
  filter(Type == 'Application', Sub_category == 'Person to be protected') %>% 
  group_by(Year, Quarter) %>% 
  summarise(ptbp = sum_na(Total))

# Relevant 3rd party
fmpo_rel_third_qtr <- fmpo_csv %>% 
  filter(Type == 'Application', Sub_category == 'Relevant 3rd party') %>% 
  group_by(Year, Quarter) %>% 
  summarise(rel_third = sum_na(Total))

# Other 3rd party
fmpo_other_third_qtr <- fmpo_csv %>% 
  filter(Type == 'Application', Sub_category == 'Other 3rd party') %>% 
  group_by(Year, Quarter) %>% 
  summarise(other_third = sum_na(Total))

# Other app type
fmpo_other_apps_qtr <- fmpo_csv %>% 
  filter(Type == 'Application', Sub_category == 'Other') %>% 
  group_by(Year, Quarter) %>% 
  summarise(other = sum_na(Total))

# Total Applications made
fmpo_apps_qtr <- fmpo_csv %>% 
  filter(Type == 'Application', Category == 'All') %>% 
  group_by(Year, Quarter) %>% 
  summarise(total_apps = sum_na(Total))

# Total cases started
fmpo_case_start_qtr <- fmpo_csv %>% 
  filter(Type == 'Cases started') %>% 
  group_by(Year, Quarter) %>% 
  summarise(case_start = sum_na(Total))

# Orders made with POA
fmpo_ord_poa_qtr <- fmpo_csv %>% 
  filter(Type == 'Disposal', Category == 'Order made', Poa == 'Yes') %>% 
  group_by(Year, Quarter) %>% 
  summarise(ord_poa = sum_na(Total))

# Orders made without POA
fmpo_ord_nopoa_qtr <- fmpo_csv %>% 
  filter(Type == 'Disposal', Category == 'Order made', Poa == 'No') %>% 
  group_by(Year, Quarter) %>% 
  summarise(ord_nopoa = sum_na(Total))

# Total Orders made
fmpo_ords_qtr <- fmpo_csv %>% 
  filter(Type == 'Disposal', Category == 'Order made') %>% 
  group_by(Year, Quarter) %>% 
  summarise(total_ords = sum_na(Total))

# Other disposals
fmpo_other_disp_qtr <- fmpo_csv %>% 
  filter(Type == 'Disposal', Category == 'Other Order') %>% 
  group_by(Year, Quarter) %>% 
  summarise(other_disps = sum_na(Total))

# All disposals
fmpo_all_disp_qtr <- fmpo_csv %>% 
  filter(Type == 'Disposal', Category == 'All') %>% 
  group_by(Year, Quarter) %>% 
  summarise(total_disps = sum_na(Total))

# Total cases stared
fmpo_case_close_qtr <- fmpo_csv %>% 
  filter(Type == 'Cases concluded') %>% 
  group_by(Year, Quarter) %>% 
  summarise(case_close = sum_na(Total))

# Joining the columns together
fmpo_qtr_tables <- list(fmpo_qtrs, fmpo_under_17_qtr, fmpo_over_17_qtr, fmpo_unknown_age_qtr,
                           fmpo_ptbp_qtr, fmpo_rel_third_qtr, fmpo_other_third_qtr, fmpo_other_apps_qtr,
                           fmpo_apps_qtr, fmpo_case_start_qtr,
                           fmpo_ord_poa_qtr, fmpo_ord_nopoa_qtr, fmpo_ords_qtr,
                           fmpo_other_disp_qtr, fmpo_all_disp_qtr, fmpo_case_close_qtr)

fmpo_joined_qtr <- reduce(fmpo_qtr_tables, left_join, by = c('Year', 'Quarter'))

#Creating the regular part of Table 17. 
# Because the data starts in Q4 2008, it is separated for formatting purposes from the rest of the data
# NAs are replaced with 0 but this will be overwritten later where na remains a genuine lack of data rather than 0
t17_reg_qtr_all <- fmpo_joined_qtr %>% 
  mutate(Quarter = paste0('Q', Quarter), 
         blank1 = NA,
         blank2 = NA) %>% 
  relocate(Quarter, .after = Year) %>% 
  relocate(blank1, .after = unknown_age) %>% 
  relocate(blank2, .after = case_start) %>% 
  mutate(across(where(is.numeric), ~ replace_na(.x, 0)))

t17_reg_qtr_a <- t17_reg_qtr_all %>% filter(Year == 2008)
t17_reg_qtr_b <- t17_reg_qtr_all %>% filter(Year != 2008)

# time period
if(pub_quarter==4){
  
  timeperiod17 <- paste0("Annually 2009 - ", pub_year, " and quarterly Q4 2008 - Q", pub_quarter," ", pub_year)
  
} else {
  
  timeperiod17 <- paste0("Annually 2009 - ", pub_year-1, " and quarterly Q4 2008 - Q", pub_quarter," ", pub_year)
}