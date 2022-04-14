#Table 2

#Uncontested Applications
#YEAR	Qtr	Type	Count_type	Public_private	Disposal_type	Order_type	Order_type_code	Gender	age_band	Applicants_in_case	Respondents_in_case	HC_INDICATOR	Count
#####################################################
#Public Law Annual
######################################################
#Individual children (includes 2022 and NA. Filter both out)
pub_ca_ind_child_year <- child_act_csv %>%
  filter(Type == 'Application', Count_type == 'Individual children', Public_private == 'Public law') %>% 
  group_by(Year) %>% 
  summarise(pub_ind_child = sum(Count))

#Applications made
pub_ca_app_made_year <- child_act_csv %>%
  filter(Type == 'Application', Count_type == 'Application events', Public_private == 'Public law') %>% 
  group_by(Year) %>% 
  summarise(pub_app_made = sum(Count))

#Total orders applied for
pub_ca_ord_appl_year <- child_act_csv %>%
  filter(Type == 'Application', Count_type == 'Order type', Public_private == 'Public law') %>% 
  group_by(Year) %>% 
  summarise(pub_ord_appl = sum(Count))

#Cases starting
pub_ca_case_start_year <- child_act_csv %>%
  filter(Type == 'Cases', Count_type == 'Cases starting', Public_private == 'Public law') %>% 
  group_by(Year) %>% 
  summarise(pub_case_start = sum(Count))

#Orders made
pub_ca_ord_made_year <- child_act_csv %>%
  filter(Type == 'Disposal', Count_type == 'Order type', Disposal_type == 'Order made', Public_private == 'Public law') %>% 
  group_by(Year) %>% 
  summarise(pub_ord_made = sum(Count))

#Disposals made
pub_ca_disp_made_year <- child_act_csv %>%
  filter(Type == 'Disposal', Count_type == 'Order type', Disposal_type != 'Interim order', Public_private == 'Public law') %>% 
  group_by(Year) %>% 
  summarise(pub_disp_made = sum(Count))

#Disposal events
pub_ca_disp_event_year <- child_act_csv %>%
  filter(Type == 'Disposal', Count_type == 'Disposal events', Public_private == 'Public law') %>% 
  group_by(Year) %>% 
  summarise(pub_disp_event = sum(Count))

#Cases disposed
pub_ca_case_close_year <- child_act_csv %>%
  filter(Type == 'Cases', Count_type == 'Cases closed', Public_private == 'Public law') %>% 
  group_by(Year) %>% 
  summarise(pub_case_close = sum(Count))

#Gathering the public law annual tables and joining them together
pub_annual_tables <- list(pub_ca_ind_child_year, pub_ca_app_made_year, pub_ca_ord_appl_year, pub_ca_case_start_year,
                          pub_ca_ord_made_year, pub_ca_disp_made_year, pub_ca_disp_event_year, pub_ca_case_close_year)

pub_join_year <- reduce(pub_annual_tables, left_join, by = 'Year')

#####################################################
#Private Law Annual
######################################################
#Individual children (includes 2022 and NA. Filter both out)
priv_ca_ind_child_year <- child_act_csv %>%
  filter(Type == 'Application', Count_type == 'Individual children', Public_private == 'Private law') %>% 
  group_by(Year) %>% 
  summarise(priv_ind_child = sum(Count))

#Applications made
priv_ca_app_made_year <- child_act_csv %>%
  filter(Type == 'Application', Count_type == 'Application events', Public_private == 'Private law') %>% 
  group_by(Year) %>% 
  summarise(priv_app_made = sum(Count))

#Total orders applied for
priv_ca_ord_appl_year <- child_act_csv %>%
  filter(Type == 'Application', Count_type == 'Order type', Public_private == 'Private law') %>% 
  group_by(Year) %>% 
  summarise(priv_ord_appl = sum(Count))

#Cases starting
priv_ca_case_start_year <- child_act_csv %>%
  filter(Type == 'Cases', Count_type == 'Cases starting', Public_private == 'Private law') %>% 
  group_by(Year) %>% 
  summarise(priv_case_start = sum(Count))

#Orders made
priv_ca_ord_made_year <- child_act_csv %>%
  filter(Type == 'Disposal', Count_type == 'Order type', Disposal_type == 'Order made', Public_private == 'Private law') %>% 
  group_by(Year) %>% 
  summarise(priv_ord_made = sum(Count))

