#Table 19 accessible
#TYPE	YEAR	QUARTER	APPLICATION	ORDER_TYPE	ADOPTER	ADOPTED_CHILD_SEX	ADOPTED_CHILD_AGE	COUNT

# Annually #######################################################
#M/F couple
adopt_apps_male_female_year <- adopt_csv %>% 
  filter(Type == 'Application', Application %in% c('Adoption', 'Adoption+other'), Adopter == 'M/F couple') %>% 
  group_by(Year) %>% 
  summarise(m_f_couple = sum(Count))

#Sole applicant
adopt_apps_sole_year <- adopt_csv %>% 
  filter(Type == 'Application', Application %in% c('Adoption', 'Adoption+other'), Adopter == 'Sole applicant') %>% 
  group_by(Year) %>% 
  summarise(sole_appl = sum(Count))

#Step parent
adopt_apps_step_year <- adopt_csv %>% 
  filter(Type == 'Application', Application %in% c('Adoption', 'Adoption+other'), Adopter == 'Step parent') %>% 
  group_by(Year) %>% 
  summarise(step_parent = sum(Count))

#Same sex
adopt_apps_same_year <- adopt_csv %>% 
  filter(Type == 'Application', Application %in% c('Adoption', 'Adoption+other'), Adopter == 'Same sex couple') %>% 
  group_by(Year) %>% 
  summarise(same_sex = sum(Count))

#Other or not stated
adopt_apps_other_adopter_year <- adopt_csv %>% 
  filter(Type == 'Application', Application %in% c('Adoption', 'Adoption+other'), Adopter == 'Other or not stated') %>% 
  group_by(Year) %>% 
  summarise(other_adopter = sum(Count))

#Total adoption applications
adopt_apps_total_adopt_year <- adopt_csv %>% 
  filter(Type == 'Application', Application %in% c('Adoption', 'Adoption+other')) %>% 
  group_by(Year) %>% 
  summarise(total_adopt_apps = sum(Count))

#Placement orders
adopt_apps_placement_year <- adopt_csv %>% 
  filter(Type == 'Application', Application == 'Non-adoption', Order_type == 'Placement') %>% 
  group_by(Year) %>% 
  summarise(placement_ords = sum(Count))

#Other orders under Act
adopt_apps_other_orders_year <- adopt_csv %>% 
  filter(Type == 'Application', Application == 'Non-adoption', Order_type != 'Placement') %>% 
  group_by(Year) %>% 
  summarise(other_orders = sum(Count))

#Total applications under Adoption Act
adopt_apps_total_apps_year <- adopt_csv %>% 
  filter(Type == 'Application') %>% 
  group_by(Year) %>% 
  summarise(total_apps = sum(Count))

#Total applications under Adoption Act
adopt_apps_case_start_year <- adopt_csv %>% 
  filter(Type == 'Cases started') %>% 
  group_by(Year) %>% 
  summarise(case_start = sum(Count))

adopt_apps_annual_tables <- list(adopt_apps_male_female_year, adopt_apps_sole_year, adopt_apps_step_year,
                               adopt_apps_same_year, adopt_apps_other_adopter_year, adopt_apps_total_adopt_year,
                               adopt_apps_placement_year, adopt_apps_other_orders_year,
                               adopt_apps_total_apps_year, adopt_apps_case_start_year)

adopt_apps_joined_year <- reduce(adopt_apps_annual_tables, left_join, by = 'Year')

t19_reg_year <- adopt_apps_joined_year %>% 
  filter(Year <= annual_year) %>% 
  mutate(Quarter = NA, 
         blank1 = NA,
         blank2 = NA) %>% 
  relocate(Quarter, .after = Year) %>% 
  relocate(blank1, .after = total_adopt_apps) %>% 
  relocate(blank2, .after = other_orders)


