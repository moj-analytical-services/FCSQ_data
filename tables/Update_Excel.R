

# Import ##########################################################################################

# template Excel sheet
options(digits = 15) # Set the number of significant figure to 15 (same as excel)

# Turn off summarise warnings
options(dplyr.summarise.inform = FALSE)
path <- "styles_pub.xlsx"
xltabr::set_style_path(paste0(path_to_project,path))
xltabr::set_cell_format_path(paste0(path_to_project,"number_formats.csv"))

#xltabr::set_style_path()
#xltabr::set_cell_format_path()
template <- openxlsx::loadWorkbook(file=paste0(path_to_project, "My template.xlsx"))
#template <- openxlsx::loadWorkbook(file=paste0(path_to_project, "FCSQ Template.xlsx"))

#download_file_from_s3("alpha-family-data/Tables/2021 Q4 Template.xls", paste0(path_to_project, "template.xlsx"), overwrite = TRUE)
#template <- openxlsx::loadWorkbook(file=paste0(path_to_project, "template.xlsx"))
# Editing #########################################################################################
# data is used for source data where needed for tables with drop downs
# table is used for the table itself


source(paste0(path_to_project, "functions.R"))
source(paste0(path_to_project, "index.R"))

# notes
source(paste0(path_to_project, "footnotes.R"))

# tables
source(paste0(path_to_project, "table_1_change.R"))
source(paste0(path_to_project, "Regular_Tables/table1_reg.R"))

#No Formula Tables
source(paste0(path_to_project, "Regular_Tables/table2_reg.R"))
source(paste0(path_to_project, "Regular_Tables/table5_reg.R"))
source(paste0(path_to_project, "Regular_Tables/table6_reg.R"))
source(paste0(path_to_project, "Regular_Tables/table7_reg.R"))
source(paste0(path_to_project, "Regular_Tables/table8_reg.R"))
source(paste0(path_to_project, "Regular_Tables/table9_reg.R"))
source(paste0(path_to_project, "Regular_Tables/table13_reg.R"))
source(paste0(path_to_project, "Regular_Tables/table14_reg.R"))
source(paste0(path_to_project, "Regular_Tables/table15.R"))
source(paste0(path_to_project, "Regular_Tables/table17_reg.R"))
source(paste0(path_to_project, "Regular_Tables/table18_reg.R"))
source(paste0(path_to_project, "Regular_Tables/table19_reg.R"))
source(paste0(path_to_project, "Regular_Tables/table20_reg.R"))
source(paste0(path_to_project, "Regular_Tables/table21_22_reg.R"))
source(paste0(path_to_project, "Regular_Tables/table23_reg.R"))


#Formula cols
source(paste0(path_to_project, "Regular_Tables/table3_reg.R"))
source(paste0(path_to_project, "Regular_Tables/table4_reg.R"))
source(paste0(path_to_project, "Regular_Tables/table10_reg.R"))
source(paste0(path_to_project, "Regular_Tables/table11_reg.R"))
source(paste0(path_to_project, "Regular_Tables/table12_reg.R"))
source(paste0(path_to_project, "Regular_Tables/table16_reg.R"))
source(paste0(path_to_project, "Regular_Tables/table24_reg.R"))
source(paste0(path_to_project, "Regular_Tables/table25_reg.R"))



# dropdowns
source(paste0(path_to_project, "Regular_Tables/lists.R"))

####################################################################
#Summary Tables
#Table 1

####################################################################

openxlsx::writeData(wb = template,
                    sheet = 'Table_1',
                    x = timeperiod1,
                    startRow = 3,
                    colNames = F)

# data
t1_start <- 7

# Adjusting row height for notes. Actual footnotes do not start until row 5 
t1_note_heights <- rep(14.3, length(notes1))
t1_note_heights[6] = 21
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_1', 
                      tables = list(table1_pivot_annual, table1_pivot_qtr), 
                      notes = notes1, 
                      starting_row = t1_start, 
                      quarterly_format = c(2),
                      note_row_heights = t1_note_heights)

# Adding expressions for missing values. As these are strings they have to be added separately from the numbers
na_cols <- c(3, 4, 7, 10, 11, 13, 14, 17, 20, 21)
na_adder(wb = template,
         sheet = 'Table_1',
         value = "-",
         cols = na_cols,
         lengths = rep(5, length(na_cols)),
         start_row = t1_start)

