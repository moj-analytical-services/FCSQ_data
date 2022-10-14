# Table 8

#Yearly data
t8_reg_year <- care_disposal_csv %>% 
  filter(Year <= annual_year, Quarter == '') %>% 
  mutate(Quarter = NA)
  

# Separating Quarterly data
t8_reg_qtr <- care_disposal_csv %>% filter(is.na(Year)) %>% 
  separate(Quarter, into = c('Year', 'Quarter'), convert = TRUE) %>%
  relocate(Year, Quarter)

# Content #########################################################################################

# time period
if(pub_quarter==4){
  
  timeperiod8 <- paste0("Annually 2011 - ", pub_year, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
  
} else {
  
  timeperiod8 <- paste0("Annually 2011 - ", pub_year-1, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
}