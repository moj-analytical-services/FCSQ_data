full_t1 <- bind_rows(t1_reg_year, t1_reg_qtr)

# Cases started portion of Table 1
t1_accessible_a <- full_t1 %>% select(Year, Quarter, contains('Cases started')) %>% 
  transmute(Year,
            Quarter,
            Stage = 'Cases started',
            `Public Law` = `Public Law Cases started`,
            `Private Law` = `Private Law Cases started`,
            `Matrimonial Matters` = `Matrimonial Matters Cases started`,
            `Financial Remedies` = `Financial Remedy Cases started`,
            `Domestic Violence`= `Domestic Violence Cases started`,
            `Forced Marriage Protection` = `Forced Marriage Protection Cases started`,
            `Female Genital Mutilation`= `Female Genital Mutilation Cases started`,
            `Adoption`= `Adoption Cases started`,
            `Total` = `Total Cases started`)

t1_accessible_b <- full_t1 %>% select(Year, Quarter, contains('Cases closed')) %>% 
  transmute(Year,
            Quarter,
            Stage = 'Cases closed',
            `Public Law` = `Public Law Cases closed`,
            `Private Law` = `Private Law Cases closed`,
            `Matrimonial Matters` = `Matrimonial Matters Cases closed`,
            `Financial Remedies` = `Financial Remedy Cases closed`,
            `Domestic Violence`= `Domestic Violence Cases closed`,
            `Forced Marriage Protection` = `Forced Marriage Protection Cases closed`,
            `Female Genital Mutilation`= `Female Genital Mutilation Cases closed`,
            `Adoption`= `Adoption Cases closed`,
            `Total` = `Total Cases closed`)

# Adding NA. These tend to remain the same quarter on quarter

# Categories with NA before 2011. This is Public Law, Private Law, Domestic Violence, Adoption and Total
t1_na_2011 <- c(4, 5, 8, 11, 12)

# Adding the NA values for the categories to be replaced later
t1_accessible <- bind_rows(t1_accessible_a, t1_accessible_b) %>% 
  mutate(across(all_of(t1_na_2011), function(x){
    case_when(Year < 2011 ~ na_value,
              TRUE ~ x)
  }
  )) %>%
  mutate(`Forced Marriage Protection` = case_when(Year < 2009 ~ na_value,
                                                  TRUE ~ `Forced Marriage Protection`),
         `Female Genital Mutilation` = case_when((Year < 2015) | (Year == 2015 & Quarter %in% c('Q1', 'Q2')) ~ na_value,
                                                 TRUE ~ `Female Genital Mutilation`)) %>% 
  mutate(Quarter = replace_na(Quarter, 'Annual')) %>% 
  mutate(`Adoption` = case_when(
      (Stage == 'Cases started' & (Year == 2022 & Quarter %in% c('Annual', 'Q4') ) ) |
        (Stage == 'Cases started' & Year > 2022) | (Stage == 'Cases closed' & Year > 2022) ~ na_value,
      TRUE ~ `Adoption`),
    
    `Total` = case_when(
      (Stage == 'Cases started' & (Year == 2022 & Quarter %in% c('Annual', 'Q4') ) ) |
        (Stage == 'Cases started' & Year > 2022) | (Stage == 'Cases closed' & Year > 2022) ~ na_value,
      TRUE ~ `Total`))
  
