# Accessible Version of Table 12

divorce_t12_input <- divorce_t12_input %>% arrange(Year, Quarter) %>% 
  filter(Case != 'Judicial Separation' | Quarter < '2023 Q2')


divorce_applications <- divorce_t12_input %>% filter(Stage == 'Petition')
divorce_conditional <- divorce_t12_input %>% filter(Stage == 'Decree Nisi')
divorce_final <- divorce_t12_input %>% filter(Stage %in% c('Decree Absolute', 'Judicial Separations Granted'))


#Applications Annually
divorce_app_year <- divorce_applications %>% filter(Quarter == '') %>%
  transmute(Year,
            Quarter = '',
            `Proceeding Type` = Case,
            `Case Type` = Case_type,
            Law,
            `Applications` = Count) %>% 
  filter(Year > 2002)

# Applications Quarterly
divorce_app_qtr <- divorce_applications %>% filter(Quarter != '') %>% 
  separate(Quarter, c('Year', 'Quarter'), sep = ' ') %>% 
  mutate(Year = as.numeric(Year)) %>%
  transmute(Year,
            Quarter,
            `Proceeding Type` = Case,
            `Case Type` = Case_type,
            Law,
            `Applications` = Count)%>% 
  filter(Year > 2010)

divorce_app <- bind_rows(divorce_app_year, divorce_app_qtr) %>% arrange(`Proceeding Type`, `Case Type`, `Law`)

#Conditional Orders Annually
divorce_cond_year <- divorce_conditional %>% filter(Quarter == '') %>%
  transmute(Year,
            Quarter = '',
            `Proceeding Type` = Case,
            `Case Type` = Case_type,
            Law,
            `Conditional Orders` = Count,
            `Mean time (weeks) to Conditional Order` = Mean_weeks,
            `Median time (weeks) to Conditional Order` = Median_weeks,
            ) %>% 
  filter(Year > 2002)

# Conditional Orders Quarterly
divorce_cond_qtr <- divorce_conditional %>% filter(Quarter != '') %>% 
  separate(Quarter, c('Year', 'Quarter'), sep = ' ') %>% 
  mutate(Year = as.numeric(Year)) %>%
  transmute(Year,
            Quarter,
            `Proceeding Type` = Case,
            `Case Type` = Case_type,
            Law,
            `Conditional Orders` = Count,
            `Mean time (weeks) to Conditional Order` = Mean_weeks,
            `Median time (weeks) to Conditional Order` = Median_weeks,
  )%>% 
  filter(Year > 2010)

divorce_cond <- bind_rows(divorce_cond_year, divorce_cond_qtr) %>% arrange(`Proceeding Type`, `Case Type`, `Law`)

#Final Orders Annually
divorce_final_year <- divorce_final %>% filter(Quarter == '') %>%
  transmute(Year,
            Quarter = '',
            `Proceeding Type` = Case,
            `Case Type` = Case_type,
            Law,
            `Final Orders` = Count,
            `Mean time (weeks) to Final Order` = Mean_weeks,
            `Median time (weeks) to Final Order` = Median_weeks,
  ) %>% 
  filter(Year > 2002)

# Final Orders Quarterly
divorce_final_qtr <- divorce_final %>% filter(Quarter != '') %>% 
  separate(Quarter, c('Year', 'Quarter'), sep = ' ') %>% 
  mutate(Year = as.numeric(Year)) %>%
  transmute(Year,
            Quarter,
            `Proceeding Type` = Case,
            `Case Type` = Case_type,
            Law,
            `Final Orders` = Count,
            `Mean time (weeks) to Final Order` = Mean_weeks,
            `Median time (weeks) to Final Order` = Median_weeks,
  )%>% 
  filter(Year > 2010)

divorce_fin_ord <- bind_rows(divorce_final_year, divorce_final_qtr) %>% arrange(`Proceeding Type`, `Case Type`, `Law`)

# To keep all the quarters in for each year when joining, an extra table is created
t12_all_cats <- divorce_fin_ord %>% distinct(Year, Quarter, `Proceeding Type`, `Case Type`, Law)