#Disposals made
priv_ca_disp_made_year <- child_act_csv %>%
  filter(Type == 'Disposal', Count_type == 'Order type', Disposal_type != 'Interim order', Public_private == 'Private law') %>% 
  group_by(Year) %>% 
  summarise(priv_disp_made = sum(Count))

#Disposal events
priv_ca_disp_event_year <- child_act_csv %>%
  filter(Type == 'Disposal', Count_type == 'Disposal events', Public_private == 'Private law') %>% 
  group_by(Year) %>% 
  summarise(priv_disp_event = sum(Count))

#Cases disposed
priv_ca_case_close_year <- child_act_csv %>%
  filter(Type == 'Cases', Count_type == 'Cases closed', Public_private == 'Private law') %>% 
  group_by(Year) %>% 
  summarise(priv_case_close = sum(Count))

#Gathering the private law annual tables and joining them together
priv_annual_tables <- list(priv_ca_ind_child_year, priv_ca_app_made_year, priv_ca_ord_appl_year, priv_ca_case_start_year,
                          priv_ca_ord_made_year, priv_ca_disp_made_year, priv_ca_disp_event_year, priv_ca_case_close_year)

priv_join_year <- reduce(priv_annual_tables, left_join, by = 'Year')
#################################################
#Finishing the annual part of T2
##################################################
t2_reg_year <- pub_join_year %>% left_join(priv_join_year, by = 'Year') %>% 
  filter(Year <= annual_year, !is.na(Year)) %>% 
  mutate(Qtr = NA, blank1 = NA, blank2 = NA, blank3 = NA) %>% 
  relocate(Qtr, .after = Year) %>% 
  relocate(blank1, .after = pub_case_start) %>% 
  relocate(blank2, .after = pub_case_close) %>% 
  relocate(blank3, .after = priv_case_start)
  


##Now doing the quarterly part of T2
#####################################################
#Public Law Quarterly
######################################################
#Individual children, Quarter works differently for this section
pub_ca_ind_child_qtr <- child_act_csv %>%
  filter(Type == 'Application', Count_type == 'Individual children', Public_private == 'Public law') %>% 
  group_by(Qtr) %>% 
  summarise(pub_ind_child_qtr = sum(Count)) %>% 
  separate(Qtr, c('Year', 'Qtr'), sep = '-') %>% 
  mutate(Year = as.double(Year))

#Applications made
pub_ca_app_made_qtr <- child_act_csv %>%
  filter(Type == 'Application', Count_type == 'Application events', Public_private == 'Public law') %>% 
  group_by(Year, Qtr) %>% 
  summarise(pub_app_made_qtr = sum(Count))

#Total orders applied for
pub_ca_ord_appl_qtr <- child_act_csv %>%
  filter(Type == 'Application', Count_type == 'Order type', Public_private == 'Public law') %>% 
  group_by(Year, Qtr) %>% 
  summarise(pub_ord_appl_qtr = sum(Count))

#Cases starting
pub_ca_case_start_qtr <- child_act_csv %>%
  filter(Type == 'Cases', Count_type == 'Cases starting', Public_private == 'Public law') %>% 
  group_by(Year, Qtr) %>% 
  summarise(pub_case_start_qtr = sum(Count))

#Orders made
pub_ca_ord_made_qtr <- child_act_csv %>%
  filter(Type == 'Disposal', Count_type == 'Order type', Disposal_type == 'Order made', Public_private == 'Public law') %>% 
  group_by(Year, Qtr) %>% 
  summarise(pub_ord_made_qtr = sum(Count))

#Disposals made
pub_ca_disp_made_qtr <- child_act_csv %>%
  filter(Type == 'Disposal', Count_type == 'Order type', Disposal_type != 'Interim order', Public_private == 'Public law') %>% 
  group_by(Year, Qtr) %>% 
  summarise(pub_disp_made_qtr = sum(Count))

#Disposal events
pub_ca_disp_event_qtr <- child_act_csv %>%
  filter(Type == 'Disposal', Count_type == 'Disposal events', Public_private == 'Public law') %>% 
  group_by(Year, Qtr) %>% 
  summarise(pub_disp_event_qtr = sum(Count))

#Cases disposed
pub_ca_case_close_qtr <- child_act_csv %>%
  filter(Type == 'Cases', Count_type == 'Cases closed', Public_private == 'Public law') %>% 
  group_by(Year, Qtr) %>% 
  summarise(pub_case_close_qtr = sum(Count))

