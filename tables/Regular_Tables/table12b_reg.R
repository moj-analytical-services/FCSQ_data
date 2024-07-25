# Table 12b regular
# This table contains both formulas and raw data

#Keeping track of row to start with
t12b_start <- 14

#List info
t12b_list_col <- 2
t12b_list_letter <- num_to_letter(t12_list_col)
t12b_list_a_row <- 7
t12b_list_b_row <- 8

current_div_year_new <- divorce_t12b_input %>%  distinct(Year) %>% filter(Year <= annual_year) %>% pull(Year)

#####################
#Annually
#####################
# div_year_row_seq_new <- seq(from = t12b_start, to = t12b_start + length(current_div_year_new) - 1)
# 
# #Annual data
# div_year_new <- tibble(Year = current_div_year_new,
#                       Quarter = NA_character_,
#                       d_apps = glue('=IF(SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$C:$C,$A{div_year_row_seq_new},Table_12b_source!$B:$B,D$5,Table_12b_source!$A:$A,${t12b_list_letter}${t12b_list_b_row},Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row},Table_12b_source!$F:$F,"All")=0,".",SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$C:$C,$A{div_year_row_seq_new},Table_12b_source!$B:$B,D$5,Table_12b_source!$A:$A,${t12b_list_letter}${t12b_list_b_row},Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row},Table_12b_source!$F:$F,"All"))')
#                       ,
#                       d_cond = glue('=IF(SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$C:$C,$A{div_year_row_seq_new},Table_12b_source!$B:$B,E$5,Table_12b_source!$A:$A,${t12b_list_letter}${t12b_list_b_row},Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row})=0,".",SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$C:$C,$A{div_year_row_seq_new},Table_12b_source!$B:$B,E$5,Table_12b_source!$A:$A,${t12b_list_letter}${t12b_list_b_row},Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row}))')
#                       ,
#                       d_mean_cond = glue('=IF(SUMIFS(Table_12b_source!$I:$I,Table_12b_source!$C:$C,$A{div_year_row_seq_new},Table_12b_source!$B:$B,$E$5,Table_12b_source!$A:$A,${t12b_list_letter}${t12b_list_b_row},Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row})=0,".",SUMIFS(Table_12b_source!$I:$I,Table_12b_source!$C:$C,$A{div_year_row_seq_new},Table_12b_source!$B:$B,$E$5,Table_12b_source!$A:$A,${t12b_list_letter}${t12b_list_b_row},Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row}))')
#                       ,
#                       d_median_cond = glue('=IF(SUMIFS(Table_12b_source!$J:$J,Table_12b_source!$C:$C,$A{div_year_row_seq_new},Table_12b_source!$B:$B,$E$5,Table_12b_source!$A:$A,${t12b_list_letter}${t12b_list_b_row},Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row})=0,".",SUMIFS(Table_12b_source!$J:$J,Table_12b_source!$C:$C,$A{div_year_row_seq_new},Table_12b_source!$B:$B,$E$5,Table_12b_source!$A:$A,${t12b_list_letter}${t12b_list_b_row},Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row}))')
#                       ,
#                       d_final = glue('=IF(SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$C:$C,$A{div_year_row_seq_new},Table_12b_source!$B:$B,H$5,Table_12b_source!$A:$A,${t12b_list_letter}${t12b_list_b_row},Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row})=0,".",SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$C:$C,$A{div_year_row_seq_new},Table_12b_source!$B:$B,H$5,Table_12b_source!$A:$A,${t12b_list_letter}${t12b_list_b_row},Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row}))')
#                       ,
#                       d_mean_final = glue('=IF(SUMIFS(Table_12b_source!$I:$I,Table_12b_source!$C:$C,$A{div_year_row_seq_new},Table_12b_source!$B:$B,H$5, Table_12b_source!$A:$A,${t12b_list_letter}${t12b_list_b_row}, Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row})=0,".",SUMIFS(Table_12b_source!$I:$I,Table_12b_source!$C:$C,$A{div_year_row_seq_new},Table_12b_source!$B:$B,H$5, Table_12b_source!$A:$A,${t12b_list_letter}${t12b_list_b_row}, Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row}))')
#                       ,
#                       d_median_final = glue('=IF(SUMIFS(Table_12b_source!$J:$J,Table_12b_source!$C:$C,$A{div_year_row_seq_new},Table_12b_source!$B:$B,$H$5,Table_12b_source!$A:$A,${t12b_list_letter}${t12b_list_b_row},Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row})=0,".",SUMIFS(Table_12b_source!$J:$J,Table_12b_source!$C:$C,$A{div_year_row_seq_new},Table_12b_source!$B:$B,$H$5,Table_12b_source!$A:$A,${t12b_list_letter}${t12b_list_b_row},Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row}))')
#                       ,
#                       n_apps = glue('=IF(SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$C:$C,$A{div_year_row_seq_new},Table_12b_source!$B:$B,L$5,Table_12b_source!$A:$A,$L$12,Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row})=0,".",SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$C:$C,$A{div_year_row_seq_new},Table_12b_source!$B:$B,L$5,Table_12b_source!$A:$A,$L$12,Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row}))')
#                       ,
#                       n_cond = glue('=IF(SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$C:$C,$A{div_year_row_seq_new},Table_12b_source!$B:$B,M$5,Table_12b_source!$A:$A,$L$12,Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row})=0,".",SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$C:$C,$A{div_year_row_seq_new},Table_12b_source!$B:$B,M$5,Table_12b_source!$A:$A,$L$12,Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row}))')
#                       ,
#                       n_final = glue('=IF(SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$C:$C,$A{div_year_row_seq_new},Table_12b_source!$B:$B,N$5,Table_12b_source!$A:$A,$L$12,Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row})=0,".",SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$C:$C,$A{div_year_row_seq_new},Table_12b_source!$B:$B,N$5,Table_12b_source!$A:$A,$L$12,Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row}))')
#                       ,
#                       j_apps = glue('=IF(SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$C:$C,$A{div_year_row_seq_new},Table_12b_source!$B:$B,P$5,Table_12b_source!$A:$A,$P$12,Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row})=0,".",SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$C:$C,$A{div_year_row_seq_new},Table_12b_source!$B:$B,P$5,Table_12b_source!$A:$A,$P$12,Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row}))')
#                       ,
#                       j_final = glue('=IF(SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$C:$C,$A{div_year_row_seq_new},Table_12b_source!$B:$B,Q$5,Table_12b_source!$A:$A,$P$12,Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row})=0,".",SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$C:$C,$A{div_year_row_seq_new},Table_12b_source!$B:$B,Q$5,Table_12b_source!$A:$A,$P$12,Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row}))')
#                       
# )
# 
# t12b_reg_year <- div_year_new %>% 
#   mutate(blank1 = NA, blank2 = NA, blank3 = NA) %>% 
#   relocate(blank1, .after = Quarter) %>% 
#   relocate(blank2, .after = d_median_final) %>% 
#   relocate(blank3, .after = n_final) %>%  
#   mutate(across(3:ncol(.), .fns = formula_add)) %>% 
#   mutate(across(where(is.numeric), ~replace_na(.x, 0))) 

