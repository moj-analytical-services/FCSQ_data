#Accessible Notes
notes_wb <- openxlsx::createWorkbook()
openxlsx::addWorksheet(notes_wb, 'Notes')

#Different Styles that are used
title_style <- openxlsx::createStyle(
  valign = 'top',
  textDecoration = 'bold'
)

name_style <- openxlsx::createStyle(
  fontSize = 13,
  textDecoration = 'bold')

#Adding the first cell
openxlsx::writeData(notes_wb, 'Notes', 'Notes',
                    startRow = 1,
                    colNames = F)

openxlsx::setRowHeights(notes_wb,
                        'Notes',
                        rows = 1,
                        heights = 31.5)

openxlsx::addStyle(notes_wb,
                   'Notes',
                   style = title_style,
                   rows = 1,
                   cols = 1)


#Setting start counts for the notes
starting_row <- 2
note_number <- 0

#Table 15
t15_note_len <- length(t15_notes)
note_add(notes_wb, 'Notes', table_no = 15, startRow = starting_row, t15_notes)

note_number <- note_number + t15_note_len
starting_row <- starting_row + t15_note_len + 2

openxlsx::saveWorkbook(notes_wb, paste0(path_to_project,"note2_output.xlsx"), overwrite = TRUE)
                    