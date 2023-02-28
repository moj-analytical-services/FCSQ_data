# Table 24
probate_lookup <- probate_csv %>% 
  mutate(Lookup = case_when(is.na(Quarter) ~ paste(Year, "", Digital_paper_channel, `Grant Type`, `Applicant Type`, sep = '|' ),
                            TRUE ~ paste(Year, paste0('Q', Quarter), Digital_paper_channel, `Grant Type`, `Applicant Type`, sep = '|' ))) %>% 
  relocate(Lookup)

# Getting the distinct Years and Quarters
probate_dates_annual <- probate_lookup %>% distinct(Year) %>% mutate(Quarter = NA) %>% filter(Year <= annual_year) %>% arrange(Year)

probate_dates_quarter <- probate_lookup %>% distinct(Year, Quarter) %>% filter(Year > 2019 | Year == 2019 & Quarter %in% c(3, 4), !is.na(Quarter))  %>% 
  mutate(Quarter = paste0('Q', Quarter)) %>% arrange(Year, Quarter)

probate_dates <- bind_rows(probate_dates_annual, probate_dates_quarter)

probate_rowcount <- nrow(probate_dates)

#List info
t24_list_col <- 3
t24_list_letter <- num_to_letter(t24_list_col)
t24_list_a_row <- 7
t24_list_b_row <- 8


# formulae
t24_start <- 13
start_col <- 3

#Columns in Excel sheet. There are blank columns that are missed out.
probate_blank_cols <- c(7, 12)
probate_columns_all <- seq(from = 3, to = 15)
probate_columns <- setdiff(probate_columns_all, probate_blank_cols)
probate_rows <- seq(probate_rowcount) + t24_start - 1


#Data
contest_probate_figures <- contest_probate %>% pull(-1)
full_t24 <- tibble(Year = probate_dates$Year,
                   Quarter = probate_dates$Quarter,
                   # Backslash escapes single quotes
                   probate_apps = glue('=VLOOKUP($A{probate_rows}&"|"&$B{probate_rows}&"|"&${t24_list_letter}${t24_list_a_row}&"|"&C$12&"|"&${t24_list_letter}${t24_list_b_row},\'Table 23 source\'!$A:$H,8, FALSE)'),
                   grant_will_apps = glue('=VLOOKUP($A{probate_rows}&"|"&$B{probate_rows}&"|"&${t24_list_letter}${t24_list_a_row}&"|"&D$12&"|"&${t24_list_letter}${t24_list_b_row},\'Table 23 source\'!$A:$H,8, FALSE)'),
                   grant_admin_apps = glue('=VLOOKUP($A{probate_rows}&"|"&$B{probate_rows}&"|"&${t24_list_letter}${t24_list_a_row}&"|"&E$12&"|"&${t24_list_letter}${t24_list_b_row},\'Table 23 source\'!$A:$H,8, FALSE)'),
                   grant_reseal_apps = glue('=IFERROR(VLOOKUP($A{probate_rows}&"|"&$B{probate_rows}&"|"&${t24_list_letter}${t24_list_a_row}&"|"&E$12&"|"&${t24_list_letter}${t24_list_b_row},\'Table 23 source\'!$A:$H,8, FALSE),0)'),
                   all_grant_apps = glue('=VLOOKUP($A{probate_rows}&"|"&$B{probate_rows}&"|"&${t24_list_letter}${t24_list_a_row}&"|"&F$12&"|"&${t24_list_letter}${t24_list_b_row},\'Table 23 source\'!$A:$H,8, FALSE)'),
                   blank1 = NA,
                   probate_issued = glue('=VLOOKUP($A{probate_rows}&"|"&$B{probate_rows}&"|"&${t24_list_letter}${t24_list_a_row}&"|"&H$12&"|"&${t24_list_letter}${t24_list_b_row},\'Table 23 source\'!$A:$H,7, FALSE)'),
                   grant_will_issued = glue('=VLOOKUP($A{probate_rows}&"|"&$B{probate_rows}&"|"&${t24_list_letter}${t24_list_a_row}&"|"&I$12&"|"&${t24_list_letter}${t24_list_b_row},\'Table 23 source\'!$A:$H,7, FALSE)'),
                   grant_admin_issued = glue('=VLOOKUP($A{probate_rows}&"|"&$B{probate_rows}&"|"&${t24_list_letter}${t24_list_a_row}&"|"&J$12&"|"&${t24_list_letter}${t24_list_b_row},\'Table 23 source\'!$A:$H,7, FALSE)'),
                   grant_reseal_issued = glue('=IFERROR(VLOOKUP($A{probate_rows}&"|"&$B{probate_rows}&"|"&${t24_list_letter}${t24_list_a_row}&"|"&E$12&"|"&${t24_list_letter}${t24_list_b_row},\'Table 23 source\'!$A:$H,7, FALSE),0)'),
                   all_grant_issued = glue('=VLOOKUP($A{probate_rows}&"|"&$B{probate_rows}&"|"&${t24_list_letter}${t24_list_a_row}&"|"&K$12&"|"&${t24_list_letter}${t24_list_b_row},\'Table 23 source\'!$A:$H,7, FALSE)'),
                   blank2 = NA,
                   grants_revoked = glue('=VLOOKUP($A{probate_rows}&"|"&$B{probate_rows}&"|"&${t24_list_letter}${t24_list_a_row}&"|"&M$12&"|"&${t24_list_letter}${t24_list_b_row},\'Table 23 source\'!$A:$H,7, FALSE)'),
                   standing_search = glue('=VLOOKUP($A{probate_rows}&"|"&$B{probate_rows}&"|"&${t24_list_letter}${t24_list_a_row}&"|"&N$12&"|"&${t24_list_letter}${t24_list_b_row},\'Table 23 source\'!$A:$H,7, FALSE)'),
                   contested_probate = c(glue('=IF(OR(AND(${t24_list_letter}${t24_list_a_row}="All",${t24_list_letter}${t24_list_b_row}="All"),AND(${t24_list_letter}${t24_list_a_row}="Paper",${t24_list_letter}${t24_list_b_row}="All")),{contest_probate_figures},":")'), 
                                         rep("-", probate_rowcount - length(contest_probate_figures)))
  
)

# Splitting into year and quarter for formating purposes. Marking as formula columns
t24_reg_year <- full_t24 %>% filter(is.na(Quarter)) %>% mutate(across(.cols = 3:ncol(.), .fns = formula_add))
t24_reg_qtr_a <- full_t24 %>% filter(Year == 2019, !is.na(Quarter)) %>% mutate(across(.cols = 3:ncol(.), .fns = formula_add))
t24_reg_qtr_b <- full_t24 %>% filter(Year != 2019, !is.na(Quarter)) %>% mutate(across(.cols = 3:ncol(.), .fns = formula_add))

# Marking columns as formula

# time period
if(pub_quarter==4){
  
  timeperiod24 <- paste0("Annually 2012 - ", pub_year, " and quarterly Q3 2019 - Q", pub_quarter," ", pub_year)
  
} else {
  
  timeperiod24 <- paste0("Annually 2012 - ", pub_year-1, " and quarterly Q3 2019 - Q", pub_quarter," ", pub_year)
}


