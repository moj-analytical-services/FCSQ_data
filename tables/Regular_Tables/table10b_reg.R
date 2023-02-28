# Code to fill in Table 10b
# Formula table so everything is written in the script

# Content #########################################################################################

# years and quarters
table10b_alt <- table_10b_lookup %>% separate(Lookup, c("Case_type", "Year", "Quarter"), sep = '\\|', convert = TRUE)

time_div_dates_annual <- table10b_alt %>% distinct(Year) %>% mutate(Quarter = NA) %>% filter(Year <= annual_year) %>% arrange(Year, Quarter)

time_div_dates_quarter <- table10b_alt %>% distinct(Year, Quarter) %>% filter(Quarter != '') %>% arrange(Year, Quarter)


time_div_rowcount <- nrow(time_div_dates_annual) + nrow(time_div_dates_quarter)

# formulae
t10b_start <- 13
start_col <- 3

#drop down list info - This is the cell containing the list
t10b_list_col <- 2
t10b_list_letter <- num_to_letter(t10b_list_col)
t10b_list_row <- 7

#Columns in Excel sheet. There are blank columns that are missed out.
columns <- c(1,2,4,5,7,8,10,11,13,14)

#Columns that the vlookup looks up from the source file
lookup_cols <- c(2,3,4,5,6,7,8,9,12,13)

for (i in 1:time_div_rowcount) {
  col_count <- 1
  for (j in columns) {
    lookup_col <- lookup_cols[col_count]
    formula <- glue('=VLOOKUP(${t10b_list_letter}${t10b_list_row}&"|"&$A{i+t10b_start-1}&"|"&$B{i+t10b_start-1},Table_10b_source!$A:$M,{lookup_col},FALSE)')
    writeFormula(wb=template,
                 sheet='Table_10b',
                 x=formula,
                 startRow = i+t10b_start-1,
                 startCol = j+start_col-1)
    col_count <- col_count + 1
  }
}

# time period
if(pub_quarter==4){
  
  timeperiod10b <- paste0("Annually 2022 - ", pub_year, " and quarterly Q3 2022 - Q", pub_quarter," ", pub_year)
  
} else {
  
  timeperiod10b <- paste0("Annually 2022 - ", pub_year-1, " and quarterly Q3 2022 - Q", pub_quarter," ", pub_year)
}


# Output ##########################################################################################

# time period
openxlsx::writeData(wb = template,
                    sheet = 'Table_10b',
                    x = timeperiod10b,
                    startRow = 3,
                    colNames = F)

# table
#setting row heights
t10b_row_heights <- rep(15, length(notes10b))

t10b_col_length <- 16
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_10b', 
                      tables = list(time_div_dates_annual, time_div_dates_quarter), 
                      notes = notes10b, 
                      starting_row = t10b_start, 
                      quarterly_format = c(2),
                      col_num = t10b_col_length,
                      note_row_heights = t10b_row_heights)
