
# Variables #######################################################################################

pub_year <- 2021                                                              # Specify the publication year and quarter for the output name
pub_quarter <- 4
annual_year <- 2021
pub_date <- "31st March 2022"
next_pub_date <- "30th June 2022"
path_to_project = '~/FCSQ_data/tables/'                                       # UPDATE ONLY IF YOU CHANGE THE LOCATION OF THE PROJECT FILES
csv_folder <- paste0("alpha-family-data/CSVs/CSV_bulletin/", pub_year, " Q",pub_quarter,"/") # location in the S3 bucket to import CSVs from

# Import ##########################################################################################

# template Excel sheet
template <- openxlsx::loadWorkbook(file=paste0(path_to_project, "My template.xlsx"))
#download_file_from_s3("alpha-family-data/Tables/2021 Q4 Template.xls", paste0(path_to_project, "template.xlsx"), overwrite = TRUE)
#template <- openxlsx::loadWorkbook(file=paste0(path_to_project, "template.xlsx"))
# Editing #########################################################################################
# data is used for source data where needed for tables with drop downs
# table is used for the table itself

source(paste0(path_to_project, "functions.R"))
source(paste0(path_to_project, "index.R"))

# tables
source(paste0(path_to_project, "Regular_Tables/table15.R"))
source(paste0(path_to_project, "Regular_Tables/table16_reg.R"))

# notes
source(paste0(path_to_project, "footnotes.R"))
notes_all <- c(t15_notes)

# dropdowns
source(paste0(path_to_project, "Regular_Tables/lists.R"))

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
                      notes = notes15, 
                      starting_row = 10, 
                      quarterly_format = c(3, 4))

# Export ##########################################################################################

openxlsx::saveWorkbook(template, paste0(path_to_project,"test_output.xlsx"), overwrite = TRUE)
