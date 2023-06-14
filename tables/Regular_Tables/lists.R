# Code to create the drop down menus in the output tables

# Processing ######################################################################################

#table 3/4
dropdown3_df <- data.frame(c("Order count", "Children count"))
dropdown4_df <- data.frame(c("Order count", "Children count"))

# table 10
dropdown10_df <- data.frame(c("Adoption", "Old Divorce (incl. annulment and FR)", "Domestic Violence", "Financial Remedy", "Private Law", "Public Law"))

# table 10b
dropdown10b_df <- data.frame(c("All", "Sole", "Joint"))

# table 11
dropdown11_df <- data.frame(c("Adoption", "Divorce (incl. FR)", "Domestic Violence", "Financial Remedy", "Private Law", "Public Law"))

# table 12
dropdown12a_df <- tibble(c("All", "Old", "New"))
dropdown12b_df <- tibble(c("All", "Paper", "Digital"))

# table 12b
dropdown12b_a_df <- tibble(c("All", "Joint", "Sole"))
dropdown12b_b_df <- tibble(c("Divorce and Civil Partnership", "Divorce", "Civil Partnership"))

#table 16
dropdown16_df <- tibble(c('All', 'Exparte', 'On notice'))

#table 24
dropdown24a_df <- tibble(c("All", "Paper", "Digital"))
dropdown24b_df <- tibble(c("All", "Personal", "Solicitor"))

#table 25
dropdown25a_df <- tibble(c("All", "Paper", "Digital"))
dropdown25b_df <- tibble(c("All", "Stopped", "Not Stopped"))


# Output ##########################################################################################
# table 3/4 #####################################
# List will be added at BB column - because BA column contains the hidden values
list_add(wb = template,
         sheet = 'Table_3',
         list = dropdown3_df,
         listRow = t3_list_row,
         listCol = t3_list_col,
         startRow = 12,
         startCol = 54)

list_add(wb = template,
         sheet = 'Table_4',
         list = dropdown4_df,
         listRow = t4_list_row,
         listCol = t4_list_col,
         startRow = 12,
         startCol = 54)

# Adding default option for the tables
openxlsx::writeData(wb = template,
                    sheet = 'Table_3',
                    x = 'Order count',
                    startRow = t3_list_row,
                    startCol = t3_list_col)

openxlsx::writeData(wb = template,
                    sheet = 'Table_4',
                    x = 'Order count',
                    startRow = t4_list_row,
                    startCol = t4_list_col)



# table 10 ###############################
list_add(wb = template,
         sheet = 'Table_10',
         list = dropdown10_df,
         listRow = t10_list_row,
         listCol = t10_list_col,
         startRow = t10_start,
         startCol = t10_col_length + 1)

openxlsx::writeData(wb = template,
                    sheet = 'Table_10',
                    x = 'Adoption',
                    startRow = t10_list_row,
                    startCol = t10_list_col)

# table 10b ###############################
list_add(wb = template,
         sheet = 'Table_10b',
         list = dropdown10b_df,
         listRow = t10b_list_row,
         listCol = t10b_list_col,
         startRow = t10b_start,
         startCol = t10b_col_length + 1)

openxlsx::writeData(wb = template,
                    sheet = 'Table_10b',
                    x = 'All',
                    startRow = t10b_list_row,
                    startCol = t10b_list_col)

# table 11 #############################
list_add(wb = template,
         sheet = 'Table_11',
         list = dropdown11_df,
         listRow = t11_list_row,
         listCol = t11_list_col,
         startRow = t11_start,
         startCol = t11_col_length + 1)

openxlsx::writeData(wb = template,
                    sheet = 'Table_11',
                    x = 'Adoption',
                    startRow = t11_list_row,
                    startCol = t11_list_col)

# table 12 ######################
list_add(wb = template,
         sheet = 'Table_12',
         list = dropdown12a_df,
         listRow = t12_list_a_row,
         listCol = t12_list_col,
         startRow = t12_start,
         startCol = ncol(t12_reg_year) + 1)

list_add(wb = template,
         sheet = 'Table_12',
         list = dropdown12b_df,
         listRow = t12_list_b_row,
         listCol = t12_list_col,
         startRow = t12_start,
         startCol = ncol(t12_reg_year) + 2)

openxlsx::writeData(wb = template,
                    sheet = 'Table_12',
                    x = 'All',
                    startRow = t12_list_a_row,
                    startCol = t12_list_col)

openxlsx::writeData(wb = template,
                    sheet = 'Table_12',
                    x = 'All',
                    startRow = t12_list_b_row,
                    startCol = t12_list_col)

# table 12b ######################
list_add(wb = template,
         sheet = 'Table_12b',
         list = dropdown12b_a_df,
         listRow = t12b_list_a_row,
         listCol = t12b_list_col,
         startRow = t12b_start,
         startCol = ncol(t12b_reg_qtr) + 1)

list_add(wb = template,
         sheet = 'Table_12b',
         list = dropdown12b_b_df,
         listRow = t12b_list_b_row,
         listCol = t12b_list_col,
         startRow = t12b_start,
         startCol = ncol(t12b_reg_qtr) + 2)

openxlsx::writeData(wb = template,
                    sheet = 'Table_12b',
                    x = 'All',
                    startRow = t12b_list_a_row,
                    startCol = t12b_list_col)

openxlsx::writeData(wb = template,
                    sheet = 'Table_12b',
                    x = 'Divorce and Civil Partnership',
                    startRow = t12b_list_b_row,
                    startCol = t12b_list_col)

# table 16 ###################
list_add(wb = template,
         sheet = 'Table_15',
         list = dropdown16_df,
         listRow = t16_list_row,
         listCol = t16_list_col,
         startRow = t16_start,
         startCol = ncol(dv_qtr) + 1)

openxlsx::writeData(wb = template,
                    sheet = 'Table_15',
                    x = 'All',
                    startRow = t16_list_row,
                    startCol = t16_list_col)


# table 24 ###################
list_add(wb = template,
         sheet = 'Table_23',
         list = dropdown24a_df,
         listRow = t24_list_a_row,
         listCol = t24_list_col,
         startRow = t24_start,
         startCol = ncol(t24_reg_year) + 1)


list_add(wb = template,
         sheet = 'Table_23',
         list = dropdown24b_df,
         listRow = t24_list_b_row,
         listCol = t24_list_col,
         startRow = t24_start,
         startCol = ncol(t24_reg_year) + 2)

openxlsx::writeData(wb = template,
                    sheet = 'Table_23',
                    x = 'All',
                    startRow = t24_list_a_row,
                    startCol = t24_list_col)

openxlsx::writeData(wb = template,
                    sheet = 'Table_23',
                    x = 'All',
                    startRow = t24_list_b_row,
                    startCol = t24_list_col)

# table 25 ###################
list_add(wb = template,
         sheet = 'Table_24',
         list = dropdown25a_df,
         listRow = t25_list_a_row,
         listCol = t25_list_col,
         startRow = t25_start,
         startCol = ncol(t25_reg_year) + 1)


list_add(wb = template,
         sheet = 'Table_24',
         list = dropdown25b_df,
         listRow = t25_list_b_row,
         listCol = t25_list_col,
         startRow = t25_start,
         startCol = ncol(t25_reg_year) + 2)

openxlsx::writeData(wb = template,
                    sheet = 'Table_24',
                    x = 'All',
                    startRow = t25_list_a_row,
                    startCol = t25_list_col)

openxlsx::writeData(wb = template,
                    sheet = 'Table_24',
                    x = 'All',
                    startRow = t25_list_b_row,
                    startCol = t25_list_col)
