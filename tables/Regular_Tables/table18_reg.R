#Table 18

#YEAR	QUARTER	TYPE	CATEGORY	SUB_CATEGORYTOTAL
#Adding to have the correct years available

# Annually #################################################
fgm_years <- fgm_csv %>% distinct(Year) %>% filter(Year > 2015)

# Under 17
fgm_under_17_year <- fgm_csv %>% 
  filter(Type == 'Application', Sub_category == '17 or under') %>% 
  group_by(Year) %>% 
  summarise(under_17 = sum_na(Total))

# Over 17
fgm_over_17_year <- fgm_csv %>% 
  filter(Type == 'Application', Sub_category == 'Over 17') %>% 
  group_by(Year) %>% 
  summarise(over_17 = sum_na(Total))

# Unknown
fgm_unknown_age_year <- fgm_csv %>% 
  filter(Type == 'Application', Sub_category == 'Unknown') %>% 
  group_by(Year) %>% 
  summarise(unknown_age = sum_na(Total))

# Person to be protected app type
fgm_ptbp_year <- fgm_csv %>% 
  filter(Type == 'Application', Sub_category == 'Person to be protected') %>% 
  group_by(Year) %>% 
  summarise(ptbp = sum_na(Total))

# Relevant 3rd party
fgm_rel_third_year <- fgm_csv %>% 
  filter(Type == 'Application', Sub_category == 'Relevant 3rd party') %>% 
  group_by(Year) %>% 
  summarise(rel_third = sum_na(Total))

# Other 3rd party
fgm_other_third_year <- fgm_csv %>% 
  filter(Type == 'Application', Sub_category == 'Other 3rd party') %>% 
  group_by(Year) %>% 
  summarise(other_third = sum_na(Total))

# Total Applications made
fgm_apps_year <- fgm_csv %>% 
  filter(Type == 'Application', Category == 'All') %>% 
  group_by(Year) %>% 
  summarise(total_apps = sum_na(Total))

# Total cases started
fgm_case_start_year <- fgm_csv %>% 
  filter(Type == 'Cases started') %>% 
  group_by(Year) %>% 
  summarise(case_start = sum_na(Total))

# Total Orders made
fgm_ords_year <- fgm_csv %>% 
  filter(Type == 'Disposal', Category == 'Order made') %>% 
  group_by(Year) %>% 
  summarise(total_ords = sum_na(Total))

# Other disposals
fgm_other_disp_year <- fgm_csv %>% 
  filter(Type == 'Disposal', Category == 'Other Order') %>% 
  group_by(Year) %>% 
  summarise(other_disps = sum_na(Total))

# All disposals
fgm_all_disp_year <- fgm_csv %>% 
  filter(Type == 'Disposal', Category == 'All') %>% 
  group_by(Year) %>% 
  summarise(total_disps = sum_na(Total))

# Total cases stared
fgm_case_close_year <- fgm_csv %>% 
  filter(Type == 'Cases concluded') %>% 
  group_by(Year) %>% 
  summarise(case_close = sum_na(Total))

# Joining the columns together
fgm_annual_tables <- list(fgm_years, fgm_under_17_year, fgm_over_17_year, fgm_unknown_age_year,
                           fgm_ptbp_year, fgm_rel_third_year, fgm_other_third_year,
                           fgm_apps_year, fgm_case_start_year,
                           fgm_ords_year,
                           fgm_other_disp_year, fgm_all_disp_year, fgm_case_close_year)

fgm_joined_year <- reduce(fgm_annual_tables, left_join, by = 'Year') 

#Creating the regular part of Table 18
t18_reg_year <- fgm_joined_year %>% filter(Year <= annual_year) %>% 
  mutate(Quarter = NA, 
         blank1 = NA,
         blank2 = NA) %>% 
  relocate(Quarter, .after = Year) %>% 
  relocate(blank1, .after = unknown_age) %>% 
  relocate(blank2, .after = case_start) %>% 
  mutate(across(where(is.numeric), ~ replace_na(.x, 0)))

# Quarterly #################################################
fgm_qtrs <- fgm_csv %>% distinct(Year, Quarter) %>% 
  filter(Year > 2015 | (Year == 2015 & Quarter %in% c(3, 4)))

# Under 17
fgm_under_17_qtr <- fgm_csv %>% 
  filter(Type == 'Application', Sub_category == '17 or under') %>% 
  group_by(Year, Quarter) %>% 
  summarise(under_17 = sum_na(Total))

