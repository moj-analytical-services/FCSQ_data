# Table 12 regular
# This table contains both formulas and raw data

#Keeping track of row to start with
t12_start <- 15

current_div_year <- divorce_t12_input %>% 
  distinct(Year) %>% 
  arrange(Year) %>% 
  filter(Year <= annual_year, Year >=2003) %>% pull(Year) 
div_year_row_seq <- seq(from = t12_start, to = t12_start + length(current_div_year) - 1)

#List info
t12_list_col <- 2
t12_list_letter <- num_to_letter(t12_list_col)
t12_list_a_row <- 8
t12_list_b_row <- 9
#Remaining annual data
div_year <- tibble(Year = current_div_year,
                  Quarter = NA_character_,
                  d_pet_filed = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,D$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row})=0,".",SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,D$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row}))')
                  ,
                  d_decrees_nisi = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,E$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row})=0,".",SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,E$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row}))')
                  ,
                  d_mean_nisi = glue('=IF(SUMIFS(Table_12_source!$H:$H,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,E$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row})=0,".",SUMIFS(Table_12_source!$H:$H,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,E$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row}))')
                  ,
                  d_median_nisi = glue('=IF(SUMIFS(Table_12_source!$I:$I,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,E$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row})=0,".",SUMIFS(Table_12_source!$I:$I,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,E$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row}))')
                  ,
                  d_decrees_abs = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,H$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row})=0,".",SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,H$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row}))')
                  ,
                  d_mean_abs = glue('=IF(SUMIFS(Table_12_source!$H:$H,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,H$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row})=0,".",SUMIFS(Table_12_source!$H:$H,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,H$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row}))')
                  ,
                  d_median_abs = glue('=IF(SUMIFS(Table_12_source!$I:$I,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,H$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row})=0,".",SUMIFS(Table_12_source!$I:$I,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,H$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row}))')
                  ,
                  dig_perc = glue('=IF(AND(${t12_list_letter}${t12_list_b_row} = "All", ${t12_list_letter}${t12_list_a_row} <> "New"), SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,D$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,"Digital")/SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,D$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,"All"),".")')
                  ,
                  n_pet_filed = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,M$6,Table_12_source!$A:$A,$M$13,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row})=0,".",SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,M$6,Table_12_source!$A:$A,$M$13,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row}))')
                  ,
                  n_decrees_nisi = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,N$6,Table_12_source!$A:$A,$M$13,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row})=0,".",SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,N$6,Table_12_source!$A:$A,$M$13,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row}))')
                  ,
                  n_decrees_abs = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,O$6,Table_12_source!$A:$A,$M$13,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row})=0,".",SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,O$6,Table_12_source!$A:$A,$M$13,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row}))')
                  ,
                  j_pet_filed = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,Q$6,Table_12_source!$A:$A,$Q$13,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row})=0,".",SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,Q$6,Table_12_source!$A:$A,$Q$13,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row}))')
                  ,
                  j_decrees_granted = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,R$6,Table_12_source!$A:$A,$Q$13,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row})=0,".",SUMIFS(Table_12_source!$G:$G,Table_12_source!$C:$C,$A{div_year_row_seq},Table_12_source!$B:$B,R$6,Table_12_source!$A:$A,$Q$13,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row}))')
                  ,
                  t_pet_filed = glue('=IF(${t12_list_letter}${t12_list_a_row}="New",".",IF(${t12_list_letter}${t12_list_b_row}="Digital",D{div_year_row_seq},D{div_year_row_seq}+L{div_year_row_seq}+P{div_year_row_seq}))')
                  ,
                  t_decrees_nisi = glue('=IF(${t12_list_letter}${t12_list_a_row}="New",".",IF(${t12_list_letter}${t12_list_b_row} = "Digital", E{div_year_row_seq},E{div_year_row_seq}+M{div_year_row_seq}))')
                  ,
                  t_decrees_abs = glue('=IF(${t12_list_letter}${t12_list_a_row}="New",".",IF(${t12_list_letter}${t12_list_b_row} = "Digital", H{div_year_row_seq}, H{div_year_row_seq}+N{div_year_row_seq}+Q{div_year_row_seq}))')
                  
                  )


#Joining all the tables together
t12_reg_year <- div_year %>% 
  mutate(blank1 = NA, blank2 = NA, blank3 = NA, blank4 = NA) %>% 
  relocate(blank1, .after = Quarter) %>% 
  relocate(blank2, .after = dig_perc) %>% 
  relocate(blank3, .after = n_decrees_abs) %>% 
  relocate(blank4, .after = j_decrees_granted) %>% 
  mutate(across(3:ncol(.), .fns = formula_add)) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, 0))) 


