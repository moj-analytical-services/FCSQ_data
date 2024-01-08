# Table 22a accessible
full_t22a <- t22a_reg_qtr %>% ungroup()

t22a_accessible <- full_t22a %>% transmute(Year,
                                         Quarter = replace_na(Quarter, 'Annual'),
                                         `Cases started` = case_starts,
                                         `Age of child: 0-12 years` = under_12,
                                         `Age of child: 13-15 years` = under_15,
                                         `Age of child: 16-18 years` = under_18,
                                         `Age of child: Unknown` = unknown,
                                         `Total individual children` = total_child,
                                         `Total Applications Made` = total_apps)