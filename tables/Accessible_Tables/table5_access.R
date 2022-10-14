#T5 accessible
full_t5 <- bind_rows(t5_reg_year, t5_reg_qtr)

# Public Law
t5_pub_law <- full_t5 %>% 
  transmute(Category = 'Public law',
            Year = Year,
            Quarter = Qtr,
            `Less than 1 year old` = pub_less_than_one,
            `1-4 years old` = pub_one_to_four,
            `5-9 years old` = pub_five_to_nine,
            `10-14 years old` = pub_ten_to_fourteen,
            `15-17 years old` = pub_fifteen_to_seventeen,
            `Other age` = pub_other_age,
            `Unknown age` = pub_unknown_age,
            `Total individual children` = pub_total_apps)

t5_priv_law <- full_t5 %>% 
  transmute(Category = 'Private law',
            Year = Year,
            Quarter = Qtr,
            `Less than 1 year old` = priv_less_than_one,
            `1-4 years old` = priv_one_to_four,
            `5-9 years old` = priv_five_to_nine,
            `10-14 years old` = priv_ten_to_fourteen,
            `15-17 years old` = priv_fifteen_to_seventeen,
            `Other age` = priv_other_age,
            `Unknown age` = priv_unknown_age,
            `Total individual children` = priv_total_apps)

t5_accessible <- bind_rows(t5_pub_law, t5_priv_law) %>% 
  mutate(Quarter = replace_na(Quarter, 'Annual'))