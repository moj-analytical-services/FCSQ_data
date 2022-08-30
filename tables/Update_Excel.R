

# Import ##########################################################################################

# template Excel sheet
options(digits = 15) # Set the number of significant figure to 15 (same as excel)

# Turn off summarise warnings
options(dplyr.summarise.inform = FALSE)

# Downloads the template from the s3 bucket. This will be filled in with data
download_file_from_s3(paste0(csv_folder, "FCSQ Template", " ", pub_year, " Q", pub_quarter, ".xlsx"), "tables/FCSQ Template.xlsx", overwrite = TRUE)
template <- openxlsx::loadWorkbook(file=paste0(path_to_project, "FCSQ Template.xlsx"))

#template <- openxlsx::loadWorkbook(file=paste0(path_to_project, "My template.xlsx"))

# Editing #########################################################################################
# data is used for source data where needed for tables with drop downs
# table is used for the table itself

# Fills in time periods for the index page
source(paste0(path_to_project, "index.R"))

# loads the footnotes for each table
source(paste0(path_to_project, "footnotes.R"))

#Formula tables. Formulas are added in the sheet as well using write formula.
source(paste0(path_to_project, "Regular_Tables/table3_reg.R"))
source(paste0(path_to_project, "Regular_Tables/table4_reg.R"))
source(paste0(path_to_project, "Regular_Tables/table10_reg.R"))
source(paste0(path_to_project, "Regular_Tables/table11_reg.R"))

# Now data frames for the non formula tables are added into the excel workbook.
# Any not applicable and suppressed values are also added here.
# tables
#None Formula Tables - These tables don't contain formulas so the scripts just create the data frames containing the data
####################################################################
#Summary Tables
#Table 1

####################################################################
# Loading the data source
source(paste0(path_to_project, "table_1_change.R"))
source(paste0(path_to_project, "Regular_Tables/table1_reg.R"))

# Writing the time period
openxlsx::writeData(wb = template,
                    sheet = 'Table_1',
                    x = timeperiod1,
                    startRow = 3,
                    colNames = F)

# the start row of the data
t1_start <- 7

# Adjusting row height for notes. Actual footnotes do not start until row 5 
t1_note_heights <- rep(14.3, length(notes1))
t1_note_heights[6] = 23.25

# Writing the data and notes into the template
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_1', 
                      tables = list(t1_reg_year, t1_reg_qtr), 
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
         start_row = t1_start + nrow(t1_reg_year))


####################################################################
#Children Act Summary
#Table 2

####################################################################
# Load the data
source(paste0(path_to_project, "Regular_Tables/table2_reg.R"))

openxlsx::writeData(wb = template,
                    sheet = 'Table_2',
                    x = timeperiod2,
                    startRow = 3,
                    colNames = F)

# setting start row and note heights
t2_start <- 9
t2_note_heights <- rep(14.3, length(notes2))
t2_note_heights[5] = 21.8

# writing the data and notes
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
# Load the data frame
source(paste0(path_to_project, "Regular_Tables/table5_reg.R"))


t5_start <- 8
openxlsx::writeData(wb = template,
                    sheet = 'Table_5',
                    x = timeperiod5,
                    startRow = 3,
                    colNames = F)

# writing the data and notes
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
# Loads and writes the data
source(paste0(path_to_project, "Regular_Tables/table6_reg.R"))
t6_start <- 8
openxlsx::writeData(wb = template,
                    sheet = 'Table_6',
                    x = timeperiod6,
                    startRow = 3,
                    colNames = F)

write_formatted_table(workbook = template, 
                      sheet_name = 'Table_6', 
                      tables = list(t6_reg_year, t6_reg_qtr), 
                      notes = notes6, 
                      starting_row = 8, 
                      quarterly_format = c(2))

####################################################################
#Children Act High Court
#Table 7

####################################################################
# Loads and writes the data
source(paste0(path_to_project, "Regular_Tables/table7_reg.R"))
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
                      notes = notes7, 
                      starting_row = t7_start, 
                      quarterly_format = c(2))

####################################################################
#Care and Supervision
#Table 8

