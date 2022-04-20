# Table 5 accessible
#Only one age band category here so easier to use csv as starting point

# Age Band Order
t5_lookup_order <- tribble(~Age_band, ~Order,
                           '<1 year', 1,
                           '1-4 years', 2,
                           '5-9 years', 3,
                           '10-14 years', 4,
                           '15-17 years', 5,
                           'Other', 6,
                           'Unknown', 7,
                           'All', 8)

# Yearly Public Law
t5_pub_band_year <- child_act_csv %>% filter(Count_type == 'Individual children', Public_private == 'Public law') %>% 
  group_by(Year, Age_band) %>% 
  summarise(`Number of children involved` = sum(Count)) 

# Total yearly Public Law
t5_pub_all_year <- child_act_csv %>% filter(Count_type == 'Individual children', Public_private == 'Public law') %>% 
  group_by(Year) %>% 
  summarise(`Number of children involved` = sum(Count)) %>% ungroup() %>% 
  mutate(Age_band = 'All')

# Public Law Annual
t5_pub_year <- bind_rows(t5_pub_band_year, t5_pub_all_year) %>% left_join(t5_lookup_order, by = 'Age_band') %>% 
  filter(Year <= annual_year, !is.na(Year)) %>% 
  arrange(Year, Order) %>% 
  transmute(Category = 'Public law',
            Year = Year,
            Quarter = '[z]',
            `Age of child` = Age_band,
            `Number of children involved` = `Number of children involved`) 


# Yearly Private Law by Age Band
t5_priv_band_year <- child_act_csv %>% filter(Count_type == 'Individual children', Public_private == 'Private law') %>% 
  group_by(Year, Age_band) %>% 
  summarise(`Number of children involved` = sum(Count)) 

# Total yearly Private Law by Age Band
t5_priv_all_year <- child_act_csv %>% filter(Count_type == 'Individual children', Public_private == 'Private law') %>% 
  group_by(Year) %>% 
  summarise(`Number of children involved` = sum(Count)) %>% ungroup() %>% 
  mutate(Age_band = 'All')

#Private Law Annually
t5_priv_year <- bind_rows(t5_priv_band_year, t5_priv_all_year) %>% left_join(t5_lookup_order, by = 'Age_band') %>% 
  filter(Year <= annual_year, !is.na(Year)) %>% 
  arrange(Year, Order) %>% 
  transmute(Category = 'Private law',
            Year = Year,
            Quarter = '[z]',
            `Age of child` = Age_band,
            `Number of children involved` = `Number of children involved`)  

####################Quarterly########################################################################################
# Quarterly Public Law
t5_pub_band_qtr <- child_act_csv %>% filter(Count_type == 'Individual children', Public_private == 'Public law') %>% 
  group_by(Qtr, Age_band) %>% 
  summarise(`Number of children involved` = sum(Count)) %>% 
  separate(Qtr, c('Year', 'Qtr'), sep = '-') %>% 
  mutate(Year = as.double(Year))

# Total quarterly Public Law
t5_pub_all_qtr <- child_act_csv %>% filter(Count_type == 'Individual children', Public_private == 'Public law') %>% 
  group_by(Qtr) %>% 
  summarise(`Number of children involved` = sum(Count)) %>% ungroup() %>% 
  mutate(Age_band = 'All') %>% 
  separate(Qtr, c('Year', 'Qtr'), sep = '-') %>% 
  mutate(Year = as.double(Year))

# Public Law Quarterly
t5_pub_qtr <- bind_rows(t5_pub_band_qtr, t5_pub_all_qtr) %>% left_join(t5_lookup_order, by = 'Age_band') %>%
  filter(!is.na(Year)) %>% 
  arrange(Year, Qtr, Order) %>% 
  transmute(Category = 'Public law',
            Year = Year,
            Quarter = paste0('Q', Qtr),
            `Age of child` = Age_band,
            `Number of children involved` = `Number of children involved`) 



# Quarterly Private Law
t5_priv_band_qtr <- child_act_csv %>% filter(Count_type == 'Individual children', Public_private == 'Private law') %>% 
  group_by(Qtr, Age_band) %>% 
  summarise(`Number of children involved` = sum(Count)) %>% 
  separate(Qtr, c('Year', 'Qtr'), sep = '-') %>% 
  mutate(Year = as.double(Year))

# Total quarterly Private Law
t5_priv_all_qtr <- child_act_csv %>% filter(Count_type == 'Individual children', Public_private == 'Private law') %>% 
  group_by(Qtr) %>% 
  summarise(`Number of children involved` = sum(Count)) %>% ungroup() %>% 
  mutate(Age_band = 'All') %>% 
  separate(Qtr, c('Year', 'Qtr'), sep = '-') %>% 
  mutate(Year = as.double(Year))

# Private Law Quarterly
t5_priv_qtr <- bind_rows(t5_pub_band_qtr, t5_pub_all_qtr) %>% left_join(t5_lookup_order, by = 'Age_band') %>%
  filter(!is.na(Year)) %>% 
  arrange(Year, Qtr, Order) %>% 
  transmute(Category = 'Private law',
            Year = Year,
            Quarter = paste0('Q', Qtr),
            `Age of child` = Age_band,
            `Number of children involved` = `Number of children involved`) 

t5_accessible <- bind_rows(t5_pub_year, t5_pub_qtr, t5_priv_year, t5_priv_qtr)