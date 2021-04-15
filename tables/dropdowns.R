# Code to create the drop down menus in the output tables

# Processing ######################################################################################

# table 11
dropdown11_df <- data.frame(c("Adoption", "Divorce", "Domestic Violence", "Financial Remedy", "Private Law", "Public Law"))

# Output ##########################################################################################

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