na_cols_fmpo_fgm <- c(8, 9, 18, 19)
na_adder(wb = template,
         sheet = 'Table_1',
         value = "..",
         cols = na_cols_fmpo_fgm,
         lengths = c(3, 9, 3, 9),
         start_row = t1_start)

na_adder(wb = template,
         sheet = 'Table_1',
         value = "..",
         cols = c(9, 19),
         lengths = c(18, 18),
         start_row = t1_start + nrow(table1_pivot_annual))
####################################################################
#Children Act Summary
#Table 2

####################################################################

openxlsx::writeData(wb = template,
                    sheet = 'Table_2',
                    x = timeperiod2,
                    startRow = 3,
                    colNames = F)

# data
t2_start <- 9
t2_note_heights <- rep(14.3, length(notes2))
t2_note_heights[5] = 21.8

write_formatted_table(workbook = template, 
                      sheet_name = 'Table_2', 
                      tables = list(t2_reg_year, t2_reg_qtr), 
                      notes = notes2, 
                      starting_row = t2_start, 
                      quarterly_format = c(2),
                      note_row_heights = t2_note_heights)

####################################################################
#Children Act Individual children
#Table 5

####################################################################
t5_start <- 8

openxlsx::writeData(wb = template,
                    sheet = 'Table_5',
                    x = timeperiod5,
                    startRow = 3,
                    colNames = F)

# data
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_5', 
                      tables = list(t5_reg_year, t5_reg_qtr), 
                      notes = notes5, 
                      starting_row = t5_start, 
                      quarterly_format = c(2))

####################################################################
#Children Act Parties
#Table 6

####################################################################
t6_start <- 8
openxlsx::writeData(wb = template,
                    sheet = 'Table_6',
                    x = timeperiod6,
                    startRow = 3,
                    colNames = F)

# data
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_6', 
                      tables = list(t6_reg_year, t6_reg_qtr), 
                      notes = notes2, 
                      starting_row = 8, 
                      quarterly_format = c(2))

####################################################################
#Children Act High Court
#Table 7

####################################################################
t7_start <- 8

openxlsx::writeData(wb = template,
                    sheet = 'Table_7',
                    x = timeperiod7,
                    startRow = 3,
                    colNames = F)

# data
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_7', 
                      tables = list(t7_reg_year, t7_reg_qtr), 
                      notes = notes2, 
                      starting_row = t7_start, 
                      quarterly_format = c(2))

####################################################################
#Care and Supervision
#Table 8

####################################################################
t8_start <- 6
openxlsx::writeData(wb = template,
                    sheet = 'Table_8',
                    x = timeperiod8,
                    startRow = 3,
                    colNames = F)

# data
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_8', 
                      tables = list(t8_reg_year, t8_reg_qtr), 
                      notes = notes8, 
                      starting_row = t8_start, 
                      quarterly_format = c(2))

####################################################################
#Private Law Disposal
#Table 9

####################################################################
t9_start <- 6
openxlsx::writeData(wb = template,
                    sheet = 'Table_9',
                    x = timeperiod9,
                    startRow = 3,
                    colNames = F)

# data
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_9', 
                      tables = list(t9_reg_year, t9_reg_qtr), 
                      notes = notes9, 
                      starting_row = t9_start, 
                      quarterly_format = c(2))
####################################################################
#Matrimonial matters proceedings
#Table 12

####################################################################

openxlsx::writeData(wb = template,
                    sheet = 'Table_12',
                    x = timeperiod12,
                    startRow = 3,
                    colNames = F)

# data
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_12', 
                      tables = list(t12_reg_year, t12_reg_qtr), 
                      notes = notes12, 
                      starting_row = t12_start, 
                      quarterly_format = c(2))

na_adder(wb = template,
         sheet = 'Table_12',
         value = ".",
         cols = c(6, 7, 9, 10),
         lengths = rep(3, 4),
         start_row = t12_start)

####################################################################
#Divorce Progression
#Table 13

####################################################################
t13_start <- 9
openxlsx::writeData(wb = template,
                    sheet = 'Table_13',
                    x = timeperiod13,
                    startRow = 3,
                    colNames = F)

# data
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_13', 
                      tables = list(t13_reg_year, t13_reg_qtr), 
                      notes = notes13, 
                      starting_row = t13_start, 
                      quarterly_format = c(2))

####################################################################
#Divorce Progression Percentages
#Table 14

