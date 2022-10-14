#T6 accessible
full_t7 <- bind_rows(t7_reg_year, t7_reg_qtr)

t7_pub_law <- full_t7 %>% 
  transmute(Category = 'Public law',
            Year = Year,
            Quarter = Qtr,
            `Total cases started` = pub_case_start,
            `Total cases started indicated as High Court` = pub_all_hc,
            `High Court cases started in Central London DFJ` = pub_london_hc,
            `High Court cases started outside Central London DFJ` = pub_outside_london_hc
            )

t7_priv_law <- full_t7 %>% 
  transmute(Category = 'Private law',
            Year = Year,
            Quarter = Qtr,
            `Total cases started` = priv_case_start,
            `Total cases started indicated as High Court` = priv_all_hc,
            `High Court cases started in Central London DFJ` = priv_london_hc,
            `High Court cases started outside Central London DFJ` = priv_outside_london_hc
  )

t7_accessible <- bind_rows(t7_pub_law, t7_priv_law) %>% 
  mutate(Quarter = replace_na(Quarter, 'Annual'))