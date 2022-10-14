#Table 4 accessible
# Currently Interim Orders are left in. Will change later
t4_orders <- ca_order_lookup %>% filter(Table == 4)

t4_years <- child_act_csv %>% filter(Year <= annual_year, !is.na(Year)) %>% distinct(Year) %>% 
  arrange(Year)

# Selecting final four quarters only
t4_quarter <- child_act_csv %>% distinct(Year, Qtr) %>% 
  filter(!is.na(Year), Qtr != '') %>% tail(4)


####### Table 4b ##############################################################

##############################################################################
#Public Law Child Count Applications Year
###############################################################################
t4_child_pub_year <- child_act_csv %>% 
  filter(Type == 'Disposal', Count_type == 'Children', Public_private == 'Public law', Year <= annual_year) %>% 
  inner_join(t4_orders, by = 'Order_type_code') %>% 
  group_by(Year, Type, Count_type, Public_private, `Order type`, Order_category) %>% 
  summarise(Count = sum_na(Count)) %>% ungroup()

#Putting together a template of all the years and orders in the right order.
#Full join on character() emulates a cross join
t4_pub_order_template_year <- t4_orders %>% filter(Public_or_Private != 'Private law') %>% 
  full_join(t4_years, by = character())%>% 
  arrange(as.numeric(Order_type_code)) %>% distinct(Year, `Order type`, Order_category)

#Joining together and pivoting to get the data in the right shape
#Final step replaces any na with 0
t4b_accessible_pub_year_a <- t4_pub_order_template_year %>% left_join(t4_child_pub_year, by = c('Year', 'Order type', 'Order_category')) %>% 
  transmute(Category = 'Public law',
            `Order type category` = Order_category,
            `Order type` = `Order type`,
            Year = Year,
            Count = Count) %>%
  pivot_wider(names_from = Year,
              values_from = Count) 

# Combined Orders
pub_combined_orders_child_year <- child_act_csv %>% filter(Count_type == 'Combined orders - children', Public_private == 'Public law') %>% 
  group_by(Year) %>% 
  summarise(Count = sum_na(Count)) %>% 
  semi_join(t4_years, by = 'Year') %>% 
  transmute(Category = 'Public law',
            `Order type category` = 'Combined Orders',
            `Order type` = 'Supervision & Special Guardianship Orders',
             Year = Year,
            Count = Count) %>%
  pivot_wider(names_from = Year,
              values_from = Count)

t4b_accessible_pub_year <- bind_rows(t4b_accessible_pub_year_a, pub_combined_orders_child_year)
###############################################################################
#Public Law Child Count Applications Quarterly
t4_child_pub_qtr <- child_act_csv %>% 
  filter(Type == 'Disposal', Count_type == 'Children', Public_private == 'Public law') %>% 
  inner_join(t4_orders, by = 'Order_type_code') %>% 
  group_by(Year, Qtr, Type, Count_type, Public_private, `Order type`, Order_category) %>% 
  summarise(Count = sum_na(Count)) %>% ungroup() 

#Putting together a template of all the quarters and orders in the right order
t4_pub_order_template_qtr <- t4_orders %>% filter(Public_or_Private != 'Private law') %>% 
  full_join(t4_quarter, by = character())%>% 
  arrange(as.numeric(Order_type_code)) %>% distinct(Year, Qtr, `Order type`, Order_category)

#Joining together and pivoting to get the data in the right shape
#Final step replaces any na with 0 and selects the last four quarters only
t4b_accessible_pub_qtr_a <- t4_pub_order_template_qtr %>% left_join(t4_child_pub_qtr, by = c('Year', 'Qtr', 'Order type', 'Order_category')) %>% 
  transmute(Category = 'Public law',
            `Order type category` = Order_category,
            `Order type` = `Order type`,
            Year = Year,
            Qtr = Qtr,
            Count = Count) %>%
  pivot_wider(names_from = c(Year, Qtr),
              names_sep = ' Q',
              values_from = Count)

# Combined Orders
pub_combined_orders_child_qtr <- child_act_csv %>% filter(Count_type == 'Combined orders - children', Public_private == 'Public law') %>% 
  group_by(Year, Qtr) %>% 
  summarise(Count = sum_na(Count)) %>% 
  semi_join(t4_quarter, by = c('Year', 'Qtr')) %>% 
  transmute(Category = 'Public law',
            `Order type category` = 'Combined Orders',
            `Order type` = 'Supervision & Special Guardianship Orders',
            Year = Year,
            Qtr = Qtr,
            Count = Count) %>% 
  pivot_wider(names_from = c(Year, Qtr),
              names_sep = ' Q',
              values_from = Count)

