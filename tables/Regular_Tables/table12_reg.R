# Table 12 regular
# This table contains both formulas and raw data

#Keeping track of row to start with
t12_start <- 12

current_div_year <- divorce_csv %>% distinct(Year) %>% filter(Year <= annual_year) %>% pull(Year)
div_year_row_seq <- seq(from = t12_start, to = t12_start + length(current_div_year) - 1)


#Remaining annual data
div_year <- tibble(Year = current_div_year,
                  Quarter = NA_character_,
                  d_pet_filed = glue('=IF(SUMIFS(Table_12_source!$E:$E,Table_12_source!$B:$B,$A{div_year_row_seq}\\
                                   ,Table_12_source!$A:$A,D$4,Table_12_source!$D:$D,$B$7)=0,"."\\
                                   ,SUMIFS(Table_12_source!$E:$E,Table_12_source!$B:$B,$A{div_year_row_seq},Table_12_source!$A:$A,D$4,Table_12_source!$D:$D,$B$7))')
                  ,
                  d_decrees_nisi = glue('=IF(SUMIFS(Table_12_source!$E:$E,Table_12_source!$B:$B,$A{div_year_row_seq}\\
                                   ,Table_12_source!$A:$A,E$4,Table_12_source!$D:$D,$B$7)=0,"."\\
                                   ,SUMIFS(Table_12_source!$E:$E,Table_12_source!$B:$B,$A{div_year_row_seq},Table_12_source!$A:$A,E$4,Table_12_source!$D:$D,$B$7))')
                  ,
                  d_mean_nisi = glue('=IF(SUMIFS(Table_12_source!$F:$F,Table_12_source!$B:$B,$A{div_year_row_seq}\\
                                     ,Table_12_source!$A:$A,E$4,Table_12_source!$D:$D,$B$7)=0,"."\\
                                     ,SUMIFS(Table_12_source!$F:$F,Table_12_source!$B:$B,$A{div_year_row_seq},Table_12_source!$A:$A,E$4,Table_12_source!$D:$D,$B$7))')
                  ,
                  d_median_nisi = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$B:$B,$A{div_year_row_seq}\\
                                     ,Table_12_source!$A:$A,E$4,Table_12_source!$D:$D,$B$7)=0,"."\\
                                     ,SUMIFS(Table_12_source!$G:$G,Table_12_source!$B:$B,$A{div_year_row_seq},Table_12_source!$A:$A,E$4,Table_12_source!$D:$D,$B$7))')
                  ,
                  d_decrees_abs = glue('=IF(SUMIFS(Table_12_source!$E:$E,Table_12_source!$B:$B,$A{div_year_row_seq}\\
                                   ,Table_12_source!$A:$A,H$4,Table_12_source!$D:$D,$B$7)=0,"."\\
                                   ,SUMIFS(Table_12_source!$E:$E,Table_12_source!$B:$B,$A{div_year_row_seq},Table_12_source!$A:$A,H$4,Table_12_source!$D:$D,$B$7))')
                  ,
                  d_mean_abs = glue('IF(SUMIFS(Table_12_source!$F:$F,Table_12_source!$B:$B,$A{div_year_row_seq}\\
                  ,Table_12_source!$A:$A,H$4,Table_12_source!$D:$D,$B$7)=0,"."\\
                  ,SUMIFS(Table_12_source!$F:$F,Table_12_source!$B:$B,$A{div_year_row_seq},Table_12_source!$A:$A,H$4,Table_12_source!$D:$D,$B$7))')
                  ,
                  d_median_abs = glue('IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$B:$B,$A{div_year_row_seq}\\
                  ,Table_12_source!$A:$A,H$4,Table_12_source!$D:$D,$B$7)=0,"."\\
                  ,SUMIFS(Table_12_source!$G:$G,Table_12_source!$B:$B,$A{div_year_row_seq},Table_12_source!$A:$A,H$4,Table_12_source!$D:$D,$B$7))')
                  )

# Nullity of Marriage

#Nullity of Marriage Petitions
null_pets_year <- divorce_csv %>% 
  filter(Type == 'Petitions', Proceeding_type == 'Nullity of Marriage') %>% 
  group_by(Year) %>% 
  summarise(n_pet_filed = sum_na(Count))

# Nullity of Marriage Decree Nisi
null_nisi_year <- divorce_csv %>% 
  filter(Order_type == 'Decree Nisi', Proceeding_type == 'Nullity of Marriage') %>% 
  group_by(Year) %>% 
  summarise(n_decrees_nisi = sum_na(Count))

#Nullity of Marriage Decree Abs
null_abs_year <- divorce_csv %>% 
  filter(Order_type == 'Decree Absolute', Proceeding_type == 'Nullity of Marriage') %>% 
  group_by(Year) %>% 
  summarise(n_decrees_abs = sum_na(Count))

#Judicial Separation Petitions
jud_pets_year <- divorce_csv %>% 
  filter(Type == 'Petitions', Proceeding_type == 'Judicial Separation') %>% 
  group_by(Year) %>% 
  summarise(j_pet_filed = sum_na(Count))

