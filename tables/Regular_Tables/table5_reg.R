#Table 5

#YEAR	Qtr	Type	Count_type	Public_private	Disposal_type	Order_type	Order_type_code	Gender	age_band	Applicants_in_case	Respondents_in_case	HC_INDICATOR	Count
#Year, Qtr, Count_type, Public_private, age_band

###########################################
#Public Law Annual Applications by Age Band
###########################################
# Less than 1 year
pub_app_one_year <- child_act_csv %>% 
  filter(Count_type == 'Individual children', Age_band == '<1 year', Public_private == 'Public law') %>% 
  group_by(Year) %>% 
  summarise(pub_less_than_one = sum(Count))

# 1 to 4 years
pub_app_four_year <- child_act_csv %>% 
  filter(Count_type == 'Individual children', Age_band == '1-4 years', Public_private == 'Public law') %>% 
  group_by(Year) %>% 
  summarise(pub_one_to_four = sum(Count))

# 5 to 9 years
pub_app_nine_year <- child_act_csv %>% 
  filter(Count_type == 'Individual children', Age_band == '5-9 years', Public_private == 'Public law') %>% 
  group_by(Year) %>% 
  summarise(pub_five_to_nine = sum(Count))

# 10 to 14 years
pub_app_fourteen_year <- child_act_csv %>% 
  filter(Count_type == 'Individual children', Age_band == '10-14 years', Public_private == 'Public law') %>% 
  group_by(Year) %>% 
  summarise(pub_ten_to_fourteen = sum(Count))

# 15 to 17 years
pub_app_seventeen_year <- child_act_csv %>% 
  filter(Count_type == 'Individual children', Age_band == '15-17 years', Public_private == 'Public law') %>% 
  group_by(Year) %>% 
  summarise(pub_fifteen_to_seventeen = sum(Count))

# other age
pub_app_other_year <- child_act_csv %>% 
  filter(Count_type == 'Individual children', Age_band == 'Other', Public_private == 'Public law') %>% 
  group_by(Year) %>% 
  summarise(pub_other_age = sum(Count))

# unknown age
pub_app_unknown_year <- child_act_csv %>% 
  filter(Count_type == 'Individual children', Age_band == 'Unknown', Public_private == 'Public law') %>% 
  group_by(Year) %>% 
  summarise(pub_unknown_age = sum(Count))

#Total applications
pub_app_total <- child_act_csv %>% 
  filter(Count_type == 'Individual children', Public_private == 'Public law') %>% 
  group_by(Year) %>% 
  summarise(pub_total_apps = sum(Count))

# Gathering each columns then joining them together
pub_child_annual_tables <- list(pub_app_one_year, pub_app_four_year, pub_app_nine_year,
                                pub_app_fourteen_year, pub_app_seventeen_year, 
                                pub_app_other_year, pub_app_unknown_year, pub_app_total)

pub_child_join_year <-  reduce(pub_child_annual_tables, left_join, by = 'Year')

###########################################
#Private Law Annual Applications by Age Band
###########################################
# Less than 1 year
priv_app_one_year <- child_act_csv %>% 
  filter(Count_type == 'Individual children', Age_band == '<1 year', Public_private == 'Private law') %>% 
  group_by(Year) %>% 
  summarise(priv_less_than_one = sum(Count))

# 1 to 4 years
priv_app_four_year <- child_act_csv %>% 
  filter(Count_type == 'Individual children', Age_band == '1-4 years', Public_private == 'Private law') %>% 
  group_by(Year) %>% 
  summarise(priv_one_to_four = sum(Count))

# 5 to 9 years
priv_app_nine_year <- child_act_csv %>% 
  filter(Count_type == 'Individual children', Age_band == '5-9 years', Public_private == 'Private law') %>% 
  group_by(Year) %>% 
  summarise(priv_five_to_nine = sum(Count))

# 10 to 14 years
priv_app_fourteen_year <- child_act_csv %>% 
  filter(Count_type == 'Individual children', Age_band == '10-14 years', Public_private == 'Private law') %>% 
  group_by(Year) %>% 
  summarise(priv_ten_to_fourteen = sum(Count))

# 15 to 17 years
priv_app_seventeen_year <- child_act_csv %>% 
  filter(Count_type == 'Individual children', Age_band == '15-17 years', Public_private == 'Private law') %>% 
  group_by(Year) %>% 
  summarise(priv_fifteen_to_seventeen = sum(Count))

# other age
priv_app_other_year <- child_act_csv %>% 
  filter(Count_type == 'Individual children', Age_band == 'Other', Public_private == 'Private law') %>% 
  group_by(Year) %>% 
  summarise(priv_other_age = sum(Count))

# unknown age
priv_app_unknown_year <- child_act_csv %>% 
  filter(Count_type == 'Individual children', Age_band == 'Unknown', Public_private == 'Private law') %>% 
  group_by(Year) %>% 
  summarise(priv_unknown_age = sum(Count))

