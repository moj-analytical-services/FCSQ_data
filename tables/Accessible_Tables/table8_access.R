# Table 8 accessible

full_t8 <- bind_rows(t8_reg_year, t8_reg_qtr)

t8_accessible <- full_t8 %>% transmute(Year = Year,
                                       Quarter = replace_na(Quarter, 'Annual'),
                                       `Total Disposals` = Number_of_disposals,
                                       `Mean disposal duration (weeks)` = Mean_duration,
                                       `Median disposal duration (weeks)` = Median_duration,
                                       `Cases disposed in 26 weeks` = Disposed_in_26_weeks)