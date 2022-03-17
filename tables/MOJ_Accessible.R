#MojTable Excel
#Alternate version using MojTable


tables <- list(t15_accessible)
titles <- list('Table 15')
subtitles <- list(c('Financial Remedy', 'This is a secondary title', 'Note for Final Remedy'))
tabnames <- list('Table_15')
tablenames <- list('Fin_Remedy')
filename <- 'mojExcel.xlsx'

makeExcel(
  tables,
  titles,
  subtitles,
  tabnames,
  tablenames,
  filename
)
