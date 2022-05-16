# Table 23

# Annually #############################
# Enduring Power of Attorney
opg_epa_year <- opg_csv %>% 
  filter(Type == 'EPA') %>% 
  group_by(Year) %>% 
  summarise(epa = sum(Count))

# Lasting Power of Attorney
opg_lpa_year <- opg_csv %>% 
  filter(Type == 'LPA') %>% 
  group_by(Year) %>% 
  summarise(lpa = sum(Count))

# Property and finance
opg_property_year <- opg_csv %>% 
  filter(Type == 'Property and finance') %>% 
  group_by(Year) %>% 
  summarise(property = sum(Count))

# Health and welfare
opg_health_year <- opg_csv %>% 
  filter(Type == 'Health and welfare') %>% 
  group_by(Year) %>% 
  summarise(health = sum(Count))

# Gender of Donor - Female
opg_female_year <- opg_csv %>% 
  filter(Category == 'Gender of Donor', Type == 'Female') %>% 
  group_by(Year) %>% 
  summarise(female = sum(Count))

# Gender of Donor - Male
opg_male_year <- opg_csv %>% 
  filter(Category == 'Gender of Donor', Type == 'Male') %>% 
  group_by(Year) %>% 
  summarise(male = sum(Count))

# Gender of Donor Other
opg_other_gender_year <- opg_csv %>% 
  filter(Category == 'Gender of Donor', Type == 'Other') %>% 
  group_by(Year) %>% 
  summarise(other_gender = sum(Count))

# Gender of Donor Unknown
opg_unknown_gender_year <- opg_csv %>% 
  filter(Category == 'Gender of Donor', Type == 'Unknown') %>% 
  group_by(Year) %>% 
  summarise(unknown_gender = sum(Count))

# Age of Donor 18-24
opg_eighteen_year <- opg_csv %>% 
  filter(Category == 'Age of Donor', Type == '18-24') %>% 
  group_by(Year) %>% 
  summarise(eighteen_to_24 = sum(Count))

# Age of Donor 25-34
opg_twenty_five_year <- opg_csv %>% 
  filter(Category == 'Age of Donor', Type == '25-34') %>% 
  group_by(Year) %>% 
  summarise(twenty_five_to_34 = sum(Count))

# Age of Donor 35-44
opg_thirty_five_year <- opg_csv %>% 
  filter(Category == 'Age of Donor', Type == '35-44') %>% 
  group_by(Year) %>% 
  summarise(thirty_five_to_44 = sum(Count))

# Age of Donor 45-54
opg_forty_five_year <- opg_csv %>% 
  filter(Category == 'Age of Donor', Type == '45-54') %>% 
  group_by(Year) %>% 
  summarise(forty_five_to_54 = sum(Count))

# Age of Donor 55-64
opg_fifty_five_year <- opg_csv %>% 
  filter(Category == 'Age of Donor', Type == '55-64') %>% 
  group_by(Year) %>% 
  summarise(fifty_five_to_64 = sum(Count))

# Age of Donor 65-74
opg_sixty_five_year <- opg_csv %>% 
  filter(Category == 'Age of Donor', Type == '65-74') %>% 
  group_by(Year) %>% 
  summarise(sixty_five_to_74 = sum(Count))

# Age of Donor 75-84
opg_seventy_five_year <- opg_csv %>% 
  filter(Category == 'Age of Donor', Type == '75-84') %>% 
  group_by(Year) %>% 
  summarise(seventy_five_to_84 = sum(Count))

# Age of Donor 85 +
opg_eighty_five_year <- opg_csv %>% 
  filter(Category == 'Age of Donor', Type == '85+') %>% 
  group_by(Year) %>% 
  summarise(eighty_five_plus = sum(Count))

# Other Age of Donor
opg_other_age_year <- opg_csv %>% 
  filter(Category == 'Age of Donor', Type == 'Other') %>% 
  group_by(Year) %>% 
  summarise(other_age = sum(Count))

# Unknown Age of Donor
opg_unknown_age_year <- opg_csv %>% 
  filter(Category == 'Age of Donor', Type == 'Unknown') %>% 
  group_by(Year) %>% 
  summarise(unknown_age = sum(Count))