#####################
#Quarterly
#####################
t12_start_qtr <- t12_start + length(current_div_year)

current_div_qtr <- divorce_t12_input %>% distinct(Quarter) %>% separate('Quarter', into = c('Year', 'Quarter'), sep = ' Q') %>% 
  mutate(Year = as.numeric(Year)) %>% 
  filter(Year > 2010) %>% 
  arrange(Year, Quarter)

div_qtr_row_seq <- seq(from = t12_start_qtr, to = t12_start_qtr + nrow(current_div_qtr) - 1)

#Remaining annual data
div_qtr <- tibble(Year = current_div_qtr$Year,
                   Quarter = current_div_qtr$Quarter,
                   d_pet_filed = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A{div_qtr_row_seq}&" "&LEFT($B{div_qtr_row_seq},2),Table_12_source!$B:$B,D$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row})=0,".",SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A{div_qtr_row_seq}&" "&LEFT($B{div_qtr_row_seq},2),Table_12_source!$B:$B,D$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row}))')
                   ,
                   d_decrees_nisi = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A{div_qtr_row_seq}&" "&LEFT($B{div_qtr_row_seq},2),Table_12_source!$B:$B,E$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row})=0,".",SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A{div_qtr_row_seq}&" "&LEFT($B{div_qtr_row_seq},2),Table_12_source!$B:$B,E$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row}))')
                   ,
                   d_mean_nisi = glue('=IF(SUMIFS(Table_12_source!$H:$H,Table_12_source!$D:$D,$A{div_qtr_row_seq} & " "&LEFT($B{div_qtr_row_seq},2),Table_12_source!$B:$B,E$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row})=0,".",SUMIFS(Table_12_source!$H:$H,Table_12_source!$D:$D,$A{div_qtr_row_seq} & " "&LEFT($B{div_qtr_row_seq},2),Table_12_source!$B:$B,E$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row}))')
                   ,
                   d_median_nisi = glue('=IF(SUMIFS(Table_12_source!$I:$I,Table_12_source!$D:$D,$A{div_qtr_row_seq} & " " &LEFT($B{div_qtr_row_seq},2),Table_12_source!$B:$B,E$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row})=0,".",SUMIFS(Table_12_source!$I:$I,Table_12_source!$D:$D,$A{div_qtr_row_seq} & " " &LEFT($B{div_qtr_row_seq},2),Table_12_source!$B:$B,E$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row}))')
                   ,
                   d_decrees_abs = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A{div_qtr_row_seq} & " " &LEFT($B{div_qtr_row_seq},2),Table_12_source!$B:$B,H$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row})=0,".",SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A{div_qtr_row_seq} & " " &LEFT($B{div_qtr_row_seq},2),Table_12_source!$B:$B,H$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row}))')
                   ,
                   d_mean_abs = glue('=IF(SUMIFS(Table_12_source!$H:$H,Table_12_source!$D:$D,$A{div_qtr_row_seq} & " " &LEFT($B{div_qtr_row_seq},2),Table_12_source!$B:$B,H$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row})=0,".",SUMIFS(Table_12_source!$H:$H,Table_12_source!$D:$D,$A{div_qtr_row_seq} & " " &LEFT($B{div_qtr_row_seq},2),Table_12_source!$B:$B,H$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row}))')
                   ,
                   d_median_abs = glue('=IF(SUMIFS(Table_12_source!$I:$I,Table_12_source!$D:$D,$A{div_qtr_row_seq} & " " &LEFT($B{div_qtr_row_seq},2),Table_12_source!$B:$B,H$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row})=0,".",SUMIFS(Table_12_source!$I:$I,Table_12_source!$D:$D,$A{div_qtr_row_seq} & " " &LEFT($B{div_qtr_row_seq},2),Table_12_source!$B:$B,H$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row}))')
                   ,
                  dig_perc = case_when((Year > 2021) & !(Year == 2022 & Quarter == 1) ~ glue('=IF(${t12_list_letter}${t12_list_b_row} = "All",SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A{div_qtr_row_seq}&" "&LEFT($B{div_qtr_row_seq},2),Table_12_source!$B:$B,D$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,"Digital")/SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A{div_qtr_row_seq}&" "&LEFT($B{div_qtr_row_seq},2),Table_12_source!$B:$B,D$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,"All"),".")'),
                                       TRUE ~ glue('=IF(AND(${t12_list_letter}${t12_list_b_row} = "All", ${t12_list_letter}${t12_list_a_row} <> "New"),SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A{div_qtr_row_seq}&" "&LEFT($B{div_qtr_row_seq},2),Table_12_source!$B:$B,D$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,"Digital")/SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A{div_qtr_row_seq}&" "&LEFT($B{div_qtr_row_seq},2),Table_12_source!$B:$B,D$6,Table_12_source!$A:$A,$D$5,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,"All"),".")'))
                  ,
                   n_pet_filed = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A{div_qtr_row_seq} & " " &LEFT($B{div_qtr_row_seq},2),Table_12_source!$B:$B,M$6,Table_12_source!$A:$A,$M$13,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row})=0,".",SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A{div_qtr_row_seq} & " " &LEFT($B{div_qtr_row_seq},2),Table_12_source!$B:$B,M$6,Table_12_source!$A:$A,$M$13,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row}))')
                   ,
                   n_decrees_nisi = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A{div_qtr_row_seq} & " " &LEFT($B{div_qtr_row_seq},2),Table_12_source!$B:$B,N$6,Table_12_source!$A:$A,$M$13,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row})=0,".",SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A{div_qtr_row_seq} & " " &LEFT($B{div_qtr_row_seq},2),Table_12_source!$B:$B,N$6,Table_12_source!$A:$A,$M$13,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row}))')
                   ,
                   n_decrees_abs = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A{div_qtr_row_seq} & " " &LEFT($B{div_qtr_row_seq},2),Table_12_source!$B:$B,O$6,Table_12_source!$A:$A,$M$13,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row})=0,".",SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A{div_qtr_row_seq} & " " &LEFT($B{div_qtr_row_seq},2),Table_12_source!$B:$B,O$6,Table_12_source!$A:$A,$M$13,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row}))')
                   ,
                   j_pet_filed = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A{div_qtr_row_seq} & " " &LEFT($B{div_qtr_row_seq},2),Table_12_source!$B:$B,Q$6,Table_12_source!$A:$A,$Q$13,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row})=0,".",SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A{div_qtr_row_seq} & " " &LEFT($B{div_qtr_row_seq},2),Table_12_source!$B:$B,Q$6,Table_12_source!$A:$A,$Q$13,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row}))')
                   ,
                   j_decrees_granted = glue('=IF(SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A{div_qtr_row_seq} & " " &LEFT($B{div_qtr_row_seq},2),Table_12_source!$B:$B,R$6,Table_12_source!$A:$A,$Q$13,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row})=0,".",SUMIFS(Table_12_source!$G:$G,Table_12_source!$D:$D,$A{div_qtr_row_seq} & " " &LEFT($B{div_qtr_row_seq},2),Table_12_source!$B:$B,R$6,Table_12_source!$A:$A,$Q$13,Table_12_source!$F:$F,${t12_list_letter}${t12_list_a_row},Table_12_source!$E:$E,${t12_list_letter}${t12_list_b_row}))')
                   ,
                   t_pet_filed = case_when((Year > 2021) & !(Year == 2022 & Quarter == 1) ~ glue('=IF(${t12_list_letter}${t12_list_a_row}="Old",".",D{div_qtr_row_seq})'),
                                           TRUE ~ glue('=IF(${t12_list_letter}${t12_list_a_row}="New",".",IF(${t12_list_letter}${t12_list_b_row}="Digital",D{div_qtr_row_seq},D{div_qtr_row_seq}+L{div_qtr_row_seq}+P{div_qtr_row_seq}))'))
                   ,
                   t_decrees_nisi = glue('=IF(${t12_list_letter}${t12_list_a_row}="New",".",IF(${t12_list_letter}${t12_list_b_row} = "Digital", E{div_qtr_row_seq},E{div_qtr_row_seq}+M{div_qtr_row_seq}))')
                   ,
                   t_decrees_abs = glue('=IF(${t12_list_letter}${t12_list_a_row}="New",".",IF(${t12_list_letter}${t12_list_b_row} = "Digital", H{div_qtr_row_seq}, H{div_qtr_row_seq}+N{div_qtr_row_seq}+Q{div_qtr_row_seq}))')
          
)

t12_reg_qtr <- div_qtr %>% 
  mutate(Quarter = paste0('Q', Quarter), blank1 = NA, blank2 = NA, blank3 = NA, blank4 = NA) %>% 
  relocate(blank1, .after = Quarter) %>% 
  relocate(blank2, .after = dig_perc) %>% 
  relocate(blank3, .after = n_decrees_abs) %>% 
  relocate(blank4, .after = j_decrees_granted) %>% 
  mutate(across(3:ncol(.), .fns = formula_add)) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, 0))) 

# time period
if(pub_quarter==4){
  
  timeperiod12 <- paste0("Annually 2003 - ", pub_year, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
  
} else {
  
  timeperiod12 <- paste0("Annually 2003 - ", pub_year-1, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
}