####################################################################
# Loads and writes the data
source(paste0(path_to_project, "Regular_Tables/table8_reg.R"))
t8_start <- 6
t8_row_heights <- rep(15, length(notes8))
t8_row_heights[c(5, 6, 7, 8)] <- c(46.5, 25.5, 37.5, 25.5)

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
                      quarterly_format = c(2),
                      note_row_heights = t8_row_heights)

####################################################################
#Private Law Disposal
#Table 9

####################################################################
# Loads and writes the data
source(paste0(path_to_project, "Regular_Tables/table9_reg.R"))
t9_start <- 6

t9_row_heights <- rep(15, length(notes9))
t9_row_heights[c(5, 6, 7)] <- c(25.5, 36.75, 25.5)

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
                      quarterly_format = c(2),
                      note_row_heights = t9_row_heights)
####################################################################
#Matrimonial matters proceedings
#Table 12

####################################################################
# Loads and writes the data. Note that this table contains both formulas and raw data
source(paste0(path_to_project, "Regular_Tables/table12_reg.R"))
openxlsx::writeData(wb = template,
                    sheet = 'Table_12',
                    x = timeperiod12,
                    startRow = 3,
                    colNames = F)

# data
t12_row_heights <- rep(15, length(notes12))
t12_row_heights[seq(from = 5, to = length(notes12))] <- c(24, 22.5, 11.25, 12.75, 12.75, 24.75, 12.75, 22.5)

write_formatted_table(workbook = template, 
                      sheet_name = 'Table_12', 
                      tables = list(t12_reg_year, t12_reg_qtr), 
                      notes = notes12, 
                      starting_row = t12_start, 
                      quarterly_format = c(2),
                      note_row_heights = t12_row_heights)

# Pre 2006 Timeliness block
na_adder(wb = template,
         sheet = 'Table_12',
         value = ".",
         cols = c(6, 7, 9, 10),
         lengths = rep(3, 4),
         start_row = t12_start)

# Digital Column Block
na_adder(wb = template,
         sheet = 'Table_12',
         value = ".",
         cols = 11,
         lengths = 16,
         start_row = t12_start)

# Digital Column Block
na_adder(wb = template,
         sheet = 'Table_12',
         value = ".",
         cols = 11,
         lengths = 34,
         start_row = t12_start + nrow(t12_reg_year))

# Adding a dotted line to separate the old and new divorce law
dotted_line_style <- openxlsx::createStyle(border = "top",
                                           borderStyle = "mediumDashed")
openxlsx::addStyle(wb = template,
                   sheet = 'Table_12',
                   style = dotted_line_style,
                   rows = t12_start + nrow(t12_reg_year) + 45,
                   cols = seq(ncol(t12_reg_year)),
                   stack = T,
                   gridExpand = T)

####################################################################
#New Matrimonial matters proceedings
#Table 12b

####################################################################
# Loads and writes the data. Note that this table contains both formulas and raw data
source(paste0(path_to_project, "Regular_Tables/table12b_reg.R"))
openxlsx::writeData(wb = template,
                    sheet = 'Table_12b',
                    x = timeperiod12b,
                    startRow = 3,
                    colNames = F)

# data
t12b_row_heights <- rep(15, length(notes12b))
t12b_row_heights[seq(from = 5, to = length(notes12b))] <- c(24, 22.5, 11.25, 12.75, 12.75, 24.75, 12.75, 22.5, 12)

write_formatted_table(workbook = template, 
                      sheet_name = 'Table_12b', 
                      tables = list(t12b_reg_qtr), 
                      notes = notes12b, 
                      starting_row = t12b_start, 
                      quarterly_format = c(1),
                      note_row_heights = t12b_row_heights)


####################################################################
#Divorce Progression
#Table 13

####################################################################
# Loads and writes the data
source(paste0(path_to_project, "Regular_Tables/table13_reg.R"))
t13_start <- 9
t13_row_heights <- rep(15, length(notes13))
t13_row_heights[[12]] <- 34.5
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
                      quarterly_format = c(2),
                      note_row_heights = t13_row_heights)

####################################################################
#Divorce Progression Percentages
#Table 14

####################################################################
# Loads and writes the data
source(paste0(path_to_project, "Regular_Tables/table14_reg.R"))
t14_start <- 7
t14_row_heights <- rep(15, length(notes14))
t14_row_heights[seq(from = 5, to = length(notes14))] <- c(24, 12.75, 40.5)
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
                      quarterly_format = c(2),
                      note_row_heights = t14_row_heights)
