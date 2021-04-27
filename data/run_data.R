# Script to run data extraction from FamilyMan on the AP

# When is_test is set to TRUE, no files in the S3 will be overwritten. Set to FALSE when running to generate the output
is_test <- TRUE

# Packages ################################################################################################################################

library(glue)
library(s3tools)
library(dplyr)
library(lubridate)
library(readr)
library(dtplyr)
library(data.table)

# Variables #######################################################################################

snapshot_date <- "'2020-10-30'"                              # specify the FamilyMan snapshot to be used
exclude_year <- "2020"                                       # specify the incomplete quarter to be excluded from the data
exclude_quarter <- "4"
year_cut_off <- "2010"                                       # only records from years after this will be included in the final output
pub_year <- "2020"                                           # specify the publication year and quarter for the output name
pub_quarter <- "3"
database <- "familyman_dev_v2"                               # specify the database name
path_to_project <- "~/FCSQ_data/data/"                       # location to save files in the repo
csv_folder <- "alpha-family-data/CSVs/"                      # location in the S3 bucket to save CSV outputs

# Lookups #########################################################################################

# Court lookup
s3tools::download_file_from_s3("alpha-family-data/CSVs/lookups/court_lookup.csv", paste0(path_to_project, "lookups/court_lookup.csv"), overwrite = TRUE)
court_lookup <- data.table::fread(paste0(path_to_project, "lookups/court_lookup.csv"))

# Birth country lookup
s3tools::download_file_from_s3("alpha-family-data/CSVs/lookups/adopt_birth_country_lookup.csv", paste0(path_to_project, "lookups/birth_country_lookup.csv"), overwrite = TRUE)
birth_country_lookup <- data.table::fread(paste0(path_to_project, "lookups/birth_country_lookup.csv"))

# Checks ##########################################################################################
# Some lookups need to be updated manually for any new values - if the tables opened are not empty, open the relevent script and
# follow the instructions given

source(paste0(path_to_project, "adopt_checks.R"))

# Processing ######################################################################################

source(paste0(path_to_project, "functions.R"))
source(paste0(path_to_project, "dv.R"))
source(paste0(path_to_project, "adopt.R"))
