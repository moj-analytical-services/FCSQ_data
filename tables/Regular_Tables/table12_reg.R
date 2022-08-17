# Table 12 regular
# This table contains both formulas and raw data

#Keeping track of row to start with
t12_start <- 12

current_div_year <- divorce_t12_input %>% distinct(Year) %>% filter(Year <= annual_year, Year >=2003) %>% pull(Year)
div_year_row_seq <- seq(from = t12_start, to = t12_start + length(current_div_year) - 1)


#Remaining annual data
div_year <- tibble(Year = current_div_year,
                  Quarter = NA_character_,
                  d_pet_filed = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,D$5,Table_12_source!$A:$A,$D$4,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8)=0,".",SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,D$5,Table_12_source!$A:$A,$D$4,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8))')
                  ,
                  d_decrees_nisi = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,E$5,Table_12_source!$A:$A,$D$4,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8)=0,".",SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,E$5,Table_12_source!$A:$A,$D$4,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8))')
                  ,
                  d_mean_nisi = glue('=IF(SUMIFS(Table_12_source!$H:$H,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,E$5,Table_12_source!$A:$A,$D$4,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8)=0,".",SUMIFS(Table_12_source!$H:$H,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,E$5,Table_12_source!$A:$A,$D$4,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8))')
                  ,
                  d_median_nisi = glue('=IF(SUMIFS(Table_12_source!$I:$I,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,E$5,Table_12_source!$A:$A,$D$4,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8)=0,".",SUMIFS(Table_12_source!$I:$I,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,E$5,Table_12_source!$A:$A,$D$4,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8))')
                  ,
                  d_decrees_abs = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,H$5,Table_12_source!$A:$A,$D$4,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8)=0,".",SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,H$5,Table_12_source!$A:$A,$D$4,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8))')
                  ,
                  d_mean_abs = glue('=IF(SUMIFS(Table_12_source!$H:$H,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,H$5,Table_12_source!$A:$A,$D$4,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8)=0,".",SUMIFS(Table_12_source!$H:$H,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,H$5,Table_12_source!$A:$A,$D$4,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8))')
                  ,
                  d_median_abs = glue('=IF(SUMIFS(Table_12_source!$I:$I,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,H$5,Table_12_source!$A:$A,$D$4,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8)=0,".",SUMIFS(Table_12_source!$I:$I,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,H$5,Table_12_source!$A:$A,$D$4,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8))')
                  ,
                  n_pet_filed = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,L$5,Table_12_source!$A:$A,$L$10,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8)=0,".",SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,L$5,Table_12_source!$A:$A,$L$10,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8))')
                  ,
                  n_decrees_nisi = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,M$5,Table_12_source!$A:$A,$L$10,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8)=0,".",SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,M$5,Table_12_source!$A:$A,$L$10,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8))')
                  ,
                  n_decrees_abs = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,N$5,Table_12_source!$A:$A,$L$10,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8)=0,".",SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,N$5,Table_12_source!$A:$A,$L$10,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8))')
                  ,
                  j_pet_filed = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,P$5,Table_12_source!$A:$A,$P$10,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8)=0,".",SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,P$5,Table_12_source!$A:$A,$P$10,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8))')
                  ,
                  j_decrees_granted = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,Q$5,Table_12_source!$A:$A,$P$10,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8)=0,".",SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,Q$5,Table_12_source!$A:$A,$P$10,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8))')
                  ,
                  t_pet_filed = glue('=IF($B$7="New",".",IF($B$8="Digital",D{div_year_row_seq},D{div_year_row_seq}+L{div_year_row_seq}+P{div_year_row_seq}))')
                  ,
                  t_decrees_nisi = glue('=IF($B$7="New",".",IF($B$8 = "Digital", E{div_year_row_seq},E{div_year_row_seq}+M{div_year_row_seq}))')
                  ,
                  t_decrees_abs = glue('=IF($B$7="New",".",IF($B$8 = "Digital", H{div_year_row_seq}, H{div_year_row_seq}+N{div_year_row_seq}+Q{div_year_row_seq}))')
                  )


#Joining all the tables together
t12_reg_year <- div_year %>% 
  mutate(blank1 = NA, blank2 = NA, blank3 = NA, blank4 = NA) %>% 
  relocate(blank1, .after = Quarter) %>% 
  relocate(blank2, .after = d_median_abs) %>% 
  relocate(blank3, .after = n_decrees_abs) %>% 
  relocate(blank4, .after = j_decrees_granted) %>% 
  mutate(across(3:ncol(.), .fns = formula_add)) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, 0))) 


#####################
#Quarterly
#####################
t12_start_qtr <- t12_start + length(current_div_year)

current_div_qtr <- divorce_t12_input %>% distinct(Quarter) %>% separate('Quarter', into = c('Year', 'Quarter'), sep = ' Q') %>% 
  filter(Year > 2010) %>% 
  arrange(Year, Quarter)

div_qtr_row_seq <- seq(from = t12_start_qtr, to = t12_start_qtr + nrow(current_div_qtr) - 1)

