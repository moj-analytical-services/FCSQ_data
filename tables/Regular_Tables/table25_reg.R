# Table 25

#Creating a lookup column with no spaces
probate_time_lookup <- probate_timeliness_csv %>% 
  mutate(Lookup = case_when(is.na(Quarter) ~ paste0(Digital_paper, Year, Stopped, Application_type),
                            TRUE ~ paste0(Digital_paper, Year, paste0('Q', Quarter), Stopped, Application_type))) %>% 
  relocate(Lookup)

# Getting the distinct Years and Quarters
probate_time_dates_annual <- probate_time_lookup %>% distinct(Year) %>% mutate(Quarter = NA) %>% filter(Year != 2019, Year <= annual_year) %>% arrange(Year)

probate_time_dates_quarter <- probate_time_lookup %>% distinct(Year, Quarter) %>% filter(!(Year == 2019 & Quarter == 1), !is.na(Quarter))  %>% 
  mutate(Quarter = paste0('Q', Quarter)) %>% arrange(Year, Quarter)

probate_time_dates <- bind_rows(probate_time_dates_annual, probate_time_dates_quarter)

probate_time_rowcount <- nrow(probate_time_dates)

# formulae
t25_start <- 13
start_col <- 3

#List info
t25_list_col <- 3
t25_list_letter <- num_to_letter(t25_list_col)
t25_list_a_row <- 7
t25_list_b_row <- 8

#Columns in Excel sheet. There are blank columns that are missed out.
probate_time_blank_cols <- c(6, 9, 13, 16, 20, 23, 27)
probate_time_columns_all <- seq(from = 3, to = 29)
probate_time_columns <- setdiff(probate_time_columns_all, probate_time_blank_cols)
probate_time_rows <- seq(probate_time_rowcount) + t25_start - 1