#Judicial Separation Granted
jud_granted_year <- divorce_csv %>% 
  filter(Order_type == 'Judicial Separations Granted', Proceeding_type == 'Judicial Separation') %>% 
  group_by(Year) %>% 
  summarise(j_decrees_granted = sum_na(Count))

#Total Petitions
total_pets_year <- divorce_csv %>% 
  filter(Type == 'Petitions') %>% 
  group_by(Year) %>% 
  summarise(all_pet_filed = sum_na(Count))

#Total Decree Nisi
total_nisi_year <- divorce_csv %>% 
  filter(Order_type == 'Decree Nisi') %>% 
  group_by(Year) %>% 
  summarise(all_decrees_nisi = sum_na(Count))

#Total Decree Absolutes/granted
total_abs_year <- divorce_csv %>% 
  filter(Order_type %in% c('Judicial Separations Granted', 'Decree Absolute')) %>% 
  group_by(Year) %>% 
  summarise(all_decrees_abs = sum_na(Count))

#Joining all the tables together

div_annual_tables <- list(div_year, null_pets_year, null_nisi_year, null_abs_year,
                          jud_pets_year, jud_granted_year, 
                          total_pets_year, total_nisi_year, total_abs_year)

div_joined_year <- reduce(div_annual_tables, left_join, by = 'Year')

t12_reg_year <- div_joined_year %>% 
  mutate(blank1 = NA, blank2 = NA, blank3 = NA, blank4 = NA) %>% 
  relocate(blank1, .after = Quarter) %>% 
  relocate(blank2, .after = d_median_abs) %>% 
  relocate(blank3, .after = n_decrees_abs) %>% 
  relocate(blank4, .after = j_decrees_granted) %>% 
  mutate(across(starts_with('d_'), .fns = formula_add)) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, 0))) 


#####################
#Quarterly
#####################
t12_start_qtr <- t12_start + length(current_div_year)

current_div_qtr <- divorce_csv %>% filter(Year > 2010) %>% distinct(Year, Quarter)
div_qtr_row_seq <- seq(from = t12_start_qtr, to = t12_start_qtr + nrow(current_div_qtr) - 1)

glue('Table_12_source!$B:$B,$A{div_qtr_row_seq}&" "&LEFT($B{div_qtr_row_seq},2)')

#Remaining annual data
div_qtr <- tibble(Year = current_div_qtr$Year,
                   Quarter = current_div_qtr$Quarter,
                   d_pet_filed = glue('=IF(SUMIFS(Table_12_source!$E:$E,Table_12_source!$C:$C,$A{div_qtr_row_seq}&" "&LEFT($B{div_qtr_row_seq},2)\\
                                   ,Table_12_source!$A:$A,D$4,Table_12_source!$D:$D,$B$7)=0,"."\\
                                   ,SUMIFS(Table_12_source!$E:$E,Table_12_source!$C:$C,$A{div_qtr_row_seq}&" "&LEFT($B{div_qtr_row_seq},2),Table_12_source!$A:$A,D$4,Table_12_source!$D:$D,$B$7))')
                   ,
                   d_decrees_nisi = glue('=IF(SUMIFS(Table_12_source!$E:$E,Table_12_source!$C:$C,$A{div_qtr_row_seq}&" "&LEFT($B{div_qtr_row_seq},2)\\
                                   ,Table_12_source!$A:$A,E$4,Table_12_source!$D:$D,$B$7)=0,"."\\
                                   ,SUMIFS(Table_12_source!$E:$E,Table_12_source!$C:$C,$A{div_qtr_row_seq}&" "&LEFT($B{div_qtr_row_seq},2),Table_12_source!$A:$A,E$4,Table_12_source!$D:$D,$B$7))')
                   ,
                   d_mean_nisi = glue('=IF(SUMIFS(Table_12_source!$F:$F,Table_12_source!$C:$C,$A{div_qtr_row_seq}&" "&LEFT($B{div_qtr_row_seq},2)\\
                                     ,Table_12_source!$A:$A,E$4,Table_12_source!$D:$D,$B$7)=0,"."\\
                                     ,SUMIFS(Table_12_source!$F:$F,Table_12_source!$C:$C,$A{div_qtr_row_seq}&" "&LEFT($B{div_qtr_row_seq},2),Table_12_source!$A:$A,E$4,Table_12_source!$D:$D,$B$7))')
                   ,
                   d_median_nisi = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_qtr_row_seq}&" "&LEFT($B{div_qtr_row_seq},2)\\
                                     ,Table_12_source!$A:$A,E$4,Table_12_source!$D:$D,$B$7)=0,"."\\
                                     ,SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_qtr_row_seq}&" "&LEFT($B{div_qtr_row_seq},2),Table_12_source!$A:$A,E$4,Table_12_source!$D:$D,$B$7))')
                   ,
                   d_decrees_abs = glue('=IF(SUMIFS(Table_12_source!$E:$E,Table_12_source!$C:$C,$A{div_qtr_row_seq}&" "&LEFT($B{div_qtr_row_seq},2)\\
                                   ,Table_12_source!$A:$A,H$4,Table_12_source!$D:$D,$B$7)=0,"."\\
                                   ,SUMIFS(Table_12_source!$E:$E,Table_12_source!$C:$C,$A{div_qtr_row_seq}&" "&LEFT($B{div_qtr_row_seq},2),Table_12_source!$A:$A,H$4,Table_12_source!$D:$D,$B$7))')
                   ,
                   d_mean_abs = glue('IF(SUMIFS(Table_12_source!$F:$F,Table_12_source!$C:$C,$A{div_qtr_row_seq}&" "&LEFT($B{div_qtr_row_seq},2)\\
                  ,Table_12_source!$A:$A,H$4,Table_12_source!$D:$D,$B$7)=0,"."\\
                  ,SUMIFS(Table_12_source!$F:$F,Table_12_source!$C:$C,$A{div_qtr_row_seq}&" "&LEFT($B{div_qtr_row_seq},2),Table_12_source!$A:$A,H$4,Table_12_source!$D:$D,$B$7))')
                   ,
                   d_median_abs = glue('IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_qtr_row_seq}&" "&LEFT($B{div_qtr_row_seq},2)\\
                  ,Table_12_source!$A:$A,H$4,Table_12_source!$D:$D,$B$7)=0,"."\\
                  ,SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_qtr_row_seq}&" "&LEFT($B{div_qtr_row_seq},2),Table_12_source!$A:$A,H$4,Table_12_source!$D:$D,$B$7))')
)

