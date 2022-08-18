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

t12b_accessible <- new_divorce_app_qtr