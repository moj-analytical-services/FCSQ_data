#Table 14
#Year	Quarter	Stage	Quarters_after_petition	Number

#Recreating working divorce column. Regex just picks the digit at the start of the sentence
#Setting all Quarters greater than 9 to 10 as a catch all

#Lookup created to set the order of the columns later on
div_prog_lookup <- tribble(
  ~Order, ~Stage,
  "00", "Decree Nisi",
  "01", "Decree Absolute",
  "02", "FR Application",
  "03", "FR Disposal",
  "04", "Hearing",
  "05", "Injunction Application",
  "06", "Injunction Order"
)

#Adding the column names and updating the naming of Stages
divorce_progress_format <- divorce_progress_csv %>% filter(Year > 2010) %>% 
  mutate(Quarters = case_when(
   Quarters_after_petition == '0 to 1' ~ '0',
   Quarters_after_petition == '1 to 2' ~ '1',
   Quarters_after_petition == '2 to 3' ~ '2',
   Quarters_after_petition == '3 to 4' ~ '3',
   Quarters_after_petition == '4 to 5' ~ '4',
   Quarters_after_petition == '5 to 6' ~ '5',
   Quarters_after_petition == '6 to 7' ~ '6',
   Quarters_after_petition == '7 to 8' ~ '7',
   Quarters_after_petition == '8 to 9' ~ '8',
   Quarters_after_petition == '9 to 10' ~ '9',
   TRUE ~ '10+'
   
  ),
  Stage = case_when(
    Stage == 'AR Application' ~ 'FR Application',
    Stage == 'AR Order' ~ 'FR Disposal',
    TRUE ~ Stage
  ))

#Groups together, summarises the categories and pivots the columns
divorce_progress_a <- divorce_progress_format %>% group_by(Stage, Quarters) %>% 
  summarise(Number = sum(Number)) %>% 
  pivot_wider(names_from = Quarters, values_from = Number) %>% 
  relocate(`10+`, .after = `9`)

#Total number of petitions since 2010  
div_pet_all <- divorce_progress_a %>% filter(Stage == 'Petition') %>% pull(`0`)

#Now tidying up the tables. Everything is divided by the number of petitions for the table
# The final part is getting the Stages in the right order
t14_reg <- divorce_progress_a %>% 
  filter(Stage != 'Petition') %>% 
  mutate(across(everything(), ~ .x/div_pet_all)) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, 0))) %>% 
  left_join(div_prog_lookup, by = 'Stage') %>% 
  arrange(Order) %>% 
  select(!Order)
  
# time period
timeperiod14 <- paste0 ("Q1 2011 - Q", pub_quarter," ", pub_year)
  