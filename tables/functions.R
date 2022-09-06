# Functions for creating the tables from the CSVs
# Once complete, can look to move to the fcsrap package

# Based on the functions of the same name added by Francesca Bryden to the mojrap package. Small changes made.
# Used to write table data including the notes

multiple_cell_merge <- function(wb, sheet, rows, cols) {
  for(i in rows)
    openxlsx::mergeCells(wb = wb,
                         sheet = sheet,
                         cols = cols,
                         i)
}

### Notes functions #####################################################################

# This function adds footnotes to the table. 
#col_length is how many columns are merged together - a number
# Row height provides an option to adjust row heights for each row containing a note - a numerical vector
note_footer <- function(wb, sheet, start_row, notes, col_length, row_heights = NULL){
  ##Write notes to sheet below last table
  start_row_notes <- start_row + 2
  end_row_notes <- start_row_notes + length(notes)
  openxlsx::writeData(wb = wb,
                      sheet = sheet,
                      x = notes,
                      startRow = start_row_notes,
                      colNames = F)
  
  ##Create style for notes; small font size, left and top aligned
  note_style <- openxlsx::createStyle(
    fontName = "Arial",
    fontSize = "8",
    halign = "left",
    valign = "top",
    wrapText = TRUE
  )
  
  
  # Setting the row heights if available
  if (!is.null(row_heights)){
    openxlsx::setRowHeights(wb = wb,
                            sheet = sheet,
                            rows = start_row_notes:end_row_notes,
                            heights = row_heights)
    
    
  }
  #Format notes; merge and then add style
  multiple_cell_merge(wb = wb,
                      sheet = sheet,
                      rows = start_row_notes:end_row_notes,
                      cols = seq(col_length))
  openxlsx::addStyle(wb = wb,
                     sheet = sheet,
                     style = note_style,
                     rows = start_row_notes:end_row_notes,
                     cols = seq(col_length),
                     stack = T,
                     gridExpand = T)
  
  #Making the word Source and Notes which are usually the first and fourth element of the notes bold
  openxlsx::addStyle(wb = wb,
                     sheet = sheet,
                     style = openxlsx::createStyle(textDecoration = 'bold'),
                     rows = c(start_row_notes, start_row_notes + 3),
                     cols = seq(col_length),
                     stack = T,
                     gridExpand = T)

  
  #Remove gridlines from sheet
  openxlsx::showGridLines(wb = wb,
                          sheet = sheet,
                          showGridLines = FALSE)
}

# note helper functions
notes_select <- function(notes, table){
  notes %>% filter(`Table number` == table) %>% 
    pull(`Note text`)
}

make_reg_notes <- function(notes, source){
  notes <- c("Source:",
             glue(source),
             "",
             "Notes:",
             glue("{seq_along(notes)}) {notes}"))
}

get_note_frame <- function(table_name){
  # This gets the note numbers for a particular table after removing all the square brackets
  notes_import %>% filter(`Table number` == table_name)
  
}


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
  frame_list[[glue('Table {table_num}')]] %>% 
    filter(str_detect(Lookup, paste('-', lookup_code))) %>% 
    pull(`Note number`) %>% str_remove_all('[\\[\\]]')
}


