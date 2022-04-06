# Code to create the drop down menus in the output tables

# Processing ######################################################################################

# table 10
dropdown10_df <- data.frame(c("Adoption", "Divorce (incl. annulment and FR)", "Domestic Violence", "Financial Remedy", "Private Law", "Public Law"))

# table 11
dropdown11_df <- data.frame(c("Adoption", "Divorce (incl. FR)", "Domestic Violence", "Financial Remedy", "Private Law", "Public Law"))

#table 16
dropdown16_df <- tibble(c('All', 'Exparte', 'On notice'))
# Output ##########################################################################################

# table 10
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
# table 11
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
# table 16
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