library(a11ytables)
library(tibble)

# A cover page, with subheaded sections of information
cover_df <- tribble(
  ~"Subsection title", ~"Subsection body",
  "Description", "The data was extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973–74 models)",
  "Format", "A data frame with 32 observations on 11 (numeric) variables."
)

# A contents page, with the sheet names and titles
contents_df <- tribble(
  ~"Sheet name", ~"Sheet title",
  "Notes", "Notes",
  "Table 1", "Motor Trend Car Road Tests"
)

# A notes page, a lookup of codes to information 
notes_df <- tribble(
  ~"Note number", ~"Note text",
  "[c]", "Confidential: suppressed.",
  "[z]", "Not applicable.",
  "[1]", "Hocking [original transcriber]'s noncrucial coding of the Mazda's rotary engine as a straight six-cylinder engine and the Porsche's flat engine as a V engine, as well as the inclusion of the diesel Mercedes 240D, have been retained to enable direct comparisons to be made with previous analyses.",
  "[2]", "Test note.",
  "[3]", "Test note."
)

# An example statistical table, made using the in-built mtcars dataset
# Suppression ('[c]') and notes markers ('[1]') added as examples 
cars_df <- tibble::rownames_to_column(mtcars, "car") |>
  subset(select = c("car", "mpg", "cyl", "disp", "hp"))
cars_df[1, "mpg"] <- "[c]"  # suppress
cars_df[2:nrow(cars_df) , "cyl"] <- "[c]"  # suppress
notes_cars <- c("Mazda RX4", "Mazda RX4 Wag", "Porsche 914-2", "Merc 240D")
cars_df[["Notes"]] <- ifelse(  # notes column
  cars_df[["car"]] %in% notes_cars,
  "[1]", "[z]"
)
names(cars_df) <- c(  # notes in column headers
  "Car",
  "Miles per gallon [2]",
  "Cylinders [2, 3]",
  "Displacement [note 2]",
  "Horsepower [note]",
  "Notes"
)

a11ytable_new <- new_a11ytable(
  tab_titles = c("Cover", "Contents", "Notes", "Table 1"),
  sheet_types = c("cover", "contents", "notes", "tables"),
  sheet_titles = c(
    "The mtcars demo datset: 'Motor Trend Car Road Tests'",
    "Table of contents",
    "Notes",
    "Motor Trend Car Road Tests"
  ),
  sources = c(
    NA_character_,
    NA_character_,
    NA_character_, 
    "Motor Trend (1974)"
  ),
  table_names = c(
    "cover_sheet",
    "table_of_contents",
    "notes_table",
    "demographic_benchmarks"
  ),
  tables = list(
    cover_df,
    contents_df,
    notes_df,
    cars_df
  )
)

a11y_wb <- create_a11y_wb(a11y_new)
saveWorkbook(a11y_wb, "publication.xlsx")