# This function takes a list of tables, notes and the starting row and adds the data to the spreadsheet properly formatted.
write_formatted_table <- function(workbook, sheet_name, tables, notes, starting_row, quarterly_format = NULL, col_num = NULL, note_row_heights = NULL) {
  
  #Throw error if not passed a list of tables
  if(inherits(tables, "list") == FALSE) {stop("Tables must be provided as a list")}
  #Throw error if not passed a vector of notes
  if(is.vector(notes) == FALSE | inherits(notes, "list") == TRUE) {stop("Notes must be provided as a vector")}
  
  #setting column numbers
  if (is.null(col_num)){
    colnum <- seq_len(ncol(tables[[1]]))
    
  } else{
    colnum <- seq_len(col_num)
  }
  ##Set starting row parameters
  start_row <- starting_row
  
  ##Vectorise this across all tables
  for(i in seq_len(length(tables))) {
    #Set location of end row based on number of rows in a table
    if(is.data.frame(tables[[i]])) {
      end_row <- start_row + nrow(tables[[i]]) - 1
    } else {
      #If it's not a data frame, just write it to a single line
      end_row <- start_row
    }
    
    #Write data into place
    openxlsx::writeData(wb = workbook,
                        sheet = sheet_name,
                        x = tables[[i]],
                        startRow = start_row,
                        colNames = F)
    
    ##Add line at end of data if last table
    if(i == length(tables)) {
      openxlsx::addStyle(workbook,
                         sheet_name,
                         style = openxlsx::createStyle(
                           border = "bottom",
                           borderStyle = "thin"),
                         rows = end_row,
                         cols = colnum,
                         stack = T,
                         gridExpand = T)
    } 
    
    ##Set row heights for quarterly tables; every 4th row is taller to break up data
    #only for tables specified in quarterly_format argument
    if(i %in% quarterly_format) {
      all_rows <- seq(from = start_row, to = end_row, by = 1)
      quarterly_rows <- seq(from = start_row, to = end_row, by = 4)
      non_quarterly_rows <- setdiff(all_rows, quarterly_rows)
      openxlsx::setRowHeights(wb = workbook,
                              sheet = sheet_name,
                              rows = quarterly_rows,
                              heights = 26.25)
      
      #Styling Year columns not in the quarterly rows white to avoid repetition
      openxlsx::addStyle(wb = workbook,
                         sheet = sheet_name,
                         openxlsx::createStyle(fontColour = "white"),
                         rows = non_quarterly_rows,
                         cols = 1,
                         stack = T,
                         gridExpand = T)
      #Make sure all values are aligned to the bottom of the cell
      openxlsx::addStyle(workbook,
                         sheet_name,
                         openxlsx::createStyle(valign = "bottom"),
                         rows = start_row:end_row,
                         cols = colnum,
                         stack = T,
                         gridExpand = T)
    }
    
    #Create new start row value, 1 rows below previous table
    start_row <- end_row + 1
  }
  
  ##Write notes to sheet below last table
  note_footer(wb = workbook, 
              sheet = sheet_name, 
              start_row = end_row, 
              notes = notes, 
              col_length = colnum,
              row_heights = note_row_heights)
  
}

download_file_from_s3 <- function(s3_path, local_path, overwrite = FALSE) {
  # trim s3:// if included by the user and add it back in where required
  s3_path <- paste0("s3://", gsub('^s3://', "", s3_path))
  if (!(file.exists(local_path)) || overwrite) {
    local_path_folders <- stringr::str_extract(local_path, ".*[\\/]+")
    if(!is.na(local_path)) {
      dir.create(local_path_folders, showWarnings = FALSE, recursive = TRUE)
    }
    # download file
    tryCatch({
      # download file to tempfile()
      botor::s3_download_file(s3_path,
                              local_path,
                              force = overwrite)
    },
    error = function(cond){
      stop("\nError, file cannot be found. \nYou either don't have access to this bucket, or are using an invalid s3_path argument (file does not exist).")
    })
    
    
  } else {
    stop(paste0("The file already exists locally and you didn't specify",
                " overwrite=TRUE"))
  }
}


read_using <- function(FUN, s3_path, ...) {
  # trim s3:// if included by the user
  s3_path <- paste0("s3://", gsub('^s3://', "", s3_path))
  # find fileext
  file_ext <- paste0('.', tolower(tools::file_ext(s3_path)))
  # download file to tempfile()
  tmp <- botor::s3_download_file(s3_path,
                                 tempfile(fileext = file_ext),
                                 force = TRUE)
  FUN(tmp, ...)
}

