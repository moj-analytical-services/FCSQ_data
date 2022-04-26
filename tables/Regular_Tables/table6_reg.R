#Table 6

#YEAR	Qtr	Type	Count_type	Public_private	Disposal_type	Order_type	Order_type_code	Gender	age_band	Applicants_in_case	Respondents_in_case	HC_INDICATOR	Count
#####################################################
#Public Law Annual
######################################################
# Total cases staring
pub_case_start_year <- child_act_csv %>%
  filter(Count_type == 'Cases starting', Public_private == 'Public law') %>% 
  group_by(Year) %>% 
  summarise(pub_case_start = sum(Count))

# 1 Applicant
pub_applicant_one_year <- child_act_csv %>%
  filter(Count_type == 'Cases starting', Public_private == 'Public law', Applicants_in_case == '1') %>% 
  group_by(Year) %>% 
  summarise(pub_appl_one = sum(Count))

# 2 or more Applicants
pub_applicant_two_year <- child_act_csv %>%
  filter(Count_type == 'Cases starting', Public_private == 'Public law', Applicants_in_case == '2+') %>% 
  group_by(Year) %>% 
  summarise(pub_appl_two = sum(Count))

# 1 Respondents
pub_respondent_one_year <- child_act_csv %>%
  filter(Count_type == 'Cases starting', Public_private == 'Public law', Respondents_in_case == '1') %>% 
  group_by(Year) %>% 
  summarise(pub_resp_one = sum(Count))

# 2 Respondents
pub_respondent_two_year <- child_act_csv %>%
  filter(Count_type == 'Cases starting', Public_private == 'Public law', Respondents_in_case == '2') %>% 
  group_by(Year) %>% 
  summarise(pub_resp_two = sum(Count))

# 3 Respondents
pub_respondent_three_year <- child_act_csv %>%
  filter(Count_type == 'Cases starting', Public_private == 'Public law', Respondents_in_case == '3') %>% 
  group_by(Year) %>% 
  summarise(pub_resp_three = sum(Count))

# 4+ Respondents
pub_respondent_four_year <- child_act_csv %>%
  filter(Count_type == 'Cases starting', Public_private == 'Public law', Respondents_in_case == '4+') %>% 
  group_by(Year) %>% 
  summarise(pub_resp_four = sum(Count))

#Gathering and joining the columns
pub_t6_annual_tables <- list(pub_case_start_year, pub_applicant_one_year, pub_applicant_two_year, 
     pub_respondent_one_year, pub_respondent_two_year, pub_respondent_three_year, pub_respondent_four_year)

pub_t6_join_year <- reduce(pub_t6_annual_tables, left_join, by = 'Year')

#####################################################
#Private Law Annual
######################################################
# Total cases staring
priv_case_start_year <- child_act_csv %>%
  filter(Count_type == 'Cases starting', Public_private == 'Private law') %>% 
  group_by(Year) %>% 
  summarise(priv_case_start = sum(Count))

# 1 Applicant
priv_applicant_one_year <- child_act_csv %>%
  filter(Count_type == 'Cases starting', Public_private == 'Private law', Applicants_in_case == '1') %>% 
  group_by(Year) %>% 
  summarise(priv_appl_one = sum(Count))

# 2 or more Applicants
priv_applicant_two_year <- child_act_csv %>%
  filter(Count_type == 'Cases starting', Public_private == 'Private law', Applicants_in_case == '2+') %>% 
  group_by(Year) %>% 
  summarise(priv_appl_two = sum(Count))

# 1 Respondents
priv_respondent_one_year <- child_act_csv %>%
  filter(Count_type == 'Cases starting', Public_private == 'Private law', Respondents_in_case == '1') %>% 
  group_by(Year) %>% 
  summarise(priv_resp_one = sum(Count))

# 2 Respondents
priv_respondent_two_year <- child_act_csv %>%
  filter(Count_type == 'Cases starting', Public_private == 'Private law', Respondents_in_case == '2') %>% 
  group_by(Year) %>% 
  summarise(priv_resp_two = sum(Count))

# 3 Respondents
priv_respondent_three_year <- child_act_csv %>%
  filter(Count_type == 'Cases starting', Public_private == 'Private law', Respondents_in_case == '3') %>% 
  group_by(Year) %>% 
  summarise(priv_resp_three = sum(Count))

# 4+ Respondents
priv_respondent_four_year <- child_act_csv %>%
  filter(Count_type == 'Cases starting', Public_private == 'Private law', Respondents_in_case == '4+') %>% 
  group_by(Year) %>% 
  summarise(priv_resp_four = sum(Count))

#Gathering and joining the columns
priv_t6_annual_tables <- list(priv_case_start_year, priv_applicant_one_year, priv_applicant_two_year, 
                             priv_respondent_one_year, priv_respondent_two_year, priv_respondent_three_year, priv_respondent_four_year)

priv_t6_join_year <- reduce(priv_t6_annual_tables, left_join, by = 'Year')

#################################################
#Finishing the annual part of T6
##################################################
t6_reg_year <- pub_t6_join_year %>% left_join(priv_t6_join_year, by = 'Year') %>% 
  filter(Year <= annual_year, !is.na(Year)) %>% 
  mutate(Qtr = NA, blank1 = NA, blank2 = NA, blank3 = NA) %>% 
  relocate(Qtr, .after = Year) %>% 
  relocate(blank1, .after = pub_appl_two) %>% 
  relocate(blank2, .after = pub_resp_four) %>% 
  relocate(blank3, .after = priv_appl_two)


##Now doing the quarterly part of T6
#####################################################
#Public Law Quarterly
######################################################
# Total cases staring
pub_case_start_qtr <- child_act_csv %>%
  filter(Count_type == 'Cases starting', Public_private == 'Public law') %>% 
  group_by(Year, Qtr) %>% 
  summarise(pub_case_start = sum(Count))

