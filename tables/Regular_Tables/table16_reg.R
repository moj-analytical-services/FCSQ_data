#Table 16 Regular

#Starting with the Hard Coded Data
#Pre 2011

t16_start <- 10
dv_hard_code_seq <- seq(from = 3, to = 10)
dv_hard_code <- tibble(Year = 2003:2010,
                       Quarter = NA_character_,
                       Nmo_app = glue('IF($B$6="All",Table_16_source!O{dv_hard_code_seq},"-")'),
                       Oo_app = glue('IF($B$6="All",Table_16_source!P{dv_hard_code_seq},"-")'),
                       Appl_total = glue('IF($B$6="All",Table_16_source!Q{dv_hard_code_seq},"-")'),
                       App_made = '-',
                       Case_start = '-',
                       blank1 = NA,
                       Nmo_ords = glue('IF($B$6="All",Table_16_source!T{dv_hard_code_seq},"-")'),
                       Oo_ords = glue('IF($B$6="All",Table_16_source!U{dv_hard_code_seq},"-")'),
                       Ords_total = glue('IF($B$6="All",Table_16_source!V{dv_hard_code_seq},"-")'),
                       Case_close = '-')

#Marking formula columns. This is so write data writes the column as a formula.
#marking columns as formula
dv_hard_code <- dv_hard_code %>% mutate(across(.cols = c(Nmo_app, Oo_app, Appl_total, Nmo_ords, Oo_ords, Ords_total), .fns = formula_add))


#Keeping track of row to start with
current_t16 <- t16_start + nrow(dv_hard_code)
dv_label <- dv_csv %>% distinct(Year, Quarter) %>% filter(Year > 2010)
current_dv_year <- dv_label %>% distinct(Year) %>% pull(Year)
dv_year_row_seq <- seq(from = current_t16, to = current_t16 + length(current_dv_year) - 1)


#Remaining annual data
dv_year <- tibble(Year = current_dv_year,
                  Quarter = NA_character_,
                  Nmo_app = glue('IF($B$6="All",SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A{dv_year_row_seq}\\
                                   ,Table_16_source!$D:$D,LEFT($C$8, LEN($C$8) - 1),Table_16_source!$E:$E,C$9)\\
                                   ,SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A{dv_year_row_seq},\\
                                   Table_16_source!$D:$D,LEFT($C$8, LEN($C$8) - 1),Table_16_source!$E:$E,C$9,Table_16_source!$F:$F,$B$6))'
                                   ),
                                   
                                                                                                            
                  Oo_app = glue('IF($B$6="All",SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A{dv_year_row_seq}\\
                                   ,Table_16_source!$D:$D,LEFT($C$8, LEN($C$8) - 1),Table_16_source!$E:$E,D$9)\\
                                   ,SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A{dv_year_row_seq},\\
                                   Table_16_source!$D:$D,LEFT($C$8, LEN($C$8) - 1),Table_16_source!$E:$E,D$9,Table_16_source!$F:$F,$B$6))'
                  ),
                  
              
                  Appl_total = glue('C{dv_year_row_seq}+D{dv_year_row_seq}'),
                  
                  App_made = glue('IF($B$6="All",SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A{dv_year_row_seq}\\
                                    ,Table_16_source!$D:$D,"Application events"), "-")'),
                                    
                  Case_start = glue('IF($B$6="All",SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A{dv_year_row_seq}\\
                                      ,Table_16_source!$D:$D,LEFT(G$8, LEN(G$8)-1)),"-")'),
                  blank1 = NA,
                                      
                  Nmo_ords = glue('IF($B$6="All",SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A{dv_year_row_seq}\\
                                    ,Table_16_source!$D:$D,$I$8,Table_16_source!$E:$E,I$9)\\
                                    ,SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A{dv_year_row_seq}\\
                                    ,Table_16_source!$D:$D,$I$8,Table_16_source!$E:$E,I$9,Table_16_source!$F:$F,$B$6))'),
                  
                  Oo_ords = glue('IF($B$6="All",SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A{dv_year_row_seq}\\
                                   ,Table_16_source!$D:$D,$I$8,Table_16_source!$E:$E,J$9)\\
                                   ,SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A{dv_year_row_seq}\\
                                   ,Table_16_source!$D:$D,$I$8,Table_16_source!$E:$E,J$9,Table_16_source!$F:$F,$B$6))'),
                  
                  Ords_total = glue('I{dv_year_row_seq}+J{dv_year_row_seq}'),
                  
                  Case_close = glue('IF($B$6="All",SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A{dv_year_row_seq}\\
                                      ,Table_16_source!$D:$D,LEFT(L$8, LEN(L$8)-1)),"-")'))

#Marking formula columns. This is so write data writes the column as a formula.
dv_year <- dv_year %>% mutate(across(.cols = 3:ncol(.), .fns = formula_add))



#Hard Coded Quarter
current_t16 <- current_t16 + nrow(dv_year)
dv_hard_code_qtr_seq <- seq(from = 13, to = 20)
dv_hard_code_qtr <- tibble(Year = rep(c(2009, 2010), each = 4),
                       Quarter = paste0('Q', rep(1:4, 2)),
                       Nmo_app = glue('IF($B$6="All",Table_16_source!O{dv_hard_code_qtr_seq},"-")'),
                       Oo_app = glue('IF($B$6="All",Table_16_source!P{dv_hard_code_qtr_seq},"-")'),
                       Appl_total = glue('IF($B$6="All",Table_16_source!Q{dv_hard_code_qtr_seq},"-")'),
                       App_made = '-',
                       Case_start = '-',
                       blank1 = NA,
                       Nmo_ords = glue('IF($B$6="All",Table_16_source!T{dv_hard_code_qtr_seq},"-")'),
                       Oo_ords = glue('IF($B$6="All",Table_16_source!U{dv_hard_code_qtr_seq},"-")'),
                       Ords_total = glue('IF($B$6="All",Table_16_source!V{dv_hard_code_qtr_seq},"-")'),
                       Case_close = '-')


