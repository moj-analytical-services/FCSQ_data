#Annual T10b, removing Unknown which isn't in the table
table10b_alt <- table_10b_lookup %>% separate(Lookup, c("Case_type", "Year", "Quarter"), sep = '\\|', convert = TRUE)

# t10b_accessible_year <- table10b_alt %>% filter(Quarter == '') %>% 
#   mutate(Quarter = NA) %>% select(!contains('Unknown'))
# 
# colnames(t10b_accessible_year) <- c('Category',
#                                    'Year',
#                                    'Quarter',
#                                    'Both Applicant and Respondent - Number of Disposals',
#                                    'Both Applicant and Respondent - Mean duration in weeks',
#                                    'Applicant only - Number of Disposals',
#                                    'Applicant only - Mean duration in weeks',
#                                    'Respondent only - Number of Disposals',
#                                    'Respondent only - Mean duration in weeks',
#                                    'Neither Applicant nor Respondent - Number of Disposals',
#                                    'Neither Applicant nor Respondent - Mean duration in weeks',
#                                    'All types of representation - Number of Disposals',
#                                    'All types of representation - Mean duration in weeks'
# )


#Quarterly T10b
t10b_accessible_qtr <- table10b_alt %>% filter(Quarter != '') %>% select(!contains('Unknown'))

colnames(t10b_accessible_qtr) <- c('Category',
                                  'Year',
                                  'Quarter',
                                  'Both Applicant and Respondent - Number of Disposals',
                                  'Both Applicant and Respondent - Mean duration in weeks',
                                  'Applicant only - Number of Disposals',
                                  'Applicant only - Mean duration in weeks',
                                  'Respondent only - Number of Disposals',
                                  'Respondent only - Mean duration in weeks',
                                  'Neither Applicant nor Respondent - Number of Disposals',
                                  'Neither Applicant nor Respondent - Mean duration in weeks',
                                  'All types of representation - Number of Disposals',
                                  'All types of representation - Mean duration in weeks'
)

#Binds rows together and rounds all week columns to one decimal place
t10b_accessible <- t10b_accessible_qtr %>% arrange(Category, Year, Quarter) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, na_value))) %>% 
  mutate(Quarter = replace_na(Quarter, 'Annual'))