#Gathering the public law quarterly tables and joining them together
pub_qtr_tables <- list(pub_ca_ind_child_qtr, pub_ca_app_made_qtr, pub_ca_ord_appl_qtr, pub_ca_case_start_qtr,
                          pub_ca_ord_made_qtr, pub_ca_disp_made_qtr, pub_ca_disp_event_qtr, pub_ca_case_close_qtr)

pub_join_qtr <- reduce(pub_qtr_tables, left_join, by = c('Year', 'Qtr'))


#####################################################
#Private Law Quarterly
######################################################
#Individual children, Quarter works differently for this section
priv_ca_ind_child_qtr <- child_act_csv %>%
  filter(Type == 'Application', Count_type == 'Individual children', Public_private == 'Private law') %>% 
  group_by(Qtr) %>% 
  summarise(priv_ind_child_qtr = sum(Count)) %>% 
  separate(Qtr, c('Year', 'Qtr'), sep = '-') %>% 
  mutate(Year = as.double(Year))

#Applications made
priv_ca_app_made_qtr <- child_act_csv %>%
  filter(Type == 'Application', Count_type == 'Application events', Public_private == 'Private law') %>% 
  group_by(Year, Qtr) %>% 
  summarise(priv_app_made_qtr = sum(Count))

#Total orders applied for
priv_ca_ord_appl_qtr <- child_act_csv %>%
  filter(Type == 'Application', Count_type == 'Order type', Public_private == 'Private law') %>% 
  group_by(Year, Qtr) %>% 
  summarise(priv_ord_appl_qtr = sum(Count))

#Cases starting
priv_ca_case_start_qtr <- child_act_csv %>%
  filter(Type == 'Cases', Count_type == 'Cases starting', Public_private == 'Private law') %>% 
  group_by(Year, Qtr) %>% 
  summarise(priv_case_start_qtr = sum(Count))

#Orders made
priv_ca_ord_made_qtr <- child_act_csv %>%
  filter(Type == 'Disposal', Count_type == 'Order type', Disposal_type == 'Order made', Public_private == 'Private law') %>% 
  group_by(Year, Qtr) %>% 
  summarise(priv_ord_made_qtr = sum(Count))

#Disposals made
priv_ca_disp_made_qtr <- child_act_csv %>%
  filter(Type == 'Disposal', Count_type == 'Order type', Disposal_type != 'Interim order', Public_private == 'Private law') %>% 
  group_by(Year, Qtr) %>% 
  summarise(priv_disp_made_qtr = sum(Count))

#Disposal events
priv_ca_disp_event_qtr <- child_act_csv %>%
  filter(Type == 'Disposal', Count_type == 'Disposal events', Public_private == 'Private law') %>% 
  group_by(Year, Qtr) %>% 
  summarise(priv_disp_event_qtr = sum(Count))

#Cases disposed
priv_ca_case_close_qtr <- child_act_csv %>%
  filter(Type == 'Cases', Count_type == 'Cases closed', Public_private == 'Private law') %>% 
  group_by(Year, Qtr) %>% 
  summarise(priv_case_close_qtr = sum(Count))

#Gathering the public law quarterly tables and joining them together
priv_qtr_tables <- list(priv_ca_ind_child_qtr, priv_ca_app_made_qtr, priv_ca_ord_appl_qtr, priv_ca_case_start_qtr,
                       priv_ca_ord_made_qtr, priv_ca_disp_made_qtr, priv_ca_disp_event_qtr, priv_ca_case_close_qtr)

priv_join_qtr <- reduce(priv_qtr_tables, left_join, by = c('Year', 'Qtr'))

#Finishing the quarterly part of T2
t2_reg_qtr <- pub_join_qtr %>% left_join(priv_join_qtr, by = c('Year', 'Qtr')) %>% 
  filter(!is.na(Year)) %>% 
  mutate(Qtr = paste0('Q', Qtr), blank1 = NA, blank2 = NA, blank3 = NA) %>% 
  relocate(Qtr, .after = Year) %>% 
  relocate(blank1, .after = pub_case_start_qtr) %>% 
  relocate(blank2, .after = pub_case_close_qtr) %>% 
  relocate(blank3, .after = priv_case_start_qtr)

# Content #########################################################################################

# time period
if(pub_quarter==4){
  
  timeperiod2 <- paste0("Annually 2006 - ", pub_year, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
  
} else {
  
  timeperiod2 <- paste0("Annually 2006 - ", pub_year-1, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
}
