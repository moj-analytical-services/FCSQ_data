# Table 24
probate_lookup <- probate_csv %>% 
  mutate(Lookup = case_when(is.na(Quarter) ~ paste(Year, "", Digital_paper_channel, `Grant Type`, `Applicant Type`, sep = '|' ),
                            TRUE ~ paste(Year, paste0('Q', Quarter), Digital_paper_channel, `Grant Type`, `Applicant Type`, sep = '|' ))) %>% 
  relocate(Lookup)

# Getting the distinct Years and Quarters
probate_dates_annual <- probate_lookup %>% distinct(Year) %>% mutate(Quarter = NA) %>% filter(Year <= annual_year)

probate_dates_quarter <- probate_lookup %>% distinct(Year, Quarter) %>% filter(Year > 2019 | Year == 2019 & Quarter %in% c(3, 4), !is.na(Quarter))  %>% 
  mutate(Quarter = paste0('Q', Quarter))

probate_dates <- bind_rows(probate_dates_annual, probate_dates_quarter)

probate_rowcount <- nrow(probate_dates)

# formulae
start_row <- 12
start_col <- 3

#Columns in Excel sheet. There are blank columns that are missed out.
probate_blank_cols <- c(7, 12)
probate_columns_all <- seq(from = 3, to = 15)
probate_columns <- setdiff(probate_columns_all, probate_blank_cols)
probate_rows <- seq(probate_rowcount) + start_row - 1


#Data
contest_probate_figures <- contest_probate %>% pull(-1)
full_t24 <- tibble(Year = probate_dates$Year,
                   Quarter = probate_dates$Quarter,
                   # Backslash escapes single quotes
                   probate_apps = glue('=VLOOKUP($A{probate_rows}&"|"&$B{probate_rows}&"|"&$C$6&"|"&C$11&"|"&$C$7,\'Table 24 source\'!$A:$H,8, FALSE)'),
                   grant_will_apps = glue('=VLOOKUP($A{probate_rows}&"|"&$B{probate_rows}&"|"&$C$6&"|"&D$11&"|"&$C$7,\'Table 24 source\'!$A:$H,8, FALSE)'),
                   grant_admin_apps = glue('=VLOOKUP($A{probate_rows}&"|"&$B{probate_rows}&"|"&$C$6&"|"&E$11&"|"&$C$7,\'Table 24 source\'!$A:$H,8, FALSE)'),
                   all_grant_apps = glue('=VLOOKUP($A{probate_rows}&"|"&$B{probate_rows}&"|"&$C$6&"|"&F$11&"|"&$C$7,\'Table 24 source\'!$A:$H,8, FALSE)'),
                   blank1 = NA,
                   probate_issued = glue('=VLOOKUP($A{probate_rows}&"|"&$B{probate_rows}&"|"&$C$6&"|"&H$11&"|"&$C$7,\'Table 24 source\'!$A:$H,7, FALSE)'),
                   grant_will_issued = glue('=VLOOKUP($A{probate_rows}&"|"&$B{probate_rows}&"|"&$C$6&"|"&I$11&"|"&$C$7,\'Table 24 source\'!$A:$H,7, FALSE)'),
                   grant_admin_issued = glue('=VLOOKUP($A{probate_rows}&"|"&$B{probate_rows}&"|"&$C$6&"|"&J$11&"|"&$C$7,\'Table 24 source\'!$A:$H,7, FALSE)'),
                   all_grant_issued = glue('=VLOOKUP($A{probate_rows}&"|"&$B{probate_rows}&"|"&$C$6&"|"&K$11&"|"&$C$7,\'Table 24 source\'!$A:$H,7, FALSE)'),
                   blank2 = NA,
                   grants_revoked = glue('=VLOOKUP($A{probate_rows}&"|"&$B{probate_rows}&"|"&$C$6&"|"&M$11&"|"&$C$7,\'Table 24 source\'!$A:$H,7, FALSE)'),
                   standing_search = glue('=VLOOKUP($A{probate_rows}&"|"&$B{probate_rows}&"|"&$C$6&"|"&N$11&"|"&$C$7,\'Table 24 source\'!$A:$H,7, FALSE)'),
                   contested_probate = c(glue('=IF(OR(AND($C$6="All",$C$7="All"),AND($C$6="Paper",$C$7="All")),{contest_probate_figures},":")'), 
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


# Adding Source

# Replacing NA with -1
probate_lookup <- probate_lookup %>% mutate(across(where(is.numeric) & !c(Year, Quarter), ~replace_na(.x, -1)))
openxlsx::writeData(wb = template,
                    sheet = 'Table 24 source',
                    x = probate_lookup)

na_formatter(wb = template,
             sheet = 'Table 24 source',
             table = probate_lookup,
             value = ':',
             startRow = 1,
             skipCols = c(2, 3))