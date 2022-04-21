#Accessible Notes
# Note Start
note_number <- 0

#Table 1 notes
t1_note_len <- length(t1_notes)
t1_note_section <- tibble(`Note number` = paste0("[", note_number + seq_along(t1_notes), "]"),
                          `Note text` = t1_notes,
                          `Table number` = 'Table 1')
note_number <- note_number + t1_note_len

#Table 2 notes
t2_note_len <- length(t2_notes)
t2_note_section <- tibble(`Note number` = paste0("[", note_number + seq_along(t2_notes), "]"),
                          `Note text` = t2_notes,
                          `Table number` = 'Table 2')
note_number <- note_number + t2_note_len

#Table 5 notes
t5_note_len <- length(t5_notes)
t5_note_section <- tibble(`Note number` = paste0("[", note_number + seq_along(t5_notes), "]"),
                          `Note text` = t5_notes,
                          `Table number` = 'Table 5')
note_number <- note_number + t5_note_len

#Table 10 notes
t10_note_len <- length(t10_notes)
t10_note_section <- tibble(`Note number` = paste0("[", note_number + seq_along(t10_notes), "]"),
                          `Note text` = t10_notes,
                          `Table number` = 'Table 10')
note_number <- note_number + t10_note_len

#Table 11 notes
t11_note_len <- length(t11_notes)
t11_note_section <- tibble(`Note number` = paste0("[", note_number + seq_along(t11_notes), "]"),
                           `Note text` = t11_notes,
                           `Table number` = 'Table 11')
note_number <- note_number + t11_note_len

#Table 15 notes
t15_note_len <- length(t15_notes)
t15_note_section <- tibble(`Note number` = paste0("[", note_number + seq_along(t15_notes), "]"),
                           `Note text` = t15_notes,
                           `Table number` = 'Table 15')
note_number <- note_number + t15_note_len

#Table 16 notes
t16_note_len <- length(t16_notes)
t16_note_section <- tibble(`Note number` = paste0("[", note_number + seq_along(t16_notes), "]"),
                           `Note text` = t16_notes,
                           `Table number` = 'Table 16')
note_number <- note_number + t16_note_len

notes_all <- bind_rows(t1_note_section, t2_note_section, t5_note_section, t10_note_section,
                       t11_note_section, t15_note_section, t16_note_section )