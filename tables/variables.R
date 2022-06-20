# Variables #######################################################################################

pub_year <- 2022                                                              # Specify the publication year and quarter for the output name
pub_quarter <- 1
annual_year <- 2021
pub_date <- "30th June 2022"
next_pub_date <- "29th September 2022"
path_to_project = '~/FCSQ_data/tables/'                                       # UPDATE ONLY IF YOU CHANGE THE LOCATION OF THE PROJECT FILES
csv_folder <- paste0("alpha-family-data/CSVs/Table_Creation/", pub_year, " Q",pub_quarter,"/") # location in the S3 bucket to import CSVs from
lookup_folder <- "alpha-family-data/CSVs/lookups/"

# Numerical values that will be used for na and suppressed values. Numerical values must be used to keep numerical columns numerical
na_value <- -1
suppress_value <- -2

# Setting months
if(pub_quarter=="1"){
  pub_months <- "January to March"
  pub_months_short <- "Jan-Mar"
} else if(pub_quarter=="2"){
  pub_months <- "April to June"
  pub_months_short <- "Apr-Jun"
} else if(pub_quarter=="3"){
  pub_months <- "July to September"
  pub_months_short <- "Jul-Sep"
} else if(pub_quarter=="4"){
  pub_months <- "October to December"
  pub_months_short <- "Oct-Dec"
} else{
  pub_months <- "unknown quarter"
}