#Helper function for adding notes
note_add <- function(wb, sheetName, table_no, startRow, notes){
  
  #Writing the Table Name
  openxlsx::writeData(wb, 
                      sheetName, 
                      paste('Table', table_no),
                      startRow = startRow,
                      colNames = F)
  
  #Styling by making it bold and larger
  openxlsx::addStyle(wb,
                     sheetName,
                     style = name_style,
                     rows = startRow,
                     cols = 1)
  
  note_length <- length(notes)
  
  #Creating the notes using note number to make the counts accurate
  note_no <- paste0("[", note_number + seq_along(notes), "]")
  notes_df <- tibble(`Note number` = note_no, 
                     `Note text` = notes)
  
  #Adding the notes to the sheet
  openxlsx::writeData(wb,
                      'Notes',
                      notes_df,
                      startRow = startRow + 1)
  
}

na_adder <- function(wb, sheet, value, cols, lengths, start_row ){
  # cols - vector of column numbers
  # lengths - how many times the value is repeated as a vector
  # values - what value for the NA
  # start row - Row to start with
  # What NA to add
  for (i in seq_along(cols)){
    data <- rep(value, lengths[[i]])
    openxlsx::writeData(wb = wb,
                        sheet = sheet,
                        x = data,
                        startRow = start_row,
                        startCol = cols[[i]],
                        colNames = F)
    
  }
  
}

table3_header <- function(wb, sheet, heading, start_row, start_col){
  # This function adds the headers to Table 3 and Table 4.
  #Start row here is the first row of the table
  
  # Years included in the table
  t3_year_head <- 2011:annual_year
  num_years <- annual_year - 2010
  
  # Last four quarters
  t3_qtr_head <- child_act_csv %>% distinct(Year, Qtr) %>% 
    filter(!is.na(Year), Qtr != '') %>% mutate(Quarter = paste0(Year, " Q", Qtr)) %>% 
    tail(4) %>% pull(-1)
  
  #Combining and taking the transpose to have in row format
  t3_head <- c(t3_year_head, NA, t3_qtr_head)
  
  tran_t3_head <- t(t3_head)
  
  #Writing the years and quarters, there are transposed so they are added row wise.
  openxlsx::writeData(wb = wb,
                      sheet = sheet,
                      x = t(t3_year_head),
                      startRow = start_row + 1,
                      startCol = start_col,
                      colNames = F)
  
  openxlsx::writeData(wb = wb,
                      sheet = sheet,
                      x = t(t3_qtr_head),
                      startRow = start_row + 1,
                      startCol = start_col + num_years + 1,
                      colNames = F)
  
  #Adding the Public Law or Private Law heading to the right row
  openxlsx::writeData(wb = wb,
                      sheet = sheet,
                      x = heading,
                      startRow = start_row,
                      startCol = start_col,
                      colNames = F)
  
  ##Create style for heading; centered and bottom aligned
  heading_style <- openxlsx::createStyle(
    fontName = "Arial",
    fontSize = "10",
    halign = "center",
    valign = "bottom",
    wrapText = FALSE,
    border = "bottom",
    borderStyle = "medium"
  )
  
  #Columns to merge in the list
  cols <- seq(start_col, start_col + length(t3_head) - 1)
  
  # Merging cells. Columns are the number of full years plus 5 additional ones (blank space and four quarters)
  openxlsx::mergeCells(wb = wb,
                       sheet = sheet,
                       cols = cols,
                       rows = start_row)
  
  # Adding border lines
  openxlsx::addStyle(wb = wb,
                     sheet = sheet,
                     style = heading_style,
                     rows = start_row,
                     cols = cols,
                     stack = T,
                     gridExpand = T)
  
  openxlsx::addStyle(wb = wb,
                     sheet = sheet,
                     style = openxlsx::createStyle(border = "bottom",
                                                   borderStyle = "none"),
                     rows = start_row,
                     cols = start_col + t3_years,
                     stack = T,
                     gridExpand = T)
  
  #Remove gridlines from sheet
  openxlsx::showGridLines(wb = wb,
                          sheet = sheet,
                          showGridLines = FALSE)
  
}