t4b_accessible_pub_qtr <- bind_rows(t4b_accessible_pub_qtr_a, pub_combined_orders_child_qtr)

t4b_accessible_pub <- left_join(t4b_accessible_pub_year, t4b_accessible_pub_qtr, by = c("Category", "Order type", "Order type category"))


##############################################################################
#Private Law Child Count Applications Year
###############################################################################
t4_child_priv_year <- child_act_csv %>% 
  filter(Type == 'Disposal', Count_type == 'Children', Public_private == 'Private law', Year <= annual_year) %>% 
  inner_join(t4_orders, by = 'Order_type_code') %>% 
  group_by(Year, Type, Count_type, Public_private, `Order type`, Order_category) %>% 
  summarise(Count = sum_na(Count)) %>% ungroup()

#Putting together a template of all the years and orders in the right order
t4_priv_order_template_year <- t4_orders %>% filter(Public_or_Private != 'Public law') %>% 
  full_join(t4_years, by = character())%>% 
  arrange(as.numeric(Order_type_code)) %>% distinct(Year, `Order type`, Order_category)

#Joining together and pivoting to get the data in the right shape
#Final step replaces any na with 0
t4b_accessible_priv_year <- t4_priv_order_template_year %>% left_join(t4_child_priv_year, by = c('Year', 'Order type', 'Order_category')) %>% 
  transmute(Category = 'Private law',
            `Order type category` = Order_category,
            `Order type` = `Order type`,
            Year = Year,
            Count = Count) %>%
  pivot_wider(names_from = Year,
              values_from = Count)

###############################################################################
#Private Law Child Count Applications Quarterly
t4_child_priv_qtr <- child_act_csv %>% 
  filter(Type == 'Disposal', Count_type == 'Children', Public_private == 'Private law') %>% 
  inner_join(t4_orders, by = 'Order_type_code') %>% 
  group_by(Year, Qtr, Type, Count_type, Public_private, `Order type`, Order_category) %>% 
  summarise(Count = sum_na(Count)) %>% ungroup() 

#Putting together a template of all the quarters and orders in the right order
t4_priv_order_template_qtr <- t4_orders %>% filter(Public_or_Private != 'Public law') %>% 
  full_join(t4_quarter, by = character())%>% 
  arrange(as.numeric(Order_type_code)) %>% distinct(Year, Qtr, `Order type`, Order_category)

#Joining together and pivoting to get the data in the right shape
#Final step replaces any na with 0 and selects the last four quarters only
t4b_accessible_priv_qtr <- t4_priv_order_template_qtr %>% left_join(t4_child_priv_qtr, by = c('Year', 'Qtr', 'Order type', 'Order_category')) %>% 
  transmute(Category = 'Private law',
            `Order type category` = Order_category,
            `Order type` = `Order type`,
            Year = Year,
            Qtr = Qtr,
            Count = Count) %>%
  pivot_wider(names_from = c(Year, Qtr),
              names_sep = ' Q',
              values_from = Count)

t4b_accessible_priv <- left_join(t4b_accessible_priv_year, t4b_accessible_priv_qtr, by = c("Category", "Order type", "Order type category"))

t4b_accessible <- bind_rows(t4b_accessible_pub, t4b_accessible_priv) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, 0))) %>% 
  mutate(across(starts_with('2022'), ~ na_value))



####### Table 4a ##############################################################
#Public Law Order Count Orders Year
###############################################################################

t4_order_pub_year <- child_act_csv %>% 
  filter(Type == 'Disposal', Count_type == 'Order type', Public_private == 'Public law', Year <= annual_year) %>% 
  inner_join(t4_orders, by = 'Order_type_code') %>% 
  group_by(Year, Type, Count_type, Public_private, `Order type`, Order_category) %>% 
  summarise(Count = sum_na(Count)) %>% ungroup()


#Joining together and pivoting to get the data in the right shape
#Final step replaces any na with 0
t4a_accessible_pub_year_a <- t4_pub_order_template_year %>% left_join(t4_order_pub_year, by = c('Year', 'Order type', 'Order_category')) %>% 
  transmute(Category = 'Public law',
            `Order type category` = Order_category,
            `Order type` = `Order type`,
            Year = Year,
            Count = Count) %>%
  pivot_wider(names_from = Year,
              values_from = Count) 

# Combined Orders
pub_combined_orders_order_year <- child_act_csv %>% filter(Count_type == 'Combined orders - orders', Public_private == 'Public law') %>% 
  group_by(Year) %>% 
  summarise(Count = sum_na(Count)) %>% 
  semi_join(t4_years, by = 'Year') %>% 
  transmute(Category = 'Public law',
            `Order type category` = 'Combined Orders',
            `Order type` = 'Supervision & Special Guardianship Orders',
            Year = Year,
            Count = Count) %>%
  pivot_wider(names_from = Year,
              values_from = Count)

