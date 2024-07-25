# Table 23


# Formatting. Blank columns are converted to logical. Name and Quarters are named
# R restricts columns to only have one data type. * become NA and will have to be added in again as numbers formatted as text can cause issues
t23_data <- opg_table %>% as_tibble() %>% mutate(across(c(5, 8, 12, 22, 24), ~as.logical(.x))) %>% 
  rename(Year = X1, Quarter = X2, blank1 = X5, blank2 = X8, blank3 = X12, blank4 = X22, blank5 = X24, deputyships = X25)


# Replacing with Na with Infinity. These are overwritten with * or [c] when Excel is updated
t23_reg_year <- t23_data %>% filter(is.na(Quarter), Year <= annual_year) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, suppress_value)))

t23_reg_qtr <- t23_data %>% filter(!is.na(Quarter)) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, suppress_value)))

full_t23 <- bind_rows(t23_reg_year, t23_reg_qtr)

if(pub_quarter==4){
  
  timeperiod23 <- paste0("Annually 2008 - ", pub_year, " and quarterly Q1 2008 - Q", pub_quarter," ", pub_year)
  
} else {
  
  timeperiod23 <- paste0("Annually 2008 - ", pub_year-1, " and quarterly Q1 2008 - Q", pub_quarter," ", pub_year)
  
}