# Total registered applications
opg_total_apps_year <- opg_csv %>% 
  filter(Category == 'Total registered applications') %>% 
  group_by(Year) %>% 
  summarise(total_apps = sum(Count))

# Deputyship applications
opg_deputyship_year <- opg_csv %>% 
  filter(Category == 'Deputyships appointed') %>% 
  group_by(Year) %>% 
  summarise(deputyships = sum(Count))

opg_annual_tables <- list(opg_epa_year, opg_lpa_year,
                          opg_property_year, opg_health_year, opg_female_year, opg_male_year, opg_other_gender_year, opg_unknown_gender_year,
                          opg_eighteen_year, opg_twenty_five_year, opg_thirty_five_year, opg_forty_five_year, opg_fifty_five_year,
                          opg_sixty_five_year, opg_seventy_five_year, opg_eighty_five_year, opg_other_age_year, opg_unknown_age_year,
                          opg_total_apps_year, opg_deputyship_year)

# Gathering and joining the tables
# NA are replaced with -1
# These are replaced with * later on
opg_joined_year <- reduce(opg_annual_tables, left_join, by = 'Year')

t23_reg_year <- opg_joined_year %>% mutate(Quarter = NA, blank1 = NA,
                                           blank2 = NA, blank3 = NA,
                                           blank4 = NA, blank5 = NA) %>% 
  relocate(Quarter, .after = Year) %>% 
  relocate(blank1, .after = lpa) %>% 
  relocate(blank2, .after = health) %>%
  relocate(blank3, .after = unknown_gender) %>%
  relocate(blank4, .after = unknown_age) %>%
  relocate(blank5, .after = total_apps) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, -1)))


# Quarterly ###########################
# Enduring Power of Attorney
opg_epa_qtr <- opg_csv %>% 
  filter(Type == 'EPA') %>% 
  group_by(Year, Quarter) %>% 
  summarise(epa = sum(Count))

# Lasting Power of Attorney
opg_lpa_qtr <- opg_csv %>% 
  filter(Type == 'LPA') %>% 
  group_by(Year, Quarter) %>% 
  summarise(lpa = sum(Count))

# Property and finance
opg_property_qtr <- opg_csv %>% 
  filter(Type == 'Property and finance') %>% 
  group_by(Year, Quarter) %>% 
  summarise(property = sum(Count))

# Health and welfare
opg_health_qtr <- opg_csv %>% 
  filter(Type == 'Health and welfare') %>% 
  group_by(Year, Quarter) %>% 
  summarise(health = sum(Count))

# Gender of Donor - Female
opg_female_qtr <- opg_csv %>% 
  filter(Category == 'Gender of Donor', Type == 'Female') %>% 
  group_by(Year, Quarter) %>% 
  summarise(female = sum(Count))

# Gender of Donor - Male
opg_male_qtr <- opg_csv %>% 
  filter(Category == 'Gender of Donor', Type == 'Male') %>% 
  group_by(Year, Quarter) %>% 
  summarise(male = sum(Count))

# Gender of Donor Other
opg_other_gender_qtr <- opg_csv %>% 
  filter(Category == 'Gender of Donor', Type == 'Other') %>% 
  group_by(Year, Quarter) %>% 
  summarise(other_gender = sum(Count))

# Gender of Donor Unknown
opg_unknown_gender_qtr <- opg_csv %>% 
  filter(Category == 'Gender of Donor', Type == 'Unknown') %>% 
  group_by(Year, Quarter) %>% 
  summarise(unknown_gender = sum(Count))

# Age of Donor 18-24
opg_eighteen_qtr <- opg_csv %>% 
  filter(Category == 'Age of Donor', Type == '18-24') %>% 
  group_by(Year, Quarter) %>% 
  summarise(eighteen_to_24 = sum(Count))

# Age of Donor 25-34
opg_twenty_five_qtr <- opg_csv %>% 
  filter(Category == 'Age of Donor', Type == '25-34') %>% 
  group_by(Year, Quarter) %>% 
  summarise(twenty_five_to_34 = sum(Count))

