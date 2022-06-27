#Table 3 accessible
t3_orders <- ca_order_lookup %>% filter(Table == 3)


#Getting a list of years
t3_years <- child_act_csv %>% filter(Year <= annual_year, !is.na(Year)) %>% distinct(Year) %>% 
  arrange(Year)

# Selecting final four quarters only
t3_quarter <- child_act_csv %>% distinct(Year, Qtr) %>% 
  filter(!is.na(Year), Qtr != '') %>% tail(4)


####### Table 3a ##############################################################

##############################################################################
#Public Law Child Count Applications Year
###############################################################################

#Getting the Counts for each Order by grouped Categories
t3_child_pub_year <- child_act_csv %>% 
  filter(Type == 'Application', Count_type == 'Children', Public_private == 'Public law', Year <= annual_year) %>% 
  inner_join(t3_orders, by = 'Order_type_code') %>% 
  group_by(Year, Type, Count_type, Public_private, `Order type`, Order_category) %>% 
  summarise(Count = sum_na(Count)) %>% ungroup()

#Putting together a template of all the years and orders in the right order.
#Full join on character() emulates a cross join. Each year should have the listed orders in the lookup even when the amount appearing is 0
t3_pub_order_template_year <- t3_orders %>% filter(Public_or_Private != 'Private law') %>% 
  full_join(t3_years, by = character())%>% 
  arrange(as.numeric(Order_type_code)) %>% distinct(Year, `Order type`, Order_category)

#Joining together and pivoting to get the data in the right shape
#Final step replaces any na with 0
t3a_accessible_pub_year <- t3_pub_order_template_year %>% left_join(t3_child_pub_year, by = c('Year', 'Order type', 'Order_category')) %>% 
  transmute(Category = 'Public law',
            `Order category` = Order_category,
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
  group_by(Year, Qtr, Type, Count_type, Public_private, `Order type`, Order_category) %>% 
  summarise(Count = sum_na(Count)) %>% ungroup() 

#Putting together a template of all the quarters and orders in the right order
t3_pub_order_template_qtr <- t3_orders %>% filter(Public_or_Private != 'Private law') %>% 
  full_join(t3_quarter, by = character())%>% 
  arrange(as.numeric(Order_type_code)) %>% distinct(Year, Qtr, `Order type`, Order_category)

#Joining together and pivoting to get the data in the right shape
#Final step replaces any na with 0 and selects the last four quarters only
t3a_accessible_pub_qtr <- t3_pub_order_template_qtr %>% left_join(t3_child_pub_qtr, by = c('Year', 'Qtr', 'Order type', 'Order_category')) %>% 
  transmute(Category = 'Public law',
            `Order category` = Order_category,
            `Order type` = `Order type`,
            Year = Year,
            Qtr = Qtr,
            Count = Count) %>%
  pivot_wider(names_from = c(Year, Qtr),
              names_sep = ' Q',
              values_from = Count) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, 0)))

t3a_accessible_pub <- left_join(t3a_accessible_pub_year, t3a_accessible_pub_qtr, by = c("Category", "Order type", "Order category"))


##############################################################################
#Private Law Child Count Applications Year
###############################################################################
t3_child_priv_year <- child_act_csv %>% 
  filter(Type == 'Application', Count_type == 'Children', Public_private == 'Private law', Year <= annual_year) %>% 
  inner_join(t3_orders, by = 'Order_type_code') %>% 
  group_by(Year, Type, Count_type, Public_private, `Order type`, Order_category) %>% 
  summarise(Count = sum_na(Count)) %>% ungroup()

#Putting together a template of all the years and orders in the right order
t3_priv_order_template_year <- t3_orders %>% filter(Public_or_Private != 'Public law') %>% 
  full_join(t3_years, by = character())%>% 
  arrange(as.numeric(Order_type_code)) %>% distinct(Year, `Order type`, Order_category)

#Joining together and pivoting to get the data in the right shape
#Final step replaces any na with 0
t3a_accessible_priv_year <- t3_priv_order_template_year %>% left_join(t3_child_priv_year, by = c('Year', 'Order type', 'Order_category')) %>% 
  transmute(Category = 'Private law',
            `Order category` = Order_category,
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
  group_by(Year, Qtr, Type, Count_type, Public_private, `Order type`, Order_category) %>% 
  summarise(Count = sum_na(Count)) %>% ungroup() 

#Putting together a template of all the quarters and orders in the right order
t3_priv_order_template_qtr <- t3_orders %>% filter(Public_or_Private != 'Public law') %>% 
  full_join(t3_quarter, by = character())%>% 
  arrange(as.numeric(Order_type_code)) %>% distinct(Year, Qtr, `Order type`, Order_category)

#Joining together and pivoting to get the data in the right shape
#Final step replaces any na with 0 and selects the last four quarters only
t3a_accessible_priv_qtr <- t3_priv_order_template_qtr %>% left_join(t3_child_priv_qtr, by = c('Year', 'Qtr', 'Order type', 'Order_category')) %>% 
  transmute(Category = 'Private law',
            `Order category` = Order_category,
            `Order type` = `Order type`,
            Year = Year,
            Qtr = Qtr,
            Count = Count) %>%
  pivot_wider(names_from = c(Year, Qtr),
              names_sep = ' Q',
              values_from = Count) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, 0)))

