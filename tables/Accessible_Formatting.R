#Accessible Formatting
#After initial file accessible table created, formatting added here
#Mostly this is adding a comma to thousands

accessible_tables <- openxlsx::loadWorkbook(file=paste0("fcsq_accessible.xlsx"))

# Creates a function to replace NA with [z]
comma_style <- openxlsx::createStyle(numFmt = 'COMMA')

#Pulling tab names and the data frames. Each table has 
sheet_names <- fcsq_a11y %>% filter(sheet_type == 'tables') %>% pull(tab_title)
table_list <- fcsq_a11y %>% filter(sheet_type == 'tables') %>% pull(table)

# List of columns that have comma formtting applied in each table. 99 represents no formatting applied
comma_cols <- list(4:ncol(table_list[[1]]),
                     4:ncol(table_list[[2]]),
                     3:ncol(table_list[[3]]),
                     3:ncol(table_list[[4]]),
                     3:ncol(table_list[[5]]),
                     3:ncol(table_list[[6]]),
                     4:ncol(table_list[[7]]),
                     4:ncol(table_list[[8]]),
                     4:ncol(table_list[[9]]),
                     #Table 8 and 9 only have a single column that is formatted
                     3,
                     3,
                     #Table 10 has every two columns formatted
                     seq(from = 4, to = ncol(table_list[[12]]), by = 2),
                     4:ncol(table_list[[13]]),
                     # Divorce has a mixture of columns. Subject to change
                     c(5, 6, 9, 12, 13),
                     c(3, seq(from = 4, to = ncol(table_list[[15]]), by = 2)),
                     #Divorce Progression does not need any 
                     99,
                     3:ncol(table_list[[17]]),
                     4:ncol(table_list[[18]]),
                     #FMPO AND FGM don't require anything either
                     99,
                     99,
                   3:ncol(table_list[[21]]),
                   3:ncol(table_list[[22]]),
                   3:ncol(table_list[[23]]),
                   3:ncol(table_list[[24]]),
                   3:ncol(table_list[[25]]),
                   3:ncol(table_list[[26]]),
                   seq(from = 5, to = 20, by = 5)
                   
                   )
                        

# Adds commas at the thousand separator and changes any na and suppressed values with their replacements
pwalk(list(sheet_names, table_list, comma_cols), ~comma_formatter(accessible_tables, ..1, ..2, ..3))
pwalk(list(sheet_names, table_list), ~ na_formatter(accessible_tables, ..1, ..2, na_value = na_value))
pwalk(list(sheet_names, table_list), ~ na_formatter(accessible_tables, ..1, ..2, na_value = suppress_value, value = '[c]'))


# Adds hyperlinks to the Contents Page
add_content_link <- function(sheet_name, startRow){
  openxlsx::writeFormula(wb = accessible_tables, 
                         "Contents",
                         startRow = startRow,
                         x = makeHyperlinkString(sheet = sheet_name, 
                                                 row = 1, col = 1, 
                                                 text = sheet_name))
}

# A list containing vectors for the worksheets used to add hyperlinks to the Contents Page
content_list <- list(c('Notes', table_names), 
             seq(4, nrow(contents_df) + 3))


pwalk(content_list, add_content_link)


openxlsx::saveWorkbook(accessible_tables, paste0(path_to_project,"test_output_access.xlsx"), overwrite = TRUE)

