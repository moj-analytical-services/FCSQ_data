#MojTable Excel
#Alternate version using MojTable


tables <- list(t1_accessible, t2_accessible, t10_accessible, t11_accessible, t15_accessible, t16_accessible)
titles <- list('Table 1', 'Table 2', 'Table 10', 'Table 11','Table 15', 'Table 16')
subtitles <- list(c('Summary Table'),
                  c('Children Act Main'),
                  c('Timeliness'),
                  c('Legal Rep'),
                  c('Financial Remedy', 'This is a secondary title', 'Note for Final Remedy'),
                  c('Domestic Violence Remedies', 'Includes exparte / on notice split'))
tabnames <- list('Table_1', 'Table_2', 'Table_10', 'Table_11','Table_15', 'Table_16')
tablenames <- list('Sum_Tables', 'CA_Main', 'Timeliness', 'Leg_Rep', 'Fin_Remedy', 'Domestic_Violence')
filename <- 'mojExcel.xlsx'

makeExcel(
  tables,
  titles,
  subtitles,
  tabnames,
  tablenames,
  filename
)
