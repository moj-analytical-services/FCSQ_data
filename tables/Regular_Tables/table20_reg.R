#Table 20 accessible
#TYPE	YEAR	QUARTER	APPLICATION	ORDER_TYPE	ADOPTER	ADOPTED_CHILD_SEX	ADOPTED_CHILD_AGE	COUNT

# Annually #######################################################
#M/F couple
adopt_ords_male_female_year <- adopt_csv %>% 
  filter(Type == 'Order granted', Application %in% c('Adoption', 'Adoption+other'), Adopter == 'M/F couple') %>% 
  group_by(Year) %>% 
  summarise(m_f_couple = sum(Count))

#Sole applicant
adopt_ords_sole_year <- adopt_csv %>% 
  filter(Type == 'Order granted', Application %in% c('Adoption', 'Adoption+other'), Adopter == 'Sole applicant') %>% 
  group_by(Year) %>% 
  summarise(sole_appl = sum(Count))

#Step parent
adopt_ords_step_year <- adopt_csv %>% 
  filter(Type == 'Order granted', Application %in% c('Adoption', 'Adoption+other'), Adopter == 'Step parent') %>% 
  group_by(Year) %>% 
  summarise(step_parent = sum(Count))

#Same sex
adopt_ords_same_year <- adopt_csv %>% 
  filter(Type == 'Order granted', Application %in% c('Adoption', 'Adoption+other'), Adopter == 'Same sex couple') %>% 
  group_by(Year) %>% 
  summarise(same_sex = sum(Count))

#Other or not stated
adopt_ords_other_adopter_year <- adopt_csv %>% 
  filter(Type == 'Order granted', Application %in% c('Adoption', 'Adoption+other'), Adopter == 'Other or not stated') %>% 
  group_by(Year) %>% 
  summarise(other_adopter = sum(Count))

#Adopted child sex - male
adopt_ords_male_child_year <- adopt_csv %>% 
  filter(Type == 'Order granted', Application %in% c('Adoption', 'Adoption+other'), Adopted_child_sex == 'Male') %>% 
  group_by(Year) %>% 
  summarise(male_child = sum(Count))

#Adopted child sex - female
adopt_ords_female_child_year <- adopt_csv %>% 
  filter(Type == 'Order granted', Application %in% c('Adoption', 'Adoption+other'), Adopted_child_sex == 'Female') %>% 
  group_by(Year) %>% 
  summarise(female_child = sum(Count))

#Adopted Child Age < 1 year
adopt_ords_one_year <- adopt_csv %>% 
  filter(Type == 'Order granted', Application %in% c('Adoption', 'Adoption+other'), Adopted_child_age == '<1 year') %>% 
  group_by(Year) %>% 
  summarise(less_than_one = sum(Count))

#Adopted Child Age 1-4 years
adopt_ords_four_year <- adopt_csv %>% 
  filter(Type == 'Order granted', Application %in% c('Adoption', 'Adoption+other'), Adopted_child_age == '1-4 years') %>% 
  group_by(Year) %>% 
  summarise(one_to_four = sum(Count))

#Adopted Child Age 5-9 years
adopt_ords_nine_year <- adopt_csv %>% 
  filter(Type == 'Order granted', Application %in% c('Adoption', 'Adoption+other'), Adopted_child_age == '5-9 years') %>% 
  group_by(Year) %>% 
  summarise(five_to_nine = sum(Count))

#Adopted Child Age 10-14 years
adopt_ords_fourteen_year <- adopt_csv %>% 
  filter(Type == 'Order granted', Application %in% c('Adoption', 'Adoption+other'), Adopted_child_age == '10-14 years') %>% 
  group_by(Year) %>% 
  summarise(ten_to_fourteen = sum(Count))

#Adopted Child Age 15-17 years
adopt_ords_seventeen_year <- adopt_csv %>% 
  filter(Type == 'Order granted', Application %in% c('Adoption', 'Adoption+other'), Adopted_child_age == '15-17 years') %>% 
  group_by(Year) %>% 
  summarise(fifteen_to_seventeen = sum(Count))

