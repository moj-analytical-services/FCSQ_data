# Table 17 accessible
#Building an accessible version.
# Note that since all Na have been replaced by 0. The NA that represent a lack of data need to be added in

full_t17 <- bind_rows(t17_reg_year, t17_reg_qtr_all)

t17_accessible <- full_t17 %>% transmute(Year,
                       Quarter = replace_na(Quarter, 'Annual'),
                       `Applications: Age of person to be protected - 17 and under` = case_when(
                         Year %in% c(2008, 2009) ~ na_value,
                         TRUE ~ under_17),
                       `Applications: Age of person to be protected - Over 17` = case_when(
                         Year %in% c(2008, 2009) ~ na_value,
                         TRUE ~ over_17),
                       `Applications: Age of person to be protected - Unknown` = unknown_age,
                       `Applications: Applicant type - Person to be protected` = case_when(
                         Year %in% c(2008, 2009) ~ na_value,
                         TRUE ~ ptbp),
                       `Applications: Applicant type - Relevant 3rd party` = case_when(
                         Year %in% c(2008, 2009) ~ na_value,
                         TRUE ~ rel_third),
                       `Applications: Applicant type - Other 3rd party` = case_when(
                         Year %in% c(2008, 2009) ~ na_value,
                         TRUE ~ other_third),
                       `Applications: Applicant type - Other` = case_when(
                         Year %in% c(2008, 2009) ~ na_value,
                         TRUE ~ other),
                       `Total applications made` = total_apps,
                       `Total cases started` = case_start,
                       `Disposals: Orders made with power of arrest attached` = case_when(
                         (Year > 2014) | (Year == 2014 & (Quarter %in% c('Q3', 'Q4') | is.na(Quarter)))  ~ na_value,
                         TRUE ~ ord_poa),
                       `Disposals: Orders made without power of arrest attached` = case_when(
                         (Year > 2014) | (Year == 2014 & (Quarter %in% c('Q3', 'Q4') | is.na(Quarter)))  ~ na_value,
                         TRUE ~ ord_nopoa),
                       `Disposals: Total orders made` = total_ords,
                       `Disposals: Other disposals` = other_disps,
                       `Total disposals` = total_disps,
                       `Total cases concluded` = case_close)