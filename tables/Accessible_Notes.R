#Accessible Notes

note_section <- function(notes, table_name, note_number){
  # Helper function to create a section of notes
  # Takes notes created in the footnotes section, the Table name and the current note number
  tibble(`Note number` = paste0("[", note_number + seq_along(notes), "]"),
         `Note text` = notes,
         `Table number` = table_name)
}
# Note Start
note_number <- 0

#Table 1 notes
t1_note_len <- length(t1_notes)
t1_note_section <- note_section(t1_notes, 'Table 1', note_number)
note_number <- note_number + t1_note_len

#Table 2 notes
t2_note_len <- length(t2_notes)
t2_note_section <- note_section(t2_notes, 'Table 2', note_number)
note_number <- note_number + t2_note_len

#Table 3 notes
t3_note_len <- length(t3_notes)
t3_note_section <- note_section(t3_notes, 'Table 3', note_number)
note_number <- note_number + t3_note_len

#Table 4 notes
t4_note_len <- length(t4_notes)
t4_note_section <- note_section(t4_notes, 'Table 4', note_number)
note_number <- note_number + t4_note_len

#Table 5 notes
t5_note_len <- length(t5_notes)
t5_note_section <- note_section(t5_notes, 'Table 5', note_number)
note_number <- note_number + t5_note_len

#Table 6 notes
t6_note_len <- length(t6_notes)
t6_note_section <- note_section(t6_notes, 'Table 6', note_number)
note_number <- note_number + t6_note_len

#Table 7 notes
t7_note_len <- length(t7_notes)
t7_note_section <- note_section(t7_notes, 'Table 7', note_number)
note_number <- note_number + t7_note_len

#Table 10 notes
t10_note_len <- length(t10_notes)
t10_note_section <- note_section(t10_notes, 'Table 10', note_number)
note_number <- note_number + t10_note_len

#Table 11 notes
t11_note_len <- length(t11_notes)
t11_note_section <- note_section(t11_notes, 'Table 11', note_number)
note_number <- note_number + t11_note_len

#Table 15 notes
t15_note_len <- length(t15_notes)
t15_note_section <- note_section(t15_notes, 'Table 15', note_number)
note_number <- note_number + t15_note_len

#Table 16 notes
t16_note_len <- length(t16_notes)
t16_note_section <- note_section(t16_notes, 'Table 16', note_number)
note_number <- note_number + t16_note_len


notes_all <- bind_rows(t1_note_section, t2_note_section,
                       t3_note_section, t4_note_section,
                       t5_note_section, t6_note_section,
                       t7_note_section, t10_note_section,
                       t11_note_section, t15_note_section, t16_note_section )