#Total applications
priv_app_total <- child_act_csv %>% 
  filter(Count_type == 'Individual children', Public_private == 'Private law') %>% 
  group_by(Year) %>% 
  summarise(priv_total_apps = sum(Count))

# Gathering each columns then joining them together
priv_child_annual_tables <- list(priv_app_one_year, priv_app_four_year, priv_app_nine_year,
                                priv_app_fourteen_year, priv_app_seventeen_year, 
                                priv_app_other_year, priv_app_unknown_year, priv_app_total)

priv_child_join_year <-  reduce(priv_child_annual_tables, left_join, by = 'Year')

#Now joining the Public and Private Law sections filtering out any unnecessary data
t5_reg_year <- pub_child_join_year %>% left_join(priv_child_join_year, by = 'Year') %>% 
  filter(Year <= annual_year, !is.na(Year)) %>% 
  mutate(Qtr = NA, blank1 = NA, blank2 = NA) %>% 
  relocate(Qtr, .after = Year) %>% 
  relocate(blank1, .after = pub_total_apps) %>% 
  relocate(blank2, .after = Qtr)

## Now doing the same for quarterly data
###########################################
#Public Law Quarterly Applications by Age Band
###########################################

#Individual children has a different Qtr column that has to be separated into Year and Quarter

# Less than 1 year
pub_app_one_qtr <- child_act_csv %>% 
  filter(Count_type == 'Individual children', Age_band == '<1 year', Public_private == 'Public law') %>% 
  group_by(Qtr) %>% 
  summarise(pub_less_than_one = sum(Count)) %>% 
  separate(Qtr, c('Year', 'Qtr'), sep = '-') %>% 
  mutate(Year = as.double(Year))

# 1 to 4 years
pub_app_four_qtr <- child_act_csv %>% 
  filter(Count_type == 'Individual children', Age_band == '1-4 years', Public_private == 'Public law') %>% 
  group_by(Qtr) %>% 
  summarise(pub_one_to_four = sum(Count)) %>% 
  separate(Qtr, c('Year', 'Qtr'), sep = '-') %>% 
  mutate(Year = as.double(Year))

# 5 to 9 years
pub_app_nine_qtr <- child_act_csv %>% 
  filter(Count_type == 'Individual children', Age_band == '5-9 years', Public_private == 'Public law') %>% 
  group_by(Qtr) %>% 
  summarise(pub_five_to_nine = sum(Count)) %>% 
  separate(Qtr, c('Year', 'Qtr'), sep = '-') %>% 
  mutate(Year = as.double(Year))

# 10 to 14 years
pub_app_fourteen_qtr <- child_act_csv %>% 
  filter(Count_type == 'Individual children', Age_band == '10-14 years', Public_private == 'Public law') %>% 
  group_by(Qtr) %>% 
  summarise(pub_ten_to_fourteen = sum(Count)) %>% 
  separate(Qtr, c('Year', 'Qtr'), sep = '-') %>% 
  mutate(Year = as.double(Year))


# 15 to 17 years
pub_app_seventeen_qtr <- child_act_csv %>% 
  filter(Count_type == 'Individual children', Age_band == '15-17 years', Public_private == 'Public law') %>% 
  group_by(Qtr) %>% 
  summarise(pub_fifteen_to_seventeen = sum(Count)) %>% 
  separate(Qtr, c('Year', 'Qtr'), sep = '-') %>% 
  mutate(Year = as.double(Year))


# other age
pub_app_other_qtr <- child_act_csv %>% 
  filter(Count_type == 'Individual children', Age_band == 'Other', Public_private == 'Public law') %>% 
  group_by(Qtr) %>% 
  summarise(pub_other_age = sum(Count)) %>% 
  separate(Qtr, c('Year', 'Qtr'), sep = '-') %>% 
  mutate(Year = as.double(Year))


# unknown age
pub_app_unknown_qtr <- child_act_csv %>% 
  filter(Count_type == 'Individual children', Age_band == 'Unknown', Public_private == 'Public law') %>% 
  group_by(Qtr) %>% 
  summarise(pub_unknown_age = sum(Count)) %>% 
  separate(Qtr, c('Year', 'Qtr'), sep = '-') %>% 
  mutate(Year = as.double(Year))


#Total applications
pub_app_total_qtr <- child_act_csv %>% 
  filter(Count_type == 'Individual children', Public_private == 'Public law') %>% 
  group_by(Qtr) %>% 
  summarise(pub_total_apps = sum(Count)) %>% 
  separate(Qtr, c('Year', 'Qtr'), sep = '-') %>% 
  mutate(Year = as.double(Year))


# Gathering each columns then joining them together
pub_child_qtr_tables <- list(pub_app_one_qtr, pub_app_four_qtr, pub_app_nine_qtr,
                                pub_app_fourteen_qtr, pub_app_seventeen_qtr, 
                                pub_app_other_qtr, pub_app_unknown_qtr, pub_app_total_qtr)

