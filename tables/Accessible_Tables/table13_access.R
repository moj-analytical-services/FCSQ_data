#Table 13 Accessible

full_t13 <- bind_rows(t13_reg_year, t13_reg_qtr)

t13_accessible <- full_t13 %>% 
  transmute(Year,
            Quarter,
            `Divorce cases started` = div_case_start,
            `Cases reaching decree nisi to date` = nisi_num,
            `% of divorce cases started reaching decree nisi` = round(100 * nisi_perc, 1),
            `Cases reaching decree absolute to date` = abs_num,
            `% of divorce cases started reaching decree absolute` = round(100 * abs_perc, 1),
            `Cases reaching a financial remedy application to date` = arapp_num,
            `% of divorce cases started reaching a financial remedy application ` = round(100 * arapp_perc, 1),
            `Cases reaching a financial remedy disposal to date` = arord_num,
            `% of divorce cases started reaching a financial remedy disposal` = round(100 * arord_perc, 1),
            `Cases reaching a hearing to date` = hearing_num,
            `% of divorce cases started reaching a hearing` = round(100 * hearing_perc, 1),
            `Cases reaching an injunction application to date` = injapp_num,
            `% of divorce cases started reaching an injunction application` = round(100 * injapp_perc, 1),
            `Cases reaching an injunction order to date` = injord_num,
            `% of divorce cases started reaching an injunction order` = round(100 * injord_perc, 1)
            )
