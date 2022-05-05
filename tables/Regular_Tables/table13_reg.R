#Table 13
#Divorce Progression

#Year	Quarter	Stage	Quarters_after_petition	Number

# Yearly ############

#Divorce cases started

div_prog_cases_year <- divorce_progress_csv %>% 
  filter(Stage == 'Petition') %>% 
  group_by(Year) %>% 
  summarise(div_case_start = sum(Number))

#Decree Nisi Number
div_prog_nisi_num_year <- divorce_progress_csv %>% 
  filter(Stage == 'Decree Nisi') %>% 
  group_by(Year) %>% 
  summarise(nisi_num = sum(Number))

# Decree Absolute Number
div_prog_abs_num_year <- divorce_progress_csv %>% 
  filter(Stage == 'Decree Absolute') %>% 
  group_by(Year) %>% 
  summarise(abs_num = sum(Number))

# Financial remedy applications Number
div_prog_arapp_num_year <- divorce_progress_csv %>% 
  filter(Stage == 'AR Application') %>% 
  group_by(Year) %>% 
  summarise(arapp_num = sum(Number))

# Financial remedy orders Number
div_prog_arord_num_year <- divorce_progress_csv %>% 
  filter(Stage == 'AR Order') %>% 
  group_by(Year) %>% 
  summarise(arord_num = sum(Number))


# Hearing Number
div_prog_hearing_num_year <- divorce_progress_csv %>% 
  filter(Stage == 'Hearing') %>% 
  group_by(Year) %>% 
  summarise(hearing_num = sum(Number))

# Injunction Application Number
div_prog_injapp_num_year <- divorce_progress_csv %>% 
  filter(Stage == 'Injunction Application') %>% 
  group_by(Year) %>% 
  summarise(injapp_num = sum(Number))

# Injunction Order Number
div_prog_injord_num_year <- divorce_progress_csv %>% 
  filter(Stage == 'Injunction Order') %>% 
  group_by(Year) %>% 
  summarise(injord_num = sum(Number))

#Gathering and joining
div_prog_annual_tables <- list(div_prog_cases_year, div_prog_nisi_num_year, div_prog_abs_num_year,
                               div_prog_arapp_num_year, div_prog_arord_num_year, div_prog_hearing_num_year,
                               div_prog_injapp_num_year, div_prog_injord_num_year)

div_prog_joined_year <- reduce(div_prog_annual_tables, left_join, by = 'Year')

# Now adding percentages and blanks
t13_reg_year <- div_prog_joined_year %>%
  transmute(Year,
            Quarter = NA,
            div_case_start,
            blank1 = NA,
            nisi_num,
            nisi_perc = nisi_num/div_case_start,
            blank2 = NA,
            abs_num,
            abs_perc = abs_num/div_case_start,
            blank3 = NA,
            arapp_num,
            arapp_perc = arapp_num/div_case_start,
            blank4 = NA,
            arord_num,
            arord_perc = arord_num/div_case_start,
            blank5 = NA,
            hearing_num,
            hearing_perc = hearing_num/div_case_start,
            blank6  = NA,
            injapp_num,
            injapp_perc = injapp_num/div_case_start,
            blank7 = NA,
            injord_num,
            injord_perc = injord_num/div_case_start
            )
  
# Quarterly ############
#Divorce cases started

div_prog_cases_qtr <- divorce_progress_csv %>% filter(Year >= 2011) %>% 
  filter(Stage == 'Petition') %>% 
  group_by(Year, Quarter) %>% 
  summarise(div_case_start = sum(Number))

#Decree Nisi Number
div_prog_nisi_num_qtr <- divorce_progress_csv %>% filter(Year >= 2011) %>% 
  filter(Stage == 'Decree Nisi') %>% 
  group_by(Year, Quarter) %>% 
  summarise(nisi_num = sum(Number))

# Decree Absolute Number
div_prog_abs_num_qtr <- divorce_progress_csv %>% filter(Year >= 2011) %>% 
  filter(Stage == 'Decree Absolute') %>% 
  group_by(Year, Quarter) %>% 
  summarise(abs_num = sum(Number))

# Financial remedy applications Number
div_prog_arapp_num_qtr <- divorce_progress_csv %>% filter(Year >= 2011) %>% 
  filter(Stage == 'AR Application') %>% 
  group_by(Year, Quarter) %>% 
  summarise(arapp_num = sum(Number))

# Financial remedy orders Number
div_prog_arord_num_qtr <- divorce_progress_csv %>% filter(Year >= 2011) %>% 
  filter(Stage == 'AR Order') %>% 
  group_by(Year, Quarter) %>% 
  summarise(arord_num = sum(Number))


# Hearing Number
div_prog_hearing_num_qtr <- divorce_progress_csv %>% filter(Year >= 2011) %>% 
  filter(Stage == 'Hearing') %>% 
  group_by(Year, Quarter) %>% 
  summarise(hearing_num = sum(Number))

# Injunction Application Number
div_prog_injapp_num_qtr <- divorce_progress_csv %>% filter(Year >= 2011) %>% 
  filter(Stage == 'Injunction Application') %>% 
  group_by(Year, Quarter) %>% 
  summarise(injapp_num = sum(Number))

# Injunction Order Number
div_prog_injord_num_qtr <- divorce_progress_csv %>% filter(Year >= 2011) %>% 
  filter(Stage == 'Injunction Order') %>% 
  group_by(Year, Quarter) %>% 
  summarise(injord_num = sum(Number))

#Gathering and joining
div_prog_qtr_tables <- list(div_prog_cases_qtr, div_prog_nisi_num_qtr, div_prog_abs_num_qtr,
                               div_prog_arapp_num_qtr, div_prog_arord_num_qtr, div_prog_hearing_num_qtr,
                               div_prog_injapp_num_qtr, div_prog_injord_num_qtr)

div_prog_joined_qtr <- reduce(div_prog_qtr_tables, left_join, by = c('Year', 'Quarter'))

# Now adding percentages and blanks
t13_reg_qtr <- div_prog_joined_qtr %>%
  transmute(Year,
            Quarter = paste0('Q', Quarter),
            div_case_start,
            blank1 = NA,
            nisi_num,
            nisi_perc = nisi_num/div_case_start,
            blank2 = NA,
            abs_num,
            abs_perc = abs_num/div_case_start,
            blank3 = NA,
            arapp_num,
            arapp_perc = arapp_num/div_case_start,
            blank4 = NA,
            arord_num,
            arord_perc = arord_num/div_case_start,
            blank5 = NA,
            hearing_num,
            hearing_perc = hearing_num/div_case_start,
            blank6  = NA,
            injapp_num,
            injapp_perc = injapp_num/div_case_start,
            blank7 = NA,
            injord_num,
            injord_perc = injord_num/div_case_start
  )

# time period
if(pub_quarter==4){
  
  timeperiod13 <- paste0("Annually 2003 - ", pub_year, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
  
} else {
  
  timeperiod13 <- paste0("Annually 2003 - ", pub_year-1, " and quarterly Q1 2011 - Q", pub_quarter," ", pub_year)
}