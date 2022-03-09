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


################################################################################
# Accessible Version
#This is built from the above sections

################################################################################

t15_accessible_year <- fr_joined_year %>% 
  mutate(Qtr = '[z]') %>% 
  relocate(Qtr, .after = Year)

colnames(t15_accessible_year) <- c('Year', 'Quarter' ,'Uncontested Applications', 'Contested Applications',
                              'Total Applications', 'Cases starting', 'Uncontested Disposals',
                              'Initially Contested Disposals', 'Contested Disposals',
                              'Total Disposals', 'Cases closed')


t15_accessible_qtr <- fr_joined_qtr %>% 
  mutate(Qtr = paste0('Q', Qtr)) %>% 
  relocate(Qtr, .after = Year)

colnames(t15_accessible_qtr) <- c('Year', 'Quarter' ,'Uncontested Applications', 'Contested Applications',
                                  'Total Applications', 'Cases starting', 'Uncontested Disposals',
                                  'Initially Contested Disposals', 'Contested Disposals',
                                  'Total Disposals', 'Cases closed')

t15_accessible <- bind_rows(t15_accessible_year, t15_accessible_qtr)

# Content #########################################################################################

# time period
if(pub_quarter==4){
  
  timeperiod15 <- paste0("Annually 2003 - ", pub_year, " and quarterly Q1 2009 - Q", pub_quarter," ", pub_year)
  
} else {
  
  timeperiod15 <- paste0("Annually 2003 - ", pub_year-1, " and quarterly Q1 2009 - Q", pub_quarter," ", pub_year)
}

t15_notes <- c("The types of financial remedy included are as follows: lump sum, maintenance pending suit, property adjustment, periodical payment, pension sharing, pension attachment, secure provision orders and application dismissed.",
            "The HMCTS Reform programme has been rolled out to cover financial remedy cases, with data being entered on the new Core Case Data (CCD) system. Such cases are being copied into FamilyMan (the data source for financial remedy) but please be aware that there are around 2,100 cases that have yet to be copied across. The MoJ and HMCTS are working towards a combined data source that uses both FamilyMan and CCD systems, which will address this existing gap in the data.",
            "Not all applications for financial remedy are correctly recorded in the Familyman database. Analysis of data between 2007/08 and 2010/11 suggest actual figures to be at least 10% higher than those shown above. Most of the 'missing' applications occur in cases where the financial remedy is not contested.",
            "The following application types are not included in these series: for further directions, financial dispute resolution or for interim orders. These are generally after an application had been issued and listed for the first hearing.",
            "These figures relate to the number of disposal events in which one or more types of financial remedy disposals were made (e.g. an order given or a dismissal). Figures on each type of disposals individually were removed from this publication in June 2020 (see accompanying guide for further details)",
            "Some figures may have been revised from previous publications. Minimal changes may be observed in earlier years, whilst larger changes may be seen in more recent quarters")
  
# notes
 notes15 <- c("Source:",
             "HMCTS FamilyMan system",
              "",
              "Notes:",
              paste0("1) ", t15_notes[1]),
             paste0("2) ", t15_notes[2]),
             paste0("3) ", t15_notes[3]),
             paste0("4) ", t15_notes[4]),
             paste0("5) ", t15_notes[5]),
             paste0("6) ", t15_notes[6]))
             
              