# Joining the three stages together
divorce_tables_list <- list(t12_all_cats, divorce_app, divorce_cond, divorce_fin_ord)


t12_accessible_a <- reduce(divorce_tables_list, left_join, by = c('Year', 'Quarter', 'Proceeding Type', 'Case Type', 'Law'))

# Now creating a column for all the proceeding types combined
t12_accessible_b <- t12_accessible_a %>% group_by(Year, Quarter, `Case Type`, Law) %>% 
  summarise(Applications = sum_na(Applications),
            `Conditional Orders` = sum_na(`Conditional Orders`),
            `Final Orders` = sum_na(`Final Orders`)) %>% 
  ungroup() %>% 
  transmute(Year,
            Quarter,
            `Proceeding Type` = 'All',
            `Case Type`,
            Law,
            Applications,
            `Conditional Orders`,
            `Mean time (weeks) to Conditional Order` = na_value,
            `Median time (weeks) to Conditional Order` = na_value,
            `Final Orders`,
            `Mean time (weeks) to Final Order` = na_value,
            `Median time (weeks) to Final Order` = na_value
            )

# Doing some tidying up. Like with regular divorce 0 values are considered not applicable
t12_accessible_c <- bind_rows(t12_accessible_a, filter(t12_accessible_b, Quarter == '', Year > 2002),filter(t12_accessible_b, Quarter != '', Year > 2010))  %>% 
  mutate(`Mean time (weeks) to Conditional Order` = case_when(`Proceeding Type` != 'Divorce' | Year < 2006 ~ na_value,
                                                              TRUE ~ `Mean time (weeks) to Conditional Order`),
         `Median time (weeks) to Conditional Order` = case_when(`Proceeding Type` != 'Divorce' | Year < 2006 ~ na_value,
                                                              TRUE ~ `Median time (weeks) to Conditional Order`),
         `Mean time (weeks) to Final Order` = case_when(`Proceeding Type` != 'Divorce' | Year < 2006 ~ na_value,
                                                              TRUE ~ `Mean time (weeks) to Final Order`),
         `Median time (weeks) to Final Order` = case_when(`Proceeding Type` != 'Divorce' | Year < 2006 ~ na_value,
                                                              TRUE ~ `Median time (weeks) to Final Order`),
         `Conditional Orders` = case_when(`Proceeding Type` == 'Judicial Separation' ~ na_value,
                                          TRUE ~ `Conditional Orders`),
         `Proceeding Type` = factor(`Proceeding Type`, levels = c('Divorce', 'Nullity of Marriage', 'Judicial Separation', 'All'))
         
         
         ) %>%
  mutate(across(where(is.numeric), ~replace_zero(.x, na_value))) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, na_value))) %>% 
  arrange(`Proceeding Type`, `Case Type`, `Law`)


# Creating a column for digital percentages
dig_column <- t12_accessible_c %>% select(1:6) %>% 
  filter(`Proceeding Type` == 'Divorce') %>% 
  pivot_wider(names_from = `Case Type`, values_from = `Applications`) %>% 
  mutate(perc = Digital/All) %>% 
  transmute(Year,
            Quarter,
            `Proceeding Type`,
            `Case Type` = "All",
            Law,
            `Digital percentage` = perc)

# Adding the column to the table
t12_accessible <- t12_accessible_c %>% left_join(dig_column, by = c('Year', 'Quarter', 'Proceeding Type', 'Case Type', 'Law')) %>% 
  mutate(`Proceeding Type` = as.character(`Proceeding Type`),
         `Digital percentage` = replace_na(`Digital percentage`, na_value)) %>% 
  mutate(`Case Type` = str_replace(`Case Type`, 'All', 'Digital and Paper'),
         `Law` = str_replace(`Law`, 'All', 'Old and New'))

# Replacing empty string with Annual
t12_accessible$Quarter[t12_accessible$Quarter == ''] <- 'Annual'
