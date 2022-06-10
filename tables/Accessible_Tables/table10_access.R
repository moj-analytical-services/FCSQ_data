# Table 10 accessible

#Annual T10, removing Unknown which isn't in the table
t10_accessible_year <- table10_alt %>% filter(Quarter == '') %>% 
  mutate(Quarter = NA) %>% select(!contains('Unknown'))

colnames(t10_accessible_year) <- c('Category',
                                   'Year',
                                   'Quarter',
                                   'Both Applicant and Respondent - Number of Disposals',
                                   'Both Applicant and Respondent - Mean duration in weeks',
                                   'Applicant only - Number of Disposals',
                                   'Applicant only - Mean duration in weeks',
                                   'Respondent only - Number of Disposals',
                                   'Respondent only - Mean duration in weeks',
                                   'Neither Applicant nor Respondent - Number of disposals',
                                   'Neither Applicant nor Respondent - Mean duration in weeks',
                                   'All - Number of disposals',
                                   'All - Mean duration in weeks'
)


#Quarterly T10
t10_accessible_qtr <- table10_alt %>% filter(Quarter != '') %>% select(!contains('Unknown'))

colnames(t10_accessible_qtr) <- c('Category',
                                  'Year',
                                  'Quarter',
                                  'Both Applicant and Respondent - Number of Disposals',
                                  'Both Applicant and Respondent - Mean duration in weeks',
                                  'Applicant only - Number of Disposals',
                                  'Applicant only - Mean duration in weeks',
                                  'Respondent only - Number of Disposals',
                                  'Respondent only - Mean duration in weeks',
                                  'Neither Applicant nor Respondent - Number of disposals',
                                  'Neither Applicant nor Respondent - Mean duration in weeks',
                                  'All - Number of disposals',
                                  'All - Mean duration in weeks'
)

#Binds rows together and rounds all week columns to one decimal place
t10_accessible <- bind_rows(t10_accessible_year, t10_accessible_qtr) %>% arrange(Category) %>% 
   mutate(across(seq(from = 5, to = ncol(.), by = 2), ~ round(.x, 1))) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, na_value)))