#Table 16 Regular

#Starting with the Hard Coded Data
#Pre 2011

start_t16 <- 10
dv_hard_code <- tibble(Year = 2003:2010,
                       Quarter = NA_character_,
                       Nmo_app = paste0('IF($B$6="All",Table_16_source!O', seq(from = 3, to = 10),',"-")'),
                       Oo_app = paste0('IF($B$6="All",Table_16_source!P', seq(from = 3, to = 10),',"-")'),
                       Appl_total = paste0('IF($B$6="All",Table_16_source!Q', seq(from = 3, to = 10),',"-")'),
                       App_made = '-',
                       Case_start = '-',
                       Nmo_ords = paste0('IF($B$6="All",Table_16_source!T', seq(from = 3, to = 10),',"-")'),
                       Oo_ords = paste0('IF($B$6="All",Table_16_source!U', seq(from = 3, to = 10),',"-")'),
                       Ords_total = paste0('IF($B$6="All",Table_16_source!V', seq(from = 3, to = 10),',"-")'),
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
dv_year_row <- annual_year - 2011
dv_year_row_seq <- seq(from = current_t16, to = current_t16 + dv_year_row)

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