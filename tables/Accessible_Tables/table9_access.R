# Table 9 accessible

full_t9 <- bind_rows(t9_reg_year, t9_reg_qtr)

t9_accessible <- full_t9 %>% transmute(Year = Year,
                      Quarter,
                      `Total cases` = Number_of_disposals,
                      `Mean case duration (weeks)` = Mean_duration,
                      `Median case duration (weeks)` = Median_duration)