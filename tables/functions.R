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

write_formatted_table <- function(workbook, sheet_name, tables, notes, starting_row, quarterly_format = NULL, lookup_flag = NULL) {
  
  #Throw error if not passed a list of tables
  if(inherits(tables, "list") == FALSE) {stop("Tables must be provided as a list")}
  #Throw error if not passed a vector of notes
  if(is.vector(notes) == FALSE | inherits(notes, "list") == TRUE) {stop("Notes must be provided as a vector")}
  
  #setting column numbers
  if (is.null(lookup_flag)){
    colnum <- seq_len(ncol(tables[[1]]))
    
  } else{
    colnum <- seq_len(lookup_flag)
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
    
    ##Add line at end of data (but only if data is a data frame)
    if(is.data.frame(tables[[i]])) {
      openxlsx::addStyle(workbook,
                         sheet_name,
                         style = openxlsx::createStyle(
                           border = "bottom",
                           borderStyle = "thin"),
                         rows = end_row,
                         cols = colnum,
                         stack = T,
                         gridExpand = T)
    } else{
      
      #If the provided data is not a data frame, just make it bold (used to differentiate headers)
      openxlsx::addStyle(workbook,
                         sheet_name,
                         openxlsx::createStyle(textDecoration = "bold"),
                         rows = start_row,
                         cols = 1,
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
  start_row_notes <- end_row + 2
  end_row_notes <- start_row_notes + length(notes)
  openxlsx::writeData(wb = workbook,
                      sheet = sheet_name,
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
  #Format notes; merge and then add style
  multiple_cell_merge(wb = workbook,
                      sheet = sheet_name,
                      rows = start_row_notes:end_row_notes,
                      cols = colnum)
  openxlsx::addStyle(wb = workbook,
                     sheet = sheet_name,
                     style = note_style,
                     rows = start_row_notes:end_row_notes,
                     cols = colnum,
                     stack = T,
                     gridExpand = T)
  
  
  #Remove gridlines from sheet
  openxlsx::showGridLines(wb = workbook,
                          sheet = sheet_name,
                          showGridLines = FALSE)
  
  #Attempting row heights
  openxlsx::setRowHeights(wb = workbook,
                          sheet = sheet_name,
                          rows = start_row_notes:end_row_notes,
                          heights = rep("auto", length(end_row_notes - start_row_notes + 1)))
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