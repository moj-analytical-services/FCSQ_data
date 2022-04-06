#MojTable Excel
#Alternate version using MojTable


tables <- list(t11_accessible, t15_accessible, t16_accessible)
titles <- list('Table 11','Table 15', 'Table 16')
subtitles <- list(c('Legal Rep'),
                  c('Financial Remedy', 'This is a secondary title', 'Note for Final Remedy'),
                  c('Domestic Violence Remedies', 'Includes exparte / on notice split'))
tabnames <- list('Table_11','Table_15', 'Table_16')
tablenames <- list('Leg_Rep', 'Fin_Remedy', 'Domestic_Violence')
filename <- 'mojExcel.xlsx'

makeExcel(
  tables,
  titles,
  subtitles,
  tabnames,
  tablenames,
  filename
)
