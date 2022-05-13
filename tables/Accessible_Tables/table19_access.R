# Table 19 accessible
full_t19 <- bind_rows(t19_reg_year, t19_reg_qtr)

t19_accessible <- full_t19 %>% transmute(Year,
                       Quarter,
                       `Adopter - Male/female couple` = m_f_couple,
                       `Adopter - Sole applicant` = sole_appl,
                       `Adopter - Step parent` = step_parent,
                       `Adopter - Same sex couple` = same_sex,
                       `Adopter - Other or not stated` = other_adopter,
                       `Total adoption applications` = total_adopt_apps,
                       `Non Adoption Orders - Placement orders` = placement_ords,
                       `Non Adoption Orders - Other orders` = other_orders,
                       `Total applications under the Adoption and Children Act 2002` = total_apps,
                       `Total cases started under the Adoption and Children Act 2002` = case_start)