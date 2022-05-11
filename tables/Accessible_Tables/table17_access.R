# Table 17 accessible
#Bulding an accessible version.
# Note that since all Na have been replaced by 0. The NA that represent a lack of data need to be added in

full_t17 <- bind_rows(t17_reg_year, t17_reg_qtr_all)

# Age of Person to be Protected
t17_age_part <- full_t17 %>% transmute(Year = Year,
                       Quarter = replace_na(Quarter, '[z]'),
                       Stage = 'Application',
                       Category = 'Age of person to be protected',
                       `17 or under` = case_when(
                         Year %in% c(2008, 2009) ~ -1,
                         TRUE ~ under_17),
                       
                       `Over 17` = case_when(
                         Year %in% c(2008, 2009) ~ -1,
                         TRUE ~ over_17),
                       
                       `Unknown` = unknown_age,
                       
                       `Person to be protected` = -1,
                       `Relevant 3rd party` = -1,
                       `Other 3rd party` = -1,
                       `Other` = -1,
                       `Total applications made` = -1,
                       `Total cases started` = -1,
                       `Orders made with power of arrest attached` = -1,
                       `Orders made without power of arrest attached` = -1,
                       `Total orders made` = -1,
                       `Other disposals` = -1,
                       `Total disposals` = -1,
                       `Total cases concluded` = -1)

# Applicant type
t17_app_type_part <- full_t17 %>% transmute(Year = Year,
                                       Quarter = replace_na(Quarter, '[z]'),
                                       Stage = 'Application',
                                       Category = 'Applicant type',
                                       `17 or under` = -1,
                                       `Over 17` = -1,
                                       `Unknown` = -1,
                                       `Person to be protected` = case_when(
                                         Year %in% c(2008, 2009) ~ -1,
                                         TRUE ~ ptbp),
                                       `Relevant 3rd party` = case_when(
                                         Year %in% c(2008, 2009) ~ -1,
                                         TRUE ~ rel_third),
                                       `Other 3rd party` = case_when(
                                         Year %in% c(2008, 2009) ~ -1,
                                         TRUE ~ other_third),
                                       `Other` = case_when(
                                         Year %in% c(2008, 2009) ~ -1,
                                         TRUE ~ other),
                                       `Total applications made` = -1,
                                       `Total cases started` = -1,
                                       `Orders made with power of arrest attached` = -1,
                                       `Orders made without power of arrest attached` = -1,
                                       `Total orders made` = -1,
                                       `Other disposals` = -1,
                                       `Total disposals` = -1,
                                       `Total cases concluded` = -1)


# Total Applications Made and Cases started
t17_app_total_part <- full_t17 %>% transmute(Year = Year,
                                            Quarter = replace_na(Quarter, '[z]'),
                                            Stage = 'Application',
                                            Category = 'Total',
                                            `17 or under` = -1,
                                            `Over 17` = -1,
                                            `Unknown` = -1,
                                            `Person to be protected` = -1,
                                            `Relevant 3rd party` = -1,
                                            `Other 3rd party` = -1,
                                            `Other` = -1,
                                            `Total applications made` = total_apps,
                                            `Total cases started` = case_start,
                                            `Orders made with power of arrest attached` = -1,
                                            `Orders made without power of arrest attached` = -1,
                                            `Total orders made` = -1,
                                            `Other disposals` = -1,
                                            `Total disposals` = -1,
                                            `Total cases concluded` = -1)


# Orders made
t17_orders_part <- full_t17 %>% transmute(Year = Year,
                                              Quarter = replace_na(Quarter, '[z]'),
                                              Stage = 'Disposal',
                                              Category = 'Orders Made',
                                              `17 or under` = -1,
                                              `Over 17` = -1,
                                              `Unknown` = -1,
                                              `Person to be protected` = -1,
                                              `Relevant 3rd party` = -1,
                                              `Other 3rd party` = -1,
                                              `Other` = -1,
                                              `Total applications made` = -1,
                                              `Total cases started` = -1,
                                          
                                              `Orders made with power of arrest attached` = case_when(
                                                (Year > 2014) | (Year == 2014 & Quarter %in% c('Q3', 'Q4', '[z]'))  ~ -1,
                                                TRUE ~ ord_poa),
                                          
                                              `Orders made without power of arrest attached` = case_when(
                                                (Year > 2014) | (Year == 2014 & Quarter %in% c('Q3', 'Q4', '[z]'))  ~ -1,
                                                TRUE ~ ord_nopoa),
                                              `Total orders made` = total_ords,
                                              `Other disposals` = other_disps,
                                              `Total disposals` = -1,
                                              `Total cases concluded` = -1)

# Total Disposals Made and Cases concluded
t17_disp_total_part <- full_t17 %>% transmute(Year = Year,
                                             Quarter = replace_na(Quarter, '[z]'),
                                             Stage = 'Disposal',
                                             Category = 'Total',
                                             `17 or under` = -1,
                                             `Over 17` = -1,
                                             `Unknown` = -1,
                                             `Person to be protected` = -1,
                                             `Relevant 3rd party` = -1,
                                             `Other 3rd party` = -1,
                                             `Other` = -1,
                                             `Total applications made` = -1,
                                             `Total cases started` = -1,
                                             `Orders made with power of arrest attached` = -1,
                                             `Orders made without power of arrest attached` = -1,
                                             `Total orders made` = -1,
                                             `Other disposals` = -1,
                                             `Total disposals` = total_disps,
                                             `Total cases concluded` = case_close)



t17_accessible <- bind_rows(t17_age_part, t17_app_type_part, t17_app_total_part,
                            t17_orders_part, t17_disp_total_part)