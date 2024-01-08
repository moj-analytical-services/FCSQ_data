

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
source(paste0(path_to_project, "Regular_Tables/table10b_reg.R"))
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
t1_start <- 9

# Adjusting row height for notes.
t1_note_heights <- rep(14.3, length(notes1))



t1_note_adjust <- note_adjuster(notes = c(2, 13), table = 1)
t1_note_heights[t1_note_adjust] = c(23.25, 20.7)

# Writing the data and notes into the template
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_1', 
                      tables = list(t1_reg_year, t1_reg_qtr), 
                      notes = notes1, 
                      starting_row = t1_start, 
                      quarterly_format = c(2),
                      note_row_heights = t1_note_heights)

# Adding expressions for missing values. As these are strings they have to be added separately from the numbers

#Blocking before years before 2011 for some categories
na_cols <- c(3, 4, 7, 10, 11, 13, 14, 17, 20, 21)
na_adder(wb = template,
         sheet = 'Table_1',
         value = "-",
         cols = na_cols,
         lengths = rep(5, length(na_cols)),
         start_row = t1_start)

#Blocking forced marriage and female genital mutilation
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

#Temporary Data Quality Issues blocked

#Adoption Starts and Total Case Starts - Yearly
na_adder(wb = template,
         sheet = 'Table_1',
         value = ":",
         cols = c(10, 11),
         lengths = rep(nrow(t1_reg_year) - 16, 2),
         start_row = t1_start + 16)

#Adoption Starts and Total Case Starts - Quarterly
na_adder(wb = template,
         sheet = 'Table_1',
         value = ":",
         cols = c(10, 11),
         lengths = rep(nrow(t1_reg_qtr) - 47, 2),
         start_row = t1_start + nrow(t1_reg_year) + 47)

#Adoption Disposals and Total Case Disposals - Quarterly
na_adder(wb = template,
         sheet = 'Table_1',
         value = ":",
         cols = c(20, 21),
         lengths = rep(nrow(t1_reg_qtr) - 48, 2),
         start_row = t1_start + nrow(t1_reg_year) + 48)

# #Public Law and Total Cases Disposed - Annually
# na_adder(wb = template,
#          sheet = 'Table_1',
#          value = ":",
#          cols = c(13, 21),
#          lengths = rep(nrow(t1_reg_year) - 16, 2),
#          start_row = t1_start + 16)
# 
# #Public Law and Total Cases Disposed - Quarterly
# na_adder(wb = template,
#          sheet = 'Table_1',
#          value = ":",
#          cols = c(13, 21),
#          lengths = rep(nrow(t1_reg_qtr) - 46, 2),
#          start_row = t1_start + nrow(t1_reg_year) + 46)



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
t2_start <- 11
t2_note_heights <- rep(14.3, length(notes2))

t2_note_adjust <- note_adjuster(notes = c(1, 4, 14), table = 2)

t2_note_heights[t2_note_adjust] = c(21.8, 22.2, 20.7)

# writing the data and notes
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_2', 
                      tables = list(t2_reg_year, t2_reg_qtr), 
                      notes = notes2, 
                      starting_row = t2_start, 
                      quarterly_format = c(2),
                      note_row_heights = t2_note_heights)

# Data Quality Issues block

# Block on public law orders made and cases disposed - Annually
na_adder(wb = template,
         sheet = 'Table_2',
         value = ':',
         cols = c(9),
         lengths = rep(nrow(t2_reg_year) - 11, 1),
         start_row = t2_start + 11)

# # Block on public law orders made and cases disposed - Quarterly
# na_adder(wb = template,
#          sheet = 'Table_2',
#          value = ':',
#          cols = c(8, 10),
#          lengths = rep(nrow(t2_reg_qtr) - 46, 2),
#          start_row = t2_start + nrow(t2_reg_year) + 46)

# Block on public law disposals from 2022 onward data due to CCD affecting public law - Quarterly
na_adder(wb = template,
         sheet = 'Table_2',
         value = ':',
         cols = 9,
         lengths = nrow(t2_reg_qtr) - 44,
         start_row = t2_start + nrow(t2_reg_year) + 44)

####################################################################
#Children Act Individual children
#Table 5

####################################################################
# Load the data frame
source(paste0(path_to_project, "Regular_Tables/table5_reg.R"))


t5_start <- 8
t5_note_heights <- rep(14.3, length(notes5))
t5_note_adjust <- note_adjuster(notes = c(6), table = 5)
t5_note_heights[t5_note_adjust] <- 20.7

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
                      quarterly_format = c(2),
                      note_row_heights = t5_note_heights)


####################################################################
#Children Act Parties
#Table 6