# Age of Donor 35-44
opg_thirty_five_qtr <- opg_csv %>% 
  filter(Category == 'Age of Donor', Type == '35-44') %>% 
  group_by(Year, Quarter) %>% 
  summarise(thirty_five_to_44 = sum(Count))

# Age of Donor 45-54
opg_forty_five_qtr <- opg_csv %>% 
  filter(Category == 'Age of Donor', Type == '45-54') %>% 
  group_by(Year, Quarter) %>% 
  summarise(forty_five_to_54 = sum(Count))

# Age of Donor 55-64
opg_fifty_five_qtr <- opg_csv %>% 
  filter(Category == 'Age of Donor', Type == '55-64') %>% 
  group_by(Year, Quarter) %>% 
  summarise(fifty_five_to_64 = sum(Count))

# Age of Donor 65-74
opg_sixty_five_qtr <- opg_csv %>% 
  filter(Category == 'Age of Donor', Type == '65-74') %>% 
  group_by(Year, Quarter) %>% 
  summarise(sixty_five_to_74 = sum(Count))

# Age of Donor 75-84
opg_seventy_five_qtr <- opg_csv %>% 
  filter(Category == 'Age of Donor', Type == '75-84') %>% 
  group_by(Year, Quarter) %>% 
  summarise(seventy_five_to_84 = sum(Count))

# Age of Donor 85 +
opg_eighty_five_qtr <- opg_csv %>% 
  filter(Category == 'Age of Donor', Type == '85+') %>% 
  group_by(Year, Quarter) %>% 
  summarise(eighty_five_plus = sum(Count))

# Other Age of Donor
opg_other_age_qtr <- opg_csv %>% 
  filter(Category == 'Age of Donor', Type == 'Other') %>% 
  group_by(Year, Quarter) %>% 
  summarise(other_age = sum(Count))

# Unknown Age of Donor
opg_unknown_age_qtr <- opg_csv %>% 
  filter(Category == 'Age of Donor', Type == 'Unknown') %>% 
  group_by(Year, Quarter) %>% 
  summarise(unknown_age = sum(Count))

# Total registered applications
opg_total_apps_qtr <- opg_csv %>% 
  filter(Category == 'Total registered applications') %>% 
  group_by(Year, Quarter) %>% 
  summarise(total_apps = sum(Count))

# Deputyship applications
opg_deputyship_qtr <- opg_csv %>% 
  filter(Category == 'Deputyships appointed') %>% 
  group_by(Year, Quarter) %>% 
  summarise(deputyships = sum(Count))

opg_qtr_tables <- list(opg_epa_qtr, opg_lpa_qtr,
                          opg_property_qtr, opg_health_qtr, opg_female_qtr, opg_male_qtr, opg_other_gender_qtr, opg_unknown_gender_qtr,
                          opg_eighteen_qtr, opg_twenty_five_qtr, opg_thirty_five_qtr, opg_forty_five_qtr, opg_fifty_five_qtr,
                          opg_sixty_five_qtr, opg_seventy_five_qtr, opg_eighty_five_qtr, opg_other_age_qtr, opg_unknown_age_qtr,
                          opg_total_apps_qtr, opg_deputyship_qtr)

# Gathering and joining the tables
# NA are replaced with -1
# These are replaced with * later on
opg_joined_qtr <- reduce(opg_qtr_tables, left_join, by = c('Year', 'Quarter'))

t23_reg_qtr <- opg_joined_qtr %>% mutate(blank1 = NA,
                                           blank2 = NA, blank3 = NA,
                                           blank4 = NA, blank5 = NA) %>% 
  relocate(blank1, .after = lpa) %>% 
  relocate(blank2, .after = health) %>%
  relocate(blank3, .after = unknown_gender) %>%
  relocate(blank4, .after = unknown_age) %>%
  relocate(blank5, .after = total_apps) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, -1)))

full_t23 <- bind_rows(t23_reg_year, t23_reg_qtr)

if(pub_quarter==4){
  
  timeperiod23 <- paste0("Annually 2008 - ", pub_year, " and quarterly Q1 2008 - Q", pub_quarter," ", pub_year)
 
} else {
  
  timeperiod23 <- paste0("Annually 2008 - ", pub_year-1, " and quarterly Q1 2008 - Q", pub_quarter," ", pub_year)
  
}