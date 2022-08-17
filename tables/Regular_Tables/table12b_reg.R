# Table 12b regular
# This table contains both formulas and raw data

#Keeping track of row to start with
t12b_start <- 12

current_div_year_new <- tibble()
#####################
#Quarterly
#####################
t12b_start_qtr <- t12b_start + length(current_div_year_new)

current_div_qtr_new <- divorce_t12b_input %>% distinct(Quarter) %>% separate('Quarter', into = c('Year', 'Quarter'), sep = ' Q') %>% 
  filter(Year > 2010) %>% 
  arrange(Year, Quarter)

div_qtr_row_seq_new <- seq(from = t12b_start_qtr, to = t12b_start_qtr + nrow(current_div_qtr_new) - 1)

#Remaining quarterly data
div_qtr_new <- tibble(Year = current_div_qtr_new$Year,
                  Quarter = current_div_qtr_new$Quarter,
                  d_apps = glue('=IF(SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A14&" "&LEFT($B14,2),Table_12b_source!$B:$B,D$5,Table_12b_source!$A:$A,$B$8,Table_12b_source!$E:$E,$B$7,Table_12b_source!$F:$F,"All")=0,".",SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A14&" "&LEFT($B14,2),Table_12b_source!$B:$B,D$5,Table_12b_source!$A:$A,$B$8,Table_12b_source!$E:$E,$B$7,Table_12b_source!$F:$F,"All"))')
                  ,
                  d_cond = glue('=IF(SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A14&" "&LEFT($B14,2),Table_12b_source!$B:$B,E$5,Table_12b_source!$A:$A,$B$8,Table_12b_source!$E:$E,$B$7)=0,".",SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A14&" "&LEFT($B14,2),Table_12b_source!$B:$B,E$5,Table_12b_source!$A:$A,$B$8,Table_12b_source!$E:$E,$B$7))')
                  ,
                  d_mean_cond = glue('=IF(SUMIFS(Table_12b_source!$I:$I,Table_12b_source!$D:$D,$A14&" "&LEFT($B14,2),Table_12b_source!$B:$B,$E$5,Table_12b_source!$A:$A,$B$8,Table_12b_source!$E:$E,$B$7)=0,".",SUMIFS(Table_12b_source!$I:$I,Table_12b_source!$D:$D,$A14&" "&LEFT($B14,2),Table_12b_source!$B:$B,$E$5,Table_12b_source!$A:$A,$B$8,Table_12b_source!$E:$E,$B$7))')
                  ,
                  d_median_cond = glue('=IF(SUMIFS(Table_12b_source!$J:$J,Table_12b_source!$D:$D,$A14&" "&LEFT($B14,2),Table_12b_source!$B:$B,$E$5,Table_12b_source!$A:$A,$B$8,Table_12b_source!$E:$E,$B$7)=0,".",SUMIFS(Table_12b_source!$J:$J,Table_12b_source!$D:$D,$A14&" "&LEFT($B14,2),Table_12b_source!$B:$B,$E$5,Table_12b_source!$A:$A,$B$8,Table_12b_source!$E:$E,$B$7))')
                  ,
                  d_final = glue('=IF(SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A14&" "&LEFT($B14,2),Table_12b_source!$B:$B,H$5,Table_12b_source!$A:$A,$B$8,Table_12b_source!$E:$E,$B$7)=0,".",SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A14&" "&LEFT($B14,2),Table_12b_source!$B:$B,H$5,Table_12b_source!$A:$A,$B$8,Table_12b_source!$E:$E,$B$7))')
                  ,
                  d_mean_final = glue('=IF(SUMIFS(Table_12b_source!$I:$I,Table_12b_source!$D:$D,$A14&" "&LEFT($B14,2),Table_12b_source!$B:$B,H$5, Table_12b_source!$A:$A,$B$8, Table_12b_source!$E:$E,$B$7)=0,".",SUMIFS(Table_12b_source!$I:$I,Table_12b_source!$D:$D,$A14&" "&LEFT($B14,2),Table_12b_source!$B:$B,H$5, Table_12b_source!$A:$A,$B$8, Table_12b_source!$E:$E,$B$7))')
                  ,
                  d_median_final = glue('=IF(SUMIFS(Table_12b_source!$J:$J,Table_12b_source!$D:$D,$A14&" "&LEFT($B14,2),Table_12b_source!$B:$B,$H$5,Table_12b_source!$A:$A,$B$8,Table_12b_source!$E:$E,$B$7)=0,".",SUMIFS(Table_12b_source!$J:$J,Table_12b_source!$D:$D,$A14&" "&LEFT($B14,2),Table_12b_source!$B:$B,$H$5,Table_12b_source!$A:$A,$B$8,Table_12b_source!$E:$E,$B$7))')
                  ,
                  n_apps = glue('=IF(SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A14&" "&LEFT($B14,2),Table_12b_source!$B:$B,L$5,Table_12b_source!$A:$A,$L$12,Table_12b_source!$E:$E,$B$7)=0,".",SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A14&" "&LEFT($B14,2),Table_12b_source!$B:$B,L$5,Table_12b_source!$A:$A,$L$12,Table_12b_source!$E:$E,$B$7))')
                  ,
                  n_cond = glue('=IF(SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A14&" "&LEFT($B14,2),Table_12b_source!$B:$B,M$5,Table_12b_source!$A:$A,$L$12,Table_12b_source!$E:$E,$B$7)=0,".",SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A14&" "&LEFT($B14,2),Table_12b_source!$B:$B,M$5,Table_12b_source!$A:$A,$L$12,Table_12b_source!$E:$E,$B$7))')
                  ,
                  n_final = glue('=IF(SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A14&" "&LEFT($B14,2),Table_12b_source!$B:$B,N$5,Table_12b_source!$A:$A,$L$12,Table_12b_source!$E:$E,$B$7)=0,".",SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A14&" "&LEFT($B14,2),Table_12b_source!$B:$B,N$5,Table_12b_source!$A:$A,$L$12,Table_12b_source!$E:$E,$B$7))')
                  ,
                  j_apps = glue('=IF(SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A14&" "&LEFT($B14,2),Table_12b_source!$B:$B,P$5,Table_12b_source!$A:$A,$P$12,Table_12b_source!$E:$E,$B$7)=0,".",SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A14&" "&LEFT($B14,2),Table_12b_source!$B:$B,P$5,Table_12b_source!$A:$A,$P$12,Table_12b_source!$E:$E,$B$7))')
                  ,
                  j_final = glue('=IF(SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A14&" "&LEFT($B14,2),Table_12b_source!$B:$B,Q$5,Table_12b_source!$A:$A,$P$12,Table_12b_source!$E:$E,$B$7)=0,".",SUMIFS(Table_12b_source!$H:$H,Table_12b_source!$D:$D,$A14&" "&LEFT($B14,2),Table_12b_source!$B:$B,Q$5,Table_12b_source!$A:$A,$P$12,Table_12b_source!$E:$E,$B$7))')
                 
)

t12b_reg_qtr <- div_qtr_new %>% 
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

