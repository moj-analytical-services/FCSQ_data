

# Import ##########################################################################################

# template Excel sheet
options(digits = 15) # Set the number of significant figure to 15 (same as excel)
path <- "styles_pub.xlsx"
xltabr::set_style_path(paste0(path_to_project,path))
xltabr::set_cell_format_path(paste0(path_to_project,"number_formats.csv"))

template <- openxlsx::loadWorkbook(file=paste0(path_to_project, "My template.xlsx"))
#download_file_from_s3("alpha-family-data/Tables/2021 Q4 Template.xls", paste0(path_to_project, "template.xlsx"), overwrite = TRUE)
#template <- openxlsx::loadWorkbook(file=paste0(path_to_project, "template.xlsx"))
# Editing #########################################################################################
# data is used for source data where needed for tables with drop downs
# table is used for the table itself


source(paste0(path_to_project, "functions.R"))
source(paste0(path_to_project, "index.R"))

# notes
source(paste0(path_to_project, "footnotes.R"))

# tables
source(paste0(path_to_project, "Regular_Tables/table1_reg.R"))
source(paste0(path_to_project, "Regular_Tables/table10_reg.R"))
source(paste0(path_to_project, "Regular_Tables/table11_reg.R"))
source(paste0(path_to_project, "Regular_Tables/table15.R"))
source(paste0(path_to_project, "Regular_Tables/table16_reg.R"))


# dropdowns
source(paste0(path_to_project, "Regular_Tables/lists.R"))

####################################################################
#Financial Remedy
#Table 1

####################################################################

openxlsx::writeData(wb = template,
                    sheet = 'Table_1',
                    x = timeperiod1,
                    startRow = 3,
                    colNames = F)

# data
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_1', 
                      tables = list(table1_pivot_annual, table1_pivot_qtr), 
                      notes = notes15, 
                      starting_row = 6, 
                      quarterly_format = c(2))

####################################################################
#Financial Remedy
#Table 15

####################################################################

openxlsx::writeData(wb = template,
                    sheet = 'Table_15',
                    x = timeperiod15,
                    startRow = 3,
                    colNames = F)

# data
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_15', 
                      tables = list(t15_year, t15_qtr), 
                      notes = notes15, 
                      starting_row = 6, 
                      quarterly_format = c(2))

####################################################################
#Domestic Violence
#Table 16

####################################################################

openxlsx::writeData(wb = template,
                    sheet = 'Table_16',
                    x = timeperiod15,
                    startRow = 3,
                    colNames = F)

# data
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_16', 
                      tables = list(dv_hard_code, dv_year, dv_hard_code_qtr, dv_qtr), 
                      notes = notes16, 
                      starting_row = 10, 
                      quarterly_format = c(3, 4))

# Export ##########################################################################################

openxlsx::saveWorkbook(template, paste0(path_to_project,"test_output.xlsx"), overwrite = TRUE)
