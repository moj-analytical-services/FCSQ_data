# Accessible Version of Table 12
# Dissolution of Marriage uses formulas in the regular table so necsessary to do work here to get raw data
#Judicial separation decree granted currently i decree absolute column. Probably best to change later
#STAGE	YEAR	QUARTER	CASE_TYPE	COUNT	MEAN_WEEKS	MEDIAN_WEEKS

# Petitions
diss_pet_year <- divorce_timeliness_csv %>% 
  filter(Stage == 'Petition', Year >= 2003) %>% 
  group_by(Year, Case_type) %>% 
  summarise(d_pet_filed = sum(Count))

diss_pet_qtr <- divorce_timeliness_csv %>%
  filter(Stage == 'Petition', is.na(Year)) %>% 
  separate(Quarter, into = c('Year', 'Quarter'), convert = TRUE) %>% 
  filter(Year >= 2011) %>% 
  group_by(Year, Quarter, Case_type) %>% 
  summarise(d_pet_filed = sum(Count))

# Decress Nisi
diss_nisi_year <- divorce_timeliness_csv %>% 
  filter(Stage == 'Decree Nisi', Year >= 2003) %>% 
  group_by(Year, Case_type) %>% 
  summarise(d_decrees_nisi = sum(Count))

diss_nisi_qtr <- divorce_timeliness_csv %>%
  filter(Stage == 'Decree Nisi', is.na(Year)) %>% 
  separate(Quarter, into = c('Year', 'Quarter'), convert = TRUE) %>% 
  filter(Year >= 2011) %>% 
  group_by(Year, Quarter, Case_type) %>% 
  summarise(d_decrees_nisi = sum(Count))

# Mean time (weeks) to Decree Nisi
diss_avg_nisi_weeks_year <- divorce_timeliness_csv %>% 
  filter(Stage == 'Decree Nisi', Year >= 2006) %>% 
  group_by(Year, Case_type) %>% 
  summarise(d_avg_nisi_weeks = sum(Mean_weeks))

diss_avg_nisi_weeks_qtr <- divorce_timeliness_csv %>%
  filter(Stage == 'Decree Nisi', is.na(Year)) %>% 
  separate(Quarter, into = c('Year', 'Quarter'), convert = TRUE) %>% 
  filter(Year >= 2011) %>% 
  group_by(Year, Quarter, Case_type) %>% 
  summarise(d_avg_nisi_weeks = sum(Mean_weeks))

# Median time (weeks) to Decree Nisi
diss_med_nisi_weeks_year <- divorce_timeliness_csv %>% 
  filter(Stage == 'Decree Nisi', Year >= 2006) %>% 
  group_by(Year, Case_type) %>% 
  summarise(d_med_nisi_weeks = sum(Median_weeks))

diss_med_nisi_weeks_qtr <- divorce_timeliness_csv %>%
  filter(Stage == 'Decree Nisi', is.na(Year)) %>% 
  separate(Quarter, into = c('Year', 'Quarter'), convert = TRUE) %>% 
  filter(Year >= 2011) %>% 
  group_by(Year, Quarter, Case_type) %>% 
  summarise(d_med_nisi_weeks = sum(Median_weeks))

# Decress absolute
diss_absolute_year <- divorce_timeliness_csv %>% 
  filter(Stage == 'Decree Absolute', Year >= 2003) %>% 
  group_by(Year, Case_type) %>% 
  summarise(d_decrees_abs = sum(Count))

diss_absolute_qtr <- divorce_timeliness_csv %>%
  filter(Stage == 'Decree Absolute', is.na(Year)) %>% 
  separate(Quarter, into = c('Year', 'Quarter'), convert = TRUE) %>% 
  filter(Year >= 2011) %>% 
  group_by(Year, Quarter, Case_type) %>% 
  summarise(d_decrees_abs = sum(Count))

# Mean time (weeks) to Decree absolute
diss_avg_absolute_weeks_year <- divorce_timeliness_csv %>% 
  filter(Stage == 'Decree Absolute', Year >= 2006) %>% 
  group_by(Year, Case_type) %>% 
  summarise(d_avg_absolute_weeks = sum(Mean_weeks))

diss_avg_absolute_weeks_qtr <- divorce_timeliness_csv %>%
  filter(Stage == 'Decree Absolute', is.na(Year)) %>% 
  separate(Quarter, into = c('Year', 'Quarter'), convert = TRUE) %>% 
  filter(Year >= 2011) %>% 
  group_by(Year, Quarter, Case_type) %>% 
  summarise(d_avg_absolute_weeks = sum(Mean_weeks))

# Median time (weeks) to Decree absolute
diss_med_absolute_weeks_year <- divorce_timeliness_csv %>% 
  filter(Stage == 'Decree Absolute', Year >= 2006) %>% 
  group_by(Year, Case_type) %>% 
  summarise(d_med_absolute_weeks = sum(Median_weeks))

