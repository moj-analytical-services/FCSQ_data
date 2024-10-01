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
                                         `Total Applications Made` = total_apps,
                                         `Total Orders Made` = total_ords,
                                         `Number of orders that have had a final order made` = total_final,
                                         `Length between first order and expiration of final order: 0-3 months` = less_than_3,
                                         `Length between first order and expiration of final order: 3-6 months` = less_than_6,
                                         `Length between first order and expiration of final order: 6-9 months` = less_than_9,
                                         `Length between first order and expiration of final order: 9-12 months` = less_than_12,
                                         `Length between first order and expiration of final order: Over 12 months` = over_12
                                         
                                         )