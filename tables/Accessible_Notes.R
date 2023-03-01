#Accessible Notes
# List of note numbers for each table. This uses the table numbers established in footnotes.R
# Note that Table numbers are left the samein the Lookup and variable name even though Table 14 is gone and all tables after that are one less

# Table numbers are based on R table numbers rather than spreadsheet table numbers
#notes_import <- openxlsx::read.xlsx(paste0(path_to_project,'Notes Workbook 2022 Q3.xlsx'), sheet = 'Notes', na.strings = na_keys, sep.names = ' ') %>% as_tibble()
note_frame_list <- map(no_tables_seq, get_note_frame)
names(note_frame_list) <- table_numbers

# Table 1
# Note to add into title
title_note_t1 <- glue('[note {note_lookup_selector(note_frame_list, 1, "01")}]')

# Modifying columns to have notes in them
t1_col_change <- c(3, 6, 7, 9, 10, 11)
new_t1_cols <- c(glue('Stage\n[note {note_lookup_selector(note_frame_list, 1, "02")}]'),
                 glue('Matrimonial Matters\n[note {note_lookup_selector(note_frame_list, 1, "08")}]'),
                 glue('Financial Remedies\n[note {note_lookup_selector(note_frame_list, 1, "03")}]'),
                 glue('Forced Marriage Protection\n[note {note_lookup_selector(note_frame_list, 1, "04")}]'),
                 glue('Female Genital Mutilation Protection\n[note {note_lookup_selector(note_frame_list, 1, "09")}]'),
                 glue('Adoption\n[note {note_lookup_selector(note_frame_list, 1, "05")}]')
)

t1_accessible <- t1_accessible %>% add_col_notes(table_num = 1, col_nums = t1_col_change, new_cols = new_t1_cols)

# Table 2
title_note_t2 <- glue('[note {note_lookup_selector(note_frame_list, 2, "01")}][note {note_lookup_selector(note_frame_list, 2, "02")}]')
t2_col_change <- c(1, 4, 5, 6, 7, 8, 9, 10)
new_t2_cols <- c(glue('Category\n[note {note_lookup_selector(note_frame_list, 2, "03")}]'),
  glue('Individual children involved in Applications\n[note {note_lookup_selector(note_frame_list, 2, "04")}][note {note_lookup_selector(note_frame_list, 2, "05")}]'),
  glue('Applications made\n[note {note_lookup_selector(note_frame_list, 2, "06")}]'),
  glue('Total orders applied for\n[note {note_lookup_selector(note_frame_list, 2, "07")}]'),
  glue('Cases starting\n[note {note_lookup_selector(note_frame_list, 2, "08")}]'),
  glue('Orders made\n[note {note_lookup_selector(note_frame_list, 2, "09")}]'),
  glue('Disposals made\n[note {note_lookup_selector(note_frame_list, 2, "09")}]'),
  glue('Cases disposed\n[note {note_lookup_selector(note_frame_list, 2, "08")}][note {note_lookup_selector(note_frame_list, 2, "11")}]')
  
)

t2_accessible <- t2_accessible %>% add_col_notes(table_num = 2, col_nums = t2_col_change, new_cols = new_t2_cols)

# Table 3
title_note_t3 <- glue('[note {note_lookup_selector(note_frame_list, 3, "01")}][note {note_lookup_selector(note_frame_list, 3, "02")}]')
t3a_accessible <- t3a_accessible %>% 
  mutate(Notes = case_when(`Order type` == 'Parental order' ~ glue('[note {note_lookup_selector(note_frame_list, 3, "04")}]'),
                           `Order type` == 'Enforcement' ~ glue('[note {note_lookup_selector(note_frame_list, 3, "06")}]'),
                           `Order type category` == 'Return of Missing or Taken Children' ~ glue('[note {note_lookup_selector(note_frame_list, 3, "03")}]'),
                           `Order type category` == 'Post Separation Support and Dispute Resolution' ~ glue('[note {note_lookup_selector(note_frame_list, 3, "05")}]'))
                           
         )

t3b_accessible <- t3b_accessible %>% 
  mutate(Notes = case_when(`Order type` == 'Parental order' ~ glue('[note {note_lookup_selector(note_frame_list, 3, "04")}]'),
                           `Order type` == 'Enforcement' ~ glue('[note {note_lookup_selector(note_frame_list, 3, "06")}]'),
                           `Order type category` == 'Return of Missing or Taken Children' ~ glue('[note {note_lookup_selector(note_frame_list, 3, "03")}]'),
                           `Order type category` == 'Post Separation Support and Dispute Resolution' ~ glue('[note {note_lookup_selector(note_frame_list, 3, "05")}]'))
         
  )
  
# Table 4
title_note_t4 <- glue('[note {note_lookup_selector(note_frame_list, 4, "01")}][note {note_lookup_selector(note_frame_list, 4, "02")}]')

