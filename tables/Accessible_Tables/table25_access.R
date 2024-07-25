# Table 25 accesible

t25_accessible_a <- probate_timeliness_csv %>% pivot_wider(names_from = Application_type,
                                       values_from = c(Grants_issued, Sub_to_iss_mean, Sub_to_iss_median, Doc_to_iss_mean, Doc_to_iss_median)) %>% 
                                         transmute(Year,
                                                   Quarter,
                                                   `Digital or Paper` = Digital_paper,
                                                   `Stopped or Not Stopped` = str_to_title(Stopped),
                                                   `Probate: Grants issued` = `Grants_issued_Probate`,
                                                   `Probate: Applicant submission to grant issue - Mean weeks` = Sub_to_iss_mean_Probate,
                                                   `Probate: Applicant submission to grant issue - Median weeks` = Sub_to_iss_median_Probate,
                                                   `Probate: Document receipt to grant issue - Mean weeks` = Doc_to_iss_mean_Probate,
                                                   `Probate: Document receipt to grant issue - Median weeks` = Doc_to_iss_median_Probate,
                                                   `Letter of Administration with will annexed: Grants issued` = `Grants_issued_Letter of Administration with will annexed`,
                                                   `Letter of Administration with will annexed: Applicant submission to grant issue - Mean weeks` = `Sub_to_iss_mean_Letter of Administration with will annexed`,
                                                   `Letter of Administration with will annexed: Applicant submission to grant issue - Median weeks` = `Sub_to_iss_median_Letter of Administration with will annexed`,
                                                   `Letter of Administration with will annexed: Document receipt to grant issue - Mean weeks` = `Doc_to_iss_mean_Letter of Administration with will annexed`,
                                                   `Letter of Administration with will annexed: Document receipt to grant issue - Median weeks` = `Doc_to_iss_median_Letter of Administration with will annexed`,
                                                   `Letter of Administration: Grants issued` = `Grants_issued_Letter of Administration`,
                                                   `Letter of Administration: Applicant submission to grant issue - Mean weeks` = `Sub_to_iss_mean_Letter of Administration`,
                                                   `Letter of Administration: Applicant submission to grant issue - Median weeks` = `Sub_to_iss_median_Letter of Administration`,
                                                   `Letter of Administration: Document receipt to grant issue - Mean weeks` = `Doc_to_iss_mean_Letter of Administration`,
                                                   `Letter of Administration: Document receipt to grant issue - Median weeks` = `Doc_to_iss_median_Letter of Administration`,
                                                   `All grants: Grants issued` = `Grants_issued_All grants`,
                                                   `All grants: Applicant submission to grant issue - Mean weeks` = `Sub_to_iss_mean_All grants`,
                                                   `All grants: Applicant submission to grant issue - Median weeks` = `Sub_to_iss_median_All grants`,
                                                   `All grants: Document receipt to grant issue - Mean weeks` = `Doc_to_iss_mean_All grants`,
                                                   `All grants: Document receipt to grant issue - Median weeks` = `Doc_to_iss_median_All grants`,
                                                   
                                                   )

t25_accessible_b <- t25_accessible_a %>% mutate(Quarter = as.character(Quarter)) %>% arrange(Year, Quarter)

t25_accessible_year <- t25_accessible_b %>% filter(Year != 2019, Year <= annual_year, is.na(Quarter))

t25_accessible_qtr <- t25_accessible_b %>% filter(!is.na(Quarter)) %>% 
  mutate(Quarter = paste0('Q', Quarter))


# Accounting for poor data quality and making NA the na_value
t25_accessible_qtr <- t25_accessible_qtr %>% mutate(across(5:18, ~ case_when(Year == 2019 & Quarter == 'Q2' ~ na_value,
                                                       TRUE ~ .x)))

t25_accessible <- bind_rows(t25_accessible_year, t25_accessible_qtr) %>% 
  arrange(`Digital or Paper`, `Stopped or Not Stopped`) %>% 
  mutate(`Digital or Paper` = str_replace(`Digital or Paper`, 'All', 'Digital and Paper'),
         `Stopped or Not Stopped` = str_replace(`Stopped or Not Stopped`, 'All', 'Stopped and Not Stopped')) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, na_value))) %>% 
  mutate(Quarter = replace_na(Quarter, 'Annual'))
  
