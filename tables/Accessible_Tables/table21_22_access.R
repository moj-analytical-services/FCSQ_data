# Table 21 and 22 accessible

t21_accessible <- t21_all %>% mutate(`Deprivation of Liberty` = case_when(Year == 2008 ~ -1,
                                                        TRUE ~ `Deprivation of Liberty`))

t22_accessible <- t22_all %>% mutate(`Deprivation of Liberty` = case_when(Year == 2008 ~ -1,
                                                                          TRUE ~ `Deprivation of Liberty`))