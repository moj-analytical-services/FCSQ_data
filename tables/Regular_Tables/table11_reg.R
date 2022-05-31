# Code to fill in Table 11
# Formula table so everything is written in the script

# Content #########################################################################################

# years and quarters
table11_alt <- table_11_lookup %>% separate(Lookup, c("Case_type", "Year", "Quarter"), sep = '\\|', convert = TRUE)

legrep_dates_annual <- table11_alt %>% distinct(Year) %>% mutate(Quarter = NA)

legrep_dates_quarter <- table11_alt %>% distinct(Year, Quarter) %>% filter(Quarter != '')   


legrep_rowcount <- nrow(legrep_dates_annual) + nrow(legrep_dates_quarter)

# formulae
start_row <- 12
start_col <- 3
columns <- c(1,2,4,5,7,8,10)

for (i in 1:legrep_rowcount) {
  
  lookup_col <- 2
  
  for (j in columns) {
    formula <- paste0('=VLOOKUP($B$7&"|"&$A', i+start_row-1, '&"|"&$B', i+start_row-1, ',Table_11_source!$A:$H,', lookup_col, ',FALSE',  ')')
    writeFormula(wb=template,
                 sheet='Table_11',
                 x=formula,
                 startRow = i+start_row-1,
                 startCol = j+start_col-1)
    lookup_col <- lookup_col + 1
  }
}

# time period
if(pub_quarter==4){
  
  timeperiod11 <- paste0("Annually 2011 - ", pub_year, " and quarterly Q1 2012 - Q", pub_quarter," ", pub_year)
  
} else {
  
  timeperiod11 <- paste0("Annually 2011 - ", pub_year-1, " and quarterly Q1 2012 - Q", pub_quarter," ", pub_year)
}


# Output ##########################################################################################

# time period
openxlsx::writeData(wb = template,
                    sheet = 'Table_11',
                    x = timeperiod11,
                    startRow = 3,
                    colNames = F)

# table
t11_row_heights <- rep(15, length(notes11))
t11_row_heights[seq(from = 5, to = length(notes11))] <- c(46.5, 12.75, 21, 12.75, 12.75, 33.75, 37.5, 30, 21, 21, 21, 43.5, 48, 27, 27)

write_formatted_table(workbook = template, 
                      sheet_name = 'Table_11', 
                      tables = list(legrep_dates_annual, legrep_dates_quarter), 
                      notes = notes11, 
                      starting_row = start_row, 
                      quarterly_format = c(2),
                      col_num = 12,
                      note_row_heights = t11_row_heights)
# Adding source
openxlsx::writeData(wb = template,
                    sheet = 'Table_11_source',
                    x = table_11_lookup)
