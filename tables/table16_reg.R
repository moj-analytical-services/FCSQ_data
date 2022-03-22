#Table 16 Regular

#Starting with the Hard Coded Data
#Pre 2011

start_t16 <- 10
dv_hard_code_seq <- seq(from = 3, to = 10)
dv_hard_code <- tibble(Year = 2003:2010,
                       Quarter = NA_character_,
                       Nmo_app = paste0('IF($B$6="All",Table_16_source!O', dv_hard_code_seq,',"-")'),
                       Oo_app = paste0('IF($B$6="All",Table_16_source!P', dv_hard_code_seq,',"-")'),
                       Appl_total = paste0('IF($B$6="All",Table_16_source!Q', dv_hard_code_seq,',"-")'),
                       App_made = '-',
                       Case_start = '-',
                       Nmo_ords = paste0('IF($B$6="All",Table_16_source!T', dv_hard_code_seq,',"-")'),
                       Oo_ords = paste0('IF($B$6="All",Table_16_source!U', dv_hard_code_seq,',"-")'),
                       Ords_total = paste0('IF($B$6="All",Table_16_source!V', dv_hard_code_seq,',"-")'),
                       Case_close = '-')

#Marking formula columns. This is so write data writes the column as a formula.
class(dv_hard_code$Nmo_app) <- c(class(dv_hard_code$Nmo_app), 'formula')
class(dv_hard_code$Oo_app) <- c(class(dv_hard_code$Oo_app), 'formula')
class(dv_hard_code$Appl_total) <- c(class(dv_hard_code$Appl_total), 'formula')
class(dv_hard_code$Nmo_ords) <- c(class(dv_hard_code$Nmo_ords), 'formula')
class(dv_hard_code$Oo_ords) <- c(class(dv_hard_code$Oo_ords), 'formula')
class(dv_hard_code$Ords_total) <- c(class(dv_hard_code$Ords_total), 'formula')

#Keeping track of row to start with
current_t16 <- start_t16 + nrow(dv_hard_code)
t16_year_diff <- annual_year - 2011
dv_year_row_seq <- seq(from = current_t16, to = current_t16 + t16_year_diff)

#Remaining annual data
dv_year <- tibble(Year = 2011:annual_year,
                  Quarter = NA_character_,
                  Nmo_app = paste0('IF($B$6="All",SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A', 
                                   dv_year_row_seq,
                                   ',Table_16_source!$D:$D,LEFT($C$8, LEN($C$8) - 1),Table_16_source!$E:$E,C$9)',
                                   ',SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A',
                                   dv_year_row_seq,
                                   ',Table_16_source!$D:$D,LEFT($C$8, LEN($C$8) - 1),Table_16_source!$E:$E,C$9,Table_16_source!$F:$F,$B$6))'
                                   ),
                                   
                                                                                                            
                  Oo_app = paste0('IF($B$6="All",SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A', 
                                  dv_year_row_seq,
                                  ',Table_16_source!$D:$D,LEFT($C$8, LEN($C$8) - 1),Table_16_source!$E:$E,D$9)',
                                  ',SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A',
                                  dv_year_row_seq,
                                  ',Table_16_source!$D:$D,LEFT($C$8, LEN($C$8) - 1),Table_16_source!$E:$E,D$9,Table_16_source!$F:$F,$B$6))'
                                  ),
                  
              
                  Appl_total = paste0('C', dv_year_row_seq, '+D', dv_year_row_seq),
                  
                  App_made = paste0('IF($B$6="All",SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A',
                                    dv_year_row_seq,
                                    ',Table_16_source!$D:$D,"Application events"), "-")'),
                                    
                  Case_start = paste0('IF($B$6="All",SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A',
                                      dv_year_row_seq,
                                      ',Table_16_source!$D:$D,LEFT(G$8, LEN(G$8)-1)),"-")'),
                                      
                  Nmo_ords = paste0('IF($B$6="All",SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A', 
                                    dv_year_row_seq,
                                    ',Table_16_source!$D:$D,$H$8,Table_16_source!$E:$E,H$9)',
                                    ',SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A', 
                                    dv_year_row_seq,
                                    ',Table_16_source!$D:$D,$H$8,Table_16_source!$E:$E,H$9,Table_16_source!$F:$F,$B$6))'),
                  
                  Oo_ords = paste0('IF($B$6="All",SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A', 
                                   dv_year_row_seq,
                                   ',Table_16_source!$D:$D,$H$8,Table_16_source!$E:$E,I$9)',
                                   ',SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A', 
                                   dv_year_row_seq,
                                   ',Table_16_source!$D:$D,$H$8,Table_16_source!$E:$E,I$9,Table_16_source!$F:$F,$B$6))'),
                  
                  Ords_total = paste0('H', dv_year_row_seq, '+I', dv_year_row_seq),
                  
                  Case_close = paste0('IF($B$6="All",SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A',
                                      dv_year_row_seq,
                                      ',Table_16_source!$D:$D,LEFT(K$8, LEN(K$8)-1)),"-")'))