t4a_accessible <- t4a_accessible %>% mutate(Notes = case_when(`Order type` %in% c('Authorising search, taking charge and delivery', 'Authority to obtain information on missing child') ~ glue('[note {note_lookup_selector(note_frame_list, 4, "03")}]'),
                                            `Order type` %in% c('Recovery order', 'Authority to search for another child') ~ glue('[note {note_lookup_selector(note_frame_list, 4, "04")}]'),
                                            `Order type` == 'Parental order' ~ glue('[note {note_lookup_selector(note_frame_list, 4, "05")}]'),
                                            `Order type category` == 'Interim Orders' ~ glue('[note {note_lookup_selector(note_frame_list, 4, "06")}]'),
                                            `Order type category` == 'Combined Orders' ~ glue('[note {note_lookup_selector(note_frame_list, 4, "07")}]')
                                            )
)


t4b_accessible <- t4b_accessible %>% mutate(Notes = case_when(`Order type` %in% c('Authorising search, taking charge and delivery', 'Authority to obtain information on missing child') ~ glue('[note {note_lookup_selector(note_frame_list, 4, "03")}]'),
                                                              `Order type` %in% c('Recovery order', 'Authority to search for another child') ~ glue('[note {note_lookup_selector(note_frame_list, 4, "04")}]'),
                                                              `Order type` == 'Parental order' ~ glue('[note {note_lookup_selector(note_frame_list, 4, "05")}]'),
                                                              `Order type category` == 'Interim Orders' ~ glue('[note {note_lookup_selector(note_frame_list, 4, "06")}]'),
                                                              `Order type category` == 'Combined Orders' ~ glue('[note {note_lookup_selector(note_frame_list, 4, "07")}]')
)
)

# Table 5
title_note_t5 <- glue('[note {note_lookup_selector(note_frame_list, 5, "01")}]')

t5_col_change <- c(1, 9, 10, 11)
new_t5_cols <- c(glue('Category\n[note {note_lookup_selector(note_frame_list, 5, "02")}]'),
                 glue('Other age\n[note {note_lookup_selector(note_frame_list, 5, "03")}]'),
                 glue('Unknown age\n[note {note_lookup_selector(note_frame_list, 5, "04")}]'),
                 glue('Total individual children\n[note {note_lookup_selector(note_frame_list, 5, "05")}]')
)

t5_accessible <- t5_accessible %>% add_col_notes(table_num = 5, col_nums = t5_col_change, new_cols = new_t5_cols)

# Table 6
title_note_t6 <- glue('[note {note_lookup_selector(note_frame_list, 6, "01")}]')

t6_col_change <- c(1)
new_t6_cols <- c(glue('Category\n[note {note_lookup_selector(note_frame_list, 6, "02")}]')
)
t6_accessible <- t6_accessible %>% add_col_notes(table_num = 6, col_nums = t6_col_change, new_cols = new_t6_cols)

# Table 7
title_note_t7 <- glue('[note {note_lookup_selector(note_frame_list, 7, "01")}]')

t7_col_change <- c(1, 6)
new_t7_cols <- c(glue('Category\n[note {note_lookup_selector(note_frame_list, 7, "02")}]'),
                 glue('High Court cases started in Central London DFJ\n[note {note_lookup_selector(note_frame_list, 7, "03")}]')
)

t7_accessible <- t7_accessible %>% add_col_notes(table_num = 7, col_nums = t7_col_change, new_cols = new_t7_cols)

# Table 8
title_note_t8 <- glue('[note {note_lookup_selector(note_frame_list, 8, "01")}][note {note_lookup_selector(note_frame_list, 8, "02")}]')
t8_col_change <- c(5)
new_t8_cols <- c(glue('Median disposal duration (weeks)\n[note {note_lookup_selector(note_frame_list, 8, "03")}]')
)

t8_accessible <- t8_accessible %>% add_col_notes(table_num = 8, col_nums = t8_col_change, new_cols = new_t8_cols)

# Table 9
title_note_t9 <- glue('[note {note_lookup_selector(note_frame_list, 9, "01")}]')
t9_col_change <- c(5)
new_t9_cols <- c(glue('Median case duration (weeks)\n[note {note_lookup_selector(note_frame_list, 9, "02")}]')
)

t9_accessible <- t9_accessible %>% add_col_notes(table_num = 9, col_nums = t9_col_change, new_cols = new_t9_cols)

