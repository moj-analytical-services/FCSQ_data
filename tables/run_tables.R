# Create tables from the CSVs

# Packages ########################################################################################

library(dplyr)
library(mojrap)
library(openxlsx)
library(s3tools)
library(glue)

# Variables #######################################################################################

pub_year <- 2020                                                              # Specify the publication year and quarter for the output name
pub_quarter <- 4
pub_date <- "25th March 2021"
next_pub_date <- "24th June 2021"
path_to_project = '~/FCSQ_data/tables/'                                       # UPDATE ONLY IF YOU CHANGE THE LOCATION OF THE PROJECT FILES
csv_folder <- paste0("alpha-family-data/CSVs/",pub_year, "-",pub_quarter,"/") # location in the S3 bucket to import CSVs from

# Import ##########################################################################################

# template Excel sheet
s3tools::download_file_from_s3("alpha-family-data/Tables/template.xlsx", paste0(path_to_project, "template.xlsx"), overwrite = TRUE)
template <- openxlsx::loadWorkbook(file=paste0(path_to_project, "template.xlsx"))

# Editing #########################################################################################
# data is used for source data where needed for tables with drop downs
# table is used for the table itself

source(paste0(path_to_project, "functions.R"))
source(paste0(path_to_project, "index.R"))

# tables
source(paste0(path_to_project, "data11.R"))
source(paste0(path_to_project, "table11.R"))
source(paste0(path_to_project, "table16.R"))

# additional formatting
source(paste0(path_to_project, "dropdowns.R")) # includes code for table 11

# Export ##########################################################################################

openxlsx::saveWorkbook(template, paste0(path_to_project,"test_output.xlsx"), overwrite = TRUE)
