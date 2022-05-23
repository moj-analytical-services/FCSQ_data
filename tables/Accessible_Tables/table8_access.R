# Table 8 accessible

full_t8 <- bind_rows(t8_reg_year, t8_reg_qtr)

t8_accessible <- full_t8 %>% transmute(Year = Year,
                                       Quarter,
                                       `Total Disposals` = Number_of_disposals,
                                       `Mean disposal duration (weeks)` = round(Mean_duration, 1),
                                       `Median disposal duration (weeks)` = round(Median_duration, 1),
                                       `Cases disposed in 26 weeks (%)` = round(100 *Disposed_in_26_weeks, 0))