# Over 17
fgm_over_17_qtr <- fgm_csv %>% 
  filter(Type == 'Application', Sub_category == 'Over 17') %>% 
  group_by(Year, Quarter) %>% 
  summarise(over_17 = sum_na(Total))

# Unknown
fgm_unknown_age_qtr <- fgm_csv %>% 
  filter(Type == 'Application', Sub_category == 'Unknown') %>% 
  group_by(Year, Quarter) %>% 
  summarise(unknown_age = sum_na(Total))

# Person to be protected app type
fgm_ptbp_qtr <- fgm_csv %>% 
  filter(Type == 'Application', Sub_category == 'Person to be protected') %>% 
  group_by(Year, Quarter) %>% 
  summarise(ptbp = sum_na(Total))

# Relevant 3rd party
fgm_rel_third_qtr <- fgm_csv %>% 
  filter(Type == 'Application', Sub_category == 'Relevant 3rd party') %>% 
  group_by(Year, Quarter) %>% 
  summarise(rel_third = sum_na(Total))

# Other 3rd party
fgm_other_third_qtr <- fgm_csv %>% 
  filter(Type == 'Application', Sub_category == 'Other 3rd party') %>% 
  group_by(Year, Quarter) %>% 
  summarise(other_third = sum_na(Total))


# Total Applications made
fgm_apps_qtr <- fgm_csv %>% 
  filter(Type == 'Application', Category == 'All') %>% 
  group_by(Year, Quarter) %>% 
  summarise(total_apps = sum_na(Total))

# Total cases started
fgm_case_start_qtr <- fgm_csv %>% 
  filter(Type == 'Cases started') %>% 
  group_by(Year, Quarter) %>% 
  summarise(case_start = sum_na(Total))


# Total Orders made
fgm_ords_qtr <- fgm_csv %>% 
  filter(Type == 'Disposal', Category == 'Order made') %>% 
  group_by(Year, Quarter) %>% 
  summarise(total_ords = sum_na(Total))

# Other disposals
fgm_other_disp_qtr <- fgm_csv %>% 
  filter(Type == 'Disposal', Category == 'Other Order') %>% 
  group_by(Year, Quarter) %>% 
  summarise(other_disps = sum_na(Total))

# All disposals
fgm_all_disp_qtr <- fgm_csv %>% 
  filter(Type == 'Disposal', Category == 'All') %>% 
  group_by(Year, Quarter) %>% 
  summarise(total_disps = sum_na(Total))

# Total cases stared
fgm_case_close_qtr <- fgm_csv %>% 
  filter(Type == 'Cases concluded') %>% 
  group_by(Year, Quarter) %>% 
  summarise(case_close = sum_na(Total))

# Joining the columns together
fgm_qtr_tables <- list(fgm_qtrs, fgm_under_17_qtr, fgm_over_17_qtr, fgm_unknown_age_qtr,
                        fgm_ptbp_qtr, fgm_rel_third_qtr, fgm_other_third_qtr,
                        fgm_apps_qtr, fgm_case_start_qtr,
                        fgm_ords_qtr,
                        fgm_other_disp_qtr, fgm_all_disp_qtr, fgm_case_close_qtr)

fgm_joined_qtr <- reduce(fgm_qtr_tables, left_join, by = c('Year', 'Quarter'))

#Creating the regular part of Table 18. 
# Because the data starts in Q3 2015, it is separated for formatting purposes from the rest of the data
# NAs are replaced with 0 but this will be overwritten later where na remains a genuine lack of data rather than 0
t18_reg_qtr_all <- fgm_joined_qtr %>% 
  mutate(Quarter = paste0('Q', Quarter), 
         blank1 = NA,
         blank2 = NA) %>% 
  relocate(Quarter, .after = Year) %>% 
  relocate(blank1, .after = unknown_age) %>% 
  relocate(blank2, .after = case_start) %>% 
  mutate(across(where(is.numeric), ~ replace_na(.x, 0)))

t18_reg_qtr_a <- t18_reg_qtr_all %>% filter(Year == 2015)
t18_reg_qtr_b <- t18_reg_qtr_all %>% filter(Year != 2015)

# time period
if(pub_quarter==4){
  
  timeperiod18 <- paste0("Annually 2016 - ", pub_year, " and quarterly Q3 2015 - Q", pub_quarter," ", pub_year)
  
} else {
  
  timeperiod18 <- paste0("Annually 2016 - ", pub_year-1, " and quarterly Q3 2015 - Q", pub_quarter," ", pub_year)
}