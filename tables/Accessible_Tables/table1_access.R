full_t1 <- bind_rows(table1_pivot_annual, table1_pivot_qtr)

# Cases started portion of Table 1
t1_accessible_a <- full_t1 %>% select(Year, Quarter, contains('Cases started')) %>% 
  transmute(Year,
            Quarter,
            Stage = 'Cases started',
            `Public Law` = `Public Law Cases started`,
            `Private Law` = `Private Law Cases started`,
            `Matrinomial Matters` = `Matrinomial Matters Cases started`,
            `Financial Remedy` = `Financial Remedy Cases started`,
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
            `Matrinomial Matters` = `Matrinomial Matters Cases closed`,
            `Financial Remedy` = `Financial Remedy Cases closed`,
            `Domestic Violence`= `Domestic Violence Cases closed`,
            `Forced Marriage Protection` = `Forced Marriage Protection Cases closed`,
            `Female Genital Mutilation`= `Female Genital Mutilation Cases closed`,
            `Adoption`= `Adoption Cases closed`,
            `Total` = `Total Cases closed`)

t1_accessible <- bind_rows(t1_accessible_a, t1_accessible_b)