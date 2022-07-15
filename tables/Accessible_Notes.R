#Accessible Notes

get_note_frame <- function(table_name){
  # This gets the note numbers for a particular table after removing all the square brackets
  notes_import %>% filter(`Table number` == table_name)
  
}

# %>% pull(`Note number`) %>% str_remove_all('[\\[\\]]')

# List of note numbers for each table. This uses the table numbers established in footnotes.R
note_frame_list <- map(table_numbers, get_note_frame)

# Column names are changed by positioning. For each table the number is picked from the note list and the appropriate note number picked.
# Relative orders of notes for a particular table is therefore the only thing that matters

col_name_check <- function(old_cols, new_cols, table){
  # This checks that the new columns are referring to the same columns as the original columns
  # This only works if there are no special characters in the original sequence
  checker <- str_detect(new_cols, coll(old_cols))
  if (!all(checker)){
    # Prints new columns and old columns to check where the names don't match
    print(old_cols[which(!checker)])
    print(new_cols[which(!checker)])
    
    stop(glue('Names do not match in accessible table {table}'))
    
  }
}

add_col_notes <- function(table, table_num, col_nums, new_cols, skip = FALSE){
  # Table name: This is the table that is being modified
  # Table num : The number of the table
  # col_nums: A numeric vector containing positions of column
  # new_cols : A character string containing the new column names to replace the old ones
  # skip lets you skip the check. Only set to TRUE id you are certain there is no error in renaming
  orig_cols <- colnames(table)[col_nums]
  
  if (!skip){
    col_name_check(orig_cols, new_cols, table = table_num)
    
  }
  colnames(table)[col_nums] <- new_cols
  table
  
  
}

note_lookup_selector <- function(frame_list, table_num, lookup_code){
  # Takes the list of data frames and selects the note number based on the numerical lookup code for a particular note.
  # As note numbers may change, lookup code for a particular note should not. 
  # The lookup code is usually in the form of - 01 or - 10 or so forth
  frame_list[[table_num]] %>% 
    filter(str_detect(Lookup, paste('-', lookup_code))) %>% 
    pull(`Note number`) %>% str_remove_all('[\\[\\]]')
}

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
t2_col_change <- c(4, 5, 6, 7, 8, 9, 10)
new_t2_cols <- c(glue('Individual children involved in Applications\n[note {note_lookup_selector(note_frame_list, 2, "04")}][note {note_lookup_selector(note_frame_list, 2, "05")}]'),
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
                           `Order category` == 'Return of Missing or Taken Children' ~ glue('[note {note_lookup_selector(note_frame_list, 3, "03")}]'),
                           `Order category` == 'Post Separation Support and Dispute Resolution' ~ glue('[note {note_lookup_selector(note_frame_list, 3, "05")}]'))
                           
         )

t3b_accessible <- t3b_accessible %>% 
  mutate(Notes = case_when(`Order type` == 'Parental order' ~ glue('[note {note_lookup_selector(note_frame_list, 3, "04")}]'),
                           `Order type` == 'Enforcement' ~ glue('[note {note_lookup_selector(note_frame_list, 3, "06")}]'),
                           `Order category` == 'Return of Missing or Taken Children' ~ glue('[note {note_lookup_selector(note_frame_list, 3, "03")}]'),
                           `Order category` == 'Post Separation Support and Dispute Resolution' ~ glue('[note {note_lookup_selector(note_frame_list, 3, "05")}]'))
         
  )
  
# Table 4
title_note_t4 <- glue('[note {note_lookup_selector(note_frame_list, 4, "01")}][note {note_lookup_selector(note_frame_list, 4, "02")}]')

t4a_accessible <- t4a_accessible %>% mutate(Notes = case_when(`Order type` %in% c('Authorising search, taking charge and delivery', 'Authority to obtain information on missing child') ~ glue('[note {note_lookup_selector(note_frame_list, 4, "03")}]'),
                                            `Order type` %in% c('Recovery order', 'Authority to search for another child') ~ glue('[note {note_lookup_selector(note_frame_list, 4, "04")}]'),
                                            `Order type` == 'Parental order' ~ glue('[note {note_lookup_selector(note_frame_list, 4, "05")}]'),
                                            `Order category` == 'Interim Orders' ~ glue('[note {note_lookup_selector(note_frame_list, 4, "06")}]'),
                                            `Order category` == 'Combined Orders' ~ glue('[note {note_lookup_selector(note_frame_list, 4, "07")}]')
                                            )
)


t4b_accessible <- t4b_accessible %>% mutate(Notes = case_when(`Order type` %in% c('Authorising search, taking charge and delivery', 'Authority to obtain information on missing child') ~ glue('[note {note_lookup_selector(note_frame_list, 4, "03")}]'),
                                                              `Order type` %in% c('Recovery order', 'Authority to search for another child') ~ glue('[note {note_lookup_selector(note_frame_list, 4, "04")}]'),
                                                              `Order type` == 'Parental order' ~ glue('[note {note_lookup_selector(note_frame_list, 4, "05")}]'),
                                                              `Order category` == 'Interim Orders' ~ glue('[note {note_lookup_selector(note_frame_list, 4, "06")}]'),
                                                              `Order category` == 'Combined Orders' ~ glue('[note {note_lookup_selector(note_frame_list, 4, "07")}]')
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
                  glue('All - Number of Disposals\n[note {note_lookup_selector(note_frame_list, 10, "07")}]'),
                  glue('All - Mean duration in weeks\n[note {note_lookup_selector(note_frame_list, 10, "07")}][note {note_lookup_selector(note_frame_list, 10, "08")}][note {note_lookup_selector(note_frame_list, 10, "09")}]')
                  
                  )

t10_accessible <- t10_accessible %>% add_col_notes(table_num = 10, col_nums = t10_col_change, new_cols = new_t10_cols)

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
notes_all <- notes_import %>% select(!Lookup)
#title_notes <- list(title_note_t1, title_note_t2, title_note_t3, title_note_t3, title_note_t4, title_note_t4, title_note_t5,
                    #title_note_t6, title_note_t7, title_note_t8, title_note_t9, title_note_t10, title_note_t11, title_note_t12)