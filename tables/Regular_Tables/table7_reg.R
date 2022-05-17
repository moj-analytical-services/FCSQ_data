#  Table 7
#YEAR	Qtr	Type	Count_type	Public_private	Disposal_type	Order_type	Order_type_code	Gender	age_band	Applicants_in_case	Respondents_in_case	HC_INDICATOR	Count
#####################################################
#Public Law Annual
######################################################
child_act_pub <- child_act_csv %>% 
  filter(Public_private == 'Public law')

#Cases starting
pub_ca_case_start_year <- child_act_pub %>%
  filter(Type == 'Cases', Count_type == 'Cases starting') %>% 
  group_by(Year) %>% 
  summarise(pub_case_start = sum(Count))

# Cases started in the High Court
pub_high_court_year <- child_act_pub %>%
  filter(Hc_indicator %in% c('Central London DFJ','Not central London DFJ')) %>% 
  group_by(Year) %>% 
  summarise(pub_all_hc = sum(Count))
  
# High Court in Central London DFJ
pub_central_lond_year <- child_act_pub %>%
  filter(Hc_indicator == 'Central London DFJ') %>% 
  group_by(Year) %>% 
  summarise(pub_london_hc = sum(Count))

# High Court outside Central London DFJ
pub_outside_lond_year <- child_act_pub %>%
  filter(Hc_indicator == 'Not central London DFJ') %>% 
  group_by(Year) %>% 
  summarise(pub_outside_london_hc = sum(Count))

#Gathering and joining columns
pub_t7_annual_tables <- list(pub_ca_case_start_year, pub_high_court_year,
                             pub_central_lond_year, pub_outside_lond_year)

pub_t7_join_year <- reduce(pub_t7_annual_tables, left_join, by = 'Year')

#####################################################
#Private Law Annual
######################################################
child_act_priv <- child_act_csv %>% 
  filter(Public_private == 'Private law')

#Cases starting
priv_ca_case_start_year <- child_act_priv %>%
  filter(Type == 'Cases', Count_type == 'Cases starting') %>% 
  group_by(Year) %>% 
  summarise(priv_case_start = sum(Count))

# Cases started in the High Court
priv_high_court_year <- child_act_priv %>%
  filter(Hc_indicator %in% c('Central London DFJ','Not central London DFJ')) %>% 
  group_by(Year) %>% 
  summarise(priv_all_hc = sum(Count))

# High Court in Central London DFJ
priv_central_lond_year <- child_act_priv %>%
  filter(Hc_indicator == 'Central London DFJ') %>% 
  group_by(Year) %>% 
  summarise(priv_london_hc = sum(Count))

# High Court outside Central London DFJ
priv_outside_lond_year <- child_act_priv %>%
  filter(Hc_indicator == 'Not central London DFJ') %>% 
  group_by(Year) %>% 
  summarise(priv_outside_london_hc = sum(Count))

#Gathering and joining columns
priv_t7_annual_tables <- list(priv_ca_case_start_year, priv_high_court_year,
                             priv_central_lond_year, priv_outside_lond_year)

priv_t7_join_year <- reduce(priv_t7_annual_tables, left_join, by = 'Year')

#################################################
#Finishing the annual part of T7
##################################################
t7_reg_year <- pub_t7_join_year %>% left_join(priv_t7_join_year, by = 'Year') %>% 
  filter(Year <= annual_year, !is.na(Year)) %>% 
  mutate(Qtr = NA, blank1 = NA) %>% 
  relocate(Qtr, .after = Year) %>% 
  relocate(blank1, .after = pub_outside_london_hc) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, 0)))

#####################################################
#Public Law Quarterly
######################################################
#Cases starting
pub_ca_case_start_qtr <- child_act_pub %>%
  filter(Type == 'Cases', Count_type == 'Cases starting') %>% 
  group_by(Year, Qtr) %>% 
  summarise(pub_case_start = sum(Count))

# Cases started in the High Court
pub_high_court_qtr <- child_act_pub %>%
  filter(Hc_indicator %in% c('Central London DFJ','Not central London DFJ')) %>% 
  group_by(Year, Qtr) %>% 
  summarise(pub_all_hc = sum(Count))

# High Court in Central London DFJ
pub_central_lond_qtr <- child_act_pub %>%
  filter(Hc_indicator == 'Central London DFJ') %>% 
  group_by(Year, Qtr) %>% 
  summarise(pub_london_hc = sum(Count))

# High Court outside Central London DFJ
pub_outside_lond_qtr <- child_act_pub %>%
  filter(Hc_indicator == 'Not central London DFJ') %>% 
  group_by(Year, Qtr) %>% 
  summarise(pub_outside_london_hc = sum(Count))

#Gathering and joining columns
pub_t7_qtr_tables <- list(pub_ca_case_start_qtr, pub_high_court_qtr,
                             pub_central_lond_qtr, pub_outside_lond_qtr)

pub_t7_join_qtr <- reduce(pub_t7_qtr_tables, left_join, by = c('Year', 'Qtr'))

#####################################################
#Private Law Quarterly
######################################################
#Cases starting
priv_ca_case_start_qtr <- child_act_priv %>%
  filter(Type == 'Cases', Count_type == 'Cases starting') %>% 
  group_by(Year, Qtr) %>% 
  summarise(priv_case_start = sum(Count))

# Cases started in the High Court
priv_high_court_qtr <- child_act_priv %>%
  filter(Hc_indicator %in% c('Central London DFJ','Not central London DFJ')) %>% 
  group_by(Year, Qtr) %>% 
  summarise(priv_all_hc = sum(Count))

# High Court in Central London DFJ
priv_central_lond_qtr <- child_act_priv %>%
  filter(Hc_indicator == 'Central London DFJ') %>% 
  group_by(Year, Qtr) %>% 
  summarise(priv_london_hc = sum(Count))

# High Court outside Central London DFJ
priv_outside_lond_qtr <- child_act_priv %>%
  filter(Hc_indicator == 'Not central London DFJ') %>% 
  group_by(Year, Qtr) %>% 
  summarise(priv_outside_london_hc = sum(Count))

priv_t7_qtr_tables <- list(priv_ca_case_start_qtr, priv_high_court_qtr,
                          priv_central_lond_qtr, priv_outside_lond_qtr)

priv_t7_join_qtr <- reduce(priv_t7_qtr_tables, left_join, by = c('Year', 'Qtr'))

#################################################
#Finishing the quarterly part of T7
##################################################
t7_reg_qtr <- pub_t7_join_qtr %>% left_join(priv_t7_join_qtr, by = c('Year', 'Qtr')) %>% 
  filter(!is.na(Year)) %>% 
  mutate(Qtr = paste0('Q', Qtr), blank1 = NA) %>% 
  relocate(Qtr, .after = Year) %>% 
  relocate(blank1, .after = pub_outside_london_hc) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, 0)))

# Content #########################################################################################

# time period
if(pub_quarter==4){
  
  timeperiod7 <- paste0("Annually 2011 - ", pub_year, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
  
} else {
  
  timeperiod7 <- paste0("Annually 2011 - ", pub_year-1, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
}
