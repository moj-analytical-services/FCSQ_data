# Code to create the drop down menus in the output tables

# Processing ######################################################################################

#table 3/4
dropdown3_df <- data.frame(c("Order count", "Children count"))
dropdown4_df <- data.frame(c("Order count", "Children count"))

# table 10
dropdown10_df <- data.frame(c("Adoption", "Divorce (incl. annulment and FR)", "Domestic Violence", "Financial Remedy", "Private Law", "Public Law"))

# table 11
dropdown11_df <- data.frame(c("Adoption", "Divorce (incl. FR)", "Domestic Violence", "Financial Remedy", "Private Law", "Public Law"))

# table 12
dropdown12a_df <- data.frame(c("All", "Old", "New"))
dropdown12b_df <- data.frame(c("All", "Paper", "Digital"))

# table 12b
dropdown12ba_df <- data.frame(c("All", "Joint", "Sole"))
dropdown12bb_df <- data.frame(c("Divorce", "Civil Partnership", "Both"))

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
# List will be added at BB column
list_add(wb = template,
         sheet = 'Table_3',
         list = dropdown3_df,
         listRow = 7,
         listCol = 1,
         startRow = 12,
         startCol = 54)

list_add(wb = template,
         sheet = 'Table_4',
         list = dropdown4_df,
         listRow = 7,
         listCol = 1,
         startRow = 12,
         startCol = 54)



# table 10 ###############################
list_add(wb = template,
         sheet = 'Table_10',
         list = dropdown10_df,
         listRow = 7,
         listCol = 2,
         startRow = 13,
         startCol = 18)

# table 11 #############################
list_add(wb = template,
         sheet = 'Table_11',
         list = dropdown11_df,
         listRow = 7,
         listCol = 2,
         startRow = 12,
         startCol = 14)

# table 12 ######################
list_add(wb = template,
         sheet = 'Table_12',
         list = dropdown12a_df,
         listRow = t12_list_a_row,
         listCol = t12_list_letter,
         startRow = t12_start,
         startCol = 22)

list_add(wb = template,
         sheet = 'Table_12',
         list = dropdown12b_df,
         listRow = t12_list_b_row,
         listCol = t12_list_letter,
         startRow = t12_start,
         startCol = 22)

# table 12b ######################
list_add(wb = template,
         sheet = 'Table_12b',
         list = dropdown12ba_df,
         listRow = t12b_list_a_row,
         listCol = t12b_list_letter,
         startRow = t12b_start,
         startCol = 22)

list_add(wb = template,
         sheet = 'Table_12b',
         list = dropdown12bb_df,
         listRow = t12b_list_b_row,
         listCol = t12b_list_letter,
         startRow = t12b_start,
         startCol = 22)


# table 16 ###################
list_add(wb = template,
         sheet = 'Table_16',
         list = dropdown16_df,
         listRow = 6,
         listCol = 2,
         startRow = 10,
         startCol = 14)


# table 24 ###################
list_add(wb = template,
         sheet = 'Table_24',
         list = dropdown24a_df,
         listRow = 7,
         listCol = 3,
         startRow = 13,
         startCol = 16)


list_add(wb = template,
         sheet = 'Table_24',
         list = dropdown24b_df,
         listRow = 8,
         listCol = 3,
         startRow = 13,
         startCol = 17)


# table 25 ###################
list_add(wb = template,
         sheet = 'Table_25',
         list = dropdown25a_df,
         listRow = 7,
         listCol = 3,
         startRow = 13,
         startCol = 30)


list_add(wb = template,
         sheet = 'Table_25',
         list = dropdown25b_df,
         listRow = 8,
         listCol = 3,
         startRow = 13,
         startCol = 31)