#Adopted Child Age Other Age
adopt_ords_other_age_year <- adopt_csv %>% 
  filter(Type == 'Order granted', Application %in% c('Adoption', 'Adoption+other'), Adopted_child_age == 'Other') %>% 
  group_by(Year) %>% 
  summarise(other_age = sum(Count))

#Adopted Child Age Unknown Age
adopt_ords_unknown_age_year <- adopt_csv %>% 
  filter(Type == 'Order granted', Application %in% c('Adoption', 'Adoption+other'), Adopted_child_age == 'Unknown') %>% 
  group_by(Year) %>% 
  summarise(unknown_age = sum(Count))

#Total adoption orders
adopt_ords_total_adopt_year <- adopt_csv %>% 
  filter(Type == 'Order granted', Application %in% c('Adoption', 'Adoption+other')) %>% 
  group_by(Year) %>% 
  summarise(total_adopt_ords = sum(Count))

#Placement orders
adopt_ords_placement_year <- adopt_csv %>% 
  filter(Type == 'Order granted', Application == 'Non-adoption', Order_type == 'Placement') %>% 
  group_by(Year) %>% 
  summarise(placement_ords = sum(Count))

#Other orders under Act
adopt_ords_other_orders_year <- adopt_csv %>% 
  filter(Type == 'Order granted', Application == 'Non-adoption', Order_type != 'Placement') %>% 
  group_by(Year) %>% 
  summarise(other_orders = sum(Count))

#Other Disposals
adopt_ords_other_disps_year <- adopt_csv %>% 
  filter(Type == 'No order granted') %>% 
  group_by(Year) %>% 
  summarise(other_disps = sum(Count))

#Total disposals under Adoption Act
adopt_ords_total_disps_year <- adopt_csv %>% 
  filter(Type %in% c('Order granted', 'No order granted')) %>% 
  group_by(Year) %>% 
  summarise(total_disps = sum(Count))

#Total cases disposed under Adoption Act 2002
adopt_ords_case_close_year <- adopt_csv %>% 
  filter(Type == 'Cases closed') %>% 
  group_by(Year) %>% 
  summarise(case_close = sum(Count))

adopt_ords_annual_tables <- list(adopt_ords_male_female_year, adopt_ords_sole_year, adopt_ords_step_year,
                                 adopt_ords_same_year, adopt_ords_other_adopter_year, 
                                 adopt_ords_male_child_year, adopt_ords_female_child_year,
                                 adopt_ords_one_year,adopt_ords_four_year, adopt_ords_nine_year,
                                 adopt_ords_fourteen_year, adopt_ords_seventeen_year, adopt_ords_other_age_year, adopt_ords_unknown_age_year,
                                 adopt_ords_total_adopt_year,
                                 adopt_ords_placement_year, adopt_ords_other_orders_year, adopt_ords_other_disps_year,
                                 adopt_ords_total_disps_year, adopt_ords_case_close_year)

adopt_ords_joined_year <- reduce(adopt_ords_annual_tables, left_join, by = 'Year')

t20_reg_year <- adopt_ords_joined_year %>% 
  filter(Year <= annual_year) %>% 
  mutate(Quarter = NA, 
         blank1 = NA,
         blank2 = NA,
         blank3 = NA,
         blank4 = NA) %>% 
  relocate(Quarter, .after = Year) %>% 
  relocate(blank1, .after = other_adopter) %>% 
  relocate(blank2, .after = female_child) %>% 
  relocate(blank3, .after = total_adopt_ords) %>%
  relocate(blank4, .after = other_disps) %>%
  mutate(across(where(is.numeric), ~replace_na(.x, 0)))


# Quarterly #######################################################
#M/F couple
adopt_ords_male_female_qtr <- adopt_csv %>% 
  filter(Type == 'Order granted', Application %in% c('Adoption', 'Adoption+other'), Adopter == 'M/F couple') %>% 
  group_by(Year, Quarter) %>% 
  summarise(m_f_couple = sum(Count))