t3a_accessible_priv <- left_join(t3a_accessible_priv_year, t3a_accessible_priv_qtr, by = c("Category", "Order type", "Order category"))

t3a_accessible <- bind_rows(t3a_accessible_pub, t3a_accessible_priv) %>% 
  mutate(Notes = case_when(`Order type` == 'Parental order' ~ '[note 26]',
                           `Order category` == 'Return of Missing or Taken Children' ~ '[note 25]',
                           `Order category` == 'Post Separation Support and Dispute Resolution' ~ '[note 27]',
                           `Order type` == 'Enforcement' ~ '[note 28]')) %>% 
  rename(`Order type [note 23]` = `Order type`)

####### Table 3b ##############################################################
#Public Law Child Count Applications Year
###############################################################################

t3_order_pub_year <- child_act_csv %>% 
  filter(Type == 'Application', Count_type == 'Order type', Public_private == 'Public law', Year <= annual_year) %>% 
  inner_join(t3_orders, by = 'Order_type_code') %>% 
  group_by(Year, Type, Count_type, Public_private, `Order type`, Order_category) %>% 
  summarise(Count = sum_na(Count)) %>% ungroup()


#Joining together and pivoting to get the data in the right shape
#Final step replaces any na with 0
t3b_accessible_pub_year <- t3_pub_order_template_year %>% left_join(t3_order_pub_year, by = c('Year', 'Order type', 'Order_category')) %>% 
  transmute(Category = 'Public law',
            `Order category` = Order_category,
            `Order type` = `Order type`,
            Year = Year,
            Count = Count) %>%
  pivot_wider(names_from = Year,
              values_from = Count) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, 0))) 

###############################################################################
#Public Law Child Count Applications Quarterly
t3_order_pub_qtr <- child_act_csv %>% 
  filter(Type == 'Application', Count_type == 'Order type', Public_private == 'Public law') %>% 
  inner_join(t3_orders, by = 'Order_type_code') %>% 
  group_by(Year, Qtr, Type, Count_type, Public_private, `Order type`, Order_category) %>% 
  summarise(Count = sum_na(Count)) %>% ungroup() 


#Joining together and pivoting to get the data in the right shape
#Final step replaces any na with 0 and selects the last four quarters only
t3b_accessible_pub_qtr <- t3_pub_order_template_qtr %>% left_join(t3_order_pub_qtr, by = c('Year', 'Qtr', 'Order type', 'Order_category')) %>% 
  transmute(Category = 'Public law',
            `Order category` = Order_category,
            `Order type` = `Order type`,
            Year = Year,
            Qtr = Qtr,
            Count = Count) %>%
  pivot_wider(names_from = c(Year, Qtr),
              names_sep = ' Q',
              values_from = Count) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, 0)))

t3b_accessible_pub <- left_join(t3b_accessible_pub_year, t3b_accessible_pub_qtr, by = c('Category', 'Order type', 'Order category')) 


##############################################################################
#Private Law Child Count Applications Year
###############################################################################
t3_order_priv_year <- child_act_csv %>% 
  filter(Type == 'Application', Count_type == 'Order type', Public_private == 'Private law', Year <= annual_year) %>% 
  inner_join(t3_orders, by = 'Order_type_code') %>% 
  group_by(Year, Type, Count_type, Public_private, `Order type`, Order_category) %>% 
  summarise(Count = sum_na(Count)) %>% ungroup()


#Joining together and pivoting to get the data in the right shape
#Final step replaces any na with 0
t3b_accessible_priv_year <- t3_priv_order_template_year %>% left_join(t3_order_priv_year, by = c('Year', 'Order type', 'Order_category')) %>% 
  transmute(Category = 'Private law',
            `Order category` = Order_category,
            `Order type` = `Order type`,
            Year = Year,
            Count = Count) %>%
  pivot_wider(names_from = Year,
              values_from = Count) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, 0))) 

###############################################################################
#Private Law Child Count Applications Quarterly
t3_order_priv_qtr <- child_act_csv %>% 
  filter(Type == 'Application', Count_type == 'Order type', Public_private == 'Private law') %>% 
  inner_join(t3_orders, by = 'Order_type_code') %>% 
  group_by(Year, Qtr, Type, Count_type, Public_private, `Order type`, Order_category) %>% 
  summarise(Count = sum_na(Count)) %>% ungroup() 


#Joining together and pivoting to get the data in the right shape
#Final step replaces any na with 0 and selects the last four quarters only
t3b_accessible_priv_qtr <- t3_priv_order_template_qtr %>% left_join(t3_order_priv_qtr, by = c('Year', 'Qtr', 'Order type', 'Order_category')) %>% 
  transmute(Category = 'Private law',
            `Order category` = Order_category,
            `Order type` = `Order type`,
            Year = Year,
            Qtr = Qtr,
            Count = Count) %>%
  pivot_wider(names_from = c(Year, Qtr),
              names_sep = ' Q',
              values_from = Count) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, 0)))

t3b_accessible_priv <- left_join(t3b_accessible_priv_year, t3b_accessible_priv_qtr, by = c('Category', 'Order type', 'Order category'))

t3b_accessible <- bind_rows(t3b_accessible_pub, t3b_accessible_priv)