num_to_letter <- function(number){
  #Helper function to quickly turn a number into an excel letter
  letter_lookup %>% filter(`Column Number` == number) %>% 
    pull(`Column Letter`)
}

letter_to_num <- function(letter){
  #Helper function to quickly turn a number into an excel letter
  letter_lookup %>% filter(`Column Letter` == str_to_upper(letter)) %>% 
    pull(`Column Number`)
}


# Adds the class formula to column of data frame. Use with mutate and across
formula_add <- function(col){
  class(col) <- c(class(col), 'formula')
  col
}  

# Formatting Functions ##########################
#Creates a style to separate thousands
comma_formatter <- function(wb, sheet, data, cols){
  comma_style <- openxlsx::createStyle(numFmt = 'COMMA')
  openxlsx::addStyle(wb = wb,
                     sheet = sheet,
                     style = comma_style,
                     rows = seq(nrow(data)) + 5,
                     cols = cols,
                     gridExpand = TRUE,
                     stack = TRUE)
  
}

# A more generic style formatter than the comma formatter
style_formatter <- function(wb, sheet, data, cols, style){
  openxlsx::addStyle(wb = wb,
                     sheet = sheet,
                     style = style,
                     rows = seq(nrow(data)) + 5,
                     cols = cols,
                     gridExpand = TRUE,
                     stack = TRUE)
  
}

na_formatter <- function(wb, sheet, table, value = '[z]', startRow = 6, skipCols = 0, na_value = -1){
  # Replacing all -1 with [z]
  for (i in seq_len(nrow(table))){
    
    for (j in seq_len(ncol(table))){
      # If column isn't numeric then skip
      if (!is.numeric(table[[j]]) || j %in% skipCols){
        next
      }
      # If -1 then replace with value representing NA
      if ((table[[i, j]] == na_value)){
        openxlsx::writeData(wb = wb,
                            sheet = sheet, 
                            x = value,
                            startRow = startRow + i - 1,
                            startCol = j,
                            colNames = F)
      }
    }
  }
}

list_add <- function(wb, sheet, list, listRow, listCol, startRow, startCol){
  
  endRow = startRow + nrow(list) - 1
  data_rows <- seq(from = startRow, to = endRow)
  letter_start <- num_to_letter(startCol)
  
  openxlsx::writeData(wb = wb,
                      sheet = sheet,
                      x = list,
                      startRow = startRow,
                      startCol = startCol,
                      colNames = F)
  
  openxlsx::addStyle(wb = wb,
                     sheet = sheet,
                     openxlsx::createStyle(fontColour = "white"),
                     rows = data_rows,
                     cols = startCol,
                     stack = T,
                     gridExpand = T)
  
  dataValidation(wb = wb,
                 sheet = sheet,
                 cols = listCol,
                 rows = listRow,
                 type = "list",
                 value = glue("'{sheet}'!${letter_start}${startRow}:${letter_start}{endRow}"))
  
}

colwidth_format <- function(wb, sheet, data, widths = 'auto'){
 openxlsx::setColWidths(wb = wb,
                        sheet = sheet,
                        cols = 1:ncol(data),
                        widths = widths)
  
}

# Sums including na. Easier to have a separate function than change the keyword arguments
sum_na <- function(...){
  sum(..., na.rm = TRUE)
}

# Adds hyperlinks to the Contents Page
add_content_link <- function(sheet_name, startRow){
  openxlsx::writeFormula(wb = accessible_tables, 
                         "Contents",
                         startRow = startRow,
                         x = makeHyperlinkString(sheet = sheet_name, 
                                                 row = 1, col = 1, 
                                                 text = sheet_name))
}

# Helper function to replace zero with a replacement value
replace_zero <- function(x, replacement){
  case_when(x == 0 ~ replacement,
            TRUE ~ x)
}