t4a_accessible_pub_year <- bind_rows(t4a_accessible_pub_year_a, pub_combined_orders_order_year)
###############################################################################
#Public Law Order Count Applications Quarterly
t4_order_pub_qtr <- child_act_csv %>% 
  filter(Type == 'Disposal', Count_type == 'Order type', Public_private == 'Public law') %>% 
  inner_join(t4_orders, by = 'Order_type_code') %>% 
  group_by(Year, Qtr, Type, Count_type, Public_private, `Order type`, Order_category) %>% 
  summarise(Count = sum_na(Count)) %>% ungroup() 


#Joining together and pivoting to get the data in the right shape
#Final step replaces any na with 0 and selects the last four quarters only
t4a_accessible_pub_qtr_a <- t4_pub_order_template_qtr %>% left_join(t4_order_pub_qtr, by = c('Year', 'Qtr', 'Order type', 'Order_category')) %>% 
  transmute(Category = 'Public law',
            `Order type category` = Order_category,
            `Order type` = `Order type`,
            Year = Year,
            Qtr = Qtr,
            Count = Count) %>%
  pivot_wider(names_from = c(Year, Qtr),
              names_sep = ' Q',
              values_from = Count)

# Combined Orders
pub_combined_orders_orders_qtr <- child_act_csv %>% filter(Count_type == 'Combined orders - orders', Public_private == 'Public law') %>% 
  group_by(Year, Qtr) %>% 
  summarise(Count = sum_na(Count)) %>% 
  semi_join(t4_quarter, by = c('Year', 'Qtr')) %>% 
  transmute(Category = 'Public law',
            `Order type category` = 'Combined Orders',
            `Order type` = 'Supervision & Special Guardianship Orders',
            Year = Year,
            Qtr = Qtr,
            Count = Count) %>% 
  pivot_wider(names_from = c(Year, Qtr),
              names_sep = ' Q',
              values_from = Count)

t4a_accessible_pub_qtr <- bind_rows(t4a_accessible_pub_qtr_a, pub_combined_orders_orders_qtr)
t4a_accessible_pub <- left_join(t4a_accessible_pub_year, t4a_accessible_pub_qtr, by = c('Category', 'Order type', 'Order type category')) 


##############################################################################
#Private Law Order Count Orders Year
###############################################################################
t4_order_priv_year <- child_act_csv %>% 
  filter(Type == 'Disposal', Count_type == 'Order type', Public_private == 'Private law', Year <= annual_year) %>% 
  inner_join(t4_orders, by = 'Order_type_code') %>% 
  group_by(Year, Type, Count_type, Public_private, `Order type`, Order_category) %>% 
  summarise(Count = sum_na(Count)) %>% ungroup()


#Joining together and pivoting to get the data in the right shape
#Final step replaces any na with 0
t4a_accessible_priv_year <- t4_priv_order_template_year %>% left_join(t4_order_priv_year, by = c('Year', 'Order type', 'Order_category')) %>% 
  transmute(Category = 'Private law',
            `Order type category` = Order_category,
            `Order type` = `Order type`,
            Year = Year,
            Count = Count) %>%
  pivot_wider(names_from = Year,
              values_from = Count)

###############################################################################
#Private Law Order Count Orders Quarterly
t4_order_priv_qtr <- child_act_csv %>% 
  filter(Type == 'Disposal', Count_type == 'Order type', Public_private == 'Private law') %>% 
  inner_join(t4_orders, by = 'Order_type_code') %>% 
  group_by(Year, Qtr, Type, Count_type, Public_private, `Order type`, Order_category) %>% 
  summarise(Count = sum_na(Count)) %>% ungroup() 


#Joining together and pivoting to get the data in the right shape
#Final step replaces any na with 0 and selects the last four quarters only
t4a_accessible_priv_qtr <- t4_priv_order_template_qtr %>% left_join(t4_order_priv_qtr, by = c('Year', 'Qtr', 'Order type', 'Order_category')) %>% 
  transmute(Category = 'Private law',
            `Order type category` = Order_category,
            `Order type` = `Order type`,
            Year = Year,
            Qtr = Qtr,
            Count = Count) %>%
  pivot_wider(names_from = c(Year, Qtr),
              names_sep = ' Q',
              values_from = Count)

t4a_accessible_priv <- left_join(t4a_accessible_priv_year, t4a_accessible_priv_qtr, by = c('Category', 'Order type', 'Order type category'))

t4a_accessible <- bind_rows(t4a_accessible_pub, t4a_accessible_priv) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, 0))) %>% 
  mutate(across(starts_with('2022'), ~ na_value))