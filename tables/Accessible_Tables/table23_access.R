# Table 23 accessible

# Select all non blanks columns
t23_accessible <- full_t23 %>% select(!starts_with('blank')) %>% 
  mutate(Quarter = replace_na(Quarter, 'Annual'))

# Adding registered applications prefix to all columns other than the last column, year and quarter
colnames(t23_accessible) <- paste('Registered applications', c('Year',
                              'Quarter',
                              'Application Type: Enduring Power of Attorney',
                              'Application Type: Lasting Power of Attorney',
                              'Case Subtype: Property and finance',
                              'Case Subtype: Health and welfare',
                              'Gender of Donor: Female',
                              'Gender of Donor: Male',
                              'Gender of Donor: Other',
                              'Gender of Donor: Unknown',
                              'Age of Donor: 18-24',
                              'Age of Donor: 25-34',
                              'Age of Donor: 35-44',
                              'Age of Donor: 45-54',
                              'Age of Donor: 55-64',
                              'Age of Donor: 65-74',
                              'Age of Donor: 75-84',
                              'Age of Donor: 85+',
                              'Age of Donor: Other',
                              'Age of Donor: Unknown',
                              'Total registered applications',
                              'Number of deputyships appointed'
), sep = ' - ') 

colnames(t23_accessible)[c(1, 2, 22)] <- c('Year', 'Quarter', 'Number of deputyships appointed')
