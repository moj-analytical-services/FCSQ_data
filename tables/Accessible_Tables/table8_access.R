# Table 8 accessible

full_t8 <- bind_rows(t8_reg_year, t8_reg_qtr)

#Blocking 2022 data due to CCD issues
t8_accessible <- full_t8 %>% transmute(Year = Year,
                                       Quarter = replace_na(Quarter, 'Annual'),
                                       `Total Disposals` = Number_of_disposals,
                                       `Mean disposal duration (weeks)` = Mean_duration,
                                       `Median disposal duration (weeks)` = Median_duration,
                                       `Cases disposed in 26 weeks` = Disposed_in_26_weeks) %>% 
  mutate(across(3:ncol(.), function(x){
    case_when(Year == 2022 ~ na_value,
              TRUE ~ x)
  }))