#Marking formula columns. This is so write data writes the column as a formula.
class(dv_year$Nmo_app) <- c(class(dv_year$Nmo_app), 'formula')
class(dv_year$Oo_app) <- c(class(dv_year$Oo_app), 'formula')
class(dv_year$Appl_total) <- c(class(dv_year$Appl_total), 'formula')
class(dv_year$App_made) <- c(class(dv_year$App_made), 'formula')
class(dv_year$Case_start) <- c(class(dv_year$Case_start), 'formula')
class(dv_year$Nmo_ords) <- c(class(dv_year$Nmo_ords), 'formula')
class(dv_year$Oo_ords) <- c(class(dv_year$Oo_ords), 'formula')
class(dv_year$Ords_total) <- c(class(dv_year$Ords_total), 'formula')
class(dv_year$Case_close) <- c(class(dv_year$Case_start), 'formula')


#Hard Coded Quarter
current_t16 <- current_t16 + nrow(dv_year)
dv_hard_code_qtr_seq <- seq(from = 13, to = 20)
dv_hard_code_qtr <- tibble(Year = rep(c(2009, 2010), each = 4),
                       Quarter = paste0('Q', rep(1:4, 2)),
                       Nmo_app = paste0('IF($B$6="All",Table_16_source!O', dv_hard_code_qtr_seq,',"-")'),
                       Oo_app = paste0('IF($B$6="All",Table_16_source!P', dv_hard_code_qtr_seq,',"-")'),
                       Appl_total = paste0('IF($B$6="All",Table_16_source!Q', dv_hard_code_qtr_seq,',"-")'),
                       App_made = '-',
                       Case_start = '-',
                       Nmo_ords = paste0('IF($B$6="All",Table_16_source!T', dv_hard_code_qtr_seq,',"-")'),
                       Oo_ords = paste0('IF($B$6="All",Table_16_source!U', dv_hard_code_qtr_seq,',"-")'),
                       Ords_total = paste0('IF($B$6="All",Table_16_source!V', dv_hard_code_qtr_seq,',"-")'),
                       Case_close = '-')


#Marking formula columns. This is so write data writes the column as a formula.
class(dv_hard_code_qtr$Nmo_app) <- c(class(dv_hard_code_qtr$Nmo_app), 'formula')
class(dv_hard_code_qtr$Oo_app) <- c(class(dv_hard_code_qtr$Oo_app), 'formula')
class(dv_hard_code_qtr$Appl_total) <- c(class(dv_hard_code_qtr$Appl_total), 'formula')
class(dv_hard_code_qtr$Nmo_ords) <- c(class(dv_hard_code_qtr$Nmo_ords), 'formula')
class(dv_hard_code_qtr$Oo_ords) <- c(class(dv_hard_code_qtr$Oo_ords), 'formula')
class(dv_hard_code_qtr$Ords_total) <- c(class(dv_hard_code_qtr$Ords_total), 'formula')


#Remaining Quarterly data.
#Keeping track of current row
current_t16 <- current_t16 + nrow(dv_hard_code_qtr)

#Making sure that Year and Quarter have the right amount of rows

if (pub_quarter == 4){
  t16_qtr_year <- rep(2011:annual_year, each = 4)
  t16_qtr_qtr <- paste0('Q', rep(1:4, t16_year_diff + 1))
  t16_quarter_num <- length(t16_qtr_qtr)
  dv_qtr_row_seq <- seq(from = current_t16, to = current_t16 + t16_quarter_num - 1)
  
} else{
  t16_qtr_year <- c(rep(2011:annual_year, each = 4), rep(pub_year, each = pub_quarter))
  t16_qtr_qtr <- paste0('Q', c(rep(1:4, t16_year_diff + 1), 1:pub_quarter))
  t16_quarter_num <- len(t16_qtr_qtr)
  dv_qtr_row_seq <- seq(from = current_t16, to = current_t16 + t16_quarter_num - 1)
}

