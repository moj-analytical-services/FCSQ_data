# Packages ########################################################################################

library(dplyr)
library(mojrap)
library(openxlsx)
#library(s3tools)
library(glue)
library(readr)
library(tidyr)
library(purrr)
library(stringr)
#library(tidyverse)
#library(xltabr)
library(a11ytables)
#library(mojtable)
# to disable botor debug warning messages
library(logger) 
log_threshold(WARN, namespace = 'botor')

#Loading Data
source(paste0(path_to_project, "functions.R"))

na_keys <- c(":", ".", "..", "*", "#REF!", "-", "**")

child_act_csv <- read_using(readr::read_csv, paste0(csv_folder, "CSV Children Act", " ", pub_year_quarter, ".csv" ), na = na_keys,
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

divorce_csv <- read_using(readr::read_csv, paste0(csv_folder,"CSV Divorce National", " ", pub_year_quarter, ".csv" ), na = na_keys) %>% 
  rename_with(str_to_title)

fr_csv <- read_using(readr::read_csv, paste0(csv_folder,"CSV Financial Remedy National", " ", pub_year_quarter, ".csv"), na = na_keys) %>% rename_with(str_to_title)
dv_csv <- read_using(readr::read_csv, paste0(csv_folder, "CSV Domestic Violence National", " ", pub_year_quarter, ".csv"), na = na_keys) %>% rename_with(str_to_title)
adopt_csv <- read_using(readr::read_csv, paste0(csv_folder, 'CSV Adoptions National', " ", pub_year_quarter, ".csv"), na = na_keys) %>% rename_with(str_to_title)
fmpo_csv <- read_using(readr::read_csv, paste0(csv_folder, 'CSV FMPOs National', " ", pub_year_quarter, ".csv"), na = na_keys) %>% rename_with(str_to_title)
fgm_csv <-  read_using(readr::read_csv, paste0(csv_folder, 'CSV FGMPOs National', " ", pub_year_quarter, ".csv"), na = na_keys) %>% rename_with(str_to_title)

divorce_progress_csv <- read_using(readr::read_csv, paste0(csv_folder,'CSV Divorce Progression National', " ", pub_year_quarter, ".csv"), na = na_keys) %>% rename_with(str_to_title)
divorce_timeliness_csv <- read_using(readr::read_csv, paste0(csv_folder, 'CSV Divorce Timeliness', " ", pub_year_quarter, ".csv"), na = na_keys) %>% rename_with(str_to_title)

priv_law_disposal_csv <- read_using(readr::read_csv, paste0(csv_folder, 'CSV Timeliness Private Law Final Order', " ", pub_year_quarter, ".csv"), na = na_keys) %>% rename_with(str_to_title)

probate_csv <- read_using(readr::read_csv, paste0(csv_folder, 'CSV Probate National', " ", pub_year_quarter, ".csv"), na = na_keys) %>% rename_with(str_to_title)
probate_timeliness_csv <- read_using(readr::read_csv, paste0(csv_folder, 'CSV Probate timeliness', " ", pub_year_quarter, ".csv"), na = na_keys) %>% rename_with(str_to_title)

opg_csv <- read_using(readr::read_csv, paste0(csv_folder, 'CSV OPG Powers of Attorney National', " ", pub_year_quarter, ".csv"), 
                      na =  na_keys) %>% rename_with(str_to_title) %>% select(1:5)

divorce_t12_input <- read_using(readr::read_csv, paste0(csv_folder, 'DIVORCE_FCSQ_T12', " ", pub_year_quarter, '.csv'), na = na_keys) %>% rename_with(str_to_title)
divorce_t12b_input <- read_using(readr::read_csv, paste0(csv_folder, 'CSV Divorce New Law', " ", pub_year_quarter, '.csv'), na = na_keys) %>% rename_with(str_to_title)
dol_hc_csv <- read_using(readr::read_csv, paste0(csv_folder, 'CSV High Court Deprivation of Liberty', " ", pub_year_quarter, ' - Region level.csv'), na = na_keys) %>% rename_with(str_to_title)

#Additional non csv inputs
care_disposal_csv <- read_using(readr::read_csv, paste0(csv_folder, 'CARE_FINAL', " ", pub_year_quarter,'.csv'), na = na_keys) %>% rename_with(str_to_title)

table_3_lookup <- read_using(readr::read_csv, paste0(csv_folder, 'Table_3_lookup', " ", pub_year_quarter,'.csv'), na = na_keys) %>% rename_with(str_to_title)
table_10_lookup <- read_using(readr::read_csv, paste0(csv_folder, 'Table_10_lookup', " ", pub_year_quarter,'.csv'), na = na_keys) %>% rename_with(str_to_title)
table_11_lookup <- read_using(readr::read_csv, paste0(csv_folder, 'Table_11_lookup', " ", pub_year_quarter,'.csv'), na = na_keys) %>% rename_with(str_to_title)
table_10b_lookup <- read_using(readr::read_csv, paste0(csv_folder, 'Table_10b_lookup', " ", pub_year_quarter,'.csv'), na = na_keys) %>% rename_with(str_to_title)

cop_link <- paste0(csv_folder, "COP Tables ", pub_year_quarter, ".xlsx")
cop_table_21 <- read_using(openxlsx::read.xlsx, cop_link, sheet = "Table 21", check.names = TRUE, na.strings = na_keys)
cop_table_22 <- read_using(openxlsx::read.xlsx, cop_link, sheet = "Table 22", check.names = TRUE, na.strings = na_keys)

#cafcass <- read_using(readr::read_csv, paste0(csv_folder, 'CSV Private law cases CAFCASS and MoJ', " ", pub_year_quarter, ".csv") )%>% 
  #rename_with(str_to_title) %>% select(1:5)

# OPG Table. This is the spreadsheet given by the OPG team. Start row is the first row of data. The row under the column headings
opg_table <- read_using(openxlsx::read.xlsx, paste0(csv_folder, 'OPG Tables', " ", pub_year_quarter, ".xlsx"), sheet = "Table_23", 
                        check.names = TRUE, na.strings = na_keys,  startRow = 9, skipEmptyRows = FALSE, skipEmptyCols = FALSE, colNames = FALSE)


contest_probate <- read_using(readr::read_csv, paste0(csv_folder, 'Contested_Probate', " ", pub_year_quarter,'.csv'), na = na_keys) %>% rename_with(str_to_title)

  
#notes_import <- read_using(readr::read_csv, paste0(csv_folder, 'Notes.csv'), na = na_keys)
notes_import <- read_using(openxlsx::read.xlsx, paste0(csv_folder, 'Notes Workbook', " ", pub_year_quarter, '.xlsx'), sheet = 'Notes', na.strings = na_keys, sep.names = ' ') %>% as_tibble()

#notes_import <- openxlsx::read.xlsx(paste0(path_to_project, 'Notes Workbook 2022 Q2.xlsx'), sheet = 'Notes', na.strings = na_keys, sep.names = ' ') %>% as_tibble()

#Helpful letter lookup

letter_lookup <- read_using(readr::read_csv, (paste0(lookup_folder, "letter_lookup.csv")))

ca_order_lookup <- read_using(readr::read_csv, (paste0(lookup_folder, "t3_order_lookup.csv")), col_types = cols(
  Order_type_code = col_character(),
  `Order type` = col_character(),
  Table = col_integer(),
  Order_category = col_character(),
  Public_or_Private = col_character()))

dv_hard_code_csv <- read_using(readr::read_csv, (paste0(lookup_folder, "DV_Hard_Code.csv"))) %>% rename_with(str_to_title)
