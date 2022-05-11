# Table 18 accessible
#Bulding an accessible version.
# Note that since all Na have been replaced by 0. The NA that represent a lack of data need to be added in

full_t18 <- bind_rows(t18_reg_year, t18_reg_qtr_all)

# Age of Person to be Protected
t18_age_part <- full_t18 %>% transmute(Year = Year,
                                       Quarter = replace_na(Quarter, '[z]'),
                                       Stage = 'Application',
                                       Category = 'Age of person to be protected',
                                       `17 or under` = under_17,
                                       
                                       `Over 17` = over_17,
                                       
                                       `Unknown` = unknown_age,
                                       
                                       `Person to be protected` = -1,
                                       `Relevant 3rd party` = -1,
                                       `Other 3rd party` = -1,
                                       `Total applications made` = -1,
                                       `Total cases started` = -1,
                                       `Total orders made` = -1,
                                       `Other disposals` = -1,
                                       `Total disposals` = -1,
                                       `Total cases concluded` = -1)

# Applicant type
t18_app_type_part <- full_t18 %>% transmute(Year = Year,
                                            Quarter = replace_na(Quarter, '[z]'),
                                            Stage = 'Application',
                                            Category = 'Applicant type',
                                            `17 or under` = -1,
                                            `Over 17` = -1,
                                            `Unknown` = -1,
                                            `Person to be protected` = ptbp,
                                            `Relevant 3rd party` = rel_third,
                                            `Other 3rd party` = other_third,
                                            `Total applications made` = -1,
                                            `Total cases started` = -1,
                                            `Total orders made` = -1,
                                            `Other disposals` = -1,
                                            `Total disposals` = -1,
                                            `Total cases concluded` = -1)


# Total Applications Made and Cases started
t18_app_total_part <- full_t18 %>% transmute(Year = Year,
                                             Quarter = replace_na(Quarter, '[z]'),
                                             Stage = 'Application',
                                             Category = 'Total',
                                             `17 or under` = -1,
                                             `Over 17` = -1,
                                             `Unknown` = -1,
                                             `Person to be protected` = -1,
                                             `Relevant 3rd party` = -1,
                                             `Other 3rd party` = -1,
                                             `Total applications made` = total_apps,
                                             `Total cases started` = case_start,
                                             `Total orders made` = -1,
                                             `Other disposals` = -1,
                                             `Total disposals` = -1,
                                             `Total cases concluded` = -1)


# Orders made
t18_orders_part <- full_t18 %>% transmute(Year = Year,
                                          Quarter = replace_na(Quarter, '[z]'),
                                          Stage = 'Disposal',
                                          Category = 'Orders Made',
                                          `17 or under` = -1,
                                          `Over 17` = -1,
                                          `Unknown` = -1,
                                          `Person to be protected` = -1,
                                          `Relevant 3rd party` = -1,
                                          `Other 3rd party` = -1,
                                          `Total applications made` = -1,
                                          `Total cases started` = -1,
                                          `Total orders made` = total_ords,
                                          `Other disposals` = other_disps,
                                          `Total disposals` = -1,
                                          `Total cases concluded` = -1)

# Total Disposals Made and Cases concluded
t18_disp_total_part <- full_t18 %>% transmute(Year = Year,
                                              Quarter = replace_na(Quarter, '[z]'),
                                              Stage = 'Disposal',
                                              Category = 'Total',
                                              `17 or under` = -1,
                                              `Over 17` = -1,
                                              `Unknown` = -1,
                                              `Person to be protected` = -1,
                                              `Relevant 3rd party` = -1,
                                              `Other 3rd party` = -1,
                                              `Total applications made` = -1,
                                              `Total cases started` = -1,
                                              `Total orders made` = -1,
                                              `Other disposals` = -1,
                                              `Total disposals` = total_disps,
                                              `Total cases concluded` = case_close)



t18_accessible <- bind_rows(t18_age_part, t18_app_type_part, t18_app_total_part,
                            t18_orders_part, t18_disp_total_part)