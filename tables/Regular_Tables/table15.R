#Table 15
na_keys <- c(":", ".", "..", "*", "#REF!", "-")
fr_csv <- read_using(readr::read_csv, paste0(csv_folder,"CSV Financial Remedy National", " ", pub_year, " Q", pub_quarter, ".csv"), na = na_keys) %>% rename_with(str_to_title)

#Table Creation by Year first

#Uncontested Applications
fr_uncon_apps_year <- fr_csv %>%
  filter(Type == 'Applications', Consent == 'Uncontested') %>% 
  group_by(Year) %>% 
  summarise(uncon_apps = sum(Count))

#Contested Applications
fr_con_apps_year <- fr_csv %>%
  filter(Type == 'Applications', Consent == 'Contested') %>% 
  group_by(Year) %>% 
  summarise(con_apps = sum(Count))

#Total Applications
fr_all_apps_year <- fr_csv %>%
  filter(Type == 'Applications') %>% 
  group_by(Year) %>% 
  summarise(total_apps = sum(Count))

#Total cases started
fr_case_start_year <-  fr_csv %>%
  filter(Type == 'Cases started') %>% 
  group_by(Year) %>% 
  summarise(total_case_start = sum(Count))


#Uncontested Disposals
fr_uncon_disps_year <- fr_csv %>%
  filter(Type == 'Disposals', Consent == 'Uncontested') %>% 
  group_by(Year) %>% 
  summarise(uncon_disps = sum(Count))

#Initially Contested Disposals
fr_initcon_disps_year <- fr_csv %>%
  filter(Type == 'Disposals', Consent == 'Initially Contested') %>% 
  group_by(Year) %>% 
  summarise(initcon_disps = sum(Count))

#Contested Disposals
fr_con_disps_year <- fr_csv %>%
  filter(Type == 'Disposals', Consent == 'Contested') %>% 
  group_by(Year) %>% 
  summarise(con_disps = sum(Count))

#Total Disposals
fr_all_disps_year <- fr_csv %>%
  filter(Type == 'Disposals') %>% 
  group_by(Year) %>% 
  summarise(total_disps = sum(Count))

#Total cases started
fr_case_close_year <-  fr_csv %>%
  filter(Type == 'Cases closed') %>% 
  group_by(Year) %>% 
  summarise(total_case_close = sum(Count))


#Now Joining all the parts together
#Reduce is used to repeatedly join all the tables in the list
#Adding empty columns for Quarter and for spacing

fr_tables <- list(fr_uncon_apps_year, fr_con_apps_year, fr_all_apps_year, fr_case_start_year, 
                  fr_uncon_disps_year, fr_initcon_disps_year, fr_con_disps_year, fr_all_disps_year, fr_case_close_year)

fr_joined_year <- reduce(fr_tables, left_join, by = 'Year')

t15_year <- fr_joined_year %>% 
  mutate(Qtr = NA, blank1 = NA) %>% 
  relocate(Qtr, .after = Year) %>% 
  relocate(blank1, .after = total_case_start)


#Quarter##########################################

#Now doing by Quarter

#Uncontested Applications
fr_uncon_apps_qtr <- fr_csv %>%
  filter(Type == 'Applications', Consent == 'Uncontested') %>% 
  group_by(Year, Qtr) %>% 
  summarise(uncon_apps = sum(Count))

#Contested Applications
fr_con_apps_qtr <- fr_csv %>%
  filter(Type == 'Applications', Consent == 'Contested') %>% 
  group_by(Year, Qtr) %>% 
  summarise(con_apps = sum(Count))

#Total Applications
fr_all_apps_qtr <- fr_csv %>%
  filter(Type == 'Applications') %>% 
  group_by(Year, Qtr) %>% 
  summarise(total_apps = sum(Count))

#Total cases started
fr_case_start_qtr <-  fr_csv %>%
  filter(Type == 'Cases started') %>% 
  group_by(Year, Qtr) %>% 
  summarise(total_case_start = sum(Count))


#Uncontested Disposals
fr_uncon_disps_qtr <- fr_csv %>%
  filter(Type == 'Disposals', Consent == 'Uncontested') %>% 
  group_by(Year, Qtr) %>% 
  summarise(uncon_disps = sum(Count))

#Initially Contested Disposals
fr_initcon_disps_qtr <- fr_csv %>%
  filter(Type == 'Disposals', Consent == 'Initially Contested') %>% 
  group_by(Year, Qtr) %>% 
  summarise(initcon_disps = sum(Count))

#Contested Disposals
fr_con_disps_qtr <- fr_csv %>%
  filter(Type == 'Disposals', Consent == 'Contested') %>% 
  group_by(Year, Qtr) %>% 
  summarise(con_disps = sum(Count))

#Total Disposals
fr_all_disps_qtr <- fr_csv %>%
  filter(Type == 'Disposals') %>% 
  group_by(Year, Qtr) %>% 
  summarise(total_disps = sum(Count))

#Total cases started
fr_case_close_qtr <-  fr_csv %>%
  filter(Type == 'Cases closed') %>% 
  group_by(Year, Qtr) %>% 
  summarise(total_case_close = sum(Count))


#Now Joining all the parts together
#Reduce is used to repeatedly join all the tables in the list
#Adding empty columns for spacing

fr_tables_qtr <- list(fr_uncon_apps_qtr, fr_con_apps_qtr, fr_all_apps_qtr, fr_case_start_qtr, 
                  fr_uncon_disps_qtr, fr_initcon_disps_qtr, fr_con_disps_qtr, fr_all_disps_qtr, fr_case_close_qtr)

fr_joined_qtr <- reduce(fr_tables_qtr, left_join, by = c('Year', 'Qtr'))
t15_qtr <-  fr_joined_qtr %>% 
  mutate(Qtr = paste0('Q', Qtr), blank1 = NA) %>% 
  relocate(Qtr, .after = Year) %>% 
  relocate(blank1, .after = total_case_start) %>% 
  filter(Year >= 2009)


# Content #########################################################################################

# time period
if(pub_quarter==4){
  
  timeperiod15 <- paste0("Annually 2003 - ", pub_year, " and quarterly Q1 2009 - Q", pub_quarter," ", pub_year)
  
} else {
  
  timeperiod15 <- paste0("Annually 2003 - ", pub_year-1, " and quarterly Q1 2009 - Q", pub_quarter," ", pub_year)
}

             
              