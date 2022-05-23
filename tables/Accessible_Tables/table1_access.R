#Accessible T1

#Grouping the data by years and filtering out any years that aren't full
table1_annual_access <- table_1_alt %>% group_by(Category, Year, Stage) %>% summarise(Count = sum(Count)) %>% ungroup() %>% 
  filter(Year > 2005, Year <= annual_year)

#Renaming the categories
t1_rename <- c(
  'Public Law' = 'Children Act - Public Law',
  'Private Law' = 'Children Act - Private Law',
  'Financial Remedy' = 'Financial remedies',
  'Domestic Violence' = 'Domestic violence remedy orders',
  'Forced Marriage Protection' = 'Forced marriage protection',
  'Female Genital Mutilation' = 'Female genital mutilation protection',
  'Adoption' = 'All Adoption Act',
  'Total'= 'Total cases started'
)

t1_access_annual <- table1_annual_access %>% 
  pivot_wider(names_from = Stage,
  values_from = Count) %>% 
  transmute(Category = str_replace_all(Category, t1_rename),
  Year = Year,
  Quarter = NA,
  `Cases starting`= `Cases started`,
  `Cases reaching a final disposal`= `Cases closed`)


#Doing quarterly version of data
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
lookup_order = tribble(~Category, ~Order,
                       'Children Act - Public Law', 1,
                       'Children Act - Private Law', 2,
                       'Matrinomial Matters', 3,
                       'Financial remedies', 4,
                       'Domestic violence remedy orders', 5,
                       'Forced marriage protection', 6,
                       'Female genital mutilation protection', 7,
                       'All Adoption Act', 8,
                       'Total cases started', 9)

t1_accessible <- bind_rows(t1_access_annual, t1_access_qtr) %>% left_join(lookup_order, by = 'Category') %>% 
  arrange(Order) %>% 
  select(!Order)