#Data
full_t25 <- tibble(Year = probate_time_dates$Year,
                   Quarter = probate_time_dates$Quarter,
                   probate_grants_issued = glue('=VLOOKUP(${t25_list_letter}${t25_list_a_row}&$A{probate_time_rows}&$B{probate_time_rows}&${t25_list_letter}${t25_list_b_row}&$C$10,\'Table 25 source\'!$A:$K,7,FALSE)'),
                   probate_sub_to_iss_mean = glue('=VLOOKUP(${t25_list_letter}${t25_list_a_row}&$A{probate_time_rows}&$B{probate_time_rows}&${t25_list_letter}${t25_list_b_row}&$C$10,\'Table 25 source\'!$A:$K,8,FALSE)'),
                   probate_sub_to_iss_median = glue('=VLOOKUP(${t25_list_letter}${t25_list_a_row}&$A{probate_time_rows}&$B{probate_time_rows}&${t25_list_letter}${t25_list_b_row}&$C$10,\'Table 25 source\'!$A:$K,9,FALSE)'),
                   blank1 = NA,
                   probate_doc_to_iss_mean = glue('=VLOOKUP(${t25_list_letter}${t25_list_a_row}&$A{probate_time_rows}&$B{probate_time_rows}&${t25_list_letter}${t25_list_b_row}&$C$10,\'Table 25 source\'!$A:$K,10,FALSE)'),
                   probate_doc_to_iss_median = glue('=VLOOKUP(${t25_list_letter}${t25_list_a_row}&$A{probate_time_rows}&$B{probate_time_rows}&${t25_list_letter}${t25_list_b_row}&$C$10,\'Table 25 source\'!$A:$K,11,FALSE)'),
                   blank2 = NA,
                   admin_will_grants_issued = glue('=VLOOKUP(${t25_list_letter}${t25_list_a_row}&$A{probate_time_rows}&$B{probate_time_rows}&${t25_list_letter}${t25_list_b_row}&$J$10,\'Table 25 source\'!$A:$K,7,FALSE)'),
                   admin_will_sub_to_iss_mean = glue('=VLOOKUP(${t25_list_letter}${t25_list_a_row}&$A{probate_time_rows}&$B{probate_time_rows}&${t25_list_letter}${t25_list_b_row}&$J$10,\'Table 25 source\'!$A:$K,8,FALSE)'),
                   admin_will_sub_to_iss_median = glue('=VLOOKUP(${t25_list_letter}${t25_list_a_row}&$A{probate_time_rows}&$B{probate_time_rows}&${t25_list_letter}${t25_list_b_row}&$J$10,\'Table 25 source\'!$A:$K,9,FALSE)'),
                   blank3 = NA,
                   admin_will_doc_to_iss_mean = glue('=VLOOKUP(${t25_list_letter}${t25_list_a_row}&$A{probate_time_rows}&$B{probate_time_rows}&${t25_list_letter}${t25_list_b_row}&$J$10,\'Table 25 source\'!$A:$K,10,FALSE)'),
                   admin_will_doc_to_iss_median = glue('=VLOOKUP(${t25_list_letter}${t25_list_a_row}&$A{probate_time_rows}&$B{probate_time_rows}&${t25_list_letter}${t25_list_b_row}&$J$10,\'Table 25 source\'!$A:$K,11,FALSE)'),
                   blank4 = NA,
                   admin_grants_issued = glue('=VLOOKUP(${t25_list_letter}${t25_list_a_row}&$A{probate_time_rows}&$B{probate_time_rows}&${t25_list_letter}${t25_list_b_row}&$Q$10,\'Table 25 source\'!$A:$K,7,FALSE)'),
                   admin_sub_to_iss_mean = glue('=VLOOKUP(${t25_list_letter}${t25_list_a_row}&$A{probate_time_rows}&$B{probate_time_rows}&${t25_list_letter}${t25_list_b_row}&$Q$10,\'Table 25 source\'!$A:$K,8,FALSE)'),
                   admin_sub_to_iss_median = glue('=VLOOKUP(${t25_list_letter}${t25_list_a_row}&$A{probate_time_rows}&$B{probate_time_rows}&${t25_list_letter}${t25_list_b_row}&$Q$10,\'Table 25 source\'!$A:$K,9,FALSE)'),
                   blank5 = NA,
                   admin_doc_to_iss_mean = glue('=VLOOKUP(${t25_list_letter}${t25_list_a_row}&$A{probate_time_rows}&$B{probate_time_rows}&${t25_list_letter}${t25_list_b_row}&$Q$10,\'Table 25 source\'!$A:$K,10,FALSE)'),
                   admin_doc_to_iss_median = glue('=VLOOKUP(${t25_list_letter}${t25_list_a_row}&$A{probate_time_rows}&$B{probate_time_rows}&${t25_list_letter}${t25_list_b_row}&$Q$10,\'Table 25 source\'!$A:$K,11,FALSE)'),
                   blank6 = NA,
                   all_grants_grants_issued = glue('=VLOOKUP(${t25_list_letter}${t25_list_a_row}&$A{probate_time_rows}&$B{probate_time_rows}&${t25_list_letter}${t25_list_b_row}&$X$10,\'Table 25 source\'!$A:$K,7,FALSE)'),
                   all_grants_sub_to_iss_mean = glue('=VLOOKUP(${t25_list_letter}${t25_list_a_row}&$A{probate_time_rows}&$B{probate_time_rows}&${t25_list_letter}${t25_list_b_row}&$X$10,\'Table 25 source\'!$A:$K,8,FALSE)'),
                   all_grants_sub_to_iss_median = glue('=VLOOKUP(${t25_list_letter}${t25_list_a_row}&$A{probate_time_rows}&$B{probate_time_rows}&${t25_list_letter}${t25_list_b_row}&$X$10,\'Table 25 source\'!$A:$K,9,FALSE)'),
                   blank7 = NA,
                   all_grants_doc_to_iss_mean = glue('=VLOOKUP(${t25_list_letter}${t25_list_a_row}&$A{probate_time_rows}&$B{probate_time_rows}&${t25_list_letter}${t25_list_b_row}&$X$10,\'Table 25 source\'!$A:$K,10,FALSE)'),
                   all_grants_doc_to_iss_median = glue('=VLOOKUP(${t25_list_letter}${t25_list_a_row}&$A{probate_time_rows}&$B{probate_time_rows}&${t25_list_letter}${t25_list_b_row}&$X$10,\'Table 25 source\'!$A:$K,11,FALSE)'),
                  
)
                   

# Splitting into year and quarter for formating purposes. Marking as formula columns
t25_reg_year <- full_t25 %>% filter(is.na(Quarter)) %>% mutate(across(.cols = 3:ncol(.), .fns = formula_add))
t25_reg_qtr_a <- full_t25 %>% filter(Year == 2019, !is.na(Quarter)) %>% mutate(across(.cols = 3:ncol(.), .fns = formula_add))
t25_reg_qtr_b <- full_t25 %>% filter(Year != 2019, !is.na(Quarter)) %>% mutate(across(.cols = 3:ncol(.), .fns = formula_add))

# Marking columns as formula

# time period
if(pub_quarter==4){
  
  timeperiod25 <- paste0("Annually 2020 - ", pub_year, " and quarterly Q2 2019 - Q", pub_quarter," ", pub_year)
  
} else {
  
  timeperiod25 <- paste0("Annually 2020 - ", pub_year-1, " and quarterly Q2 2019 - Q", pub_quarter," ", pub_year)
}