####################################################################
#Financial Remedy
#Table 15

####################################################################
# Loads and writes the data
source(paste0(path_to_project, "Regular_Tables/table15_reg.R"))
t15_start <- 7
t15_row_heights <- rep(15, length(notes15))
t15_row_heights[seq(from = 5, to = length(notes15))] <- c(24.75, 34.5, 24.75, 24.75, 24.75, 12.75)

openxlsx::writeData(wb = template,
                    sheet = 'Table_15',
                    x = timeperiod15,
                    startRow = 3,
                    colNames = F)

# data
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_15', 
                      tables = list(t15_reg_year, t15_reg_qtr), 
                      notes = notes15, 
                      starting_row = t15_start, 
                      quarterly_format = c(2),
                      note_row_heights = t15_row_heights)

####################################################################
#Domestic Violence
#Table 16

####################################################################
# Loads and writes the data frame. This table is all formula
source(paste0(path_to_project, "Regular_Tables/table16_reg.R"))
t16_row_heights <- rep(15, length(notes16))
t16_row_heights[seq(from = 5, to = length(notes16))] <- c(12.75, 36, 12.75, 12.75, 22.5, 22.5, 15)

openxlsx::writeData(wb = template,
                    sheet = 'Table_16',
                    x = timeperiod16,
                    startRow = 3,
                    colNames = F)

# data
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_16', 
                      tables = list(dv_hard_code, dv_year, dv_hard_code_qtr, dv_qtr), 
                      notes = notes16, 
                      starting_row = t16_start, 
                      quarterly_format = c(3, 4),
                      note_row_heights = t16_row_heights)

####################################################################
#Forced Marriage Protection Orders
#Table 17

####################################################################
# Loads the data
source(paste0(path_to_project, "Regular_Tables/table17_reg.R"))
openxlsx::writeData(wb = template,
                    sheet = 'Table_17',
                    x = timeperiod17,
                    startRow = 3,
                    colNames = F)

# sets the start row and writes the data. Note that since the table doesn't start from a full year, the quarterly data is split for formatting purposes.
t17_start <- 8
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_17', 
                      tables = list(t17_reg_year, t17_reg_qtr_a, t17_reg_qtr_b), 
                      notes = notes17, 
                      starting_row = t17_start, 
                      quarterly_format = c(2, 3))

# adding all the nas for this table. This adds dashes for the years and quarters without data
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

# adds dots for FMPO with POA from 2014 Q2 to the current year/quarter
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
         lengths = rep(nrow(t17_reg_qtr_all) - 23, length(fmpo_dot_columns)),
         start_row = t17_start + nrow(t17_reg_year) + 23)

####################################################################
#Female Genital Mutilation Protection Orders
#Table 18

####################################################################
# Loads and writes the data
source(paste0(path_to_project, "Regular_Tables/table18_reg.R"))
openxlsx::writeData(wb = template,
                    sheet = 'Table_18',
                    x = timeperiod18,
                    startRow = 3,
                    colNames = F)

t18_start <- 8
t18_row_heights <- rep(15, length(notes18))
t18_row_heights[c(9, 13)] <- c(24.75, 24.75)
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_18', 
                      tables = list(t18_reg_year, t18_reg_qtr_a, t18_reg_qtr_b), 
                      notes = notes18, 
                      starting_row = t18_start, 
                      quarterly_format = c(2, 3),
                      note_row_heights = t18_row_heights)


####################################################################
#Adoption Applications
#Table 19

####################################################################
# Loads and writes the data
source(paste0(path_to_project, "Regular_Tables/table19_reg.R"))
openxlsx::writeData(wb = template,
                    sheet = 'Table_19',
                    x = timeperiod19,
                    startRow = 3,
                    colNames = F)

# data
t19_start <- 8
t19_row_heights <- rep(15, length(notes19))
t19_row_heights[[11]] <- 24.75
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_19', 
                      tables = list(t19_reg_year, t19_reg_qtr), 
                      notes = notes19, 
                      starting_row = t19_start, 
                      quarterly_format = c(2),
                      note_row_heights = t19_row_heights)

