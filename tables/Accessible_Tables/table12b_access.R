# Accessible Table 12b - Used for New Divorce

divorce_t12b_input <- divorce_t12b_input %>% arrange(Year, Quarter)

new_divorce_applications <- divorce_t12b_input %>% filter(Stage == 'Application', Main_applicant_gender == 'All')
new_divorce_conditional <- divorce_t12b_input %>% filter(Stage == 'Conditional Order', Main_applicant_gender == 'All')
new_divorce_final <- divorce_t12b_input %>% filter(Stage == 'Final Order', Main_applicant_gender == 'All')

#Applications Quarterly
new_divorce_app_qtr <- new_divorce_applications %>% filter(Quarter != '') %>%
  separate(Quarter, c('Year', 'Quarter'), sep = ' ') %>% 
  mutate(Year = as.numeric(Year)) %>%
  transmute(Year,
            Quarter,
            Case,
            `Application Type` = Applicant,
            `Applications` = Count) %>% 
  arrange(Case, `Application Type`)


#Conditional Orders Quarterly
new_divorce_cond_qtr <- new_divorce_conditional %>% filter(Quarter != '') %>% 
  separate(Quarter, c('Year', 'Quarter'), sep = ' ') %>% 
  mutate(Year = as.numeric(Year)) %>%
  transmute(Year,
            Quarter,
            Case,
            `Application Type` = Applicant,
            `Conditional Orders` = Count,
            `Mean time (weeks) to Conditional Order` = Mean_weeks,
            `Median time (weeks) to Conditional Order` = Median_weeks,
  )

# Joining the stages together
new_divorce_tables_list <- list(new_divorce_app_qtr, new_divorce_cond_qtr)

t12b_accessible_a <- reduce(new_divorce_tables_list, left_join, by = c('Year', 'Quarter', 'Case', 'Application Type'))


t12b_accessible <- t12b_accessible_a %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, na_value))) %>% 
  arrange(Case, `Application Type`)

# Replacing empty string with Annual
t12b_accessible$Quarter[t12b_accessible$Quarter == ''] <- 'Annual'