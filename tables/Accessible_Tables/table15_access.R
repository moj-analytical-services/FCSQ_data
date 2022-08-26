################################################################################
# Accessible T15
#This is built from using code from regular T15 so run that first

################################################################################

t15_accessible_year <- fr_joined_year %>% 
  filter(Year <= annual_year) %>% 
  mutate(Qtr = NA) %>% 
  relocate(Qtr, .after = Year)

colnames(t15_accessible_year) <- c('Year', 'Quarter' ,'Uncontested Applications', 'Contested Applications',
                                   'Total Applications', 'Cases starting', 'Uncontested Disposals',
                                   'Initially Contested Disposals', 'Contested Disposals',
                                   'Total Disposals', 'Cases closed')


t15_accessible_qtr <- fr_joined_qtr %>%
  filter(Year >= 2009) %>% 
  mutate(Qtr = paste0('Q', Qtr)) %>% 
  relocate(Qtr, .after = Year)

colnames(t15_accessible_qtr) <- c('Year', 'Quarter' ,'Uncontested Applications', 'Contested Applications',
                                  'Total Applications', 'Cases starting', 'Uncontested Disposals',
                                  'Initially Contested Disposals', 'Contested Disposals',
                                  'Total Disposals', 'Cases closed')

t15_accessible <- bind_rows(t15_accessible_year, t15_accessible_qtr)