# Table 10
title_note_t10 <- glue('[note {note_lookup_selector(note_frame_list, 10, "01")}]')
t10_col_change <- c(1, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13)
new_t10_cols <- c(glue('Category\n[notes {note_lookup_selector(note_frame_list, 10, "02")},{note_lookup_selector(note_frame_list, 10, "03")}\\
,{note_lookup_selector(note_frame_list, 10, "04")},{note_lookup_selector(note_frame_list, 10, "05")},{note_lookup_selector(note_frame_list, 10, "11")}]'),
                  glue('Both Applicant and Respondent - Number of Disposals\n[note {note_lookup_selector(note_frame_list, 10, "06")}]'),
                  glue('Both Applicant and Respondent - Mean duration in weeks\n[note {note_lookup_selector(note_frame_list, 10, "06")}][note {note_lookup_selector(note_frame_list, 10, "08")}][note {note_lookup_selector(note_frame_list, 10, "09")}]'),
                  glue('Applicant only - Number of Disposals\n[note {note_lookup_selector(note_frame_list, 10, "06")}]'),
                  glue('Applicant only - Mean duration in weeks\n[note {note_lookup_selector(note_frame_list, 10, "06")}][note {note_lookup_selector(note_frame_list, 10, "08")}][note {note_lookup_selector(note_frame_list, 10, "09")}]'),
                  glue('Respondent only - Number of Disposals\n[note {note_lookup_selector(note_frame_list, 10, "06")}]'),
                  glue('Respondent only - Mean duration in weeks\n[note {note_lookup_selector(note_frame_list, 10, "06")}][note {note_lookup_selector(note_frame_list, 10, "08")}][note {note_lookup_selector(note_frame_list, 10, "09")}]'),
                  glue('Neither Applicant nor Respondent - Number of Disposals\n[note {note_lookup_selector(note_frame_list, 10, "06")}]'),
                  glue('Neither Applicant nor Respondent - Mean duration in weeks\n[note {note_lookup_selector(note_frame_list, 10, "06")}][note {note_lookup_selector(note_frame_list, 10, "08")}][note {note_lookup_selector(note_frame_list, 10, "09")}]'),
                  glue('All types of representation - Number of Disposals\n[note {note_lookup_selector(note_frame_list, 10, "07")}]'),
                  glue('All types of representation - Mean duration in weeks\n[note {note_lookup_selector(note_frame_list, 10, "07")}][note {note_lookup_selector(note_frame_list, 10, "08")}][note {note_lookup_selector(note_frame_list, 10, "09")}]')
                  
                  )

t10_accessible <- t10_accessible %>% add_col_notes(table_num = 10, col_nums = t10_col_change, new_cols = new_t10_cols)

#Table 10b
title_note_t10b <- ''
t10b_col_change <- c(1)
new_t10b_cols <- c(glue('Category\n[note {note_lookup_selector(note_frame_list, "10b", "01")}]'))

t10b_accessible <- t10b_accessible %>% add_col_notes(table_num = '10b', col_nums = t10b_col_change, new_cols = new_t10b_cols)

# Table 11
title_note_t11 <- glue('[note {note_lookup_selector(note_frame_list, 11, "01")}][note {note_lookup_selector(note_frame_list, 11, "02")}][note {note_lookup_selector(note_frame_list, 11, "03")}]')
t11_col_change <- c(1, 7, 9)
new_t11_cols <- c(glue('Category\n[notes {note_lookup_selector(note_frame_list, 11, "04")},{note_lookup_selector(note_frame_list, 11, "05")}\\
,{note_lookup_selector(note_frame_list, 11, "06")},{note_lookup_selector(note_frame_list, 11, "07")},{note_lookup_selector(note_frame_list, 11, "08")}\\
,{note_lookup_selector(note_frame_list, 11, "09")},{note_lookup_selector(note_frame_list, 11, "12")},{note_lookup_selector(note_frame_list, 11, "13")}\\
,{note_lookup_selector(note_frame_list, 11, "14")}]'),
                  glue('Applicants - unrepresented parties\n[note {note_lookup_selector(note_frame_list, 11, "10")}]'),
                  glue('Respondents - unrepresented parties\n[note {note_lookup_selector(note_frame_list, 11, "10")}]')
                  
  
)

t11_accessible <- t11_accessible %>% add_col_notes(table_num = 11, col_nums = t11_col_change, new_cols = new_t11_cols)

# Table 12
title_note_t12 <- glue('[note {note_lookup_selector(note_frame_list, 12, "01")}][note {note_lookup_selector(note_frame_list, 12, "05")}][note {note_lookup_selector(note_frame_list, 12, "06")}][note {note_lookup_selector(note_frame_list, 12, "07")}]')
t12_col_change <- c(5)
new_t12_cols <- c(glue('Law\n[note {note_lookup_selector(note_frame_list, 12, "08")}]')
                  )
t12_accessible <- t12_accessible %>% add_col_notes(table_num = 12, col_nums = t12_col_change, new_cols = new_t12_cols) %>% 
  mutate(Notes = case_when(`Proceeding Type` == 'Divorce' ~ glue('[note {note_lookup_selector(note_frame_list, 12, "07")}]'
                                                                 )
                           ))

# Table 12b
title_note_t12b <- glue('[note {note_lookup_selector(note_frame_list, "12b", "01")}]')
t12b_col_change <- c(4)
new_t12b_cols <- c(glue('Application Type\n[note {note_lookup_selector(note_frame_list, "12b", "05")}]')
)

t12b_accessible <- t12b_accessible %>% add_col_notes(table_num = '12b', col_nums = t12b_col_change, new_cols = new_t12b_cols)