# 1 Applicant
pub_applicant_one_qtr <- child_act_csv %>%
  filter(Count_type == 'Cases starting', Public_private == 'Public law', Applicants_in_case == '1') %>% 
  group_by(Year, Qtr) %>% 
  summarise(pub_appl_one = sum(Count))

# 2 or more Applicants
pub_applicant_two_qtr <- child_act_csv %>%
  filter(Count_type == 'Cases starting', Public_private == 'Public law', Applicants_in_case == '2+') %>% 
  group_by(Year, Qtr) %>% 
  summarise(pub_appl_two = sum(Count))

# 1 Respondents
pub_respondent_one_qtr <- child_act_csv %>%
  filter(Count_type == 'Cases starting', Public_private == 'Public law', Respondents_in_case == '1') %>% 
  group_by(Year, Qtr) %>% 
  summarise(pub_resp_one = sum(Count))

# 2 Respondents
pub_respondent_two_qtr <- child_act_csv %>%
  filter(Count_type == 'Cases starting', Public_private == 'Public law', Respondents_in_case == '2') %>% 
  group_by(Year, Qtr) %>% 
  summarise(pub_resp_two = sum(Count))

# 3 Respondents
pub_respondent_three_qtr <- child_act_csv %>%
  filter(Count_type == 'Cases starting', Public_private == 'Public law', Respondents_in_case == '3') %>% 
  group_by(Year, Qtr) %>% 
  summarise(pub_resp_three = sum(Count))

# 4+ Respondents
pub_respondent_four_qtr <- child_act_csv %>%
  filter(Count_type == 'Cases starting', Public_private == 'Public law', Respondents_in_case == '4+') %>% 
  group_by(Year, Qtr) %>% 
  summarise(pub_resp_four = sum(Count))

#Gathering and joining the columns
pub_t6_qtr_tables <- list(pub_case_start_qtr, pub_applicant_one_qtr, pub_applicant_two_qtr, 
                             pub_respondent_one_qtr, pub_respondent_two_qtr, pub_respondent_three_qtr, pub_respondent_four_qtr)

pub_t6_join_qtr <- reduce(pub_t6_qtr_tables, left_join, by = c('Year', 'Qtr'))

#####################################################
#Private Law Quarterly
######################################################
# Total cases staring
priv_case_start_qtr <- child_act_csv %>%
  filter(Count_type == 'Cases starting', Public_private == 'Private law') %>% 
  group_by(Year, Qtr) %>% 
  summarise(priv_case_start = sum(Count))

# 1 Applicant
priv_applicant_one_qtr <- child_act_csv %>%
  filter(Count_type == 'Cases starting', Public_private == 'Private law', Applicants_in_case == '1') %>% 
  group_by(Year, Qtr) %>% 
  summarise(priv_appl_one = sum(Count))

# 2 or more Applicants
priv_applicant_two_qtr <- child_act_csv %>%
  filter(Count_type == 'Cases starting', Public_private == 'Private law', Applicants_in_case == '2+') %>% 
  group_by(Year, Qtr) %>% 
  summarise(priv_appl_two = sum(Count))

# 1 Respondents
priv_respondent_one_qtr <- child_act_csv %>%
  filter(Count_type == 'Cases starting', Public_private == 'Private law', Respondents_in_case == '1') %>% 
  group_by(Year, Qtr) %>% 
  summarise(priv_resp_one = sum(Count))

# 2 Respondents
priv_respondent_two_qtr <- child_act_csv %>%
  filter(Count_type == 'Cases starting', Public_private == 'Private law', Respondents_in_case == '2') %>% 
  group_by(Year, Qtr) %>% 
  summarise(priv_resp_two = sum(Count))

# 3 Respondents
priv_respondent_three_qtr <- child_act_csv %>%
  filter(Count_type == 'Cases starting', Public_private == 'Private law', Respondents_in_case == '3') %>% 
  group_by(Year, Qtr) %>% 
  summarise(priv_resp_three = sum(Count))

# 4+ Respondents
priv_respondent_four_qtr <- child_act_csv %>%
  filter(Count_type == 'Cases starting', Public_private == 'Private law', Respondents_in_case == '4+') %>% 
  group_by(Year, Qtr) %>% 
  summarise(priv_resp_four = sum(Count))

#Gathering and joining the columns
priv_t6_qtr_tables <- list(priv_case_start_qtr, priv_applicant_one_qtr, priv_applicant_two_qtr, 
                          priv_respondent_one_qtr, priv_respondent_two_qtr, priv_respondent_three_qtr, priv_respondent_four_qtr)

priv_t6_join_qtr <- reduce(priv_t6_qtr_tables, left_join, by = c('Year', 'Qtr'))

#################################################
#Finishing the quarterly part of T6
##################################################
t6_reg_qtr <- pub_t6_join_qtr %>% left_join(priv_t6_join_qtr, by = c('Year', 'Qtr')) %>% 
  filter(!is.na(Year)) %>% 
  mutate(Qtr = paste0('Q', Qtr), blank1 = NA, blank2 = NA, blank3 = NA) %>% 
  relocate(Qtr, .after = Year) %>% 
  relocate(blank1, .after = pub_appl_two) %>% 
  relocate(blank2, .after = pub_resp_four) %>% 
  relocate(blank3, .after = priv_appl_two)

# Content #########################################################################################

# time period
if(pub_quarter==4){
  
  timeperiod6 <- paste0("Annually 2011 - ", pub_year, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
  
} else {
  
  timeperiod6 <- paste0("Annually 2011 - ", pub_year-1, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
}