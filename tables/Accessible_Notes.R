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
notes_all <- tibble()

# Loops through notes_list to create a data frame containing the number of notes and their table numbers
for (i in seq_along(notes_list)){
  current <- notes_list[[i]]
  note_len <- length(current)
  note_part <- note_section(current, glue('Table {i}'), note_number)
  note_number <- note_number + note_len
  notes_all <- bind_rows(notes_all, note_part)
}