diss_med_absolute_weeks_qtr <- divorce_timeliness_csv %>%
  filter(Stage == 'Decree Absolute', is.na(Year)) %>% 
  separate(Quarter, into = c('Year', 'Quarter'), convert = TRUE) %>% 
  filter(Year >= 2011) %>% 
  group_by(Year, Quarter, Case_type) %>% 
  summarise(d_med_absolute_weeks = sum(Median_weeks))

#Joining year and quarter columns then binding them to each other
diss_annual_tables <- list(diss_pet_year, diss_nisi_year, diss_avg_nisi_weeks_year, diss_med_nisi_weeks_year,
                       diss_absolute_year, diss_avg_absolute_weeks_year, diss_med_absolute_weeks_year)

diss_joined_year <- reduce(diss_annual_tables, left_join, by = c('Year', 'Case_type'))

diss_qtr_tables <- list(diss_pet_qtr, diss_nisi_qtr, diss_avg_nisi_weeks_qtr, diss_med_nisi_weeks_qtr,
                           diss_absolute_qtr, diss_avg_absolute_weeks_qtr, diss_med_absolute_weeks_qtr)

diss_joined_qtr <- reduce(diss_qtr_tables, left_join, by = c('Year', 'Quarter', 'Case_type'))

t12_diss <- bind_rows(diss_joined_year, diss_joined_qtr)

#diss_pet <- bind_rows(diss_pet_year, diss_pet_qtr)

t12_diss_part <- t12_diss %>% 
  transmute(Year = Year,
            Quarter,
            `Proceeding Type` = 'Dissolution of marriage',
            `Case Type` = Case_type,
            `Petitions filed` = d_pet_filed,
            `Decrees Nisi` = d_decrees_nisi,
            `Mean time (weeks) to decree Nisi` = d_avg_nisi_weeks,
            `Median time (weeks) to decree Nisi` = d_med_nisi_weeks,
            `Decrees Absolute` = d_decrees_abs,
            `Mean time (weeks) to decree Absolute` = d_avg_absolute_weeks,
            `Median time (weeks) to decree Absolute` = d_med_absolute_weeks,
            `Decree Granted` = na_value,
            `Decree Absolute/Granted` = na_value
            ) %>% 
  arrange(`Case Type`) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, na_value))) 

# Nullity of Marriage and Judicial separation are calculated in the regular version of Table 12

full_t12 <- bind_rows(t12_reg_year, t12_reg_qtr)

#Nullity of Marriage
t12_nullity_part <- full_t12 %>% 
  transmute(Year = Year,
            Quarter,
            `Proceeding Type` = 'Nullity of marriage',
            `Case Type` = '[z]',
            `Petitions filed` = n_pet_filed,
            `Decrees Nisi` = n_decrees_nisi,
            `Mean time (weeks) to decree Nisi` = na_value,
            `Median time (weeks) to decree Nisi` = na_value,
            `Decrees Absolute` = n_decrees_abs,
            `Mean time (weeks) to decree Absolute` = na_value,
            `Median time (weeks) to decree Absolute` = na_value,
            `Decree Granted` = na_value,
            `Decree Absolute/Granted` = na_value
            
)

#Judicial separation
t12_judicial_part <- full_t12 %>% 
  transmute(Year = Year,
            Quarter,
            `Proceeding Type` = 'Judicial separation',
            `Case Type` = '[z]',
            `Petitions filed` = j_pet_filed,
            `Decrees Nisi` = na_value,
            `Mean time (weeks) to decree Nisi` = na_value,
            `Median time (weeks) to decree Nisi` = na_value,
            `Decrees Absolute` = na_value,
            `Mean time (weeks) to decree Absolute` = na_value,
            `Median time (weeks) to decree Absolute` = na_value,
            `Decree Granted` = j_decrees_granted,
            `Decree Absolute/Granted` = na_value
  )

#Total
t12_total_part <- full_t12 %>% 
  transmute(Year = Year,
            Quarter,
            `Proceeding Type` = 'All',
            `Case Type` = '[z]',
            `Petitions filed` = all_pet_filed,
            `Decrees Nisi` = all_decrees_nisi,
            `Mean time (weeks) to decree Nisi` = na_value,
            `Median time (weeks) to decree Nisi` = na_value,
            `Decrees Absolute` = na_value,
            `Mean time (weeks) to decree Absolute` = na_value,
            `Median time (weeks) to decree Absolute` = na_value,
            `Decree Granted` = na_value,
            `Decree Absolute/Granted` = all_decrees_abs
  )

t12_accessible <- bind_rows(t12_diss_part, t12_nullity_part, t12_judicial_part, t12_total_part)