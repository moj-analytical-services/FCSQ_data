#T2 accessible

#Uses combined tables created in regular version of T2 as a starting point
#Not applicable is replaced with 0 for numeric columns

full_t2 <- bind_rows(t2_reg_year, t2_reg_qtr)

# Public Law
t2_pub_law <- full_t2 %>% 
  transmute(Category = 'Public law',
            Year,
            Quarter = Qtr,
            `Individual children involved in Applications` = pub_ind_child,
            `Applications made` = pub_app_made,
            `Total orders applied for` = pub_ord_appl,
            `Cases starting` = pub_case_start,
            `Orders made` = pub_ord_made,
            `Disposals made` = pub_disp_made,
            `Disposal events` = pub_disp_event,
            `Cases disposed` = pub_case_close)

# Private Law
t2_priv_law <- full_t2 %>% 
  transmute(Category = 'Private law',
            Year,
            Quarter = Qtr,
            `Individual children involved in Applications` = priv_ind_child,
            `Applications made` = priv_app_made,
            `Total orders applied for` = priv_ord_appl,
            `Cases starting` = priv_case_start,
            `Orders made` = priv_ord_made,
            `Disposals made` = priv_disp_made,
            `Disposal events` = priv_disp_event,
            `Cases disposed` = priv_case_close)

#Combining for the final table
t2_accessible <- bind_rows(t2_pub_law, t2_priv_law)