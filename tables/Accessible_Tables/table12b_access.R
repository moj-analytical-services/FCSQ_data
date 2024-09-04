# Accessible Table 12b - Used for New Divorce

divorce_t12b_input <- divorce_t12b_input %>% arrange(Year, Quarter)

new_divorce_applications <- divorce_t12b_input %>% filter(Stage == 'Application', Main_applicant_gender == 'All')
new_divorce_conditional <- divorce_t12b_input %>% filter(Stage == 'Conditional Order', Main_applicant_gender == 'All')
new_divorce_final <- divorce_t12b_input %>% filter(Stage == 'Final Order', Main_applicant_gender == 'All')

#Applications Annually
new_divorce_app_year <- new_divorce_applications %>% filter(Quarter == '', Year >= 2023) %>%
  transmute(Year,
            Quarter,
            Case,
            `Application Type` = Applicant,
            `Applications` = Count) %>%
  arrange(Case, `Application Type`)

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

new_divorce_app <- bind_rows(new_divorce_app_year, new_divorce_app_qtr)

#Conditional Orders Annually
new_divorce_cond_year <- new_divorce_conditional %>% filter(Quarter == '', Year >= 2023) %>%
  transmute(Year,
            Quarter,
            Case,
            `Application Type` = Applicant,
            `Conditional Orders` = Count,
            `Mean time (weeks) to Conditional Order` = Mean_weeks,
            `Median time (weeks) to Conditional Order` = Median_weeks,
  )


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

new_divorce_cond <- bind_rows(new_divorce_cond_year, new_divorce_cond_qtr)

#Final Orders Annually
new_divorce_final_year <- new_divorce_final %>% filter(Quarter == '', Year >= 2023) %>%
  transmute(Year,
            Quarter,
            Case,
            `Application Type` = Applicant,
            `Final Orders` = Count,
            `Mean time (weeks) to Final Order` = Mean_weeks,
            `Median time (weeks) to Final Order` = Median_weeks,
  )


#Final Orders Quarterly
new_divorce_final_qtr <- new_divorce_final %>% filter(Quarter != '') %>% 
  separate(Quarter, c('Year', 'Quarter'), sep = ' ') %>% 
  mutate(Year = as.numeric(Year)) %>%
  transmute(Year,
            Quarter,
            Case,
            `Application Type` = Applicant,
            `Final Orders` = Count,
            `Mean time (weeks) to Final Order` = Mean_weeks,
            `Median time (weeks) to Final Order` = Median_weeks,
  )

new_divorce_final <- bind_rows(new_divorce_final_year, new_divorce_final_qtr)

# Joining the stages together
new_divorce_tables_list <- list(new_divorce_app, new_divorce_cond, new_divorce_final)

t12b_accessible_a <- reduce(new_divorce_tables_list, left_join, by = c('Year', 'Quarter', 'Case', 'Application Type'))


# Temporarily making Case a factor to order the levels
t12b_accessible_b <- t12b_accessible_a %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, na_value))) %>% 
  mutate(Case = factor(Case, levels = c('Divorce and Civil Partnership', 'Divorce', 'Civil Partnership'))) %>% 
  arrange(Case, `Application Type`)

# Creating a column for digital percentages
sole_column <- t12b_accessible_b %>% select(1:5) %>% 
  pivot_wider(names_from = `Application Type`, values_from = `Applications`) %>% 
  mutate(perc = Sole/All) %>% 
  transmute(Year,
            Quarter,
            Case,
            `Application Type` = "All",
            `Sole percentage` = perc)

t12b_accessible <- t12b_accessible_b %>% left_join(sole_column, by = c('Year', 'Quarter', 'Case', 'Application Type')) %>% 
  mutate(Case = as.character(Case),
         `Sole percentage` = replace_na(`Sole percentage`, na_value))

# Replacing empty string with Annual
t12b_accessible$Quarter[t12b_accessible$Quarter == ''] <- 'Annual'