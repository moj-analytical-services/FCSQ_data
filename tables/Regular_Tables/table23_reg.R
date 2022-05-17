# Table 23


# Formatting. Blank columns are converted to logical. Name and Quarters are named
# R restricts columns to only have one data type. * become NA and will have to be added in again as numbers formatted as text can cause issues
t23_data <- opg_table %>% as_tibble() %>% mutate(across(c(5, 8, 13, 24), ~as.logical(.x))) %>% 
  rename(Year = X1, Quarter = X2, blank1 = X5, blank2 = X8, blank3 = X13, blank4 = X24)

# Deputyship applications Annually
opg_deputyship_year <- opg_csv %>% 
  filter(Category == 'Deputyships appointed') %>% 
  group_by(Year) %>% 
  summarise(deputyships = sum(Count))

# Deputyship applications Quarterly
opg_deputyship_qtr <- opg_csv %>% 
  filter(Category == 'Deputyships appointed') %>% 
  group_by(Year, Quarter) %>% 
  summarise(deputyships = sum(Count))

# Replacing with Na with -1. These are overwritten with * when Excel is updated
t23_reg_year <- t23_data %>% filter(is.na(Quarter)) %>% 
  left_join(opg_deputyship_year, by = 'Year') %>% 
  mutate(blank5 = NA) %>% 
  relocate(blank5, .after = X25) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, -1)))

t23_reg_qtr <- t23_data %>% filter(!is.na(Quarter)) %>% 
  left_join(opg_deputyship_qtr, by = c('Year', 'Quarter')) %>% 
  mutate(blank5 = NA) %>% 
  relocate(blank5, .after = X25) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, -1)))

full_t23 <- bind_rows(t23_reg_year, t23_reg_qtr)

if(pub_quarter==4){
  
  timeperiod23 <- paste0("Annually 2008 - ", pub_year, " and quarterly Q1 2008 - Q", pub_quarter," ", pub_year)
  
} else {
  
  timeperiod23 <- paste0("Annually 2008 - ", pub_year-1, " and quarterly Q1 2008 - Q", pub_quarter," ", pub_year)
  
}