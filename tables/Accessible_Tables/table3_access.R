#Table 3 accessible
t3_orders <- ca_order_lookup %>% filter(Table == 3)



# Selecting final four quarters only
t3_quarter <- child_act_csv %>% distinct(Year, Qtr) %>% 
  filter(!is.na(Year), Qtr != '') %>% tail(4)


####### Table 3a ##############################################################

##############################################################################
#Public Law Child Count Applications Year
###############################################################################
t3_child_pub_year <- child_act_csv %>% 
  filter(Type == 'Application', Count_type == 'Children', Public_private == 'Public law', Year <= annual_year) %>% 
  inner_join(t3_orders, by = 'Order_type_code') %>% 
  group_by(Year, Type, Count_type, Public_private, `Order type`) %>% 
  summarise(Count = sum(Count)) %>% ungroup()

#Putting together a template of all the years and orders in the right order
t3_order_template_year <- t3_child_pub_year %>% left_join(t3_orders) %>% 
  arrange(as.numeric(Order_type_code)) %>% distinct(Year, `Order type`)

#Joining together and pivoting to get the data in the right shape
#Final step replaces any na with 0
t3a_accessible_pub_year <- t3_order_template_year %>% left_join(t3_child_pub_year, by = c('Year', 'Order type')) %>% 
  transmute(Category = 'Public law',
            `Order type` = `Order type`,
            Year = Year,
            Count = Count) %>%
  pivot_wider(names_from = Year,
              values_from = Count) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, 0))) 

###############################################################################
#Public Law Child Count Applications Quarterly
t3_child_pub_qtr <- child_act_csv %>% 
  filter(Type == 'Application', Count_type == 'Children', Public_private == 'Public law') %>% 
  inner_join(t3_orders, by = 'Order_type_code') %>% 
  group_by(Year, Qtr, Type, Count_type, Public_private, `Order type`) %>% 
  summarise(Count = sum(Count)) %>% ungroup() 

#Putting together a template of all the quarters and orders in the right order
t3_order_template_qtr <- t3_child_pub_qtr %>% left_join(t3_orders) %>% 
  arrange(as.numeric(Order_type_code)) %>% distinct(Year, Qtr, `Order type`)

#Joining together and pivoting to get the data in the right shape
#Final step replaces any na with 0 and selects the last four quarters only
t3a_accessible_pub_qtr <- t3_order_template_qtr %>% left_join(t3_child_pub_qtr, by = c('Year', 'Qtr', 'Order type')) %>% 
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

t3a_accessible_pub <- t3a_accessible_pub_year %>% left_join(t3a_accessible_pub_qtr) 


##############################################################################
#Private Law Child Count Applications Year
###############################################################################
t3_child_priv_year <- child_act_csv %>% 
  filter(Type == 'Application', Count_type == 'Children', Public_private == 'Private law', Year <= annual_year) %>% 
  inner_join(t3_orders, by = 'Order_type_code') %>% 
  group_by(Year, Type, Count_type, Public_private, `Order type`) %>% 
  summarise(Count = sum(Count)) %>% ungroup()

#Putting together a template of all the years and orders in the right order
t3_priv_order_template_year <- t3_child_priv_year %>% left_join(t3_orders) %>% 
  arrange(as.numeric(Order_type_code)) %>% distinct(Year, `Order type`)

#Joining together and pivoting to get the data in the right shape
#Final step replaces any na with 0
t3a_accessible_priv_year <- t3_priv_order_template_year %>% left_join(t3_child_priv_year, by = c('Year', 'Order type')) %>% 
  transmute(Category = 'Private law',
            `Order type` = `Order type`,
            Year = Year,
            Count = Count) %>%
  pivot_wider(names_from = Year,
              values_from = Count) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, 0))) 

###############################################################################
#Private Law Child Count Applications Quarterly
t3_child_priv_qtr <- child_act_csv %>% 
  filter(Type == 'Application', Count_type == 'Children', Public_private == 'Private law') %>% 
  inner_join(t3_orders, by = 'Order_type_code') %>% 
  group_by(Year, Qtr, Type, Count_type, Public_private, `Order type`) %>% 
  summarise(Count = sum(Count)) %>% ungroup() 

#Putting together a template of all the quarters and orders in the right order
t3_priv_order_template_qtr <- t3_child_priv_qtr %>% left_join(t3_orders) %>% 
  arrange(as.numeric(Order_type_code)) %>% distinct(Year, Qtr, `Order type`)

#Joining together and pivoting to get the data in the right shape
#Final step replaces any na with 0 and selects the last four quarters only
t3a_accessible_priv_qtr <- t3_priv_order_template_qtr %>% left_join(t3_child_priv_qtr, by = c('Year', 'Qtr', 'Order type')) %>% 
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

t3a_accessible_priv <- t3a_accessible_priv_year %>% left_join(t3a_accessible_priv_qtr)
####### Table 3b ##############################################################
#Public Law Child Count Applications Year
###############################################################################