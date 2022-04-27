#Table 3 Regular
#This is a formula column

# formulae
start_row <- 11
end_row <- 48
start_col <- 2
t3_years <- annual_year - 2010
lookup_row <- nrow(table_3_lookup) + 1


#Setting information for Table 3
t3_rows_all <- seq(start_row, end_row) #full set of rows in the table
t3_empty <- c(11, 15, 16, 24, 25, 29, 30, 33, 34, 38, 39, 45, 46) #rows excluded because they are blank
t3_form_rows <- setdiff(t3_rows_all, t3_empty) #rows that have formulas in them

#Columns to add. Years since 2010 have their own column then a space for four quarters
t3_columns <- c(1:t3_years, seq(t3_years +2, t3_years +5))

glue("=VLOOKUP($AJ{i}&$A$7&$B$9&$AJ$6,'Table 3_4_source'!$A$2:$Q${lookup_row},{lookup_col},FALSE)")
for (i in t3_form_rows) {
  lookup_col <- 2
  for (j in t3_columns) {
    formula <- glue("=VLOOKUP($AJ{i}&$A$8&$B$9&$AJ$7,'Table 3_4_source'!$A$2:$Q${lookup_row},{lookup_col},FALSE)")
    writeFormula(wb=template,
                 sheet='Table_3',
                 x=formula,
                 startRow = i,
                 startCol = j + start_col - 1)
    lookup_col <- lookup_col + 1
    
  }
}