#Remaining annual data
div_qtr <- tibble(Year = current_div_qtr$Year,
                   Quarter = current_div_qtr$Quarter,
                   d_pet_filed = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A33&" "&LEFT($B33,2),Table_12_source!$B:$B,D$5,Table_12_source!$A:$A,$D$4,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8)=0,".",SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A33&" "&LEFT($B33,2),Table_12_source!$B:$B,D$5,Table_12_source!$A:$A,$D$4,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8))')
                   ,
                   d_decrees_nisi = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A33&" "&LEFT($B33,2),Table_12_source!$B:$B,E$5,Table_12_source!$A:$A,$D$4,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8)=0,".",SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A33&" "&LEFT($B33,2),Table_12_source!$B:$B,E$5,Table_12_source!$A:$A,$D$4,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8))')
                   ,
                   d_mean_nisi = glue('=IF(SUMIFS(Table_12_source!$H:$H,Table_12_source!$D:$D,$A33 & " "&LEFT($B33,2),Table_12_source!$B:$B,E$5,Table_12_source!$A:$A,$D$4,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8)=0,".",SUMIFS(Table_12_source!$H:$H,Table_12_source!$D:$D,$A33 & " "&LEFT($B33,2),Table_12_source!$B:$B,E$5,Table_12_source!$A:$A,$D$4,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8))')
                   ,
                   d_median_nisi = glue('=IF(SUMIFS(Table_12_source!$I:$I,Table_12_source!$D:$D,$A33 & " " &LEFT($B33,2),Table_12_source!$B:$B,E$5,Table_12_source!$A:$A,$D$4,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8)=0,".",SUMIFS(Table_12_source!$I:$I,Table_12_source!$D:$D,$A33 & " " &LEFT($B33,2),Table_12_source!$B:$B,E$5,Table_12_source!$A:$A,$D$4,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8))')
                   ,
                   d_decrees_abs = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A33 & " " &LEFT($B33,2),Table_12_source!$B:$B,H$5,Table_12_source!$A:$A,$D$4,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8)=0,".",SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A33 & " " &LEFT($B33,2),Table_12_source!$B:$B,H$5,Table_12_source!$A:$A,$D$4,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8))')
                   ,
                   d_mean_abs = glue('=IF(SUMIFS(Table_12_source!$H:$H,Table_12_source!$D:$D,$A33 & " " &LEFT($B33,2),Table_12_source!$B:$B,H$5,Table_12_source!$A:$A,$D$4,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8)=0,".",SUMIFS(Table_12_source!$H:$H,Table_12_source!$D:$D,$A33 & " " &LEFT($B33,2),Table_12_source!$B:$B,H$5,Table_12_source!$A:$A,$D$4,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8))')
                   ,
                   d_median_abs = glue('=IF(SUMIFS(Table_12_source!$I:$I,Table_12_source!$D:$D,$A33 & " " &LEFT($B33,2),Table_12_source!$B:$B,H$5,Table_12_source!$A:$A,$D$4,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8)=0,".",SUMIFS(Table_12_source!$I:$I,Table_12_source!$D:$D,$A33 & " " &LEFT($B33,2),Table_12_source!$B:$B,H$5,Table_12_source!$A:$A,$D$4,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8))')
                   ,
                   n_pet_filed = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A33 & " " &LEFT($B33,2),Table_12_source!$B:$B,L$5,Table_12_source!$A:$A,$L$10,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8)=0,".",SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A33 & " " &LEFT($B33,2),Table_12_source!$B:$B,L$5,Table_12_source!$A:$A,$L$10,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8))')
                   ,
                   n_decrees_nisi = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A33 & " " &LEFT($B33,2),Table_12_source!$B:$B,M$5,Table_12_source!$A:$A,$L$10,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8)=0,".",SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A33 & " " &LEFT($B33,2),Table_12_source!$B:$B,M$5,Table_12_source!$A:$A,$L$10,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8))')
                   ,
                   n_decrees_abs = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A33 & " " &LEFT($B33,2),Table_12_source!$B:$B,N$5,Table_12_source!$A:$A,$L$10,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8)=0,".",SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A33 & " " &LEFT($B33,2),Table_12_source!$B:$B,N$5,Table_12_source!$A:$A,$L$10,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8))')
                   ,
                   j_pet_filed = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A33 & " " &LEFT($B33,2),Table_12_source!$B:$B,P$5,Table_12_source!$A:$A,$P$10,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8)=0,".",SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A33 & " " &LEFT($B33,2),Table_12_source!$B:$B,P$5,Table_12_source!$A:$A,$P$10,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8))')
                   ,
                   j_decrees_granted = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A33 & " " &LEFT($B33,2),Table_12_source!$B:$B,Q$5,Table_12_source!$A:$A,$P$10,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8)=0,".",SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A33 & " " &LEFT($B33,2),Table_12_source!$B:$B,Q$5,Table_12_source!$A:$A,$P$10,Table_12_source!$F:$F,$B$7,Table_12_source!$E:$E,$B$8))')
                   ,
                   t_pet_filed = case_when((Year > 2021) & !(Year == 2022 & Quarter == 1) ~ glue('=IF($B$7="Old",".",D33)'),
                                           TRUE ~ glue('=IF($B$7="New",".",IF($B$8="Digital",D33,D33+L33+P33))'))
                   ,
                   t_decrees_nisi = glue('=IF($B$7="New",".",IF($B$8 = "Digital", E33,E33+M33))')
                   ,
                   t_decrees_abs = glue('=IF($B$7="New",".",IF($B$8 = "Digital", H33, H33+N33+Q33))')
)

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

