#Accessible T1

#Grouping the data by years and filtering out any years that aren't full
table1_annual_access <- table_1_alt %>% group_by(Category, Year, Stage) %>% summarise(Count = sum(Count)) %>% ungroup() %>% 
  filter(Year > 2005, Year <= annual_year)

#Renaming the categories. Keep the categories in the order they should be in the final table
t1_rename <- c(
  'Public Law' = 'Children Act - Public Law',
  'Private Law' = 'Children Act - Private Law',
  'Matrimonial Matters' = 'Matrimonial Matters',
  'Financial Remedy' = 'Financial remedies',
  'Domestic Violence' = 'Domestic violence remedy orders',
  'Forced Marriage Protection' = 'Forced marriage protection',
  'Female Genital Mutilation' = 'Female genital mutilation protection',
  'Adoption' = 'All Adoption Act',
  'Total'= 'Total cases started'
)

# The two stages are pivoted to separate columns and categories are renamed 
t1_access_annual <- table1_annual_access %>% 
  pivot_wider(names_from = Stage,
  values_from = Count) %>% 
  transmute(Category = str_replace_all(Category, t1_rename),
  Year = Year,
  Quarter = NA,
  `Cases starting`= `Cases started`,
  `Cases reaching a final disposal`= `Cases closed`)


#Doing the same but for quarterly data
table1_quarterly <- table_1_alt %>% 
  filter(Year > 2010) %>% 
  arrange(Year, Quarter)

t1_access_qtr <- table1_quarterly %>% 
  pivot_wider(names_from = Stage,
              values_from = Count) %>% 
  transmute(Category = str_replace_all(Category, t1_rename),
  Year = Year,
  Quarter = paste0('Q', Quarter),
  `Cases starting`= `Cases started`,
  `Cases reaching a final disposal`= `Cases closed`)


#Writing the correct order of categories
lookup_order <- tibble(Category = t1_rename,
                       Order = seq_along(t1_rename))


# Joining the annual and quarterly data into a single table. This is joined by the lookup order table which is used to get the orders correct
t1_accessible <- bind_rows(t1_access_annual, t1_access_qtr) %>% left_join(lookup_order, by = 'Category') %>% 
  arrange(Order) %>% 
  select(!Order)
