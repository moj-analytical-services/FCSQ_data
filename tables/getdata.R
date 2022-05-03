# Packages ########################################################################################

library(dplyr)
library(mojrap)
library(openxlsx)
#library(s3tools)
library(glue)
library(readr)
library(tidyr)
library(tidyverse)
library(xltabr)
library(a11ytables)
library(mojtable)
# Variables #######################################################################################

pub_year <- 2021                                                              # Specify the publication year and quarter for the output name
pub_quarter <- 4
annual_year <- 2021
pub_date <- "31st March 2022"
next_pub_date <- "30th June 2022"
path_to_project = '~/FCSQ_data/tables/'                                       # UPDATE ONLY IF YOU CHANGE THE LOCATION OF THE PROJECT FILES
csv_folder <- paste0("alpha-family-data/CSVs/Table_Creation/", pub_year, " Q",pub_quarter,"/") # location in the S3 bucket to import CSVs from

#Loading Data

na_keys <- c(":", ".", "..", "*", "#REF!", "-")

child_act_csv <- read_using(readr::read_csv, paste0(csv_folder, "CSV Children Act", " ", pub_year, " Q", pub_quarter, ".csv" ), na = na_keys,
                            col_types = cols(
                              YEAR = col_double(),
                              Qtr = col_character(),
                              Type = col_character(),
                              Count_type = col_character(),
                              Public_private = col_character(),
                              Disposal_type = col_character(),
                              Order_type = col_character(),
                              Order_type_code = col_character(),
                              Gender = col_character(),
                              age_band = col_character(),
                              Applicants_in_case = col_character(),
                              Respondents_in_case = col_character(),
                              HC_INDICATOR = col_character(),
                              Count = col_double())) %>% rename_with(str_to_title)

divorce_csv <- read_using(readr::read_csv, paste0(csv_folder,"CSV Divorce National", " ", pub_year, " Q", pub_quarter, ".csv" ), na = na_keys) %>% 
  rename_with(str_to_title)

fr_csv <- read_using(readr::read_csv, paste0(csv_folder,"CSV Financial Remedy National", " ", pub_year, " Q", pub_quarter, ".csv"), na = na_keys) %>% rename_with(str_to_title)
dv_csv <- read_using(readr::read_csv, paste0(csv_folder, "CSV Domestic Violence National", " ", pub_year, " Q", pub_quarter, ".csv"), na = na_keys) %>% rename_with(str_to_title)
adopt_csv <- read_using(readr::read_csv, paste0(csv_folder, 'CSV Adoptions National', " ", pub_year, " Q", pub_quarter, ".csv"), na = na_keys) %>% rename_with(str_to_title)
fmpo_csv <- read_using(readr::read_csv, paste0(csv_folder, 'CSV FMPOs National', " ", pub_year, " Q", pub_quarter, ".csv"), na = na_keys) %>% rename_with(str_to_title)
fgm_csv <-  read_using(readr::read_csv, paste0(csv_folder, 'CSV FGMPOs National', " ", pub_year, " Q", pub_quarter, ".csv"), na = na_keys) %>% rename_with(str_to_title)

divorce_progress_csv <- read_using(readr::read_csv, paste0(csv_folder,'CSV Divorce Progression National', " ", pub_year, " Q", pub_quarter, ".csv"), na = na_keys) %>% rename_with(str_to_title)
divorce_timeliness_csv <- read_using(readr::read_csv, paste0(csv_folder, 'CSV Divorce Timeliness', " ", pub_year, " Q", pub_quarter, ".csv"), na = na_keys) %>% rename_with(str_to_title)

priv_law_disposal_csv <- read_using(readr::read_csv, paste0(csv_folder, 'CSV Timeliness Private Law Final Order', " ", pub_year, " Q", pub_quarter, ".csv"), na = na_keys) %>% rename_with(str_to_title)

probate_csv <- read_using(readr::read_csv, paste0(csv_folder, 'CSV Probate National', " ", pub_year, " Q", pub_quarter, ".csv"), na = na_keys) %>% rename_with(str_to_title)
probate_timeliness_csv <- read_using(readr::read_csv, paste0(csv_folder, 'CSV Probate timeliness', " ", pub_year, " Q", pub_quarter, ".csv"), na = na_keys) %>% rename_with(str_to_title)

opg_csv <- read_using(readr::read_csv, paste0(csv_folder, 'CSV OPG Powers of Attorney National', " ", pub_year, " Q", pub_quarter, ".csv"), 
                      na =  na_keys) %>% rename_with(str_to_title) %>% select(1:5)

#Additional non csv inputs
care_disposal_csv <- read_using(readr::read_csv, paste0(csv_folder, 'CARE_FINAL', " ", pub_year, " Q", pub_quarter,'.csv'), na = na_keys) %>% rename_with(str_to_title)

table_3_lookup <- read_using(readr::read_csv, paste0(csv_folder, 'Table_3_lookup', " ", pub_year, " Q", pub_quarter,'.csv'), na = na_keys) %>% rename_with(str_to_title)
table_10_lookup <- read_using(readr::read_csv, paste0(csv_folder, 'Table_10_lookup', " ", pub_year, " Q", pub_quarter,'.csv'), na = na_keys) %>% rename_with(str_to_title)
table_11_lookup <- read_using(readr::read_csv, paste0(csv_folder, 'Table_11_lookup', " ", pub_year, " Q", pub_quarter,'.csv'), na = na_keys) %>% rename_with(str_to_title)

cop_link <- paste0(csv_folder, "COP Tables ", pub_year, " Q", pub_quarter, ".xlsx")
cop_table_21 <- read_using(openxlsx::read.xlsx, cop_link, sheet = "Table 21", check.names = TRUE, na.strings = na_keys)
cop_table_22 <- read_using(openxlsx::read.xlsx, cop_link, sheet = "Table 22", check.names = TRUE, na.strings = na_keys)

cafcass <- read_using(readr::read_csv, paste0(csv_folder, 'CSV Private law cases CAFCASS and MoJ', " ", pub_year, " Q", pub_quarter, ".csv") )%>% 
  rename_with(str_to_title) %>% select(1:5)

#Annual only.

if (pub_quarter == 4){
  contest_probate <- read_using(readr::read_csv, paste0(csv_folder, 'Contested_Probate', " ", pub_year, " Q", pub_quarter,'.csv'), na = na_keys) %>% rename_with(str_to_title)
  
}

#Helpful letter lookup
letter_lookup <- readr::read_csv(paste0(path_to_project, "Lookups/letter_lookup.csv"))
ca_order_lookup <- readr::read_csv(paste0(path_to_project, "Lookups/t3_order_lookup.csv"), col_types = cols(
  Order_type_code = col_character(),
  `Order type` = col_character(),
  Table = col_integer()))


