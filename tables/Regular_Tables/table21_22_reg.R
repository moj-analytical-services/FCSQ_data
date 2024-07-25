#Tidying the COP table
table21_cols <- c('Year', 'Quarter',	'Applications made under the mental capacity act 2005 of which',
                  'Applications for appointment of a property and affairs deputy',	
                  'Applications for a one-off property and affairs order',	'Applications for appointment of a personal welfare deputy',
                  'Applications for a one-off personal welfare order',	'Applications for appointment of a hybrid deputy',
                  'Applications for a one-off property and affairs and personal welfare order',
                  'Applications for orders appointing new trustees',	
                  'Applications to execute wills apply for gifts and orders for settlement including those where there is an epa or lpa',
                  'Applications relating to enduring powers of attorney',	'Applications relating to lasting powers of attorney',
                  'Applications by an existing deputy or registered attorney',	
                  'Applications for discharge of the deputy',
                  'Deprivation of Liberty',	'Other')



table22_cols <- c('Year', 'Quarter',	'Orders made under the mental capacity act 2005 of which',
                  'Orders for appointment of a property and affairs deputy',	
                  'Orders for a one-off property and affairs order',	'Orders for appointment of a personal welfare deputy',
                  'Orders for a one-off personal welfare order',	'Orders for appointment of a hybrid deputy',
                  'Orders for a one-off property and affairs and personal welfare order',
                  'Orders for orders appointing new trustees',	
                  'Orders to execute wills apply for gifts and orders for settlement including those where there is an epa or lpa',
                  'Orders relating to enduring powers of attorney',	'Orders relating to lasting powers of attorney',
                  'Orders by an existing deputy or registered attorney',	
                  'Orders for discharge of the deputy',
                  'Deprivation of Liberty',	'Other')

cop_tidy <- function(table, cols){
  #Tidies the data, supply colnames with it
  colnames(table) <- cols
  tibble(table) %>% mutate(Year = as.numeric(Year), Quarter = str_trim(Quarter)) %>% fill(Year)
  
}

t21_all <- cop_table_21 %>% cop_tidy(table21_cols)
t22_all <- cop_table_22 %>% cop_tidy(table22_cols)

# Filtering Year and Quarter sections for formatting purposes
t21_reg_year <- t21_all %>% filter(is.na(Quarter))
t21_reg_qtr <- t21_all %>% filter(!is.na(Quarter))

t22_reg_year <- t22_all %>% filter(is.na(Quarter))
t22_reg_qtr <- t22_all %>% filter(!is.na(Quarter))

# time period
if(pub_quarter==4){
  
  timeperiod21 <- paste0("Annually 2008 - ", pub_year, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
  timeperiod22 <- paste0("Annually 2008 - ", pub_year, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
  
} else {
  
  timeperiod21 <- paste0("Annually 2008 - ", pub_year-1, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
  timeperiod22 <- paste0("Annually 2008 - ", pub_year-1, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
}