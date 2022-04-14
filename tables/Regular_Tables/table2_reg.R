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

#Gathering the tables and joining them together
pub_annual_tables <- list(pub_ca_ind_child_year, pub_ca_app_made_year, pub_ca_ord_appl_year, pub_ca_case_start_year,
                          pub_ca_ord_made_year, pub_ca_disp_made_year, pub_ca_disp_event_year, pub_ca_case_close_year)

pub_join_year <- reduce(pub_annual_tables, left_join, by = 'Year')