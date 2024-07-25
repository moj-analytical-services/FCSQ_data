#Table 15
openxlsx::writeData(notes_wb, 
                    'Notes', 
                    'Table 15',
                    startRow = starting_row,
                    colNames = F)

openxlsx::addStyle(notes_wb,
                   'Notes',
                   style = name_style,
                   rows = starting_row,
                   cols = 1)

note_length <- length(t15_notes)
note_no <- paste0("[", note_number + seq_along(t15_notes), "]")
notes_df <- tibble(`Note number` = note_no, 
                   `Note text` = t15_notes)

openxlsx::writeData(notes_wb,
                    'Notes',
                    notes_df,
                    startRow = starting_row + 1)

note_number <- note_number + note_length
starting_row <- starting_row + note_length + 1

openxlsx::saveWorkbook(notes_wb, paste0(path_to_project,"note_output.xlsx"), overwrite = TRUE)