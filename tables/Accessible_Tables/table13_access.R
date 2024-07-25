#Table 13 Accessible

full_t13 <- bind_rows(t13_reg_year, t13_reg_qtr)

t13_accessible <- full_t13 %>% 
  transmute(Year,
            Quarter = replace_na(Quarter, 'Annual'),
            `Divorce cases started` = div_case_start,
            `Cases reaching conditional order to date` = nisi_num,
            `% of divorce cases started reaching conditional order` = nisi_perc,
            `Cases reaching final order to date` = abs_num,
            `% of divorce cases started reaching final order` = abs_perc,
            `Cases reaching a financial remedy application to date` = arapp_num,
            `% of divorce cases started reaching a financial remedy application` = arapp_perc,
            `Cases reaching a financial remedy disposal to date` = arord_num,
            `% of divorce cases started reaching a financial remedy disposal` = arord_perc,
            `Cases reaching a hearing to date` = hearing_num,
            `% of divorce cases started reaching a hearing` = hearing_perc
            ) %>% mutate(`Cases reaching a hearing to date` = case_when((Year == 2022 & Quarter %in% c('Q2', 'Q3', 'Q4', 'Annual')) | (Year > 2022) ~ na_value,
                                             TRUE ~ `Cases reaching a hearing to date`),
                         `% of divorce cases started reaching a hearing` = case_when((Year == 2022 & Quarter %in% c('Q2', 'Q3', 'Q4', 'Annual')) | (Year > 2022) ~ na_value,
                                                                        TRUE ~ `% of divorce cases started reaching a hearing`))
                       