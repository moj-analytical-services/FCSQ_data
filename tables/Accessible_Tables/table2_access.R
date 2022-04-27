#T2 accessible

#Uses combined tables created in regular version of T2 as a starting point
#Not applicable is replaced with 0 for numeric columns

full_t2 <- bind_rows(t2_reg_year, t2_reg_qtr)

# Public Law Applications
t2_publaw_apps <- full_t2 %>% 
  transmute(Category = 'Public law',
            Stage = 'Applications',
            Year = Year,
            Quarter = replace_na(Qtr, '[z]'),
            `Individual children` = pub_ind_child,
            `Applications made` = pub_app_made,
            `Total orders applied for` = pub_ord_appl,
            `Cases starting` = pub_case_start,
            `Orders made` = -1,
            `Disposals made` = -1,
            `Disposal events` = -1,
            `Cases disposed` = -1)

# Public Law Orders made
t2_publaw_ords <- full_t2 %>% 
  transmute(Category = 'Public law',
            Stage = 'Orders made',
            Year = Year,
            Quarter = replace_na(Qtr, '[z]'),
            `Individual children` = -1,
            `Applications made` = -1,
            `Total orders applied for` = -1,
            `Cases starting` = -1,
            `Orders made` = pub_ord_made,
            `Disposals made` = pub_disp_made,
            `Disposal events` = pub_disp_event,
            `Cases disposed` = pub_case_close)

# Private Law Applications
t2_privlaw_apps <- full_t2 %>% 
  transmute(Category = 'Private law',
            Stage = 'Applications',
            Year = Year,
            Quarter = replace_na(Qtr, '[z]'),
            `Individual children` = priv_ind_child,
            `Applications made` = priv_app_made,
            `Total orders applied for` = priv_ord_appl,
            `Cases starting` = priv_case_start,
            `Orders made` = -1,
            `Disposals made` = -1,
            `Disposal events` = -1,
            `Cases disposed` = -1)

# Private Law Orders made
t2_privlaw_ords <- full_t2 %>% 
  transmute(Category = 'Private law',
            Stage = 'Orders made',
            Year = Year,
            Quarter = replace_na(Qtr, '[z]'),
            `Individual children` = -1,
            `Applications made` = -1,
            `Total orders applied for` = -1,
            `Cases starting` = -1,
            `Orders made` = priv_ord_made,
            `Disposals made` = priv_disp_made,
            `Disposal events` = priv_disp_event,
            `Cases disposed` = priv_case_close)

#Combining for the final table
t2_accessible <- bind_rows(t2_publaw_apps, t2_publaw_ords, t2_privlaw_apps, t2_privlaw_ords)