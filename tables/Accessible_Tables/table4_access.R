#Table 4 accessible
# Currently Interim Orders are left in. Will change later
t4_orders <- ca_order_lookup %>% filter(Table == 4)



# Selecting final four quarters only
t4_quarter <- child_act_csv %>% distinct(Year, Qtr) %>% 
  filter(!is.na(Year), Qtr != '') %>% tail(4)


####### Table 4a ##############################################################

##############################################################################
#Public Law Child Count Applications Year
###############################################################################
t4_child_pub_year <- child_act_csv %>% 
  filter(Type == 'Disposal', Count_type == 'Children', Public_private == 'Public law', Year <= annual_year) %>% 
  inner_join(t4_orders, by = 'Order_type_code') %>% 
  group_by(Year, Type, Count_type, Public_private, `Order type`) %>% 
  summarise(Count = sum(Count)) %>% ungroup()

#Putting together a template of all the years and orders in the right order
t4_order_template_year <- t4_child_pub_year %>% left_join(t4_orders) %>% 
  arrange(as.numeric(Order_type_code)) %>% distinct(Year, `Order type`)

#Joining together and pivoting to get the data in the right shape
#Final step replaces any na with 0
t4a_accessible_pub_year <- t4_order_template_year %>% left_join(t4_child_pub_year, by = c('Year', 'Order type')) %>% 
  transmute(Category = 'Public law',
            `Order type` = `Order type`,
            Year = Year,
            Count = Count) %>%
  pivot_wider(names_from = Year,
              values_from = Count) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, 0))) 

###############################################################################
#Public Law Child Count Applications Quarterly
t4_child_pub_qtr <- child_act_csv %>% 
  filter(Type == 'Disposal', Count_type == 'Children', Public_private == 'Public law') %>% 
  inner_join(t4_orders, by = 'Order_type_code') %>% 
  group_by(Year, Qtr, Type, Count_type, Public_private, `Order type`) %>% 
  summarise(Count = sum(Count)) %>% ungroup() 

#Putting together a template of all the quarters and orders in the right order
t4_order_template_qtr <- t4_child_pub_qtr %>% left_join(t4_orders) %>% 
  arrange(as.numeric(Order_type_code)) %>% distinct(Year, Qtr, `Order type`)

#Joining together and pivoting to get the data in the right shape
#Final step replaces any na with 0 and selects the last four quarters only
t4a_accessible_pub_qtr <- t4_order_template_qtr %>% left_join(t4_child_pub_qtr, by = c('Year', 'Qtr', 'Order type')) %>% 
  transmute(Category = 'Public law',
            `Order type` = `Order type`,
            Year = Year,
            Qtr = Qtr,
            Count = Count) %>%
  pivot_wider(names_from = c(Year, Qtr),
              names_sep = ' Q',
              values_from = Count) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, 0))) %>% 
  select(Category, `Order type`, tail(names(.), 4))

### Table 4 has a combined orders category as well. adding the row here to the table
t4a_pub_combined_orders_year <- child_act_csv %>% 
  filter(Count_type == 'Combined orders - children', Public_private == 'Public law', Year <= annual_year) %>% 
  group_by(Year) %>% 
  summarise(Count = sum(Count)) %>% ungroup() %>% 
  pivot_wider(names_from = Year,
              values_from = Count)

t4a_pub_combined_orders_qtr <- child_act_csv %>% 
  filter(Count_type == 'Combined orders - children', Public_private == 'Public law') %>% 
  group_by(Year, Qtr) %>% 
  summarise(Count = sum(Count)) %>% ungroup() %>% 
  tail(4) %>% 
  pivot_wider(names_from = c(Year, Qtr),
              names_sep = ' Q',
              values_from = Count)


t4a_combined_pub <- bind_cols(t4a_pub_combined_orders_year, t4a_pub_combined_orders_qtr) %>% 
  mutate(Category = 'Public law',
         `Order type` = 'Supervision & Special Guardianship Orders')

t4a_accessible_pub <- t4a_accessible_pub_year %>% left_join(t4a_accessible_pub_qtr) 


##############################################################################
#Private Law Child Count Applications Year
###############################################################################
t4_child_priv_year <- child_act_csv %>% 
  filter(Type == 'Disposal', Count_type == 'Children', Public_private == 'Private law', Year <= annual_year) %>% 
  inner_join(t4_orders, by = 'Order_type_code') %>% 
  group_by(Year, Type, Count_type, Public_private, `Order type`) %>% 
  summarise(Count = sum(Count)) %>% ungroup()

