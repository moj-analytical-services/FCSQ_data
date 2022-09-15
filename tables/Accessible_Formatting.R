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

# Rounding to 1dp
round_sheet_names <- c("Table_8", "Table_9", "Table_10", "Table_25" )
round_cols <- list(c(4, 5), c(4, 5), 
                   seq(from = 5, to = ncol(t10_accessible), by = 2),
                   c(6, 7, 8, 9, 11, 12, 13, 14, 16, 17, 18, 19, 21, 22, 23, 24)
                   )
round_table_list <- list(t8_accessible, t9_accessible, t10_accessible, t24_accessible)
round_style <- openxlsx::createStyle(numFmt = "0.0")

pwalk(list(round_sheet_names, round_table_list, round_cols), ~style_formatter(accessible_tables, ..1, ..2, ..3, style = round_style))

# Rounding to 0dp percentage
perc_sheet_names <- c("Table_8", "Table_12", "Table_14" )
perc_cols <- list(6, 13, 2:ncol(t14_accessible))
perc_table_list <- list(t8_accessible, t12_accessible, t14_accessible)
perc_style <- openxlsx::createStyle(numFmt = "0%")

pwalk(list(perc_sheet_names, perc_table_list, perc_cols), ~style_formatter(accessible_tables, ..1, ..2, ..3, style = perc_style))

#Rounding to 1dp pecentage
style_formatter(accessible_tables, "Table_13", t13_accessible, seq(from = 5, to = ncol(t13_accessible), by = 2), openxlsx::createStyle(numFmt = "0.0%"))

#Dealing with na and suppression
pwalk(list(sheet_names, table_list), ~ na_formatter(accessible_tables, ..1, ..2, na_value = na_value))
na_formatter(accessible_tables, 'Table_23', t23_accessible, na_value = suppress_value, value = '[c]' )



# A list containing vectors for the worksheets used to add hyperlinks to the Contents Page
content_list <- list(c('Notes', sheet_names), 
             seq(4, nrow(contents_df) + 3))

# Adding hyperlinks to notes and tables on contents page
pwalk(content_list, add_content_link)

openxlsx::writeFormula(wb = accessible_tables,
                       sheet = 'Cover',
                       startRow = 11,
                       x = '=HYPERLINK("mailto:familycourt.statistics@gov.uk", "familycourt.statistics@gov.uk")'
                       )


# Note Colwidth set
openxlsx::setColWidths(wb = accessible_tables,
                       sheet = 'Notes',
                       cols = c(1, 2, 3),
                       widths = c(15.11, 15.11, 128) 
                       )

# Setting Colwidth for Tables with long pieces of text
colwidth_sheet <- c('Table_3a', 'Table_3b', 'Table_4a', 'Table_4b', 
                    'Table_10', 'Table_12b', 'Table_14', 'Table_16',
                    'Table_24', 'Table_25')
colwidth_cols <- list(c(2, 3),
                      c(2, 3),
                      c(2, 3),
                      c(2, 3),
                      1,
                      3,
                      1,
                      3,
                      4,
                      4
                      )

colwidths <- list(c(39.1, 39.1),
                  c(39.1, 39.1),
                  c(39.1, 39.1),
                  c(39.1, 39.1),
                  27.3,
                  23.5,
                  23.5,
                  18.5,
                  17.8,
                  20.5)

pwalk(list(colwidth_sheet, colwidth_cols, colwidths), openxlsx::setColWidths, wb = accessible_tables)

# Exporting the finished table
openxlsx::saveWorkbook(accessible_tables, paste0(path_to_project, glue("Accessible Family Court Tables ({pub_months_short} {pub_year}).xlsx")), overwrite = TRUE)
#openxlsx::saveWorkbook(accessible_tables, paste0(path_to_project,"test_output_access.xlsx"), overwrite = TRUE)

