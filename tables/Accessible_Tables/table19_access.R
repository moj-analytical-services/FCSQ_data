# Table 19 accessible
full_t19 <- bind_rows(t19_reg_year, t19_reg_qtr)

t19_accessible <- full_t19 %>% transmute(Year,
                       Quarter = replace_na(Quarter, 'Annual'),
                       `Adoption applications: Adopter - Male/female couple` = m_f_couple,
                       `Adoption applications: Adopter - Sole applicant` = sole_appl,
                       `Adoption applications: Adopter - Step parent` = step_parent,
                       `Adoption applications: Adopter - Same sex couple` = same_sex,
                       `Adoption applications: Adopter - Other or not stated` = other_adopter,
                       `Adoption applications: Total adoption applications` = total_adopt_apps,
                       `Non-Adoption applications - Placement orders` = placement_ords,
                       `Non-Adoption applications - Other orders` = other_orders,
                       `Total applications under the Adoption and Children Act 2002` = total_apps,
                       `Total cases started under the Adoption and Children Act 2002` = case_start)
  