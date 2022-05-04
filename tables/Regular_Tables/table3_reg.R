#Table 3 Regular
#This is a formula column

# formulae. Start row is the first row under the Order type heading.
# End row is the last row of data
#Start col is the first column where data is added.
#Head row is the row where the heading starts
head_row <- 9
start_row <- 11
end_row <- 48
start_col <- 2
t3_priv_row_start <- 35

t3_years <- annual_year - 2010  #Number of full years in the table
lookup_row <- nrow(table_3_lookup) + 1

#Setting row information for Table 3
t3_rows_all <- seq(start_row, end_row) #full set of rows in the table
t3_empty <- c(11, 15, 16, 24, 25, 29, 30, 33, 34, 38, 39, 45, 46) #rows excluded because they are blank
t3_pub_rows <- setdiff(t3_rows_all, t3_empty) #rows that have formulas in them

#Number of Columns to add. Years since 2010 have their own column then a space for four quarters
t3_columns <- c(seq(1,t3_years), seq(t3_years +2, t3_years +5))
t3_pub_columns <- start_col + t3_columns - 1



#Main Public Law formulae
for (i in t3_pub_rows) {
  lookup_col <- 2
  for (j in t3_pub_columns) {
    formula <- glue("=VLOOKUP($AJ{i}&$A$8&$B$9&$AJ$7,'Table 3_4_source'!$A$2:$Q${lookup_row},{lookup_col},FALSE)")
    writeFormula(wb=template,
                 sheet='Table_3',
                 x=formula,
                 startRow = i,
                 startCol = j)
    lookup_col <- lookup_col + 1
    
  }
}

#Some orders have errors without this addition
glue("=VLOOKUP($AJ{i}&$A$7&$B$9&$AJ$6,'Table 3_4_source'!$A$2:$Q${lookup_row},{lookup_col},FALSE)")
for (i in c(37, 44)) {
  lookup_col <- 2
  for (j in t3_pub_columns) {
    formula <- glue("=IFERROR(VLOOKUP($AJ{i}&$A$8&$B$9&$AJ$7,'Table 3_4_source'!$A$2:$Q${lookup_row},{lookup_col},FALSE),0)")
    writeFormula(wb=template,
                 sheet='Table_3',
                 x=formula,
                 startRow = i,
                 startCol = j)
    lookup_col <- lookup_col + 1
    
  }
}

#Adding Public Law headings
table3_header(wb = template,
              sheet = 'Table_3',
              heading = 'Public Law',
              start_row = head_row,
              start_col = 2)

############################
# Private Law
############################
#Adding Private Law headings
pri_start_col <- start_col + t3_years + 6
#Setting private columns and rows
t3_priv_columns <- pri_start_col + t3_columns - 1
t3_na_rownum <- t3_priv_row_start - start_row
t3_priv_rows <- setdiff(seq(t3_priv_row_start, end_row), t3_empty)

table3_header(wb = template,
              sheet = 'Table_3',
              heading = 'Private Law',
              start_row = head_row,
              start_col = pri_start_col)

#Adds na
na_adder(wb = template,
         sheet = 'Table_3',
         value = "..",
         cols = t3_priv_columns,
         lengths = rep(t3_na_rownum, length(t3_priv_columns)),
         start_row = start_row)

#Making blank rows white
openxlsx::addStyle(wb = template,
                   sheet = 'Table_3',
                   openxlsx::createStyle(fontColour = "white"),
                   rows = t3_empty,
                   cols = t3_priv_columns,
                   stack = T,
                   gridExpand = T)

#Main Private Law formulae
pri_start_letter <- num_to_letter(pri_start_col)
for (i in t3_priv_rows) {
  lookup_col <- 2
  for (j in t3_priv_columns) {
    formula <- glue("=VLOOKUP($AJ{i}&$A$8&${pri_start_letter}$9&$AJ$7,'Table 3_4_source'!$A$2:$Q${lookup_row},{lookup_col},FALSE)")
    writeFormula(wb=template,
                 sheet='Table_3',
                 x=formula,
                 startRow = i,
                 startCol = j)
    lookup_col <- lookup_col + 1
    
  }
}


#Total number of cols
t3_total_cols <- (t3_years + 6) * 2 

#Bottom part
openxlsx::addStyle(template,
                   'Table_3',
                   style = openxlsx::createStyle(
                     border = "bottom",
                     borderStyle = "thin"),
                   rows = end_row,
                   cols = seq(t3_total_cols),
                   stack = T,
                   gridExpand = T)

note_footer(wb = template,
            sheet = 'Table_3',
            start_row = end_row,
            notes = notes3,
            col_length = t3_total_cols)

# Content #########################################################################################

# time period
if(pub_quarter==4){
  
  timeperiod3 <- paste0("Annually 2011 - ", pub_year, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
  
} else {
  
  timeperiod3 <- paste0("Annually 2011 - ", pub_year-1, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
}

openxlsx::writeData(wb = template,
                    sheet = 'Table_3',
                    x = timeperiod3,
                    startRow = 4,
                    colNames = F)