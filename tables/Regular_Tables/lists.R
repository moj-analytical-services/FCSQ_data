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
dropdown12_df <- data.frame(c("All", "Paper", "Digital"))

#table 16
dropdown16_df <- tibble(c('All', 'Exparte', 'On notice'))

#table 24
dropdown24a_df <- tibble(c("All", "Paper", "Digital"))
dropdown24b_df <- tibble(c("All", "Personal", "Solictor"))
# Output ##########################################################################################
# table 3/4 #####################################
openxlsx::writeData(wb = template,
                    sheet = 'Table_3',
                    x = dropdown3_df,
                    startRow = 12,
                    startCol = 37,
                    colNames = F)

openxlsx::writeData(wb = template,
                    sheet = 'Table_4',
                    x = dropdown4_df,
                    startRow = 12,
                    startCol = 37,
                    colNames = F)

openxlsx::addStyle(wb = template,
                   sheet = 'Table_3',
                   openxlsx::createStyle(fontColour = "white"),
                   rows = 12:13,
                   cols = 37,
                   stack = T,
                   gridExpand = T)

openxlsx::addStyle(wb = template,
                   sheet = 'Table_4',
                   openxlsx::createStyle(fontColour = "white"),
                   rows = 12:13,
                   cols = 37,
                   stack = T,
                   gridExpand = T)

dataValidation(wb = template,
               sheet = 'Table_3',
               cols = 1,
               rows = 7,
               type = "list",
               value = "'Table_3'!$AK$12:$AK$13")

dataValidation(wb = template,
               sheet = 'Table_4',
               cols = 1,
               rows = 7,
               type = "list",
               value = "'Table_4'!$AK$12:$AK$13")
# table 10 ###############################
openxlsx::writeData(wb = template,
                    sheet = 'Table_10',
                    x = dropdown10_df,
                    startRow = 12,
                    startCol = 18,
                    colNames = F)

openxlsx::addStyle(wb = template,
                   sheet = 'Table_10',
                   openxlsx::createStyle(fontColour = "white"),
                   rows = 12:17,
                   cols = 18,
                   stack = T,
                   gridExpand = T)

dataValidation(wb = template,
               sheet = 'Table_10',
               cols = 2,
               rows = 6,
               type = "list",
               value = "'Table_10'!$R$12:$R$17")
# table 11 #############################
openxlsx::writeData(wb = template,
                    sheet = 'Table_11',
                    x = dropdown11_df,
                    startRow = 11,
                    startCol = 14,
                    colNames = F)

openxlsx::addStyle(wb = template,
                   sheet = 'Table_11',
                   openxlsx::createStyle(fontColour = "white"),
                   rows = 11:16,
                   cols = 14,
                   stack = T,
                   gridExpand = T)

dataValidation(wb = template,
               sheet = 'Table_11',
               cols = 2,
               rows = 6,
               type = "list",
               value = "'Table_11'!$N$11:$N$16")

# table 12 ######################
openxlsx::writeData(wb = template,
                    sheet = 'Table_12',
                    x = dropdown12_df,
                    startRow = 12,
                    startCol = 22,
                    colNames = F)

openxlsx::addStyle(wb = template,
                   sheet = 'Table_12',
                   openxlsx::createStyle(fontColour = "white"),
                   rows = 12:14,
                   cols = 22,
                   stack = T,
                   gridExpand = T)

dataValidation(wb = template,
               sheet = 'Table_12',
               cols = 2,
               rows = 7,
               type = "list",
               value = "'Table_12'!$V$12:$V$14")
# table 16 ###################
openxlsx::writeData(wb = template,
                    sheet = 'Table_16',
                    x = dropdown16_df,
                    startRow = 10,
                    startCol = 14,
                    colNames = F)

openxlsx::addStyle(wb = template,
                   sheet = 'Table_16',
                   openxlsx::createStyle(fontColour = "white"),
                   rows = 10:12,
                   cols = 14,
                   stack = T,
                   gridExpand = T)

dataValidation(wb = template,
               sheet = 'Table_16',
               cols = 2,
               rows = 6,
               type = "list",
               value = "'Table_16'!$N$10:$N$12")

# table 24 ###################
list_add(wb = template,
         sheet = 'Table_24',
         list = dropdown24a_df,
         listRow = 6,
         listCol = 3,
         startRow = 12,
         startCol = 16)


list_add(wb = template,
         sheet = 'Table_24',
         list = dropdown24b_df,
         listRow = 7,
         listCol = 3,
         startRow = 12,
         startCol = 17)