####################################################################
t14_start <- 7
openxlsx::writeData(wb = template,
                    sheet = 'Table_14',
                    x = timeperiod14,
                    startRow = 3,
                    colNames = F)

# data
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_14', 
                      tables = list(t14_reg), 
                      notes = notes14, 
                      starting_row = t14_start, 
                      quarterly_format = c(2))
####################################################################
#Financial Remedy
#Table 15

####################################################################
t15_start <- 7
openxlsx::writeData(wb = template,
                    sheet = 'Table_15',
                    x = timeperiod15,
                    startRow = 3,
                    colNames = F)

# data
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_15', 
                      tables = list(t15_year, t15_qtr), 
                      notes = notes15, 
                      starting_row = t15_start, 
                      quarterly_format = c(2))

####################################################################
#Domestic Violence
#Table 16

####################################################################

openxlsx::writeData(wb = template,
                    sheet = 'Table_16',
                    x = timeperiod15,
                    startRow = 3,
                    colNames = F)

# data
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_16', 
                      tables = list(dv_hard_code, dv_year, dv_hard_code_qtr, dv_qtr), 
                      notes = notes16, 
                      starting_row = t16_start, 
                      quarterly_format = c(3, 4))

####################################################################
#Forced Marriage Protection Orders
#Table 17

####################################################################

openxlsx::writeData(wb = template,
                    sheet = 'Table_17',
                    x = timeperiod17,
                    startRow = 3,
                    colNames = F)

# data
t17_start <- 8
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_17', 
                      tables = list(t17_reg_year, t17_reg_qtr_a, t17_reg_qtr_b), 
                      notes = notes17, 
                      starting_row = t17_start, 
                      quarterly_format = c(2, 3))

# Removing unnecessary border lines
openxlsx::addStyle(wb = template,
                   sheet = 'Table_17',
                   style = openxlsx::createStyle(
                     border = "top",
                     borderStyle = "none"),
                   rows = t17_start + nrow(t17_reg_year) + nrow(t17_reg_qtr_a),
                   cols = ncol(t17_reg_year),
                   stack = T,
                   gridExpand = T)



# adding all the nas for this table
fmpo_dash_columns <- c(3, 4, 7, 8, 9, 10)
na_adder(wb = template,
         sheet = 'Table_17',
         value = "-",
         cols = fmpo_dash_columns,
         lengths = rep(1, length(fmpo_dash_columns)),
         start_row = t17_start)

na_adder(wb = template,
         sheet = 'Table_17',
         value = "-",
         cols = fmpo_dash_columns,
         lengths = rep(5, length(fmpo_dash_columns)),
         start_row = t17_start + nrow(t17_reg_year))

fmpo_dot_columns <- c(14, 15)
na_adder(wb = template,
         sheet = 'Table_17',
         value = "..",
         cols = fmpo_dot_columns,
         lengths = rep(annual_year - 2013, length(fmpo_dot_columns)),
         start_row = t17_start + 5)

na_adder(wb = template,
         sheet = 'Table_17',
         value = "..",
         cols = fmpo_dot_columns,
         lengths = rep(nrow(t17_reg_qtr) - 23, length(fmpo_dot_columns)),
         start_row = t17_start + nrow(t17_reg_year) + 23)

####################################################################
#Female Genital Mutilation Protection Orders
#Table 18

####################################################################

openxlsx::writeData(wb = template,
                    sheet = 'Table_18',
                    x = timeperiod18,
                    startRow = 3,
                    colNames = F)

# data
t18_start <- 8
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_18', 
                      tables = list(t18_reg_year, t18_reg_qtr_a, t18_reg_qtr_b), 
                      notes = notes18, 
                      starting_row = t18_start, 
                      quarterly_format = c(2, 3))

# Removing unnecessary border lines
openxlsx::addStyle(wb = template,
                   sheet = 'Table_18',
                   style = openxlsx::createStyle(
                     border = "top",
                     borderStyle = "none"),
                   rows = t18_start + nrow(t18_reg_year) + nrow(t18_reg_qtr_a),
                   cols = ncol(t18_reg_year),
                   stack = T,
                   gridExpand = T)

####################################################################
#Adoption Applications
#Table 19

####################################################################
openxlsx::writeData(wb = template,
                    sheet = 'Table_19',
                    x = timeperiod19,
                    startRow = 3,
                    colNames = F)