####################################################################
# Loads and writes the data
source(paste0(path_to_project, "Regular_Tables/table6_reg.R"))
t6_start <- 8
t6_note_heights <- rep(14.3, length(notes6))
t6_note_adjust <- note_adjuster(notes = c(4), table = 6)
t6_note_heights[t6_note_adjust] <- 20.7
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
                      quarterly_format = c(2),
                      note_row_heights = t6_note_heights)

####################################################################
#Children Act High Court
#Table 7

####################################################################
# Loads and writes the data
source(paste0(path_to_project, "Regular_Tables/table7_reg.R"))
t7_start <- 10

t7_note_heights <- rep(14.3, length(notes7))
t7_note_adjust <- note_adjuster(notes = c(1), table = 7)
t7_note_heights[t7_note_adjust] <- c(24)

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
                      quarterly_format = c(2),
                      note_row_heights = t7_note_heights)

# Data Quality Issues

#Public Law High Court - Annually
na_adder(wb = template,
         sheet = 'Table_7',
         value = ':',
         cols = c(4, 5, 6),
         lengths = rep(nrow(t7_reg_year) - 11, 3),
         start_row = t7_start + 11)

#Public Law High Court - Quarterly
na_adder(wb = template,
         sheet = 'Table_7',
         value = ':',
         cols = c(4, 5, 6),
         lengths = rep(nrow(t7_reg_qtr) - 46, 3),
         start_row = t7_start + nrow(t7_reg_year) + 46)


####################################################################
#Care and Supervision
#Table 8

####################################################################
# Loads and writes the data
source(paste0(path_to_project, "Regular_Tables/table8_reg.R"))
t8_start <- 8
t8_row_heights <- rep(15, length(notes8))
t8_note_adjust <- note_adjuster(notes = c(1, 2, 3, 4, 5), table = 8)
t8_row_heights[t8_note_adjust] <- c(46.5, 25.5, 22.9, 25.5, 24)

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

# Block on disposals from 2022 onward data due to CCD affecting Public Law - Annually
na_adder(wb = template,
         sheet = 'Table_8',
         value = ':',
         cols = c(3, 4, 5, 6),
         lengths = rep(nrow(t8_reg_year) - 11, 4),
         start_row = t8_start + 11)

# Block on disposals from 2022 onward data due to CCD affecting Public Law - Quarterly
na_adder(wb = template,
         sheet = 'Table_8',
         value = ':',
         cols = c(3, 4, 5, 6),
         lengths = rep(nrow(t8_reg_qtr) - 44, 4),
         start_row = t8_start + nrow(t8_reg_year) + 44)

####################################################################
#Private Law Disposal
#Table 9

####################################################################
# Loads and writes the data
source(paste0(path_to_project, "Regular_Tables/table9_reg.R"))
t9_start <- 6

t9_row_heights <- rep(15, length(notes9))
t9_note_adjust <- note_adjuster(notes = c(1, 2, 3), table = 9)
t9_row_heights[t9_note_adjust] <- c(25.5, 36.75, 25.5)

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
t12_note_adjust <- note_adjuster(notes = c(1, 2, 3, 4, 5, 6, 7, 8), table = 12)
t12_row_heights[t12_note_adjust] <- c(24, 22.5, 11.25, 12.75, 12.75, 24.75, 12.75, 22.5)

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
t12b_note_adjust <- note_adjuster(notes = c(1, 2, 3, 4, 5), table = "12b")
t12b_row_heights[t12b_note_adjust] <- c(24, 17.7, 13.2, 14.7, 14.7)

write_formatted_table(workbook = template, 
                      sheet_name = 'Table_12b', 
                      tables = list(t12b_reg_qtr_a, t12b_reg_qtr_b), 
                      notes = notes12b, 
                      starting_row = t12b_start, 
                      quarterly_format = c(1, 2),
                      note_row_heights = t12b_row_heights)


####################################################################
#Divorce Progression
#Table 13

####################################################################
# Loads and writes the data
source(paste0(path_to_project, "Regular_Tables/table13_reg.R"))
t13_start <- 9
t13_row_heights <- rep(15, length(notes13))
t13_note_adjust <- note_adjuster(notes = c(4, 8, 9, 11), table = 13)
t13_row_heights[t13_note_adjust] <- c(22.2, 34.5, 19.5, 20.7)

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

# Block hearings from 2022 Q2
na_adder(wb = template,
         sheet = 'Table_13',
         value = ':',
         cols = c(17, 18),
         lengths = rep(nrow(t13_reg_qtr) - 45, 2),
         start_row = t13_start + nrow(t13_reg_year) + 45)