#Sole applicant
adopt_ords_sole_qtr <- adopt_csv %>% 
  filter(Type == 'Order granted', Application %in% c('Adoption', 'Adoption+other'), Adopter == 'Sole applicant') %>% 
  group_by(Year, Quarter) %>% 
  summarise(sole_appl = sum(Count))

#Step parent
adopt_ords_step_qtr <- adopt_csv %>% 
  filter(Type == 'Order granted', Application %in% c('Adoption', 'Adoption+other'), Adopter == 'Step parent') %>% 
  group_by(Year, Quarter) %>% 
  summarise(step_parent = sum(Count))

#Same sex
adopt_ords_same_qtr <- adopt_csv %>% 
  filter(Type == 'Order granted', Application %in% c('Adoption', 'Adoption+other'), Adopter == 'Same sex couple') %>% 
  group_by(Year, Quarter) %>% 
  summarise(same_sex = sum(Count))

#Other or not stated
adopt_ords_other_adopter_qtr <- adopt_csv %>% 
  filter(Type == 'Order granted', Application %in% c('Adoption', 'Adoption+other'), Adopter == 'Other or not stated') %>% 
  group_by(Year, Quarter) %>% 
  summarise(other_adopter = sum(Count))

#Adopted child sex - male
adopt_ords_male_child_qtr <- adopt_csv %>% 
  filter(Type == 'Order granted', Application %in% c('Adoption', 'Adoption+other'), Adopted_child_sex == 'Male') %>% 
  group_by(Year, Quarter) %>% 
  summarise(male_child = sum(Count))

#Adopted child sex - female
adopt_ords_female_child_qtr <- adopt_csv %>% 
  filter(Type == 'Order granted', Application %in% c('Adoption', 'Adoption+other'), Adopted_child_sex == 'Female') %>% 
  group_by(Year, Quarter) %>% 
  summarise(female_child = sum(Count))

#Adopted Child Age < 1 year
adopt_ords_one_qtr <- adopt_csv %>% 
  filter(Type == 'Order granted', Application %in% c('Adoption', 'Adoption+other'), Adopted_child_age == '<1 year') %>% 
  group_by(Year, Quarter) %>% 
  summarise(less_than_one = sum(Count))

#Adopted Child Age 1-4 years
adopt_ords_four_qtr <- adopt_csv %>% 
  filter(Type == 'Order granted', Application %in% c('Adoption', 'Adoption+other'), Adopted_child_age == '1-4 years') %>% 
  group_by(Year, Quarter) %>% 
  summarise(one_to_four = sum(Count))

#Adopted Child Age 5-9 years
adopt_ords_nine_qtr <- adopt_csv %>% 
  filter(Type == 'Order granted', Application %in% c('Adoption', 'Adoption+other'), Adopted_child_age == '5-9 years') %>% 
  group_by(Year, Quarter) %>% 
  summarise(five_to_nine = sum(Count))

#Adopted Child Age 10-14 years
adopt_ords_fourteen_qtr <- adopt_csv %>% 
  filter(Type == 'Order granted', Application %in% c('Adoption', 'Adoption+other'), Adopted_child_age == '10-14 years') %>% 
  group_by(Year, Quarter) %>% 
  summarise(ten_to_fourteen = sum(Count))

#Adopted Child Age 15-17 years
adopt_ords_seventeen_qtr <- adopt_csv %>% 
  filter(Type == 'Order granted', Application %in% c('Adoption', 'Adoption+other'), Adopted_child_age == '15-17 years') %>% 
  group_by(Year, Quarter) %>% 
  summarise(fifteen_to_seventeen = sum(Count))

#Adopted Child Age Other Age
adopt_ords_other_age_qtr <- adopt_csv %>% 
  filter(Type == 'Order granted', Application %in% c('Adoption', 'Adoption+other'), Adopted_child_age == 'Other') %>% 
  group_by(Year, Quarter) %>% 
  summarise(other_age = sum(Count))