#Putting together a template of all the years and orders in the right order
t4_priv_order_template_year <- t4_child_priv_year %>% left_join(t4_orders) %>% 
  arrange(as.numeric(Order_type_code)) %>% distinct(Year, `Order type`)

#Joining together and pivoting to get the data in the right shape
#Final step replaces any na with 0
t4a_accessible_priv_year <- t4_priv_order_template_year %>% left_join(t4_child_priv_year, by = c('Year', 'Order type')) %>% 
  transmute(Category = 'Private law',
            `Order type` = `Order type`,
            Year = Year,
            Count = Count) %>%
  pivot_wider(names_from = Year,
              values_from = Count) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, 0))) 

###############################################################################
#Private Law Child Count Applications Quarterly
t4_child_priv_qtr <- child_act_csv %>% 
  filter(Type == 'Disposal', Count_type == 'Children', Public_private == 'Private law') %>% 
  inner_join(t4_orders, by = 'Order_type_code') %>% 
  group_by(Year, Qtr, Type, Count_type, Public_private, `Order type`) %>% 
  summarise(Count = sum(Count)) %>% ungroup() 

#Putting together a template of all the quarters and orders in the right order
t4_priv_order_template_qtr <- t4_child_priv_qtr %>% left_join(t4_orders) %>% 
  arrange(as.numeric(Order_type_code)) %>% distinct(Year, Qtr, `Order type`)

#Joining together and pivoting to get the data in the right shape
#Final step replaces any na with 0 and selects the last four quarters only
t4a_accessible_priv_qtr <- t4_priv_order_template_qtr %>% left_join(t4_child_priv_qtr, by = c('Year', 'Qtr', 'Order type')) %>% 
  transmute(Category = 'Private law',
            `Order type` = `Order type`,
            Year = Year,
            Qtr = Qtr,
            Count = Count) %>%
  pivot_wider(names_from = c(Year, Qtr),
              names_sep = ' Q',
              values_from = Count) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, 0))) %>% 
  select(Category, `Order type`, tail(names(.), 4))

t4a_accessible_priv <- t4a_accessible_priv_year %>% left_join(t4a_accessible_priv_qtr)

t4a_accessible <- bind_rows(t4a_accessible_pub, t4a_combined_pub, t4a_accessible_priv)

####### Table 4b ##############################################################
#Public Law Child Count Applications Year
###############################################################################

t4_order_pub_year <- child_act_csv %>% 
  filter(Type == 'Disposal', Count_type == 'Order type', Public_private == 'Public law', Year <= annual_year) %>% 
  inner_join(t4_orders, by = 'Order_type_code') %>% 
  group_by(Year, Type, Count_type, Public_private, `Order type`) %>% 
  summarise(Count = sum(Count)) %>% ungroup()

#Putting together a template of all the years and orders in the right order
t4_order_template_year <- t4_order_pub_year %>% left_join(t4_orders) %>% 
  arrange(as.numeric(Order_type_code)) %>% distinct(Year, `Order type`)

#Joining together and pivoting to get the data in the right shape
#Final step replaces any na with 0
t4b_accessible_pub_year <- t4_order_template_year %>% left_join(t4_order_pub_year, by = c('Year', 'Order type')) %>% 
  transmute(Category = 'Public law',
            `Order type` = `Order type`,
            Year = Year,
            Count = Count) %>%
  pivot_wider(names_from = Year,
              values_from = Count) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, 0))) 

###############################################################################
#Public Law Child Count Applications Quarterly
t4_order_pub_qtr <- child_act_csv %>% 
  filter(Type == 'Disposal', Count_type == 'Order type', Public_private == 'Public law') %>% 
  inner_join(t4_orders, by = 'Order_type_code') %>% 
  group_by(Year, Qtr, Type, Count_type, Public_private, `Order type`) %>% 
  summarise(Count = sum(Count)) %>% ungroup() 

#Putting together a template of all the quarters and orders in the right order
t4_order_template_qtr <- t4_order_pub_qtr %>% left_join(t4_orders) %>% 
  arrange(as.numeric(Order_type_code)) %>% distinct(Year, Qtr, `Order type`)