# Table 13
title_note_t13 <-  glue('[note {note_lookup_selector(note_frame_list, 13, "01")}][note {note_lookup_selector(note_frame_list, 13, "02")}][note {note_lookup_selector(note_frame_list, 13, "03")}][note {note_lookup_selector(note_frame_list, 13, "08")}]')
t13_col_change <- c(3, 4, 6, 8, 9, 10, 12, 13)
new_t13_cols <- c(glue('Divorce cases started\n[note {note_lookup_selector(note_frame_list, 13, "08")}]'),
                  glue('Cases reaching conditional order to date\n[note {note_lookup_selector(note_frame_list, 13, "07")}]'),
                  glue('Cases reaching final order to date\n[note {note_lookup_selector(note_frame_list, 13, "07")}]'),
                  glue('Cases reaching a financial remedy application to date\n[note {note_lookup_selector(note_frame_list, 13, "04")}][note {note_lookup_selector(note_frame_list, 13, "05")}][note {note_lookup_selector(note_frame_list, 13, "07")}]'),
                  glue('% of divorce cases started reaching a financial remedy application\n[note {note_lookup_selector(note_frame_list, 13, "04")}][note {note_lookup_selector(note_frame_list, 13, "05")}]'),
                  glue('Cases reaching a financial remedy disposal to date\n[note {note_lookup_selector(note_frame_list, 13, "07")}]'),
                  glue('Cases reaching a hearing to date\n[note {note_lookup_selector(note_frame_list, 13, "06")}][note {note_lookup_selector(note_frame_list, 13, "07")}]'),
                  glue('% of divorce cases started reaching a hearing\n[note {note_lookup_selector(note_frame_list, 13, "06")}]')
                  )

t13_accessible <- t13_accessible %>% add_col_notes(table_num = 13, col_nums = t13_col_change, new_cols = new_t13_cols)

# Table 14
title_note_t14 <-  glue('[note {note_lookup_selector(note_frame_list, 14, "01")}][note {note_lookup_selector(note_frame_list, 14, "02")}]')

# Table 15
title_note_t15 <- glue('[note {note_lookup_selector(note_frame_list, 15, "01")}][note {note_lookup_selector(note_frame_list, 15, "02")}]')
t15_col_change <- c(3, 4, 5, 6, 7, 8, 9, 10, 11)
new_t15_cols <- c(glue('Uncontested Applications\n[note {note_lookup_selector(note_frame_list, 15, "03")}][note {note_lookup_selector(note_frame_list, 15, "04")}]'),
                  glue('Contested Applications\n[note {note_lookup_selector(note_frame_list, 15, "03")}][note {note_lookup_selector(note_frame_list, 15, "04")}]'),
                  glue('Total Applications\n[note {note_lookup_selector(note_frame_list, 15, "03")}][note {note_lookup_selector(note_frame_list, 15, "04")}]'),
                  glue('Total cases starting\n[note {note_lookup_selector(note_frame_list, 15, "03")}][note {note_lookup_selector(note_frame_list, 15, "04")}]'),
                  glue('Uncontested Disposals\n[note {note_lookup_selector(note_frame_list, 15, "05")}]'),
                  glue('Initially Contested Disposals\n[note {note_lookup_selector(note_frame_list, 15, "05")}]'),
                  glue('Contested Disposals\n[note {note_lookup_selector(note_frame_list, 15, "05")}]'),
                  glue('Total Disposals\n[note {note_lookup_selector(note_frame_list, 15, "05")}]'),
                  glue('Total cases disposed\n[note {note_lookup_selector(note_frame_list, 15, "05")}]')
                  )

t15_accessible <- t15_accessible %>% add_col_notes(table_num = 15, col_nums = t15_col_change, new_cols = new_t15_cols)

# Table 16
title_note_t16 <- glue('[note {note_lookup_selector(note_frame_list, 16, "01")}][note {note_lookup_selector(note_frame_list, 16, "02")}]')
t16_col_change <- c(3, 4, 5, 6, 7, 8, 12)
new_t16_cols <- c(glue('Application Type\n[note {note_lookup_selector(note_frame_list, 16, "05")}]'),
                  glue('Non-Molestation Orders applied for\n[note {note_lookup_selector(note_frame_list, 16, "03")}]'),
                  glue('Occupation Orders applied for\n[note {note_lookup_selector(note_frame_list, 16, "03")}]'),
                  glue('Total Orders applied for\n[note {note_lookup_selector(note_frame_list, 16, "03")}]'),
                  glue('Applications made\n[note {note_lookup_selector(note_frame_list, 16, "03")}]'),
                  glue('Cases started\n[note {note_lookup_selector(note_frame_list, 16, "06")}]'),
                  glue('Cases concluded\n[note {note_lookup_selector(note_frame_list, 16, "07")}]')
                  
  
)

t16_accessible <- t16_accessible %>% add_col_notes(table_num = 16, col_nums = t16_col_change, new_cols = new_t16_cols)

