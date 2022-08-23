#Accessible Formatting
#After initial file accessible table created, formatting added here
#Mostly this is adding a comma to thousands

accessible_tables <- openxlsx::loadWorkbook(file=paste0("fcsq_accessible.xlsx"))

# Creates a function to replace NA with [z]
comma_style <- openxlsx::createStyle(numFmt = 'COMMA')

#Pulling tab names and the data frames. Each table has 
sheet_names <- fcsq_a11y %>% filter(sheet_type == 'tables') %>% pull(tab_title)
table_list <- fcsq_a11y %>% filter(sheet_type == 'tables') %>% pull(table)

# Select digits from sheet names and adding t at the front to use as names for the table list
access_table_numbers <- paste0('t', contents_df %>% filter(`Sheet name` != 'Notes') %>% pull(`Sheet name`) %>% str_extract('\\d+.?'))
names(table_list) <- access_table_numbers

# List of columns that have comma formatting applied in each table. 99 represents no formatting applied
comma_cols <- list(4:ncol(table_list[['t1']]),
                   #Children Act Tables
                     4:ncol(table_list[['t2']]),
                     3:ncol(table_list[['t3a']]),
                     3:ncol(table_list[['t3b']]),
                     3:ncol(table_list[['t4a']]),
                     3:ncol(table_list[['t4b']]),
                     4:ncol(table_list[['t5']]),
                     4:ncol(table_list[['t6']]),
                     4:ncol(table_list[['t7']]),
                     #Table 8 and 9 only have a single column that is formatted
                     3,
                     3,
                     #Table 10 has every two columns formatted
                     seq(from = 4, to = ncol(table_list[['t10']]), by = 2),
                     4:ncol(table_list[['t11']]),
                     # Divorce has a mixture of columns. Subject to change
                     c(6, 7, 10),
                     5,
                     c(3, seq(from = 4, to = ncol(table_list[['t13']]), by = 2)),
                     #T14 does not need any 
                     99,
                     3:ncol(table_list[['t15']]),
                     4:ncol(table_list[['t16']]),
                     #FMPO AND FGM don't require anything either
                     99,
                     99,
                   3:ncol(table_list[['t19']]),
                   3:ncol(table_list[['t20']]),
                   3:ncol(table_list[['t21']]),
                   3:ncol(table_list[['t22']]),
                   3:ncol(table_list[['t23']]),
                   3:ncol(table_list[['t24']]),
                   seq(from = 5, to = 20, by = 5)
                   
                   )
                        

# Adds commas at the thousand separator and changes any na and suppressed values with their replacements
pwalk(list(sheet_names, table_list, comma_cols), ~comma_formatter(accessible_tables, ..1, ..2, ..3))
pwalk(list(sheet_names, table_list), ~ na_formatter(accessible_tables, ..1, ..2, na_value = na_value))
na_formatter(accessible_tables, 'Table 23', t23_accessible, na_value = suppress_value, value = '[c]' )
#pwalk(list(sheet_names, table_list), ~ na_formatter(accessible_tables, ..1, ..2, na_value = suppress_value, value = '[c]'))


# A list containing vectors for the worksheets used to add hyperlinks to the Contents Page
content_list <- list(c('Notes', sheet_names), 
             seq(4, nrow(contents_df) + 3))

# Adding hyperlinks to notes and tables on contents page
pwalk(content_list, add_content_link)

openxlsx::writeFormula(wb = accessible_tables,
                       sheet = 'Cover',
                       startRow = 10,
                       x = '=HYPERLINK("mailto:familycourt.statistics@gov.uk", "familycourt.statistics@gov.uk")'
                       )


# Note Colwidth set
openxlsx::setColWidths(wb = accessible_tables,
                       sheet = 'Notes',
                       cols = c(1, 2, 3),
                       widths = c(15.11, 15.11, 128) 
                       )
openxlsx::saveWorkbook(accessible_tables, paste0(path_to_project, glue("Accessible Family Court Tables ({pub_months_short} {pub_year}).xlsx")), overwrite = TRUE)
#openxlsx::saveWorkbook(accessible_tables, paste0(path_to_project,"test_output_access.xlsx"), overwrite = TRUE)

