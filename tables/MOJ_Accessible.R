#MojTable Excel
#Alternate version using MojTable


tables <- list(t15_accessible, t16_accessible)
titles <- list('Table 15', 'Table 16')
subtitles <- list(c('Financial Remedy', 'This is a secondary title', 'Note for Final Remedy'),
                  c('Domestic Violence Remedies', 'Includes exparte / on notice split'))
tabnames <- list('Table_15', 'Table_16')
tablenames <- list('Fin_Remedy', 'Domestic_Violence')
filename <- 'mojExcel.xlsx'

makeExcel(
  tables,
  titles,
  subtitles,
  tabnames,
  tablenames,
  filename
)