#Adopted Child Age Unknown Age
adopt_ords_unknown_age_qtr <- adopt_csv %>% 
  filter(Type == 'Order granted', Application %in% c('Adoption', 'Adoption+other'), Adopted_child_age == 'Unknown') %>% 
  group_by(Year, Quarter) %>% 
  summarise(unknown_age = sum(Count))

#Total adoption orders
adopt_ords_total_adopt_qtr <- adopt_csv %>% 
  filter(Type == 'Order granted', Application %in% c('Adoption', 'Adoption+other')) %>% 
  group_by(Year, Quarter) %>% 
  summarise(total_adopt_ords = sum(Count))

#Placement orders
adopt_ords_placement_qtr <- adopt_csv %>% 
  filter(Type == 'Order granted', Application == 'Non-adoption', Order_type == 'Placement') %>% 
  group_by(Year, Quarter) %>% 
  summarise(placement_ords = sum(Count))

#Other orders under Act
adopt_ords_other_orders_qtr <- adopt_csv %>% 
  filter(Type == 'Order granted', Application == 'Non-adoption', Order_type != 'Placement') %>% 
  group_by(Year, Quarter) %>% 
  summarise(other_orders = sum(Count))

#Other Disposals
adopt_ords_other_disps_qtr <- adopt_csv %>% 
  filter(Type == 'No order granted') %>% 
  group_by(Year, Quarter) %>% 
  summarise(other_disps = sum(Count))

#Total disposals under Adoption Act
adopt_ords_total_disps_qtr <- adopt_csv %>% 
  filter(Type %in% c('Order granted', 'No order granted')) %>% 
  group_by(Year, Quarter) %>% 
  summarise(total_disps = sum(Count))

#Total cases disposed under Adoption Act 2002
adopt_ords_case_close_qtr <- adopt_csv %>% 
  filter(Type == 'Cases closed') %>% 
  group_by(Year, Quarter) %>% 
  summarise(case_close = sum(Count))

adopt_ords_qtr_tables <- list(adopt_ords_male_female_qtr, adopt_ords_sole_qtr, adopt_ords_step_qtr,
                                 adopt_ords_same_qtr, adopt_ords_other_adopter_qtr, 
                                 adopt_ords_male_child_qtr, adopt_ords_female_child_qtr,
                                 adopt_ords_one_qtr,adopt_ords_four_qtr, adopt_ords_nine_qtr,
                                 adopt_ords_fourteen_qtr, adopt_ords_seventeen_qtr, adopt_ords_other_age_qtr, adopt_ords_unknown_age_qtr,
                                 adopt_ords_total_adopt_qtr,
                                 adopt_ords_placement_qtr, adopt_ords_other_orders_qtr, adopt_ords_other_disps_qtr,
                                 adopt_ords_total_disps_qtr, adopt_ords_case_close_qtr)

adopt_ords_joined_qtr <- reduce(adopt_ords_qtr_tables, left_join, by = c('Year', 'Quarter'))

t20_reg_qtr <- adopt_ords_joined_qtr %>% 
  mutate(Quarter = paste0('Q', Quarter), 
         blank1 = NA,
         blank2 = NA,
         blank3 = NA,
         blank4 = NA) %>% 
  relocate(Quarter, .after = Year) %>% 
  relocate(blank1, .after = other_adopter) %>% 
  relocate(blank2, .after = female_child) %>% 
  relocate(blank3, .after = total_adopt_ords) %>%
  relocate(blank4, .after = other_disps) %>%
  mutate(across(where(is.numeric), ~replace_na(.x, 0)))

# time period
if(pub_quarter==4){
  
  timeperiod20 <- paste0("Annually 2011 - ", pub_year, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
  
} else {
  
  timeperiod20 <- paste0("Annually 2011 - ", pub_year-1, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
}