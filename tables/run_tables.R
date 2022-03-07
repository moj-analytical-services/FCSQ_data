# Create tables from the CSVs

# Packages ########################################################################################

library(dplyr)
library(mojrap)
library(openxlsx)
#library(s3tools)
library(glue)
library(readr)
library(tidyverse)
library(xltabr)

# Variables #######################################################################################

pub_year <- 2021                                                              # Specify the publication year and quarter for the output name
pub_quarter <- 4
pub_date <- "31st March 2022"
next_pub_date <- "30th June 2022"
path_to_project = '~/FCSQ_data/tables/'                                       # UPDATE ONLY IF YOU CHANGE THE LOCATION OF THE PROJECT FILES
csv_folder <- paste0("alpha-family-data/CSVs/CSV_bulletin/", pub_year, " Q",pub_quarter,"/") # location in the S3 bucket to import CSVs from

# Import ##########################################################################################

# template Excel sheet
download_file_from_s3("alpha-family-data/Tables/ 2021 Q4 Template.xls", paste0(path_to_project, "template.xlsx"), overwrite = TRUE)
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
