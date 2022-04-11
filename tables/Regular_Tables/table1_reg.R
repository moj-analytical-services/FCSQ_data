#Quarterly Table 1
#Summing up for yearly total
table1_annual <- table_1_alt %>% group_by(Year, Category, Stage) %>% summarise(Count = sum(Count)) %>% ungroup() %>% 
  filter(Year > 2005)

#Pivoting and reordering the columns
table1_pivot_annual <- table1_annual %>%
  pivot_wider(names_from = c(Category, Stage),
              names_sep = ' ',
              values_from = Count) %>% 
  relocate(Year,
           `Public Law Cases started`,
           `Private Law Cases started`,
           `Matrinomial Matters Cases started`,
           `Financial Remedy Cases started`,
           `Domestic Violence Cases started`,
           `Forced Marriage Protection Cases started`,
           `Female Genital Mutilation Cases started`,
           `Adoption Cases started`,
           `Total Cases started`,
           `Public Law Cases closed`,
           `Private Law Cases closed`,
           `Matrinomial Matters Cases closed`,
           `Financial Remedy Cases closed`,
           `Domestic Violence Cases closed`,
           `Forced Marriage Protection Cases closed`,
           `Female Genital Mutilation Cases closed`,
           `Adoption Cases closed`,
           `Total Cases closed`) %>%
  #Tidying up, replacing NA with 0 and adding blank column
  mutate(across(everything(), ~replace_na(.x, 0))) %>% 
  mutate(Quarter = NA, blank1 = NA) %>% 
  relocate(Quarter, .after = Year) %>% 
  relocate(blank1, .after = `Total Cases started`)


#Now doing the same figures for the quarterly version
table1_quarterly <- table_1_alt %>% 
  filter(Year > 2010) %>% 
  arrange(Year, Quarter)

table1_pivot_qtr <- table1_quarterly %>%
  pivot_wider(names_from = c(Category, Stage),
              names_sep = ' ',
              values_from = Count) %>% 
  relocate(Year,
           Quarter,
           `Public Law Cases started`,
           `Private Law Cases started`,
           `Matrinomial Matters Cases started`,
           `Financial Remedy Cases started`,
           `Domestic Violence Cases started`,
           `Forced Marriage Protection Cases started`,
           `Female Genital Mutilation Cases started`,
           `Adoption Cases started`,
           `Total Cases started`,
           `Public Law Cases closed`,
           `Private Law Cases closed`,
           `Matrinomial Matters Cases closed`,
           `Financial Remedy Cases closed`,
           `Domestic Violence Cases closed`,
           `Forced Marriage Protection Cases closed`,
           `Female Genital Mutilation Cases closed`,
           `Adoption Cases closed`,
           `Total Cases closed`) %>%
  #Tidying up, replacing NA with 0 and adding blank column
  mutate(across(everything(), ~replace_na(.x, 0))) %>% 
  mutate(Quarter = paste0('Q', Quarter), blank1 = NA) %>% 
  relocate(blank1, .after = `Total Cases started`)

# Content #########################################################################################

# time period
if(pub_quarter==4){
  
  timeperiod1 <- paste0("Annually 2006 - ", pub_year, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
  
} else {
  
  timeperiod1 <- paste0("Annually 2006 - ", pub_year-1, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
}