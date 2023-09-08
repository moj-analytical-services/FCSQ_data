# NAs are stripped when read in R so need to be put back afterwards
# Adding source for Table 3 and 4

table_3_lookup <- table_3_lookup %>% mutate(across(where(is.numeric), ~replace_na(.x, na_value)))
openxlsx::writeData(wb = template,
                    sheet = 'Table 3_4_source',
                    x = table_3_lookup)

na_formatter(wb = template,
             sheet = 'Table 3_4_source',
             table = table_3_lookup,
             value = ":",
             startRow = 2,
             na_value = na_value)

# Adding source for Table 10
table_10_lookup <- table_10_lookup %>% mutate(across(where(is.numeric), ~replace_na(.x, na_value)))
openxlsx::writeData(wb = template,
                    sheet = 'Table_10_source',
                    x = table_10_lookup)

na_formatter(wb = template,
             sheet = 'Table_10_source',
             table = table_10_lookup,
             value = "-",
             startRow = 2,
             na_value = na_value)

# Adding source for Table 10
table_10b_lookup <- table_10b_lookup %>% mutate(across(where(is.numeric), ~replace_na(.x, na_value)))
openxlsx::writeData(wb = template,
                    sheet = 'Table_10b_source',
                    x = table_10b_lookup)

na_formatter(wb = template,
             sheet = 'Table_10b_source',
             table = table_10b_lookup,
             value = "-",
             startRow = 2,
             na_value = na_value)

# Adding source for Table 11
table_11_lookup <- table_11_lookup %>% mutate(across(where(is.numeric), ~replace_na(.x, na_value)))
openxlsx::writeData(wb = template,
                    sheet = 'Table_11_source',
                    x = table_11_lookup)

na_formatter(wb = template,
             sheet = 'Table_11_source',
             table = table_11_lookup,
             value = ":",
             startRow = 2,
             na_value = na_value)

# Adding source for Table 12
openxlsx::writeData(wb = template,
                    sheet = 'Table_12_source',
                    x = divorce_t12_input)

# Adding source for Table 12b
# Replacing Divorce and Civil Partnership with All in table for consistency with other tables
divorce_t12b_input_replace <- divorce_t12b_input %>% mutate(Case = str_replace(Case, 'Divorce and Civil Partnership', 'All'))
openxlsx::writeData(wb = template,
                    sheet = 'Table_12b_source',
                    x = divorce_t12b_input_replace)

# Adding source for Table 16
openxlsx::writeData(wb = template,
                    sheet = 'Table_15_source',
                    x = dv_csv)

# Creating and adding source for Table 24
probate_lookup_fill <- probate_lookup %>% mutate(across(where(is.numeric) & !c(Year, Quarter), ~replace_na(.x, na_value)))
openxlsx::writeData(wb = template,
                    sheet = 'Table 23 source',
                    x = probate_lookup_fill)

na_formatter(wb = template,
             sheet = 'Table 23 source',
             table = probate_lookup_fill,
             value = ':',
             startRow = 2,
             skipCols = c(2, 3),
             na_value = na_value)

# Creating and adding source for Table 25
probate_time_lookup <- probate_time_lookup %>% mutate(across(where(is.numeric) & !c(Year, Quarter), ~replace_na(.x, na_value)))
openxlsx::writeData(wb = template,
                    sheet = 'Table 24 source',
                    x = probate_time_lookup)

na_formatter(wb = template,
             sheet = 'Table 24 source',
             table = probate_time_lookup,
             value = ':',
             startRow = 2,
             skipCols = c(2, 3),
             na_value = na_value)