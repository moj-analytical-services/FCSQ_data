# Code to fill in Table 10
# Formula table so everything is written in the script

# Content #########################################################################################

# years and quarters
table10_alt <- table_10_lookup %>% separate(Lookup, c("Case_type", "Year", "Quarter"), sep = '\\|', convert = TRUE)

time_dates_annual <- table10_alt %>% distinct(Year) %>% mutate(Quarter = NA) %>% filter(Year <= annual_year)

time_dates_quarter <- table10_alt %>% distinct(Year, Quarter) %>% filter(Quarter != '')   


time_rowcount <- nrow(time_dates_annual) + nrow(time_dates_quarter)

# formulae
t10_start <- 15
start_col <- 3

#drop down list info - This is the cell containing the list
t10_list_col <- 2
t10_list_letter <- num_to_letter(t10_list_col)
t10_list_row <- 9

#Columns in Excel sheet. There are blank columns that are missed out.
columns <- c(1,2,4,5,7,8,10,11,13,14)

#Columns that the vlookup looks up from the source file
lookup_cols <- c(2,3,4,5,6,7,8,9,12,13)

for (i in 1:time_rowcount) {
  col_count <- 1
  for (j in columns) {
    lookup_col <- lookup_cols[col_count]
    formula <- glue('=VLOOKUP(${t10_list_letter}${t10_list_row}&"|"&$A{i+t10_start-1}&"|"&$B{i+t10_start-1},Table_10_source!$A:$M,{lookup_col},FALSE)')
    writeFormula(wb=template,
                 sheet='Table_10',
                 x=formula,
                 startRow = i+t10_start-1,
                 startCol = j+start_col-1)
    col_count <- col_count + 1
  }
}

# time period
if(pub_quarter==4){
  
  timeperiod10 <- paste0("Annually 2011 - ", pub_year, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
  
} else {
  
  timeperiod10 <- paste0("Annually 2011 - ", pub_year-1, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
}


# Output ##########################################################################################

# time period
openxlsx::writeData(wb = template,
                    sheet = 'Table_10',
                    x = timeperiod10,
                    startRow = 3,
                    colNames = F)

# table
#setting row heights
t10_row_heights <- rep(15, length(notes10))
t10_note_adjust <- note_adjuster(notes = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14), table = 10)
t10_row_heights[t10_note_adjust] <- c(21.75, 21, 33, 14.7, 13.2, 21, 21, 21, 13.2, 37.2, 26.7, 22.2, 21, 33)

t10_col_length <- 16
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_10', 
                      tables = list(time_dates_annual, time_dates_quarter), 
                      notes = notes10, 
                      starting_row = t10_start, 
                      quarterly_format = c(2),
                      col_num = t10_col_length,
                      note_row_heights = t10_row_heights)