# Nullity of Marriage

#Nullity of Marriage Petitions
null_pets_qtr <- divorce_csv %>% filter(Year > 2010) %>% 
  filter(Type == 'Petitions', Proceeding_type == 'Nullity of Marriage') %>% 
  group_by(Year, Quarter) %>% 
  summarise(n_pet_filed = sum_na(Count))

# Nullity of Marriage Decree Nisi
null_nisi_qtr <- divorce_csv %>% filter(Year > 2010) %>% 
  filter(Order_type == 'Decree Nisi', Proceeding_type == 'Nullity of Marriage') %>% 
  group_by(Year, Quarter) %>% 
  summarise(n_decrees_nisi = sum_na(Count))

#Nullity of Marriage Decree Abs
null_abs_qtr <- divorce_csv %>% filter(Year > 2010) %>% 
  filter(Order_type == 'Decree Absolute', Proceeding_type == 'Nullity of Marriage') %>% 
  group_by(Year, Quarter) %>% 
  summarise(n_decrees_abs = sum_na(Count))

#Judicial Separation Petitions
jud_pets_qtr <- divorce_csv %>% filter(Year > 2010) %>% 
  filter(Type == 'Petitions', Proceeding_type == 'Judicial Separation') %>% 
  group_by(Year, Quarter) %>% 
  summarise(j_pet_filed = sum_na(Count))

#Judicial Separation Granted
jud_granted_qtr <- divorce_csv %>% filter(Year > 2010) %>% 
  filter(Order_type == 'Judicial Separations Granted', Proceeding_type == 'Judicial Separation') %>% 
  group_by(Year, Quarter) %>% 
  summarise(j_decrees_granted = sum_na(Count))

#Total Petitions
total_pets_qtr <- divorce_csv %>% filter(Year > 2010) %>% 
  filter(Type == 'Petitions') %>% 
  group_by(Year, Quarter) %>% 
  summarise(all_pet_filed = sum_na(Count))

#Total Decree Nisi
total_nisi_qtr <- divorce_csv %>% filter(Year > 2010) %>% 
  filter(Order_type == 'Decree Nisi') %>% 
  group_by(Year, Quarter) %>% 
  summarise(all_decrees_nisi = sum_na(Count))

#Total Decree Absolutes/granted
total_abs_qtr <- divorce_csv %>% filter(Year > 2010) %>% 
  filter(Order_type %in% c('Judicial Separations Granted', 'Decree Absolute')) %>% 
  group_by(Year, Quarter) %>% 
  summarise(all_decrees_abs = sum_na(Count))

#Joining all the tables together

div_qtr_tables <- list(div_qtr, null_pets_qtr, null_nisi_qtr, null_abs_qtr,
                          jud_pets_qtr, jud_granted_qtr, 
                          total_pets_qtr, total_nisi_qtr, total_abs_qtr)

div_joined_qtr <- reduce(div_qtr_tables, left_join, by = c('Year', 'Quarter'))

t12_reg_qtr <- div_joined_qtr %>% 
  mutate(Quarter = paste0('Q', Quarter), blank1 = NA, blank2 = NA, blank3 = NA, blank4 = NA) %>% 
  relocate(blank1, .after = Quarter) %>% 
  relocate(blank2, .after = d_median_abs) %>% 
  relocate(blank3, .after = n_decrees_abs) %>% 
  relocate(blank4, .after = j_decrees_granted) %>% 
  mutate(across(starts_with('d_'), .fns = formula_add)) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, 0))) 

# time period
if(pub_quarter==4){
  
  timeperiod12 <- paste0("Annually 2003 - ", pub_year, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
  
} else {
  
  timeperiod12 <- paste0("Annually 2003 - ", pub_year-1, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
}