# Quarterly #####################
#M/F couple
adopt_apps_male_female_qtr <- adopt_csv %>% 
  filter(Type == 'Application', Application %in% c('Adoption', 'Adoption+other'), Adopter == 'M/F couple') %>% 
  group_by(Year, Quarter) %>% 
  summarise(m_f_couple = sum(Count))

#Sole applicant
adopt_apps_sole_qtr <- adopt_csv %>% 
  filter(Type == 'Application', Application %in% c('Adoption', 'Adoption+other'), Adopter == 'Sole applicant') %>% 
  group_by(Year, Quarter) %>% 
  summarise(sole_appl = sum(Count))

#Step parent
adopt_apps_step_qtr <- adopt_csv %>% 
  filter(Type == 'Application', Application %in% c('Adoption', 'Adoption+other'), Adopter == 'Step parent') %>% 
  group_by(Year, Quarter) %>% 
  summarise(step_parent = sum(Count))

#Same sex
adopt_apps_same_qtr <- adopt_csv %>% 
  filter(Type == 'Application', Application %in% c('Adoption', 'Adoption+other'), Adopter == 'Same sex couple') %>% 
  group_by(Year, Quarter) %>% 
  summarise(same_sex = sum(Count))

#Other or not stated
adopt_apps_other_adopter_qtr <- adopt_csv %>% 
  filter(Type == 'Application', Application %in% c('Adoption', 'Adoption+other'), Adopter == 'Other or not stated') %>% 
  group_by(Year, Quarter) %>% 
  summarise(other_adopter = sum(Count))

#Total adoption applications
adopt_apps_total_adopt_qtr <- adopt_csv %>% 
  filter(Type == 'Application', Application %in% c('Adoption', 'Adoption+other')) %>% 
  group_by(Year, Quarter) %>% 
  summarise(total_adopt_apps = sum(Count))

#Placement orders
adopt_apps_placement_qtr <- adopt_csv %>% 
  filter(Type == 'Application', Application == 'Non-adoption', Order_type == 'Placement') %>% 
  group_by(Year, Quarter) %>% 
  summarise(placement_ords = sum(Count))

#Other orders under Act
adopt_apps_other_orders_qtr <- adopt_csv %>% 
  filter(Type == 'Application', Application == 'Non-adoption', Order_type != 'Placement') %>% 
  group_by(Year, Quarter) %>% 
  summarise(other_orders = sum(Count))

#Total applications under Adoption Act
adopt_apps_total_apps_qtr <- adopt_csv %>% 
  filter(Type == 'Application') %>% 
  group_by(Year, Quarter) %>% 
  summarise(total_apps = sum(Count))

#Total applications under Adoption Act
adopt_apps_case_start_qtr <- adopt_csv %>% 
  filter(Type == 'Cases started') %>% 
  group_by(Year, Quarter) %>% 
  summarise(case_start = sum(Count))

adopt_apps_qtr_tables <- list(adopt_apps_male_female_qtr, adopt_apps_sole_qtr, adopt_apps_step_qtr,
                                 adopt_apps_same_qtr, adopt_apps_other_adopter_qtr, adopt_apps_total_adopt_qtr,
                                 adopt_apps_placement_qtr, adopt_apps_other_orders_qtr,
                                 adopt_apps_total_apps_qtr, adopt_apps_case_start_qtr)

adopt_apps_joined_qtr <- reduce(adopt_apps_qtr_tables, left_join, by = c('Year', 'Quarter'))

t19_reg_qtr <- adopt_apps_joined_qtr %>% 
  mutate(Quarter = paste0('Q', Quarter), 
         blank1 = NA,
         blank2 = NA) %>% 
  relocate(Quarter, .after = Year) %>% 
  relocate(blank1, .after = total_adopt_apps) %>% 
  relocate(blank2, .after = other_orders)


# time period
if(pub_quarter==4){
  
  timeperiod19 <- paste0("Annually 2011 - ", pub_year, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
  
} else {
  
  timeperiod19 <- paste0("Annually 2011 - ", pub_year-1, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
}