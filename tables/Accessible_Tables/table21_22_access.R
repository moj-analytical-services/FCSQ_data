# Table 21 and 22 accessible

t21_accessible <- t21_all %>% mutate(`Deprivation of Liberty` = case_when(Year == 2008 ~ na_value,
                                                        TRUE ~ `Deprivation of Liberty`)) %>% 
  mutate(Quarter = replace_na(Quarter, 'Annual'))

t22_accessible <- t22_all %>% mutate(`Deprivation of Liberty` = case_when(Year == 2008 ~ na_value,
                                                                          TRUE ~ `Deprivation of Liberty`)) %>% 
  mutate(Quarter = replace_na(Quarter, 'Annual'))