#Joining together and pivoting to get the data in the right shape
#Final step replaces any na with 0 and selects the last four quarters only
t4b_accessible_pub_qtr <- t4_order_template_qtr %>% left_join(t4_order_pub_qtr, by = c('Year', 'Qtr', 'Order type')) %>% 
  transmute(Category = 'Public law',
            `Order type` = `Order type`,
            Year = Year,
            Qtr = Qtr,
            Count = Count) %>%
  pivot_wider(names_from = c(Year, Qtr),
              names_sep = ' Q',
              values_from = Count) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, 0))) %>% 
  select(Category, `Order type`, tail(names(.), 4))

#########Combined Orders###########################
# table 4 has a unique combined orders category as well. Again selecting only complete years and latest four quarters
t4b_pub_combined_orders_year <- child_act_csv %>% 
  filter(Count_type == 'Combined orders - orders', Public_private == 'Public law', Year <= annual_year) %>% 
  group_by(Year) %>% 
  summarise(Count = sum(Count)) %>% ungroup() %>% 
  pivot_wider(names_from = Year,
              values_from = Count)

t4b_pub_combined_orders_qtr <- child_act_csv %>% 
  filter(Count_type == 'Combined orders - orders', Public_private == 'Public law') %>% 
  group_by(Year, Qtr) %>% 
  summarise(Count = sum(Count)) %>% ungroup() %>% 
  tail(4) %>% 
  pivot_wider(names_from = c(Year, Qtr),
              names_sep = ' Q',
              values_from = Count)


t4b_combined_pub <- bind_cols(t4b_pub_combined_orders_year, t4b_pub_combined_orders_qtr) %>% 
  mutate(Category = 'Public law',
         `Order type` = 'Supervision & Special Guardianship Orders')
######################################################
t4b_accessible_pub <- t4b_accessible_pub_year %>% left_join(t4b_accessible_pub_qtr) 


##############################################################################
#Private Law Child Count Applications Year
###############################################################################
t4_order_priv_year <- child_act_csv %>% 
  filter(Type == 'Disposal', Count_type == 'Order type', Public_private == 'Private law', Year <= annual_year) %>% 
  inner_join(t4_orders, by = 'Order_type_code') %>% 
  group_by(Year, Type, Count_type, Public_private, `Order type`) %>% 
  summarise(Count = sum(Count)) %>% ungroup()

#Putting together a template of all the years and orders in the right order
t4_priv_order_template_year <- t4_order_priv_year %>% left_join(t4_orders) %>% 
  arrange(as.numeric(Order_type_code)) %>% distinct(Year, `Order type`)

#Joining together and pivoting to get the data in the right shape
#Final step replaces any na with 0
t4b_accessible_priv_year <- t4_priv_order_template_year %>% left_join(t4_order_priv_year, by = c('Year', 'Order type')) %>% 
  transmute(Category = 'Private law',
            `Order type` = `Order type`,
            Year = Year,
            Count = Count) %>%
  pivot_wider(names_from = Year,
              values_from = Count) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, 0))) 

###############################################################################
#Private Law Child Count Applications Quarterly
t4_order_priv_qtr <- child_act_csv %>% 
  filter(Type == 'Disposal', Count_type == 'Order type', Public_private == 'Private law') %>% 
  inner_join(t4_orders, by = 'Order_type_code') %>% 
  group_by(Year, Qtr, Type, Count_type, Public_private, `Order type`) %>% 
  summarise(Count = sum(Count)) %>% ungroup() 

#Putting together a template of all the quarters and orders in the right order
t4_priv_order_template_qtr <- t4_order_priv_qtr %>% left_join(t4_orders) %>% 
  arrange(as.numeric(Order_type_code)) %>% distinct(Year, Qtr, `Order type`)

#Joining together and pivoting to get the data in the right shape
#Final step replaces any na with 0 and selects the last four quarters only
t4b_accessible_priv_qtr <- t4_priv_order_template_qtr %>% left_join(t4_order_priv_qtr, by = c('Year', 'Qtr', 'Order type')) %>% 
  transmute(Category = 'Private law',
            `Order type` = `Order type`,
            Year = Year,
            Qtr = Qtr,
            Count = Count) %>%
  pivot_wider(names_from = c(Year, Qtr),
              names_sep = ' Q',
              values_from = Count) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, 0))) %>% 
  select(Category, `Order type`, tail(names(.), 4))
#########################################################


t4b_accessible_priv <- t4b_accessible_priv_year %>% left_join(t4b_accessible_priv_qtr)

t4b_accessible <- bind_rows(t4b_accessible_pub, t4b_combined_pub, t4b_accessible_priv)