dv_qtr <- tibble(Year = t16_qtr_year,
                  Quarter = t16_qtr_qtr,
                  Nmo_app = paste0('IF($B$6="All",SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A', 
                                   dv_qtr_row_seq,
                                   ',Table_16_source!$D:$D,LEFT($C$8, LEN($C$8) - 1),Table_16_source!$E:$E,C$9',
                                   ',Table_16_source!$B:$B,MID($B', dv_qtr_row_seq,',2,1))',
                                   ',SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A',
                                   dv_qtr_row_seq,
                                   ',Table_16_source!$D:$D,LEFT($C$8, LEN($C$8) - 1),Table_16_source!$E:$E,C$9,Table_16_source!$F:$F,$B$6',
                                   ',Table_16_source!$B:$B,MID($B', dv_qtr_row_seq,',2,1)))'
                  ),
                  
                  
                  Oo_app = paste0('IF($B$6="All",SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A', 
                                  dv_qtr_row_seq,
                                  ',Table_16_source!$D:$D,LEFT($C$8, LEN($C$8) - 1),Table_16_source!$E:$E,D$9',
                                  ',Table_16_source!$B:$B,MID($B', dv_qtr_row_seq,',2,1))',
                                  ',SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A',
                                  dv_qtr_row_seq,
                                  ',Table_16_source!$D:$D,LEFT($C$8, LEN($C$8) - 1),Table_16_source!$E:$E,D$9,Table_16_source!$F:$F,$B$6',
                                  ',Table_16_source!$B:$B,MID($B', dv_qtr_row_seq,',2,1)))'
                  ),
                  
                  
                  Appl_total = paste0('C', dv_qtr_row_seq, '+D', dv_qtr_row_seq),
                  
                  App_made = paste0('IF($B$6="All",SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A',
                                    dv_year_row_seq,
                                    ',Table_16_source!$D:$D,"Application events"',
                                    ',Table_16_source!$B:$B,MID($B', dv_qtr_row_seq,',2,1))',
                                    ',"-")'),
                  
                  Case_start = paste0('IF($B$6="All",SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A',
                                      dv_qtr_row_seq,
                                      ',Table_16_source!$D:$D,LEFT(G$8, LEN(G$8)-1)',
                                      ',Table_16_source!$B:$B,MID($B', dv_qtr_row_seq,',2,1))',
                                      ',"-")'),
                  
                  Nmo_ords = paste0('IF($B$6="All",SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A', 
                                    dv_qtr_row_seq,
                                    ',Table_16_source!$D:$D,$H$8,Table_16_source!$E:$E,H$9', 
                                    ',Table_16_source!$B:$B,MID($B', dv_qtr_row_seq,',2,1))',
                                    ',SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A', 
                                    dv_qtr_row_seq,
                                    ',Table_16_source!$D:$D,$H$8,Table_16_source!$E:$E,H$9,Table_16_source!$F:$F,$B$6',
                                    ',Table_16_source!$B:$B,MID($B', dv_qtr_row_seq,',2,1)))'),
                  
                  Oo_ords = paste0('IF($B$6="All",SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A', 
                                   dv_qtr_row_seq,
                                   ',Table_16_source!$D:$D,$H$8,Table_16_source!$E:$E,I$9',
                                   ',Table_16_source!$B:$B,MID($B', dv_qtr_row_seq,',2,1))',
                                   ',SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A',
                                   dv_qtr_row_seq,
                                   ',Table_16_source!$D:$D,$H$8,Table_16_source!$E:$E,I$9,Table_16_source!$F:$F,$B$6',
                                   ',Table_16_source!$B:$B,MID($B', dv_qtr_row_seq,',2,1)))'),
                  
                  Ords_total = paste0('H', dv_qtr_row_seq, '+I', dv_qtr_row_seq),
                  
                  Case_close = paste0('IF($B$6="All",SUMIFS(Table_16_source!$H:$H,Table_16_source!$A:$A,$A',
                                      dv_qtr_row_seq,
                                      ',Table_16_source!$D:$D,LEFT(K$8, LEN(K$8)-1)',
                                      ',Table_16_source!$B:$B,MID($B', dv_qtr_row_seq,',2,1))',
                                      ',"-")'))

#Marking formula columns. This is so write data writes the column as a formula.
class(dv_qtr$Nmo_app) <- c(class(dv_qtr$Nmo_app), 'formula')
class(dv_qtr$Oo_app) <- c(class(dv_qtr$Oo_app), 'formula')
class(dv_qtr$Appl_total) <- c(class(dv_qtr$Appl_total), 'formula')
class(dv_qtr$App_made) <- c(class(dv_qtr$App_made), 'formula')
class(dv_qtr$Case_start) <- c(class(dv_qtr$Case_start), 'formula')
class(dv_qtr$Nmo_ords) <- c(class(dv_qtr$Nmo_ords), 'formula')
class(dv_qtr$Oo_ords) <- c(class(dv_qtr$Oo_ords), 'formula')
class(dv_qtr$Ords_total) <- c(class(dv_qtr$Ords_total), 'formula')
class(dv_qtr$Case_close) <- c(class(dv_qtr$Case_start), 'formula')
