# Accessible Tables 

# A cover page, with subheaded sections of information
cover_df <- tribble(
  ~"Subsection title", ~"Subsection body",
  "Description", "A set of tables relating to Family Court Statistics",
  "Format", "A set of tables."
)

# A contents page, with the sheet names and titles
contents_df <- tribble(
  ~"Sheet name", ~"Sheet title",
  "Notes", "Notes",
  "Table 15", "Number of applicantions and disposals made for one or more types of financial remedy orders, in England and Wales"
)

# A notes page, notes_all is made from the update excel file
note_no <- paste0("[", seq_len(length(notes_all)), "]")
notes_df <- tibble(`Note number` = note_no, 
                   `Note text` = notes_all)

notes_df2 <- tribble(
  ~"Note number", ~"Note text",
  "[c]", "Confidential: suppressed.",
  "[z]", "Not applicable.")

notes_df <- bind_rows(notes_df2, notes_df)
fcsq_a11y <- new_a11ytable(
  tab_titles = c("Cover", "Contents", "Notes", "Table 15"),
  sheet_types = c("cover", "contents", "notes", "tables"),
  sheet_titles = c(
    "The mtcars demo datset: 'Motor Trend Car Road Tests'",
    "Table of contents",
    "Notes",
    "Financial Remedy"
  ),
  sources = c(
    NA_character_,
    NA_character_,
    NA_character_, 
    "HMCTS FamilyMan and Core Case Data"
  ),
  table_names = c(
    "cover_sheet",
    "table_of_contents",
    "notes_table",
    "Accessible_15"
  ),
  tables = list(
    cover_df,
    contents_df,
    notes_df,
    t15_accessible
  )
)

fcsq_wb <- create_a11y_wb(fcsq_a11y)
saveWorkbook(fcsq_wb, "fcsq_accessible.xlsx", overwrite = TRUE)
