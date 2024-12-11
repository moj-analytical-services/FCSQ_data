# Table 20 accessible
full_t20 <- bind_rows(t20_reg_year, t20_reg_qtr)

t20_accessible <- full_t20 %>% transmute(Year,
                                         Quarter = replace_na(Quarter, 'Annual'),
                                         `Adoption orders: Adopter - Male/female couple` = m_f_couple,
                                         `Adoption orders: Adopter - Sole applicant` = sole_appl,
                                         `Adoption orders: Adopter - Step parent` = step_parent,
                                         `Adoption orders: Adopter - Same sex couple` = same_sex,
                                         `Adoption orders: Adopter - Other or not stated` = other_adopter,
                                         `Adoption orders: Adopted Child Sex - Male` = male_child,
                                         `Adoption orders: Adopted Child Sex - Female` = female_child,
                                         `Adoption orders: Adopted Child Age - Less than 1 years old` = less_than_one,
                                         `Adoption orders: Adopted Child Age - 1-4 years old` = one_to_four,
                                         `Adoption orders: Adopted Child Age - 5-9 years old` = five_to_nine,
                                         `Adoption orders: Adopted Child Age - 10-14 years old` = ten_to_fourteen,
                                         `Adoption orders: Adopted Child Age - 15-17 years old` = fifteen_to_seventeen,
                                         `Adoption orders: Adopted Child Age - Other` = other_age,
                                         `Adoption orders: Adopted Child Age - Unknown` = unknown_age,
                                         `Adoption orders: Total adoption orders` = total_adopt_ords,
                                         `Non-Adoption orders - Placement orders` = placement_ords,
                                         `Non-Adoption orders - Other orders` = other_orders,
                                         `Other disposals of Adoption and Children Act 2002 cases` = other_disps,
                                         `Total disposals under the Adoption and Children Act 2002` = total_disps,
                                         `Total cases disposed under the Adoption and Children Act 2002` = case_close)
  