pub_child_join_qtr <-  reduce(pub_child_qtr_tables, left_join, by = c('Year', 'Qtr'))

###########################################
#Private Law Quarterly Applications by Age Band
###########################################

#Individual children has a different Qtr column that has to be separated into Year and Quarter

# Less than 1 year
priv_app_one_qtr <- child_act_csv %>% 
  filter(Count_type == 'Individual children', Age_band == '<1 year', Public_private == 'Private law') %>% 
  group_by(Qtr) %>% 
  summarise(priv_less_than_one = sum(Count)) %>% 
  separate(Qtr, c('Year', 'Qtr'), sep = '-') %>% 
  mutate(Year = as.double(Year))

# 1 to 4 years
priv_app_four_qtr <- child_act_csv %>% 
  filter(Count_type == 'Individual children', Age_band == '1-4 years', Public_private == 'Private law') %>% 
  group_by(Qtr) %>% 
  summarise(priv_one_to_four = sum(Count)) %>% 
  separate(Qtr, c('Year', 'Qtr'), sep = '-') %>% 
  mutate(Year = as.double(Year))

# 5 to 9 years
priv_app_nine_qtr <- child_act_csv %>% 
  filter(Count_type == 'Individual children', Age_band == '5-9 years', Public_private == 'Private law') %>% 
  group_by(Qtr) %>% 
  summarise(priv_five_to_nine = sum(Count)) %>% 
  separate(Qtr, c('Year', 'Qtr'), sep = '-') %>% 
  mutate(Year = as.double(Year))

# 10 to 14 years
priv_app_fourteen_qtr <- child_act_csv %>% 
  filter(Count_type == 'Individual children', Age_band == '10-14 years', Public_private == 'Private law') %>% 
  group_by(Qtr) %>% 
  summarise(priv_ten_to_fourteen = sum(Count)) %>% 
  separate(Qtr, c('Year', 'Qtr'), sep = '-') %>% 
  mutate(Year = as.double(Year))


# 15 to 17 years
priv_app_seventeen_qtr <- child_act_csv %>% 
  filter(Count_type == 'Individual children', Age_band == '15-17 years', Public_private == 'Private law') %>% 
  group_by(Qtr) %>% 
  summarise(priv_fifteen_to_seventeen = sum(Count)) %>% 
  separate(Qtr, c('Year', 'Qtr'), sep = '-') %>% 
  mutate(Year = as.double(Year))


# other age
priv_app_other_qtr <- child_act_csv %>% 
  filter(Count_type == 'Individual children', Age_band == 'Other', Public_private == 'Private law') %>% 
  group_by(Qtr) %>% 
  summarise(priv_other_age = sum(Count)) %>% 
  separate(Qtr, c('Year', 'Qtr'), sep = '-') %>% 
  mutate(Year = as.double(Year))


# unknown age
priv_app_unknown_qtr <- child_act_csv %>% 
  filter(Count_type == 'Individual children', Age_band == 'Unknown', Public_private == 'Private law') %>% 
  group_by(Qtr) %>% 
  summarise(priv_unknown_age = sum(Count)) %>% 
  separate(Qtr, c('Year', 'Qtr'), sep = '-') %>% 
  mutate(Year = as.double(Year))


#Total applications
priv_app_total_qtr <- child_act_csv %>% 
  filter(Count_type == 'Individual children', Public_private == 'Private law') %>% 
  group_by(Qtr) %>% 
  summarise(priv_total_apps = sum(Count)) %>% 
  separate(Qtr, c('Year', 'Qtr'), sep = '-') %>% 
  mutate(Year = as.double(Year))


# Gathering each columns then joining them together
priv_child_qtr_tables <- list(priv_app_one_qtr, priv_app_four_qtr, priv_app_nine_qtr,
                             priv_app_fourteen_qtr, priv_app_seventeen_qtr, 
                             priv_app_other_qtr, priv_app_unknown_qtr, priv_app_total_qtr)

priv_child_join_qtr <-  reduce(priv_child_qtr_tables, left_join, by = c('Year', 'Qtr'))

t5_reg_qtr <- pub_child_join_qtr %>% left_join(priv_child_join_qtr, by = c('Year', 'Qtr')) %>% 
  filter(!is.na(Year)) %>% 
  mutate(Qtr = paste0('Q', Qtr), blank1 = NA, blank2 = NA) %>% 
  relocate(Qtr, .after = Year) %>% 
  relocate(blank1, .after = pub_total_apps) %>% 
  relocate(blank2, .after = Qtr)

# Content #########################################################################################

# time period
if(pub_quarter==4){
  
  timeperiod5 <- paste0("Annually 2011 - ", pub_year, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
  
} else {
  
  timeperiod5 <- paste0("Annually 2011 - ", pub_year-1, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
}