# Block hearings from 2022
na_adder(wb = template,
         sheet = 'Table_13',
         value = ':',
         cols = c(17, 18),
         lengths = rep(nrow(t13_reg_year) - 19, 2),
         start_row = t13_start + 19)

# Block FR from 2022 Q3 onwards
# na_adder(wb = template,
#          sheet = 'Table_13',
#          value = '-',
#          cols = c(11, 12, 14, 15),
#          lengths = rep(nrow(t13_reg_qtr) - 46, 4),
#          start_row = t13_start + nrow(t13_reg_year) + 46)

# Note that the old Table 14 got removed. 
# This means that from here each table while retaining the same number variable wise is in the sheet before the table number
####################################################################
#Financial Remedy
#Table 15

####################################################################
# Loads and writes the data
source(paste0(path_to_project, "Regular_Tables/table15_reg.R"))
t15_start <- 7
t15_row_heights <- rep(15, length(notes15))
t15_note_adjust <- note_adjuster(notes = c(1, 2, 3, 4, 5, 6), table = 15)
t15_row_heights[t15_note_adjust] <- c(24.75, 34.5, 24.75, 24.75, 24.75, 12.75)

openxlsx::writeData(wb = template,
                    sheet = 'Table_14',
                    x = timeperiod15,
                    startRow = 3,
                    colNames = F)

# data
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_14', 
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
t16_note_adjust <- note_adjuster(notes = c(1, 2, 3, 4, 5, 6, 7), table = 16)
t16_row_heights[t16_note_adjust] <- c(12.75, 36, 12.75, 12.75, 22.5, 22.5, 15)

openxlsx::writeData(wb = template,
                    sheet = 'Table_15',
                    x = timeperiod16,
                    startRow = 3,
                    colNames = F)

# data
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_15', 
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
                    sheet = 'Table_16',
                    x = timeperiod17,
                    startRow = 3,
                    colNames = F)

# sets the start row and writes the data. Note that since the table doesn't start from a full year, the quarterly data is split for formatting purposes.
t17_start <- 8
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_16', 
                      tables = list(t17_reg_year, t17_reg_qtr_a, t17_reg_qtr_b), 
                      notes = notes17, 
                      starting_row = t17_start, 
                      quarterly_format = c(2, 3))

# adding all the nas for this table. This adds dashes for the years and quarters without data
fmpo_dash_columns <- c(3, 4, 7, 8, 9, 10)
na_adder(wb = template,
         sheet = 'Table_16',
         value = "-",
         cols = fmpo_dash_columns,
         lengths = rep(1, length(fmpo_dash_columns)),
         start_row = t17_start)

na_adder(wb = template,
         sheet = 'Table_16',
         value = "-",
         cols = fmpo_dash_columns,
         lengths = rep(5, length(fmpo_dash_columns)),
         start_row = t17_start + nrow(t17_reg_year))

# adds dots for FMPO with POA from 2014 Q2 to the current year/quarter
fmpo_dot_columns <- c(14, 15)
na_adder(wb = template,
         sheet = 'Table_16',
         value = "..",
         cols = fmpo_dot_columns,
         lengths = rep(annual_year - 2013, length(fmpo_dot_columns)),
         start_row = t17_start + 5)

na_adder(wb = template,
         sheet = 'Table_16',
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
                    sheet = 'Table_17',
                    x = timeperiod18,
                    startRow = 3,
                    colNames = F)

t18_start <- 8
t18_row_heights <- rep(15, length(notes18))
t18_note_adjust <- note_adjuster(notes = c(5, 9), table = 18)
t18_row_heights[t18_note_adjust] <- c(24.75, 24.75)
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_17', 
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
                    sheet = 'Table_18',
                    x = timeperiod19,
                    startRow = 3,
                    colNames = F)

# data
t19_start <- 10
t19_row_heights <- rep(15, length(notes19))
t19_note_adjust <- note_adjuster(notes = c(7), table = 19)
t19_row_heights[t19_note_adjust] <- 24.75
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_18', 
                      tables = list(t19_reg_year, t19_reg_qtr), 
                      notes = notes19, 
                      starting_row = t19_start, 
                      quarterly_format = c(2),
                      note_row_heights = t19_row_heights)

#Data Quality Issues

#Adoption Placement Order Applications blocked
na_adder(wb = template,
         sheet = 'Table_18',
         value = ':',
         cols = c(10, 13, 14),
         lengths = rep(nrow(t19_reg_qtr) - 47, 3),
         start_row = t19_start + nrow(t19_reg_year) + 47)


na_adder(wb = template,
         sheet = 'Table_18',
         value = ':',
         cols = c(10, 13, 14),
         lengths = rep(nrow(t19_reg_year) - 11, 3),
         start_row = t19_start + 11)