# Table 17
title_note_t17 <- glue('[note {note_lookup_selector(note_frame_list, 17, "01")}][note {note_lookup_selector(note_frame_list, 17, "02")}]')
t17_col_change <- c(3, 4, 5, 6, 7, 8, 9, 11, 12, 13, 14, 15, 17)
new_t17_cols <- c(glue('Applications: Age of person to be protected - 17 and under\n[note {note_lookup_selector(note_frame_list, 17, "03")}]'),
                  glue('Applications: Age of person to be protected - Over 17\n[note {note_lookup_selector(note_frame_list, 17, "03")}]'),
                  glue('Applications: Age of person to be protected - Unknown\n[note {note_lookup_selector(note_frame_list, 17, "03")}]'),
                  glue('Applications: Applicant type - Person to be protected\n[note {note_lookup_selector(note_frame_list, 17, "04")}][note {note_lookup_selector(note_frame_list, 17, "05")}]'),
                  glue('Applications: Applicant type - Relevant 3rd party\n[note {note_lookup_selector(note_frame_list, 17, "04")}][note {note_lookup_selector(note_frame_list, 17, "06")}]'),
                  glue('Applications: Applicant type - Other 3rd party\n[note {note_lookup_selector(note_frame_list, 17, "04")}][note {note_lookup_selector(note_frame_list, 17, "07")}]'),
                  glue('Applications: Applicant type - Other\n[note {note_lookup_selector(note_frame_list, 17, "04")}]'),
                  glue('Total cases started\n[note {note_lookup_selector(note_frame_list, 17, "08")}]'),
                  glue('Disposals: Orders made with power of arrest attached\n[note {note_lookup_selector(note_frame_list, 17, "09")}][note {note_lookup_selector(note_frame_list, 17, "10")}]'),
                  glue('Disposals: Orders made without power of arrest attached\n[note {note_lookup_selector(note_frame_list, 17, "09")}][note {note_lookup_selector(note_frame_list, 17, "10")}]'),
                  glue('Disposals: Total orders made\n[note {note_lookup_selector(note_frame_list, 17, "09")}]'),
                  glue('Disposals: Other disposals\n[note {note_lookup_selector(note_frame_list, 17, "11")}]'),
                  glue('Total cases concluded\n[note {note_lookup_selector(note_frame_list, 17, "12")}][note {note_lookup_selector(note_frame_list, 17, "13")}]')
                  
                  
                  
                  
  
)

t17_accessible <- t17_accessible %>% add_col_notes(table_num = 17, col_nums = t17_col_change, new_cols = new_t17_cols) %>% 
  mutate(Notes = case_when(Year == 2008 & Quarter == 'Q4' ~ glue('[note {note_lookup_selector(note_frame_list, 17, "01")}]')))


# Table 18
title_note_t18 <- glue('[note {note_lookup_selector(note_frame_list, 18, "01")}]')
t18_col_change <- c(6, 7, 8, 10, 11, 12, 14)
new_t18_cols <- c(
                  glue('Applications: Applicant type - Person to be protected\n[note {note_lookup_selector(note_frame_list, 18, "02")}]'),
                  glue('Applications: Applicant type - Relevant 3rd party\n[note {note_lookup_selector(note_frame_list, 18, "03")}]'),
                  glue('Applications: Applicant type - Other 3rd party\n[note {note_lookup_selector(note_frame_list, 18, "04")}]'),
                  glue('Total cases started\n[note {note_lookup_selector(note_frame_list, 18, "05")}]'),
                  glue('Disposals: Total FGMPO orders made\n[note {note_lookup_selector(note_frame_list, 18, "06")}]'),
                  glue('Disposals: Other disposals\n[note {note_lookup_selector(note_frame_list, 18, "07")}]'),
                  glue('Total cases concluded\n[note {note_lookup_selector(note_frame_list, 18, "08")}][note {note_lookup_selector(note_frame_list, 18, "09")}]')
)

t18_accessible <- t18_accessible %>% add_col_notes(table_num = 18, col_nums = t18_col_change, new_cols = new_t18_cols)

# Table 19
title_note_t19 <- ''
t19_col_change <- c(3, 4, 5, 6, 7, 8, 10)
new_t19_cols <- c(glue('Adoption applications: Adopter - Male/female couple\n[note {note_lookup_selector(note_frame_list, 19, "01")}][note {note_lookup_selector(note_frame_list, 19, "02")}][note {note_lookup_selector(note_frame_list, 19, "05")}]'),
                  glue('Adoption applications: Adopter - Sole applicant\n[note {note_lookup_selector(note_frame_list, 19, "01")}]'),
                  glue('Adoption applications: Adopter - Step parent\n[note {note_lookup_selector(note_frame_list, 19, "01")}]'),
                  glue('Adoption applications: Adopter - Same sex couple\n[note {note_lookup_selector(note_frame_list, 19, "01")}]'),
                  glue('Adoption applications: Adopter - Other or not stated\n[note {note_lookup_selector(note_frame_list, 19, "01")}][note {note_lookup_selector(note_frame_list, 19, "03")}]'),
                  glue('Adoption applications: Total adoption applications\n[note {note_lookup_selector(note_frame_list, 19, "01")}]'),
                  glue('Non-Adoption applications - Other orders\n[note {note_lookup_selector(note_frame_list, 19, "04")}]')
                  
                  
  
)

t19_accessible <- t19_accessible %>% add_col_notes(table_num = 19, col_nums = t19_col_change, new_cols = new_t19_cols)

