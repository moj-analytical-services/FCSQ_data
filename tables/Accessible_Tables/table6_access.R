#T6 accessible
full_t6 <- bind_rows(t6_reg_year, t6_reg_qtr)

# Public Law
t6_pub_law <- full_t6 %>% 
  transmute(Category = 'Public law',
            Year = Year,
            Quarter = Qtr,
            `Total cases started` = pub_case_start,
            `Number of cases with one applicant` = pub_appl_one,
            `Number of cases with two or more applicants` = pub_appl_two,
            `Number of cases with one respondent` = pub_resp_one,
            `Number of cases with two respondents` = pub_resp_two,
            `Number of cases with three respondents` = pub_resp_three,
            `Number of cases with four or more respondents` = pub_resp_four)

t6_priv_law <- full_t6 %>% 
  transmute(Category = 'Private law',
            Year = Year,
            Quarter = Qtr,
            `Total cases started` = priv_case_start,
            `Number of cases with one applicant` = priv_appl_one,
            `Number of cases with two or more applicants` = priv_appl_two,
            `Number of cases with one respondent` = priv_resp_one,
            `Number of cases with two respondents` = priv_resp_two,
            `Number of cases with three respondents` = priv_resp_three,
            `Number of cases with four or more respondents` = priv_resp_four)

t6_accessible <- bind_rows(t6_pub_law, t6_priv_law)