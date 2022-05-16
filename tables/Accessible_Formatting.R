#Accessible Formatting
#After initial file accessible table created, formatting added here
#Mostly this is adding a comma to thousands

accessible_tables <- openxlsx::loadWorkbook(file=paste0("fcsq_accessible.xlsx"))

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
comma_style <- openxlsx::createStyle(numFmt = 'COMMA')

table_names <- fcsq_a11y %>% filter(sheet_type == 'tables') %>% pull(tab_title)
table_list <- fcsq_a11y %>% filter(sheet_type == 'tables') %>% pull(table)

# List of columns that have comma formtting applied in each table. 99 represents no formatting applied
comma_cols <- list(4:ncol(table_list[[1]]),
                     5:ncol(table_list[[2]]),
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
                   3:ncol(table_list[[24]])
                   )
                        


for (i in seq_along(table_names)){
  comma_formatter(accessible_tables, table_names[[i]], table_list[[i]], comma_cols[[i]])
}



openxlsx::saveWorkbook(accessible_tables, paste0(path_to_project,"test_output_access.xlsx"), overwrite = TRUE)