#Marking formula columns. This is so write data writes the column as a formula.
dv_hard_code_qtr <- dv_hard_code_qtr %>% mutate(across(.cols = c(Nmo_app, Oo_app, Appl_total, Nmo_ords, Oo_ords, Ords_total), .fns = formula_add))

#Remaining Quarterly data.
#Keeping track of current row
current_t16 <- current_t16 + nrow(dv_hard_code_qtr)

#Making sure that Year and Quarter have the right amount of rows
current_dv_years <- dv_label$Year
current_dv_quarter <- paste0('Q', dv_label$Quarter)

dv_qtr_row_seq <- seq(from = current_t16, to = current_t16 + length(current_dv_quarter) - 1)

dv_qtr <- tibble(Year = current_dv_years,
                  Quarter = current_dv_quarter,
                  Nmo_app = glue('IF($B$6="All",SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A{dv_qtr_row_seq}\\
                                   ,Table_16_source!$D:$D,LEFT($C$8, LEN($C$8) - 1),Table_16_source!$E:$E,C$9\\
                                   ,Table_16_source!$B:$B,MID($B{dv_qtr_row_seq},2,1))\\
                                   ,SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A{dv_qtr_row_seq}\\
                                   ,Table_16_source!$D:$D,LEFT($C$8, LEN($C$8) - 1),Table_16_source!$E:$E,C$9,Table_16_source!$F:$F,$B$6\\
                                   ,Table_16_source!$B:$B,MID($B{dv_qtr_row_seq},2,1)))'
                  ),
                  
                  
                  Oo_app = glue('IF($B$6="All",SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A{dv_qtr_row_seq}\\
                                  ,Table_16_source!$D:$D,LEFT($C$8, LEN($C$8) - 1),Table_16_source!$E:$E,D$9\\
                                  ,Table_16_source!$B:$B,MID($B{dv_qtr_row_seq},2,1))\\
                                  ,SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A{dv_qtr_row_seq}\\
                                  ,Table_16_source!$D:$D,LEFT($C$8, LEN($C$8) - 1),Table_16_source!$E:$E,D$9,Table_16_source!$F:$F,$B$6\\
                                  ,Table_16_source!$B:$B,MID($B{dv_qtr_row_seq},2,1)))'
                  ),
                  
                  
                  Appl_total = glue('C{dv_qtr_row_seq}+D{dv_qtr_row_seq}'),
                  
                  App_made = glue('IF($B$6="All",SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A{dv_qtr_row_seq}\\
                                    ,Table_16_source!$D:$D,"Application events"\\
                                    ,Table_16_source!$B:$B,MID($B{dv_qtr_row_seq},2,1))\\
                                    ,"-")'),
                  
                  Case_start = glue('IF($B$6="All",SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A{dv_qtr_row_seq}\\
                                      ,Table_16_source!$D:$D,LEFT(G$8, LEN(G$8)-1)\\
                                      ,Table_16_source!$B:$B,MID($B{dv_qtr_row_seq},2,1))\\
                                      ,"-")'),
                 blank1 = NA,
                  
                  Nmo_ords = glue('IF($B$6="All",SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A{dv_qtr_row_seq}\\
                                    ,Table_16_source!$D:$D,$I$8,Table_16_source!$E:$E,I$9\\
                                    ,Table_16_source!$B:$B,MID($B{dv_qtr_row_seq},2,1))\\
                                    ,SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A{dv_qtr_row_seq}\\
                                    ,Table_16_source!$D:$D,$I$8,Table_16_source!$E:$E,I$9,Table_16_source!$F:$F,$B$6\\
                                    ,Table_16_source!$B:$B,MID($B{dv_qtr_row_seq},2,1)))'),
                  
                  Oo_ords = glue('IF($B$6="All",SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A{dv_qtr_row_seq}\\
                                   ,Table_16_source!$D:$D,$I$8,Table_16_source!$E:$E,J$9\\
                                   ,Table_16_source!$B:$B,MID($B{dv_qtr_row_seq},2,1))\\
                                   ,SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A{dv_qtr_row_seq}\\
                                   ,Table_16_source!$D:$D,$I$8,Table_16_source!$E:$E,J$9,Table_16_source!$F:$F,$B$6\\
                                   ,Table_16_source!$B:$B,MID($B{dv_qtr_row_seq},2,1)))'),
                  
                  Ords_total = glue('I{dv_qtr_row_seq}+J{dv_qtr_row_seq}'),
                  
                  Case_close = glue('IF($B$6="All",SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A{dv_qtr_row_seq}\\
                                      ,Table_16_source!$D:$D,LEFT(L$8, LEN(L$8)-1)\\
                                      ,Table_16_source!$B:$B,MID($B{dv_qtr_row_seq},2,1))\\
                                      ,"-")'))

#Marking formula columns. This is so write data writes the column as a formula.
dv_qtr <- dv_qtr %>% mutate(across(.cols = 3:ncol(.), .fns = formula_add))

# time period
if(pub_quarter==4){
  
  timeperiod16 <- paste0("Annually 2003 - ", pub_year, " and quarterly Q1 2009 - Q", pub_quarter," ", pub_year)
  
} else {
  
  timeperiod16 <- paste0("Annually 2003 - ", pub_year-1, " and quarterly Q1 2009 - Q", pub_quarter," ", pub_year)
}

# Adding source
openxlsx::writeData(wb = template,
                    sheet = 'Table_16_source',
                    x = dv_csv)