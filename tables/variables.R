# Variables #######################################################################################

pub_year <- 2023       # Specify the publication year and quarter - UPDATE IN THE FIRST QUARTER OF A NEW YEAR
pub_quarter <- 2       # UPDATE EACH QUARTER
annual_year <- 2022    # UPDATE IN THE FOURTH QUARTER OF EVERY YEAR
pub_date <-"28th September 2023" # UPDATE EACH QUARTER
next_pub_date <- "21st December 2023"  # UPDATE EACH QUARTER
path_to_project = '~/FCSQ_data/tables/'                                       # UPDATE ONLY IF YOU CHANGE THE LOCATION OF THE PROJECT FILES
csv_folder <- paste0("alpha-family-data/CSVs/CSV_bulletin/", pub_year, " Q",pub_quarter,"/") # location in the S3 bucket to import CSVs from
lookup_folder <- "alpha-family-data/CSVs/lookups/"

# Numerical values that will be used for na and suppressed values. Numerical values must be used to keep numerical columns numerical
na_value <- -1
suppress_value <- -2
not_collect_value <- -3