# Table 20
title_note_t20 <- glue('[note {note_lookup_selector(note_frame_list, 20, "01")}]')
t20_col_change <- c(3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 19, 20)
new_t20_cols <- c(glue('Adoption orders: Adopter - Male/female couple\n[note {note_lookup_selector(note_frame_list, 20, "02")}][note {note_lookup_selector(note_frame_list, 20, "03")}][note {note_lookup_selector(note_frame_list, 20, "11")}]'),
                  glue('Adoption orders: Adopter - Sole applicant\n[note {note_lookup_selector(note_frame_list, 20, "02")}]'),
                  glue('Adoption orders: Adopter - Step parent\n[note {note_lookup_selector(note_frame_list, 20, "02")}]'),
                  glue('Adoption orders: Adopter - Same sex couple\n[note {note_lookup_selector(note_frame_list, 20, "02")}]'),
                  glue('Adoption orders: Adopter - Other or not stated\n[note {note_lookup_selector(note_frame_list, 20, "02")}][note {note_lookup_selector(note_frame_list, 20, "04")}]'),
                  glue('Adoption orders: Adopted Child Sex - Male\n[note {note_lookup_selector(note_frame_list, 20, "02")}][note {note_lookup_selector(note_frame_list, 20, "05")}]'),
                  glue('Adoption orders: Adopted Child Sex - Female\n[note {note_lookup_selector(note_frame_list, 20, "02")}][note {note_lookup_selector(note_frame_list, 20, "05")}]'),
                  glue('Adoption orders: Adopted Child Age - Less than 1 years old\n[note {note_lookup_selector(note_frame_list, 20, "02")}]'),
                  glue('Adoption orders: Adopted Child Age - 1-4 years old\n[note {note_lookup_selector(note_frame_list, 20, "02")}]'),
                  glue('Adoption orders: Adopted Child Age - 5-9 years old\n[note {note_lookup_selector(note_frame_list, 20, "02")}]'),
                  glue('Adoption orders: Adopted Child Age - 10-14 years old\n[note {note_lookup_selector(note_frame_list, 20, "02")}]'),
                  glue('Adoption orders: Adopted Child Age - 15-17 years old\n[note {note_lookup_selector(note_frame_list, 20, "02")}]'),
                  glue('Adoption orders: Adopted Child Age - Other\n[note {note_lookup_selector(note_frame_list, 20, "02")}][note {note_lookup_selector(note_frame_list, 20, "06")}]'),
                  glue('Adoption orders: Adopted Child Age - Unknown\n[note {note_lookup_selector(note_frame_list, 20, "02")}][note {note_lookup_selector(note_frame_list, 20, "07")}]'),
                  glue('Adoption orders: Total adoption orders\n[note {note_lookup_selector(note_frame_list, 20, "02")}]'),
                  glue('Non-Adoption orders - Other orders\n[note {note_lookup_selector(note_frame_list, 20, "08")}]'),
                  glue('Other disposals of Adoption and Children Act 2002 cases\n[note {note_lookup_selector(note_frame_list, 20, "09")}]')
                  
                  
                  
                  
                  
)

t20_accessible <- t20_accessible %>% add_col_notes(table_num = 20, col_nums = t20_col_change, new_cols = new_t20_cols)

# Table 21
title_note_t21 <- ''
t21_col_change <- c(8, 10, 12, 13, 15, 16, 17)
new_t21_cols <- c(glue('Applications for appointment of a hybrid deputy\n[note {note_lookup_selector(note_frame_list, 21, "01")}]'),
                  glue('Applications for orders appointing new trustees\n[note {note_lookup_selector(note_frame_list, 21, "02")}]'),
                  glue('Applications relating to enduring powers of attorney\n[note {note_lookup_selector(note_frame_list, 21, "03")}]'),
                  glue('Applications relating to lasting powers of attorney\n[note {note_lookup_selector(note_frame_list, 21, "03")}]'),
                  glue('Applications for discharge of the deputy\n[note {note_lookup_selector(note_frame_list, 21, "05")}]'),
                  glue('Deprivation of Liberty\n[note {note_lookup_selector(note_frame_list, 21, "06")}]'),
                  glue('Other\n[note {note_lookup_selector(note_frame_list, 21, "04")}]')
                  
  
)

t21_accessible <- t21_accessible %>% add_col_notes(table_num = 21, col_nums = t21_col_change, new_cols = new_t21_cols)

# Table 22
title_note_t22 <- ''
t22_col_change <- c(8, 10, 12, 13, 15, 17)
new_t22_cols <- c(glue('Orders for appointment of a hybrid deputy\n[note {note_lookup_selector(note_frame_list, 22, "01")}]'),
                  glue('Orders for orders appointing new trustees\n[note {note_lookup_selector(note_frame_list, 22, "02")}]'),
                  glue('Orders relating to enduring powers of attorney\n[note {note_lookup_selector(note_frame_list, 22, "03")}]'),
                  glue('Orders relating to lasting powers of attorney\n[note {note_lookup_selector(note_frame_list, 22, "03")}]'),
                  glue('Orders for discharge of the deputy\n[note {note_lookup_selector(note_frame_list, 22, "05")}]'),
                  glue('Other\n[note {note_lookup_selector(note_frame_list, 22, "04")}]')
                  
                  
)

