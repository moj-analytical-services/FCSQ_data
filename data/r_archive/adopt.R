# Adoption

# Calling the SQL code for the extracts 
source(paste0(path_to_project, "adopt_sql.R"))

# Applications - table of all applications and the adopter type
adopt_all_apps <- dbtools::read_sql(sql_adopt_all_apps) 

# Orders - table of all orders with the adopter type, country of birth (where relevent), age and gender of child
adopt_all_ords <- dbtools::read_sql(sql_adopt_all_ords) %>%
  as.data.table() %>%
  dtplyr::lazy_dt() %>%
  left_join(birth_country_lookup, by="country_of_birth") %>%
  mutate(type=if_else(type=='?Foreign?', if_else(nationality==2,'Foreign','Standard'),type)) %>%           # using the country of birth to determine if ?Foreign? is actually Foreign
  select(!c(country_of_birth, nationality)) %>%
  as.data.table()

# Cases started  - grouping applications to one entry per case, with the earliest receipt date and the court code from the first application
adopt_case_starts <- case_groups(event_data = adopt_all_apps, start_end = 'start')

# Cases disposed - grouping orders to one entry per case, with the latest receipt date and the court code from the latest order
# adopt_case_disps <- case_groups(event_data = adopt_all_ords, start_end = 'end')
# This will actually need specific code, following the convention for what constitutes a final order in adoption - different to dv

# Temp
adopt_all_apps %>%
  lazy_dt() %>%
  filter(year == 2011, quarter==2, adoption=='Adoption+other') %>%
  group_by(year, quarter, app_type, adopter) %>%
  summarise(count = n()) %>%
  ungroup() %>%
  arrange(app_type) %>%
  as.data.table()

x<- adopt_all_apps %>%
  lazy_dt() %>%
  filter(year==2011, quarter==2, adoption=='Adoption+other', adopter=='Sole applicant') %>%
  as.data.table()