#####################
#Quarterly
#####################
t12b_start_qtr <- t12b_start #+ length(current_div_year_new)

current_div_qtr_new <- divorce_t12b_input %>% distinct(Quarter) %>% separate('Quarter', into = c('Year', 'Quarter'), sep = ' Q') %>%
  mutate(Year = as.numeric(Year)) %>% 
  filter(Year > 2010) %>% 
  arrange(Year, Quarter)

div_qtr_row_seq_new <- seq(from = t12b_start_qtr, to = t12b_start_qtr + nrow(current_div_qtr_new) - 1)

#Remaining quarterly data
div_qtr_new <- tibble(Year = current_div_qtr_new$Year,
                  Quarter = current_div_qtr_new$Quarter,
                  d_apps = glue('=IF(SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A{div_qtr_row_seq_new}&" "&LEFT($B{div_qtr_row_seq_new},2),Table_12b_source!$B:$B,D$5,Table_12b_source!$A:$A,${t12b_list_letter}${t12b_list_b_row},Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row},Table_12b_source!$F:$F,"All")=0,".",SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A{div_qtr_row_seq_new}&" "&LEFT($B{div_qtr_row_seq_new},2),Table_12b_source!$B:$B,D$5,Table_12b_source!$A:$A,${t12b_list_letter}${t12b_list_b_row},Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row},Table_12b_source!$F:$F,"All"))')
                  ,
                  d_cond = glue('=IF(SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A{div_qtr_row_seq_new}&" "&LEFT($B{div_qtr_row_seq_new},2),Table_12b_source!$B:$B,E$5,Table_12b_source!$A:$A,${t12b_list_letter}${t12b_list_b_row},Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row})=0,".",SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A{div_qtr_row_seq_new}&" "&LEFT($B{div_qtr_row_seq_new},2),Table_12b_source!$B:$B,E$5,Table_12b_source!$A:$A,${t12b_list_letter}${t12b_list_b_row},Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row}))')
                  ,
                  d_mean_cond = glue('=IF(SUMIFS(Table_12b_source!$I:$I,Table_12b_source!$D:$D,$A{div_qtr_row_seq_new}&" "&LEFT($B{div_qtr_row_seq_new},2),Table_12b_source!$B:$B,$E$5,Table_12b_source!$A:$A,${t12b_list_letter}${t12b_list_b_row},Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row})=0,".",SUMIFS(Table_12b_source!$I:$I,Table_12b_source!$D:$D,$A{div_qtr_row_seq_new}&" "&LEFT($B{div_qtr_row_seq_new},2),Table_12b_source!$B:$B,$E$5,Table_12b_source!$A:$A,${t12b_list_letter}${t12b_list_b_row},Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row}))')
                  ,
                  d_median_cond = glue('=IF(SUMIFS(Table_12b_source!$J:$J,Table_12b_source!$D:$D,$A{div_qtr_row_seq_new}&" "&LEFT($B{div_qtr_row_seq_new},2),Table_12b_source!$B:$B,$E$5,Table_12b_source!$A:$A,${t12b_list_letter}${t12b_list_b_row},Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row})=0,".",SUMIFS(Table_12b_source!$J:$J,Table_12b_source!$D:$D,$A{div_qtr_row_seq_new}&" "&LEFT($B{div_qtr_row_seq_new},2),Table_12b_source!$B:$B,$E$5,Table_12b_source!$A:$A,${t12b_list_letter}${t12b_list_b_row},Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row}))')
                  ,
                  d_final = glue('=IF(SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A{div_qtr_row_seq_new}&" "&LEFT($B{div_qtr_row_seq_new},2),Table_12b_source!$B:$B,H$5,Table_12b_source!$A:$A,${t12b_list_letter}${t12b_list_b_row},Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row})=0,".",SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A{div_qtr_row_seq_new}&" "&LEFT($B{div_qtr_row_seq_new},2),Table_12b_source!$B:$B,H$5,Table_12b_source!$A:$A,${t12b_list_letter}${t12b_list_b_row},Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row}))')
                  ,
                  d_mean_final = glue('=IF(SUMIFS(Table_12b_source!$I:$I,Table_12b_source!$D:$D,$A{div_qtr_row_seq_new}&" "&LEFT($B{div_qtr_row_seq_new},2),Table_12b_source!$B:$B,H$5, Table_12b_source!$A:$A,${t12b_list_letter}${t12b_list_b_row}, Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row})=0,".",SUMIFS(Table_12b_source!$I:$I,Table_12b_source!$D:$D,$A{div_qtr_row_seq_new}&" "&LEFT($B{div_qtr_row_seq_new},2),Table_12b_source!$B:$B,H$5, Table_12b_source!$A:$A,${t12b_list_letter}${t12b_list_b_row}, Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row}))')
                  ,
                  d_median_final = glue('=IF(SUMIFS(Table_12b_source!$J:$J,Table_12b_source!$D:$D,$A{div_qtr_row_seq_new}&" "&LEFT($B{div_qtr_row_seq_new},2),Table_12b_source!$B:$B,$H$5,Table_12b_source!$A:$A,${t12b_list_letter}${t12b_list_b_row},Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row})=0,".",SUMIFS(Table_12b_source!$J:$J,Table_12b_source!$D:$D,$A{div_qtr_row_seq_new}&" "&LEFT($B{div_qtr_row_seq_new},2),Table_12b_source!$B:$B,$H$5,Table_12b_source!$A:$A,${t12b_list_letter}${t12b_list_b_row},Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row}))')
                  ,
                  sole_perc = glue('=SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A{div_qtr_row_seq_new}&" "&LEFT($B{div_qtr_row_seq_new},2),Table_12b_source!$B:$B,D$5,Table_12b_source!$A:$A,${t12b_list_letter}${t12b_list_b_row},Table_12b_source!$E:$E,"Sole",Table_12b_source!$F:$F,"All")/SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A{div_qtr_row_seq_new}&" "&LEFT($B{div_qtr_row_seq_new},2),Table_12b_source!$B:$B,D$5,Table_12b_source!$A:$A,${t12b_list_letter}${t12b_list_b_row},Table_12b_source!$E:$E,"All",Table_12b_source!$F:$F,"All")')
                  ,
                  n_apps = glue('=IF(SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A{div_qtr_row_seq_new}&" "&LEFT($B{div_qtr_row_seq_new},2),Table_12b_source!$B:$B,M$5,Table_12b_source!$A:$A,$M$12,Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row})=0,".",SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A{div_qtr_row_seq_new}&" "&LEFT($B{div_qtr_row_seq_new},2),Table_12b_source!$B:$B,M$5,Table_12b_source!$A:$A,$M$12,Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row}))')
                  ,
                  n_cond = glue('=IF(SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A{div_qtr_row_seq_new}&" "&LEFT($B{div_qtr_row_seq_new},2),Table_12b_source!$B:$B,N$5,Table_12b_source!$A:$A,$M$12,Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row})=0,".",SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A{div_qtr_row_seq_new}&" "&LEFT($B{div_qtr_row_seq_new},2),Table_12b_source!$B:$B,N$5,Table_12b_source!$A:$A,$M$12,Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row}))')
                  ,
                  n_final = glue('=IF(SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A{div_qtr_row_seq_new}&" "&LEFT($B{div_qtr_row_seq_new},2),Table_12b_source!$B:$B,O$5,Table_12b_source!$A:$A,$M$12,Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row})=0,".",SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A{div_qtr_row_seq_new}&" "&LEFT($B{div_qtr_row_seq_new},2),Table_12b_source!$B:$B,O$5,Table_12b_source!$A:$A,$M$12,Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row}))')
                  ,
                  j_apps = glue('=IF(SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A{div_qtr_row_seq_new}&" "&LEFT($B{div_qtr_row_seq_new},2),Table_12b_source!$B:$B,Q$5,Table_12b_source!$A:$A,$Q$12,Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row})=0,".",SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A{div_qtr_row_seq_new}&" "&LEFT($B{div_qtr_row_seq_new},2),Table_12b_source!$B:$B,Q$5,Table_12b_source!$A:$A,$Q$12,Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row}))')
                  ,
                  j_final = glue('=IF(SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A{div_qtr_row_seq_new}&" "&LEFT($B{div_qtr_row_seq_new},2),Table_12b_source!$B:$B,R$5,Table_12b_source!$A:$A,$Q$12,Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row})=0,".",SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A{div_qtr_row_seq_new}&" "&LEFT($B{div_qtr_row_seq_new},2),Table_12b_source!$B:$B,R$5,Table_12b_source!$A:$A,$Q$12,Table_12b_source!$E:$E,${t12b_list_letter}${t12b_list_a_row}))')
                 
)

t12b_reg_qtr <- div_qtr_new %>% 
  mutate(Quarter = paste0('Q', Quarter), blank1 = NA, blank2 = NA, blank3 = NA) %>% 
  relocate(blank1, .after = Quarter) %>% 
  relocate(blank2, .after = sole_perc) %>% 
  relocate(blank3, .after = n_final) %>%  
  mutate(across(3:ncol(.), .fns = formula_add)) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, 0)))

t12b_reg_qtr_a <- t12b_reg_qtr %>% filter(Year == 2022) %>% mutate(across(3:ncol(.), .fns = formula_add))
t12b_reg_qtr_b <- t12b_reg_qtr %>% filter(Year > 2022) %>% mutate(across(3:ncol(.), .fns = formula_add))

# time period
timeperiod12b <- paste0("Quarterly Q2 2022 - Q", pub_quarter," ", pub_year)

