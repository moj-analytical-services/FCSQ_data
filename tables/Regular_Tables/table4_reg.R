#Table 4 Regular
#This is a formula column that is very similar to T3 with some differences

# formulae. Start row is the first row under the Order type heading.
# End row is the last row of data
#Start col is the first column where data is added.
#Head row is the row where the heading starts
head_row <- 9
start_row <- 11
end_row <- 69
start_col <- 2
t4_priv_row_start <- 29

# Setting heights of notes
t4_row_heights <- rep(14.3, length(notes4))
t4_note_adjust <- note_adjuster(notes = c(2), table = 4)
t4_row_heights[t4_note_adjust] = 33

t4_empty <- c(11, 15, 16, 24, 25, 32, 33, 37, 38, 43, 44, 51, 52, 55, 56, 59, 60, 67, 68) #rows excluded because they are blank

t4_years <- annual_year - 2010  #Number of full years in the table
nrow_lookup <- nrow(table_3_lookup) + 1

#Setting row information for Table 3
t4_rows_all <- seq(start_row, end_row) #full set of rows in the table
t4_pub_rows <- setdiff(t4_rows_all, t4_empty) #rows that have formulas in them

#Number of Columns to add. Years since 2010 have their own column then a space for four quarters
t4_columns <- setdiff(seq(from = 1, to = t4_years + 5), t4_years + 1)
t4_pub_columns <- start_col + t4_columns - 1

# Drop Down List info - Used in lists
t4_list_col <- 1
t4_list_letter <- num_to_letter(t4_list_col)
t4_list_row <- 7


#Main Public Law formulae
for (i in t4_pub_rows) {
  lookup_col <- 2
  for (j in t4_pub_columns) {
    formula <- glue("=VLOOKUP($BA{i}&$A$8&$B$9&$BA$7,'Table 3_4_source'!$A$2:$R${nrow_lookup},{lookup_col},FALSE)")
    writeFormula(wb=template,
                 sheet='Table_4',
                 x=formula,
                 startRow = i,
                 startCol = j)
    lookup_col <- lookup_col + 1
    
  }
}

#Adding Public Law headings
table3_header(wb = template,
              sheet = 'Table_4',
              heading = 'Public Law',
              start_row = head_row,
              start_col = 2)

############################
# Private Law
############################
#Adding Private Law headings
pri_start_col <- start_col + t4_years + 6
#Setting private columns and rows
t4_priv_columns <- pri_start_col + t4_columns - 1
t4_na_rownum <- t4_priv_row_start - start_row
t4_priv_rows <- setdiff(seq(t4_priv_row_start, end_row), t4_empty)

table3_header(wb = template,
              sheet = 'Table_4',
              heading = 'Private Law',
              start_row = head_row,
              start_col = pri_start_col)

#Adds na
na_adder(wb = template,
         sheet = 'Table_4',
         value = "..",
         cols = t4_priv_columns,
         lengths = rep(t4_na_rownum, length(t4_priv_columns)),
         start_row = 12)

#Making blank rows white
openxlsx::addStyle(wb = template,
                   sheet = 'Table_4',
                   openxlsx::createStyle(fontColour = "white"),
                   rows = t4_empty,
                   cols = t4_priv_columns,
                   stack = T,
                   gridExpand = T)

#Main Private Law formulae
pri_start_letter <- num_to_letter(pri_start_col)
for (i in t4_priv_rows) {
  lookup_col <- 2
  for (j in t4_priv_columns) {
    formula <- glue("=VLOOKUP($BA{i}&$A$8&${pri_start_letter}$9&$BA$7,'Table 3_4_source'!$A$2:$R${nrow_lookup},{lookup_col},FALSE)")
    writeFormula(wb=template,
                 sheet='Table_4',
                 x=formula,
                 startRow = i,
                 startCol = j)
    lookup_col <- lookup_col + 1
    
  }
}

# Final Row is na
na_adder(wb = template,
         sheet = 'Table_4',
         value = "..",
         cols = t4_priv_columns,
         lengths = rep(1, length(t4_priv_columns)),
         start_row = 69)

#Total number of cols
t4_total_cols <- (t4_years + 6) * 2 

#Bottom part
openxlsx::addStyle(template,
                   'Table_4',
                   style = openxlsx::createStyle(
                     border = "bottom",
                     borderStyle = "thin"),
                   rows = end_row,
                   cols = seq(t4_total_cols),
                   stack = T,
                   gridExpand = T)

note_footer(wb = template,
            sheet = 'Table_4',
            start_row = end_row,
            notes = notes4,
            col_length = t4_total_cols,
            row_heights = t4_row_heights)

# Content #########################################################################################

# time period
if(pub_quarter==4){
  
  timeperiod4 <- paste0("Annually 2011 - ", pub_year, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
  
} else {
  
  timeperiod4 <- paste0("Annually 2011 - ", pub_year-1, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
}

openxlsx::writeData(wb = template,
                    sheet = 'Table_4',
                    x = timeperiod4,
                    startRow = 3,
                    colNames = F)