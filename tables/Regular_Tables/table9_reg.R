# Table 9

#Yearly data and dropping Type column
t9_reg_year <- priv_law_disposal_csv %>% 
  filter(Quarter == '') %>% 
  mutate(Quarter = NA) %>% 
  select(!Type) %>% 
  arrange(Year)


# Separating Quarterly data and dropping Type column
t9_reg_qtr <- priv_law_disposal_csv %>% filter(is.na(Year)) %>% 
  separate(Quarter, into = c('Year', 'Quarter'), convert = TRUE) %>%
  relocate(Year, Quarter) %>% 
  select(!Type) %>% 
  arrange(Year, Quarter)

# Content #########################################################################################

# time period
if(pub_quarter==4){
  
  timeperiod9 <- paste0("Annually 2011 - ", pub_year, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
  
} else {
  
  timeperiod9 <- paste0("Annually 2011 - ", pub_year-1, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
}