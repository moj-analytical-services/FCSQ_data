#Building the information needed for Table 1. This is cases started and cases closed data for each family category.
#Childrens Act
ca_cases <- child_act_csv %>% group_by(Year, Qtr, Type, Count_type, Public_private) %>% 
  summarise(Count = sum_na(Count)) %>% ungroup() %>% filter(Type == 'Cases') %>% mutate(Qtr = as.numeric(Qtr))

pub_case_close <- ca_cases %>% filter(Public_private == 'Public law', Count_type == 'Cases closed') %>% 
  transmute(Category = 'Public Law', Year = Year, Quarter = Qtr, Stage = 'Cases closed', Count = Count)

pub_case_start <- ca_cases %>% filter(Public_private == 'Public law', Count_type == 'Cases starting') %>% 
  transmute(Category = 'Public Law', Year = Year, Quarter = Qtr, Stage = 'Cases started', Count = Count)

priv_case_close <- ca_cases %>% filter(Public_private == 'Private law', Count_type == 'Cases closed') %>% 
  transmute(Category = 'Private Law', Year = Year, Quarter = Qtr, Stage = 'Cases closed', Count = Count)

priv_case_start <- ca_cases %>% filter(Public_private == 'Private law', Count_type == 'Cases starting') %>% 
  transmute(Category = 'Private Law', Year = Year, Quarter = Qtr, Stage = 'Cases started', Count = Count)

ca_part <- bind_rows(pub_case_start, pub_case_close, priv_case_start, priv_case_close)

#Financial Remedy
fr_cases <- fr_csv %>% group_by(Year, Qtr, Type) %>% summarise(Count = sum_na(Count)) %>% 
  ungroup()

fr_case_start <- fr_csv %>% filter(Type == 'Cases started') %>% 
  transmute(Category = 'Financial Remedy', Year = Year, Quarter = Qtr, Stage = 'Cases started', Count = Count)

fr_case_close <- fr_csv %>% filter(Type == 'Cases closed') %>% 
  transmute(Category = 'Financial Remedy', Year = Year, Quarter = Qtr, Stage = 'Cases closed', Count = Count)

fr_part <- bind_rows(fr_case_close, fr_case_start)

#Adoption
adopt_case <- adopt_csv %>% group_by(Year,Quarter,Type) %>% summarise(Count = sum_na(Count)) %>% 
  ungroup()

adopt_case_start <- adopt_case %>% filter(Type == 'Cases started') %>% 
  transmute(Category = 'Adoption', Year = Year, Quarter = Quarter, Stage = 'Cases started', Count = Count)

adopt_case_close <- adopt_case %>% filter(Type == 'Cases closed') %>% 
  transmute(Category = 'Adoption', Year = Year, Quarter = Quarter, Stage = 'Cases closed', Count = Count)

adopt_part <- bind_rows(adopt_case_start, adopt_case_close)

#Divorce
divorce_case <- divorce_csv %>% group_by(Year, Quarter, Type) %>% summarise(Count = sum_na(Count)) %>% 
  ungroup()

divorce_case_start <- divorce_case %>% filter(Type == 'Petitions') %>% 
  transmute(Category = 'Matrimonial Matters', Year = Year, Quarter = Quarter, Stage = 'Cases started', Count = Count)

divorce_group <- divorce_csv %>% group_by(Year, Quarter, Order_type) %>% summarise(Count = sum_na(Count)) %>% ungroup()
d1 <- divorce_group %>% filter(Order_type == 'Decree Absolute')
d2 <- divorce_group %>% filter(Order_type == 'Judicial Separations Granted')
d_combine <- d1 %>% inner_join(d2, by = c('Year', 'Quarter'))
divorce_case_close <- d_combine %>% 
  transmute(Category = 'Matrimonial Matters', Year = Year, Quarter = Quarter, Stage = 'Cases closed', Count = Count.x + Count.y)

divorce_part <- bind_rows(divorce_case_start, divorce_case_close)

#Domestic Violence
#Remember to change for future addition of only Domestic Violence cases
dv_case <- dv_csv %>% group_by(Year, Quarter, Type) %>% summarise(Count = sum_na(Total)) %>% ungroup()
dv_case_start <- dv_case %>% filter(Type == 'Cases started') %>% 
  transmute(Category = 'Domestic Violence', Year = Year, Quarter = Quarter, Stage = 'Cases started', Count = Count)

dv_case_close <- dv_case %>% filter(Type == 'Cases concluded') %>% 
  transmute(Category = 'Domestic Violence', Year = Year, Quarter = Quarter, Stage = 'Cases closed', Count = Count)

dv_part <- bind_rows(dv_case_start, dv_case_close)


#FMPO. Years before 2009 are filtered for Table 1

fmpo_case <- fmpo_csv %>% group_by(Year, Quarter, Type) %>% summarise(Count = sum_na(Total)) %>% ungroup()

fmpo_case_start <- fmpo_case %>% filter(Type == 'Cases started', Year > 2008) %>% 
  transmute(Category = 'Forced Marriage Protection', Year = Year, Quarter = Quarter, Stage = 'Cases started', Count = Count)

fmpo_case_close <- fmpo_case %>% filter(Type == 'Cases concluded', Year > 2008) %>% 
  transmute(Category = 'Forced Marriage Protection', Year = Year, Quarter = Quarter, Stage = 'Cases closed', Count = Count)

#FGMPO
fgmpo_case <- fgm_csv %>% group_by(Year, Quarter, Type) %>% summarise(Count = sum_na(Total)) %>% ungroup()

fgmpo_case_start <- fgmpo_case %>% filter(Type == 'Cases started', Year > 2010) %>% 
  transmute(Category = 'Female Genital Mutilation', Year = Year, Quarter = Quarter, Stage = 'Cases started', Count = Count)

fgmpo_case_close <- fgmpo_case %>% filter(Type == 'Cases concluded', Year > 2010) %>% 
  transmute(Category = 'Female Genital Mutilation', Year = Year, Quarter = Quarter, Stage = 'Cases closed', Count = Count)


fgm_fmpo_part <- bind_rows(fmpo_case_start, fmpo_case_close, fgmpo_case_start, fgmpo_case_close)

#Preparing Table 1
table_1_prep <- bind_rows(ca_part, divorce_part, fr_part, dv_part, fgm_fmpo_part, adopt_part)
all_cases <- table_1_prep %>% group_by(Year, Quarter, Stage) %>% summarise(Count = sum_na(Count)) %>% ungroup()
all_cases_prep <- all_cases %>% filter(Year > 2010) %>% transmute(Category = 'Total', Year = Year, Quarter = Quarter, 
                                                                  Stage = Stage, Count = Count)

table_1_alt <-  bind_rows(table_1_prep, all_cases_prep)