t22_accessible <- t22_accessible %>% add_col_notes(table_num = 22, col_nums = t22_col_change, new_cols = new_t22_cols)

# Table 23
title_note_t23 <- glue('[note {note_lookup_selector(note_frame_list, 23, "01")}]')
t23_col_change <- c(3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 20)
new_t23_cols <- c(glue('Registered applications - Application Type: Enduring Power of Attorney\n[note {note_lookup_selector(note_frame_list, 23, "03")}]'),
                  glue('Registered applications - Application Type: Lasting Power of Attorney\n[note {note_lookup_selector(note_frame_list, 23, "04")}]'),
                  glue('Registered applications - Case Subtype: Property and finance\n[note {note_lookup_selector(note_frame_list, 23, "05")}]'),
                  glue('Registered applications - Case Subtype: Health and welfare\n[note {note_lookup_selector(note_frame_list, 23, "05")}]'),
                  glue('Registered applications - Gender of Donor: Female\n[note {note_lookup_selector(note_frame_list, 23, "06")}][note {note_lookup_selector(note_frame_list, 23, "07")}]'),
                  glue('Registered applications - Gender of Donor: Male\n[note {note_lookup_selector(note_frame_list, 23, "06")}][note {note_lookup_selector(note_frame_list, 23, "07")}]'),
                  glue('Registered applications - Gender of Donor: Unknown\n[note {note_lookup_selector(note_frame_list, 23, "06")}][note {note_lookup_selector(note_frame_list, 23, "07")}][note {note_lookup_selector(note_frame_list, 23, "08")}]'),
                  glue('Registered applications - Age of Donor: 18-24\n[note {note_lookup_selector(note_frame_list, 23, "08")}][note {note_lookup_selector(note_frame_list, 23, "09")}][note {note_lookup_selector(note_frame_list, 23, "10")}]'),
                  glue('Registered applications - Age of Donor: 25-34\n[note {note_lookup_selector(note_frame_list, 23, "08")}][note {note_lookup_selector(note_frame_list, 23, "09")}][note {note_lookup_selector(note_frame_list, 23, "10")}]'),
                  glue('Registered applications - Age of Donor: 35-44\n[note {note_lookup_selector(note_frame_list, 23, "08")}][note {note_lookup_selector(note_frame_list, 23, "09")}][note {note_lookup_selector(note_frame_list, 23, "10")}]'),
                  glue('Registered applications - Age of Donor: 45-54\n[note {note_lookup_selector(note_frame_list, 23, "08")}][note {note_lookup_selector(note_frame_list, 23, "09")}][note {note_lookup_selector(note_frame_list, 23, "10")}]'),
                  glue('Registered applications - Age of Donor: 55-64\n[note {note_lookup_selector(note_frame_list, 23, "08")}][note {note_lookup_selector(note_frame_list, 23, "09")}][note {note_lookup_selector(note_frame_list, 23, "10")}]'),
                  glue('Registered applications - Age of Donor: 65-74\n[note {note_lookup_selector(note_frame_list, 23, "08")}][note {note_lookup_selector(note_frame_list, 23, "09")}][note {note_lookup_selector(note_frame_list, 23, "10")}]'),
                  glue('Registered applications - Age of Donor: 75-84\n[note {note_lookup_selector(note_frame_list, 23, "08")}][note {note_lookup_selector(note_frame_list, 23, "09")}][note {note_lookup_selector(note_frame_list, 23, "10")}]'),
                  glue('Registered applications - Age of Donor: 85+\n[note {note_lookup_selector(note_frame_list, 23, "08")}][note {note_lookup_selector(note_frame_list, 23, "09")}][note {note_lookup_selector(note_frame_list, 23, "10")}]'),
                  glue('Registered applications - Age of Donor: Unknown\n[note {note_lookup_selector(note_frame_list, 23, "08")}][note {note_lookup_selector(note_frame_list, 23, "09")}][note {note_lookup_selector(note_frame_list, 23, "10")}]'),
                  glue('Number of deputyships appointed\n[note {note_lookup_selector(note_frame_list, 23, "12")}]')
                  )

t23_accessible <- t23_accessible %>% add_col_notes(table_num = 23, col_nums = t23_col_change, new_cols = new_t23_cols)

