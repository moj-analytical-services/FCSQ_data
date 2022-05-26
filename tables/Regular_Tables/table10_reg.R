# Code to fill in Table 10
# Formula table so everything is written in the script

# Content #########################################################################################

# years and quarters
table10_alt <- table_10_lookup %>% separate(Lookup, c("Case_type", "Year", "Quarter"), sep = '\\|', convert = TRUE)

time_dates_annual <- table10_alt %>% distinct(Year) %>% mutate(Quarter = NA)

time_dates_quarter <- table10_alt %>% distinct(Year, Quarter) %>% filter(Quarter != '')   


time_rowcount <- nrow(time_dates_annual) + nrow(time_dates_quarter)

# formulae
start_row <- 13
start_col <- 3
#Columns in Excel sheet. There are blank columns that are missed out.
columns <- c(1,2,4,5,7,8,10,11,13,14)

#Columns that the lookup refers to
lookup_cols <- c(2,3,4,5,6,7,8,9,12,13)

for (i in 1:time_rowcount) {
  col_count <- 1
  for (j in columns) {
    lookup_col <- lookup_cols[col_count]
    formula <- paste0('=VLOOKUP($B$7&"|"&$A', i+start_row-1, '&"|"&$B', i+start_row-1, ',Table_10_source!$A:$M,', lookup_col, ',FALSE', ')')
    writeFormula(wb=template,
                 sheet='Table_10',
                 x=formula,
                 startRow = i+start_row-1,
                 startCol = j+start_col-1)
    col_count <- col_count + 1
  }
}

# time period
if(pub_quarter==4){
  
  timeperiod10 <- paste0("Annually 2011 - ", pub_year, " and quarterly Q1 2012 - Q", pub_quarter," ", pub_year)
  
} else {
  
  timeperiod10 <- paste0("Annually 2011 - ", pub_year-1, " and quarterly Q1 2012 - Q", pub_quarter," ", pub_year)
}


# Output ##########################################################################################

# time period
openxlsx::writeData(wb = template,
                    sheet = 'Table_10',
                    x = timeperiod10,
                    startRow = 3,
                    colNames = F)

# table
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_10', 
                      tables = list(time_dates_annual, time_dates_quarter), 
                      notes = notes10, 
                      starting_row = start_row, 
                      quarterly_format = c(2),
                      col_num = 16)

# Adding source
openxlsx::writeData(wb = template,
                    sheet = 'Table_10_source',
                    x = table_10_lookup)