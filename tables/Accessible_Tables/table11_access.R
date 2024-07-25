# Table 11 accessible

#Annual T11
table11_alt <- table_11_lookup %>% separate(Lookup, c("Case_type", "Year", "Quarter"), sep = '\\|', convert = TRUE)
t11_accessible_year <- table11_alt %>% filter(Quarter == '') %>% 
  mutate(Quarter = NA)

colnames(t11_accessible_year) <- c('Category',
                                   'Year',
                                   'Quarter',
                                   'Total number of cases started',
                                   'Cases with at least one hearing',
                                   'Applicants - represented parties',
                                   'Applicants - unrepresented parties',
                                   'Respondents - represented parties',
                                   'Respondents - unrepresented parties',
                                   'Total number of parties'
                                   )

#Quarterly T11
t11_accessible_qtr <- table11_alt %>% filter(Quarter != '')

colnames(t11_accessible_qtr) <- c('Category',
                                   'Year',
                                   'Quarter',
                                   'Total number of cases started',
                                   'Cases with at least one hearing',
                                   'Applicants - represented parties',
                                   'Applicants - unrepresented parties',
                                   'Respondents - represented parties',
                                   'Respondents - unrepresented parties',
                                   'Total number of parties'
)

t11_accessible <- bind_rows(t11_accessible_year, t11_accessible_qtr) %>% arrange(Category) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, na_value))) %>% 
  mutate(Quarter = replace_na(Quarter, 'Annual'))