# Table 24
title_note_t24 <- glue('[note {note_lookup_selector(note_frame_list, 24, "01")}][note {note_lookup_selector(note_frame_list, 24, "02")}][note {note_lookup_selector(note_frame_list, 24, "03")}]')
t24_col_change <- 5:17
new_t24_cols <- c(glue('Applications Made: Grant of Probate\n[note {note_lookup_selector(note_frame_list, 24, "04")}][note {note_lookup_selector(note_frame_list, 24, "05")}][note {note_lookup_selector(note_frame_list, 24, "06")}]'),
                  glue('Applications Made: Grant of Administration with Will annexed\n[note {note_lookup_selector(note_frame_list, 24, "04")}][note {note_lookup_selector(note_frame_list, 24, "05")}][note {note_lookup_selector(note_frame_list, 24, "06")}]'),
                  glue('Applications Made: Grant of Administration\n[note {note_lookup_selector(note_frame_list, 24, "04")}][note {note_lookup_selector(note_frame_list, 24, "05")}][note {note_lookup_selector(note_frame_list, 24, "06")}]'),
                  'Applications Made: Grants resealed',
                  glue('Applications Made: All grant types\n[note {note_lookup_selector(note_frame_list, 24, "04")}][note {note_lookup_selector(note_frame_list, 24, "05")}][note {note_lookup_selector(note_frame_list, 24, "06")}]'),
                  glue('Grants issued: Grant of Probate\n[note {note_lookup_selector(note_frame_list, 24, "06")}]'),
                  glue('Grants issued: Grant of Administration with Will annexed\n[note {note_lookup_selector(note_frame_list, 24, "06")}]'),
                  glue('Grants issued: Grant of Administration\n[note {note_lookup_selector(note_frame_list, 24, "06")}]'),
                  'Grants issued: Grants resealed',
                  glue('Grants issued: All grant types\n[note {note_lookup_selector(note_frame_list, 24, "06")}]'),
                  glue('Grants revoked\n[note {note_lookup_selector(note_frame_list, 24, "07")}]'),
                  glue('Standing Search\n[note {note_lookup_selector(note_frame_list, 24, "07")}]'),
                  glue('Contested Probate cases\n[note {note_lookup_selector(note_frame_list, 24, "07")}][note {note_lookup_selector(note_frame_list, 24, "08")}]')
                  
                  
  
)

t24_accessible <- t24_accessible %>% add_col_notes(table_num = 24, col_nums = t24_col_change, new_cols = new_t24_cols)

# Table 25
title_note_t25 <- glue('[note {note_lookup_selector(note_frame_list, 25, "01")}][note {note_lookup_selector(note_frame_list, 25, "02")}][note {note_lookup_selector(note_frame_list, 25, "03")}][note {note_lookup_selector(note_frame_list, 25, "04")}][note {note_lookup_selector(note_frame_list, 25, "07")}]')
t25_col_change <- c(8, 9, 13, 14, 18, 19, 23, 24)

new_t25_cols <- c(glue('Probate: Document receipt to grant issue - Mean weeks\n[note {note_lookup_selector(note_frame_list, 25, "05")}]'),
                  glue('Probate: Document receipt to grant issue - Median weeks\n[note {note_lookup_selector(note_frame_list, 25, "05")}]'),
                  glue('Letter of Administration with will annexed: Document receipt to grant issue - Mean weeks\n[note {note_lookup_selector(note_frame_list, 25, "05")}]'),
                  glue('Letter of Administration with will annexed: Document receipt to grant issue - Median weeks\n[note {note_lookup_selector(note_frame_list, 25, "05")}]'),
                  glue('Letter of Administration: Document receipt to grant issue - Mean weeks\n[note {note_lookup_selector(note_frame_list, 25, "05")}]'),
                  glue('Letter of Administration: Document receipt to grant issue - Median weeks\n[note {note_lookup_selector(note_frame_list, 25, "05")}]'),
                  glue('All grants: Document receipt to grant issue - Mean weeks\n[note {note_lookup_selector(note_frame_list, 25, "05")}]'),
                  glue('All grants: Document receipt to grant issue - Median weeks\n[note {note_lookup_selector(note_frame_list, 25, "05")}]')
                  )

t25_accessible <- t25_accessible %>% add_col_notes(table_num = 25, col_nums = t25_col_change, new_cols = new_t25_cols) %>% 
  mutate(Notes = case_when(Year == 2019 & Quarter == 'Q2' ~ glue('[note {note_lookup_selector(note_frame_list, 25, "06")}]' )
                           )
         )

# Removing the lookup column for the final table. Also editing notes to replace with symbols. Repeated for clarity
notes_all <- notes_import %>% select(!c(Lookup, R_Table)) %>% 
  mutate(`Note text` = str_replace(`Note text`, "'-'", "'[z]'")) %>% 
  mutate(`Note text` = str_replace(`Note text`, "':'", "'[z]'")) %>% 
  mutate(`Note text` = str_replace(`Note text`, "'..'", "'[z]'")) %>% 
  mutate(`Note text` = str_replace(`Note text`, "'\\*'", "'[c]'"))
  
  


# Gathering all the title notes
title_notes <- list(title_note_t1, title_note_t2, title_note_t3, title_note_t3, title_note_t4, title_note_t4, title_note_t5,
                    title_note_t6, title_note_t7, title_note_t8, title_note_t9, title_note_t10, title_note_t10b, title_note_t11, title_note_t12, title_note_t12b, 
                    title_note_t13, title_note_t15, title_note_t16, title_note_t17, title_note_t18, title_note_t19,
                    title_note_t20, title_note_t21, title_note_t22, title_note_t23, title_note_t24, title_note_t25)