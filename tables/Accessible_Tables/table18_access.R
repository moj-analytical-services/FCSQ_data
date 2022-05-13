# Table 18 accessible
#Bulding an accessible version.
# Note that since all Na have been replaced by 0. The NA that represent a lack of data need to be added in

full_t18 <- bind_rows(t18_reg_year, t18_reg_qtr_all)

t18_accessible <- full_t18 %>% transmute(Year,
                                         Quarter,
                                         `Applications: Age of person to be protected - 17 and under` = under_17,
                                         `Applications: Age of person to be protected - Over 17` = over_17,
                                         `Applications: Age of person to be protected - Unknown` = unknown_age,
                                         `Applications: Applicant type - Person to be protected` = ptbp,
                                         `Applications: Applicant type - Relevant 3rd party` = rel_third,
                                         `Applications: Applicant type - Other 3rd party` = other_third,
                                         `Total applications made` = total_apps,
                                         `Total cases started` = case_start,
                                         `Disposals: Total orders made` = total_ords,
                                         `Disposals: Other disposals` = other_disps,
                                         `Total disposals` = total_disps,
                                         `Total cases concluded` = case_close)