# data
t19_start <- 8
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_19', 
                      tables = list(t19_reg_year, t19_reg_qtr), 
                      notes = notes19, 
                      starting_row = t19_start, 
                      quarterly_format = c(2))

####################################################################
#Adoption Orders
#Table 20

####################################################################

openxlsx::writeData(wb = template,
                    sheet = 'Table_20',
                    x = timeperiod20,
                    startRow = 3,
                    colNames = F)

# data
t20_start <- 8
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_20', 
                      tables = list(t20_reg_year, t20_reg_qtr), 
                      notes = notes20, 
                      starting_row = t20_start, 
                      quarterly_format = c(2))


####################################################################
#Applications under the Mental Capacity Act
#Table 21

####################################################################

openxlsx::writeData(wb = template,
                    sheet = 'Table_21',
                    x = timeperiod21,
                    startRow = 4,
                    colNames = F)

# data
t21_start <- 7
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_21', 
                      tables = list(t21_reg_year, t21_reg_qtr), 
                      notes = notes21, 
                      starting_row = t21_start, 
                      quarterly_format = c(2))

# Adding dot to table
na_adder(wb = template,
         sheet = 'Table_21',
         value = "..",
         cols = 16,
         lengths = 1,
         start_row = t21_start)

####################################################################
#Orders under the Mental Capacity Act
#Table 22

####################################################################

openxlsx::writeData(wb = template,
                    sheet = 'Table_22',
                    x = timeperiod22,
                    startRow = 4,
                    colNames = F)

# data
t22_start <- 7
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_22', 
                      tables = list(t22_reg_year, t22_reg_qtr), 
                      notes = notes22, 
                      starting_row = t22_start, 
                      quarterly_format = c(2))

# Adding dot to table
na_adder(wb = template,
         sheet = 'Table_22',
         value = "..",
         cols = 16,
         lengths = 1,
         start_row = t22_start)

####################################################################
#OPG
#Table 23

####################################################################

openxlsx::writeData(wb = template,
                    sheet = 'Table_23',
                    x = timeperiod23,
                    startRow = 4,
                    colNames = F)

# data
t23_start <- 9
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_23', 
                      tables = list(t23_reg_year, t23_reg_qtr), 
                      notes = notes23, 
                      starting_row = t23_start, 
                      quarterly_format = c(2))

# Adding stars to table
na_formatter(wb = template,
             sheet = 'Table_23',
             table = full_t23,
             value = '*',
             startRow = t23_start)


####################################################################
#Probate
#Table 24

####################################################################

openxlsx::writeData(wb = template,
                    sheet = 'Table_24',
                    x = timeperiod24,
                    startRow = 4,
                    colNames = F)

# data
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_24', 
                      tables = list(t24_reg_year, t24_reg_qtr_a, t24_reg_qtr_b), 
                      notes = notes24, 
                      starting_row = t24_start, 
                      quarterly_format = c(2, 3))

# Applications made NA
na_adder(wb = template,
         sheet = 'Table_24',
         value = "-",
         cols = c(3, 4, 5),
         lengths = rep(7, 3),
         start_row = t24_start)

# Contested Probate NA
na_adder(wb = template,
         sheet = 'Table_24',
         value = "-",
         cols = 15,
         lengths = nrow(t24_reg_qtr_a) + nrow(t24_reg_qtr_b),
         start_row = t24_start + nrow(t24_reg_year))

####################################################################
#Probate Timeliness
#Table 25

####################################################################

openxlsx::writeData(wb = template,
                    sheet = 'Table_25',
                    x = timeperiod25,
                    startRow = 4,
                    colNames = F)

# data
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_25', 
                      tables = list(t25_reg_year, t25_reg_qtr_a, t25_reg_qtr_b), 
                      notes = notes25, 
                      starting_row = t25_start, 
                      quarterly_format = c(2, 3))

# 2019 Q2 NA
# Everything before All Grants is NA
probate_time_na_columns <- setdiff(seq(from = 3, to = 23), probate_time_blank_cols)
na_adder(wb = template,
         sheet = 'Table_25',
         value = ":",
         cols = probate_time_na_columns,
         lengths = rep(1, length(probate_time_na_columns)),
         start_row = t25_start + nrow(t25_reg_year))

# Export ##########################################################################################

openxlsx::saveWorkbook(template, paste0(path_to_project,"test_output.xlsx"), overwrite = TRUE)
