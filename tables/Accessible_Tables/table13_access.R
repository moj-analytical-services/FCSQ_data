#Table 13 Accessible

full_t13 <- bind_rows(t13_reg_year, t13_reg_qtr)

t13_accessible <- full_t13 %>% 
  transmute(Year,
            Quarter = replace_na(Quarter, 'Annual'),
            `Divorce cases started` = div_case_start,
            `Cases reaching decree nisi to date` = nisi_num,
            `% of divorce cases started reaching decree nisi` = nisi_perc,
            `Cases reaching decree absolute to date` = abs_num,
            `% of divorce cases started reaching decree absolute` = abs_perc,
            `Cases reaching a financial remedy application to date` = arapp_num,
            `% of divorce cases started reaching a financial remedy application` = arapp_perc,
            `Cases reaching a financial remedy disposal to date` = arord_num,
            `% of divorce cases started reaching a financial remedy disposal` = arord_perc,
            `Cases reaching a hearing to date` = hearing_num,
            `% of divorce cases started reaching a hearing` = hearing_perc
            )
