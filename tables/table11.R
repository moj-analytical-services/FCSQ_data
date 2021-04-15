# Code to fill in Table 11

# Content #########################################################################################

# years and quarters
legrep_dates_annual <- 
  legrep_lookup_annual %>%
  filter(case_type=='Adoption') %>%
  select(year)

legrep_dates_quarter <-    
  legrep_lookup_quarter %>%
  filter(case_type=='Adoption') %>%
  select(year, quarter) %>%
  mutate(quarter=paste0("Q", quarter))

legrep_rowcount <- nrow(legrep_dates_annual) + nrow(legrep_dates_quarter)

# formulae
start_row <- 11
start_col <- 3
columns <- c(1,2,4,5,7,8,10)

for (i in 1:legrep_rowcount) {
  
  lookup_col <- 2
  
  for (j in columns) {
    formula <- paste0('=VLOOKUP($B$6&"|"&$A', i+start_row-1, '&"|"&$B', i+start_row-1, ',Table_11_source!$A:$H,', lookup_col, ')')
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

# notes
notes11 <- c("Source:",
             "HMCTS FamilyMan system",
             "",
             "Notes:",
             "1) Self-representation is determined by the field 'legal representation' in Familyman being left blank. Therefore, this is only a proxy measure and parties without a recorded representative are not necessarily self-representing litigants in person.",
             "Please note that the latest quarters' figures may reduce in future publications, particularly in regard to parties obtaining legal representation as cases progress. Therefore the latest quarter figures should be considered as provisional. ",
             "2) In this instance 'at least one hearing' refers to non-vacated scheduled hearings, rather than actual hearings that have taken place.",
             "3) 'Unrepresented' refers to parties where the REPRESENTATIVE_ID field has been left blank. Therefore they should be considered as parties without a recorded representative, rather than 'litigants in person'.",
             "4) Financial Remedy (also known as Ancillary Relief) refers to financial settlements when marriages or civil partnerships are dissolved or annulled. It may be for the former spouse or the couple's child(ren) and covers a range of different types of order including periodical payments, lump sum, pension sharing, property adjustment and maintenance pending suit.",
             "5) These figures will be an undercount as not all applications for financial remedy are correctly recorded in the Familyman database. Analysis of data between 2007/08 and 2010/11 suggest actual figures to be at least 10% higher than those shown above. Most of the 'missing' applications occur in cases where the financial remedy is not contested. ",
             "6) Matrimony cases only include divorce (including civil partnerships), not annulment or judicial separation.",
             "7) Typically, there will always be fewer financial remedy cases than divorce cases, as they are effectively a subset of divorce (many cases will be counted in both tables). However, this may not be true for very recent quarters as hearing dates for each type of case are different, i.e. cases appearing in recent quarters in the FR table may have appeared in an earlier quarter of the divorce table.",
             "8) The majority of Public law applicants are public bodies with access to their own legal resources, however this legal representation is often not recorded. To address this we introduced a new methodology in 2016 Q4 which assumes that all public body applicants have legal representation. ",
             "10) Please note the latest quarters will likely change in future as more cases are included – for example the proportion of unrepresented parties in divorce cases in Q1 2020 was 23% in the previous bulletin but is now 26%.",
             "11) Some figures may have been revised from previous publications. Minimal changes may be observed in earlier years, whilst larger changes may be seen in more recent quarters")

# Output ##########################################################################################

# time period
openxlsx::writeData(wb = template,
                    sheet = 'Table_11',
                    x = timeperiod11,
                    startRow = 3,
                    colNames = F)

# table
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_11', 
                      tables = list(legrep_dates_annual, legrep_dates_quarter), 
                      notes = notes11, 
                      starting_row = start_row, 
                      quarterly_format = c(2))

