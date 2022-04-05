#Loading Data

na_keys <- c(":", ".", "..", "*", "#REF!", "-")
dv_csv <- read_using(readr::read_csv, paste0(csv_folder, "CSV Domestic Violence National", " ", pub_year, " Q", pub_quarter, ".csv"), na = na_keys) %>% rename_with(str_to_title)
fr_csv <- read_using(readr::read_csv, paste0(csv_folder,"CSV Financial Remedy National", " ", pub_year, " Q", pub_quarter, ".csv"), na = na_keys) %>% rename_with(str_to_title)
table_11_lookup <- read_using(readr::read_csv, paste0(csv_folder, 'Table_11_lookup', " ", pub_year, " Q", pub_quarter,'.csv'), na = na_keys) %>% rename_with(str_to_title)

table11_alt <- table_11_lookup %>% separate(Lookup, c("Case_type", "Year", "Quarter"), sep = '\\|', convert = TRUE)