####################################################################
#Adoption Orders
#Table 20

####################################################################
# Loads and writes the data
source(paste0(path_to_project, "Regular_Tables/table20_reg.R"))
openxlsx::writeData(wb = template,
                    sheet = 'Table_19',
                    x = timeperiod20,
                    startRow = 3,
                    colNames = F)

# data
t20_start <- 8
t20_row_heights <- rep(15, length(notes20))
t20_note_adjust <- note_adjuster(notes = c(1), table = 20)
t20_row_heights[t20_note_adjust] <- 24.75
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_19', 
                      tables = list(t20_reg_year, t20_reg_qtr), 
                      notes = notes20, 
                      starting_row = t20_start, 
                      quarterly_format = c(2),
                      note_row_heights = t20_row_heights)

#Adoption Disposals blocked
na_adder(wb = template,
         sheet = 'Table_19',
         value = ':',
         cols = c(26),
         lengths = rep(nrow(t20_reg_qtr) - 48, 3),
         start_row = t20_start + nrow(t20_reg_year) + 48)

####################################################################
#Applications under the Mental Capacity Act
#Table 21

####################################################################
# Loads both Table 21 and Table 22 data
source(paste0(path_to_project, "Regular_Tables/table21_22_reg.R"))
openxlsx::writeData(wb = template,
                    sheet = 'Table_20',
                    x = timeperiod21,
                    startRow = 4,
                    colNames = F)

# data
t21_start <- 7
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_20', 
                      tables = list(t21_reg_year, t21_reg_qtr), 
                      notes = notes21, 
                      starting_row = t21_start, 
                      quarterly_format = c(2))

# Adding dot to table for first deprivation of liberty
na_adder(wb = template,
         sheet = 'Table_20',
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
                    sheet = 'Table_21',
                    x = timeperiod22,
                    startRow = 4,
                    colNames = F)

# data
t22_start <- 7
write_formatted_table(workbook = template, 
                      sheet_name = 'Table_21', 
                      tables = list(t22_reg_year, t22_reg_qtr), 
                      notes = notes22, 
                      starting_row = t22_start, 
                      quarterly_format = c(2))

# Adding dot to table for first deprivation of liberty
na_adder(wb = template,
         sheet = 'Table_21',
         value = "..",
         cols = 16,
         lengths = 1,
         start_row = t22_start)


####################################################################
#High Court Deprivation of Liberty
#Table 22a

####################################################################
# Data is loaded under Table 21 heading
openxlsx::writeData(wb = template,
                    sheet = 'Table_22',
                    x = timeperiod22a,
                    startRow = 3,
                    colNames = F)

# data
t22a_start <- 9
t22a_row_heights <- rep(15, length(notes22a))
t22a_note_adjust <- note_adjuster(notes = c(3), table = '22a')
t22a_row_heights[t22a_note_adjust] <- c(22.9)

write_formatted_table(workbook = template, 
                      sheet_name = 'Table_22', 
                      tables = list(t22a_reg_qtr), 
                      notes = notes22a, 
                      starting_row = t22a_start, 
                      quarterly_format = c(1))
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
t23_note_adjust <- note_adjuster(notes = c(2, 4, 6), table = 23)
t23_row_heights[t23_note_adjust] <- c(23.25, 21, 21)

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

# # Block on deputyships from 2008 - 2014 quarterly
na_adder(wb = template,
         sheet = 'Table_23',
         value = '-',
         cols = 25,
         lengths = 28,
         start_row = t23_start + nrow(t23_reg_year))

# Block deputyships from 2008 - 2014 annually
na_adder(wb = template,
         sheet = 'Table_23',
         value = '-',
         cols = 25,
         lengths = 7,
         start_row = t23_start)



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
t24_note_adjust <- note_adjuster(notes = c(1, 7, 8), table = 24)
t24_row_heights[t24_note_adjust] <- c(48, 24, 23.25)

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
         cols = c(3, 4, 5, 6, 12),
         lengths = rep(7, 5),
         start_row = t24_start)

# Contested Probate NA
na_adder(wb = template,
         sheet = 'Table_24',
         value = "-",
         cols = 17,
         lengths = nrow(t24_reg_qtr_a) + nrow(t24_reg_qtr_b),
         start_row = t24_start + nrow(t24_reg_year))

# Grants resealed NA
na_adder(wb = template,
         sheet = 'Table_24',
         value = ":",
         cols = c(6, 12),
         lengths = c(1, 1),
         start_row = t24_start + 7)


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
t25_note_adjust <- note_adjuster(notes = c(2, 4, 5), table = 25)
t25_row_heights[t25_note_adjust] <- c(21.4, 21.4, 23.25)

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