####################################################################
#Adoption Orders
#Table 20

####################################################################
# Loads and writes the data
source(paste0(path_to_project, "Regular_Tables/table20_reg.R"))
openxlsx::writeData(wb = template,
                    sheet = 'Table_20',
                    x = timeperiod20,
                    startRow = 3,
                    colNames = F)

# data
t20_start <- 8
t20_row_heights <- rep(15, length(notes20))
t20_row_heights[[5]] <- 24.75
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_20', 
                      tables = list(t20_reg_year, t20_reg_qtr), 
                      notes = notes20, 
                      starting_row = t20_start, 
                      quarterly_format = c(2),
                      note_row_heights = t20_row_heights)


####################################################################
#Applications under the Mental Capacity Act
#Table 21

####################################################################
# Loads both Table 21 and Table 22 data
source(paste0(path_to_project, "Regular_Tables/table21_22_reg.R"))
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

# Adding dot to table for first deprivation of liberty
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
# Data is loaded under Table 21 heading
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

# Adding dot to table for first deprivation of liberty
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
# Loads and writes the data
source(paste0(path_to_project, "Regular_Tables/table23_reg.R"))
openxlsx::writeData(wb = template,
                    sheet = 'Table_23',
                    x = timeperiod23,
                    startRow = 4,
                    colNames = F)

# data
t23_start <- 9

t23_row_heights <- rep(15, length(notes23))
t23_row_heights[[6]] <- 23.25
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_23', 
                      tables = list(t23_reg_year, t23_reg_qtr), 
                      notes = notes23, 
                      starting_row = t23_start, 
                      quarterly_format = c(2),
                      note_row_heights = t23_row_heights)

# Adding stars to table
na_formatter(wb = template,
             sheet = 'Table_23',
             table = full_t23,
             value = '*',
             startRow = t23_start,
             na_value = suppress_value)


####################################################################
#Probate
#Table 24

####################################################################
# Loads and writes the data
source(paste0(path_to_project, "Regular_Tables/table24_reg.R"))
openxlsx::writeData(wb = template,
                    sheet = 'Table_24',
                    x = timeperiod24,
                    startRow = 4,
                    colNames = F)

# data

t24_row_heights <- rep(15, length(notes24))
t24_row_heights[c(5, 11, 12)] <- c(48, 24, 23.25)
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_24', 
                      tables = list(t24_reg_year, t24_reg_qtr_a, t24_reg_qtr_b), 
                      notes = notes24, 
                      starting_row = t24_start, 
                      quarterly_format = c(2, 3),
                      note_row_heights = t24_row_heights)

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
# Loads and writes the data
source(paste0(path_to_project, "Regular_Tables/table25_reg.R"))
openxlsx::writeData(wb = template,
                    sheet = 'Table_25',
                    x = timeperiod25,
                    startRow = 4,
                    colNames = F)

# data

t25_row_heights <- rep(15, length(notes25))
t25_row_heights[[9]] <- 23.25
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_25', 
                      tables = list(t25_reg_year, t25_reg_qtr_a, t25_reg_qtr_b), 
                      notes = notes25, 
                      starting_row = t25_start, 
                      quarterly_format = c(2, 3),
                      note_row_heights = t25_row_heights)

# 2019 Q2 NA
# Everything before All Grants is NA
probate_time_na_columns <- setdiff(seq(from = 3, to = 23), probate_time_blank_cols)
na_adder(wb = template,
         sheet = 'Table_25',
         value = ":",
         cols = probate_time_na_columns,
         lengths = rep(1, length(probate_time_na_columns)),
         start_row = t25_start + nrow(t25_reg_year))
############################################################################
# Extra parts added for formula tables

# Adding sources for formula tables
source(paste0(path_to_project, "Regular_Tables/table_sources.R"))

# dropdowns used for formulas are added here
source(paste0(path_to_project, "Regular_Tables/lists.R"))

# Export ##########################################################################################
openxlsx::saveWorkbook(template, paste0(path_to_project, glue("Family Court Tables ({pub_months_short} {pub_year}).xlsx")), overwrite = TRUE)
#openxlsx::saveWorkbook(template, paste0(path_to_project,"test_output_2022_q1.xlsx"), overwrite = TRUE)
