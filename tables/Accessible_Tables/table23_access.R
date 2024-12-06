# Table 23 accessible

# Select all non blanks columns
# Deputyships past 2022 Q1 aren't currently available
t23_accessible <- full_t23 %>% select(!starts_with('blank')) %>% 
  mutate(Quarter = replace_na(Quarter, 'Annual')) %>% 
  mutate(deputyships = case_when(Year >= 2008 & Year < 2015 ~ na_value,
                                 TRUE ~ deputyships))

# Adding registered applications prefix to all columns other than the last column, year and quarter
colnames(t23_accessible) <- paste('Registered applications', c('Year',
                              'Quarter',
                              'Application Type: Enduring Power of Attorney',
                              'Application Type: Lasting Power of Attorney',
                              'Case Subtype: Property and finance',
                              'Case Subtype: Health and welfare',
                              'Gender of Donor: Female',
                              'Gender of Donor: Male',
                              'Gender of Donor: Unknown',
                              'Age of Donor: 18-24',
                              'Age of Donor: 25-34',
                              'Age of Donor: 35-44',
                              'Age of Donor: 45-54',
                              'Age of Donor: 55-64',
                              'Age of Donor: 65-74',
                              'Age of Donor: 75-84',
                              'Age of Donor: 85+',
                              'Age of Donor: Unknown',
                              'Total registered applications',
                              'Number of deputyships appointed'
), sep = ' - ') 

colnames(t23_accessible)[c(1, 2, 20)] <- c('Year', 'Quarter', 'Number of deputyships appointed')
