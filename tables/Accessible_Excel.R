# Accessible Tables 


# A cover page, with subheaded sections of information
cover_df <- tribble(
  ~"Subsection title", ~"Subsection body",
  "Description", "Statistics on the types and volume of cases that have passed through the Family Court in an accessible format",
  "Format", "A set of tables, all in an accessible format. Each tab contains only one table each. The data for what is Tables 3 and 4 in the regular tables contains two separate counts so are split into Tables 3a, 3b, 4a and 4b respectively",
  "Publication dates", glue("This data was originally published at 9:30am on {pub_date}. The next publication will be published at 9:30 am on {next_pub_date}."),
  "Contact details", "Carly Gray\nHead of Access to Justice Data and Statistics\nPhone Number: 0778 427 5495",
  "Statistical Contact Email", ""
)

table_sources_access <- c("HMCTS FamilyMan and Core Case Data",
             "HMCTS FamilyMan",
             "HMCTS FamilyMan",
             "HMCTS FamilyMan",
             "HMCTS FamilyMan",
             "HMCTS FamilyMan",
             "HMCTS FamilyMan",
             "HMCTS FamilyMan",
             "HMCTS FamilyMan",
             "HMCTS FamilyMan",
             "HMCTS FamilyMan",
             "HMCTS FamilyMan and Core Case Data",
             "HMCTS FamilyMan and Core Case Data",
             "HMCTS FamilyMan and Core Case Data",
             "HMCTS Core Case Data",
             "HMCTS FamilyMan and Core Case Data",
             "HMCTS FamilyMan and Core Case Data",
             "HMCTS FamilyMan and Core Case Data",
             "HMCTS FamilyMan",
             "HMCTS One Performance Truth (OPT) system",
             "HMCTS One Performance Truth (OPT) system",
             "HMCTS FamilyMan",
             "HMCTS FamilyMan",
             "Court of Protection data management system",
             "Court of Protection data management system",
             "Office of the Public Guardian data management systems SIRIUS and Casrec",
             "HMCTS ProbateMan system to Q1 2019, HMCTS Core Case Data from Q2 2019, HMCTS Pentaho system (contested cases only)",
             "HMCTS Core Case Data")

# A contents page, with the sheet names and titles
contents_df <- tribble(
  ~"Sheet name", ~"Sheet title",
  "Notes", "Notes",
  "Table 1", "Cases starting and cases concluding in Family courts in England and Wales",
  "Table 2", "Public and Private (Children Act) cases started and disposed, counted by case, individual children, applications and disposals, in England and Wales",
  "Table 3a", "Number of orders applied for in Public and Private law (Children Act) applications made in the Family courts in England and Wales, by type of order",
  "Table 3b", "Number of children involved in Public and Private law (Children Act) applications made in the Family courts in England and Wales, by type of order",
  "Table 4a", "Number of orders in Public and Private law (Children Act) made in Family courts in England and Wales, by type of order",
  "Table 4b", "Number of children involved in Public and Private law (Children Act) orders made in Family courts in England and Wales, by type of order",
  "Table 5", "Number of individual children involved in Public and Private (Children Act) applications made in the Family courts in England and Wales by age",
  "Table 6", "Number of individual parties involved in Public and Private (Children Act) cases in England and Wales",
  "Table 7", "Number of Public and Private (Children Act) cases started in England and Wales by High court indicator and area",
  "Table 8", "Summary statistics on the time to first definitive disposal for care proceedings in the Family courts of England and Wales",
  "Table 9", "Summary statistics on the timeliness of Private law cases from issue to final order in the Family courts of England and Wales",
  "Table 10", "Number of disposals and average time to first definitve disposal in courts in England and Wales by case type and legal representaion of parties",
  "Table 11", "Legal representation status of applicants and respondents in cases with at least one hearing in Family courts in England and Wales",
  "Table 12", "Number of cases relating to matrimonial proceedings (including civil partnerships), with selected average times, in England and Wales",
  "Table 12b", "Number of cases relating to matrimonial proceedings (including civil partnerships), for New Divorce Law, in England and Wales",
  "Table 13", "Progression of divorce cases (including civil partnerships) started for England and Wales",
  "Table 14", "Percentage of divorce cases (including civil partnerships) reaching certain stages, by the number of quarters since petition and stage, England and Wales",
  "Table 15", "Number of applications and disposals made for one or more types of financial remedy (formerly ancillary relief) orders, in England and Wales",
  "Table 16", "Applications and orders made for domestic violence remedies in England and Wales",
  "Table 17", "Applications and disposals of Forced Marriage Protection Orders made in the High Court and county courts, England and Wales",
  "Table 18", "Applications and disposals of Female Genital Mutilation Protection Orders, England and Wales",
  "Table 19", "Applications for adoption and related orders made in courts in England and Wales",
  "Table 20", "Orders issued for adoption and related orders in courts in England and Wales",
  "Table 21", "Court of Protection Applications made in England and Wales",
  "Table 22", "Court of Protection Orders made in England and Wales",
  "Table 23", "Office of the Public Guardian applications registered in England and Wales",
  "Table 24", "Number of applications made and grants issued for grants of representation in probate proceedings, by type and method of application, and grant revocations, standings searches and contested probate cases",
  "Table 25", "Average time to grant issue for grants of representation in probate proceedings, England and Wales"
  
)


# Adding Sources. timeperiod from index page
timeperiods_all <- c(timeperiod1, timeperiod2, timeperiod3, timeperiod3, timeperiod4, timeperiod4,
                     timeperiod5, timeperiod6, timeperiod7, timeperiod8, timeperiod9, timeperiod10,
                     timeperiod11, timeperiod12, timeperiod12b, timeperiod13, timeperiod14, timeperiod15, timeperiod16,
                     timeperiod17, timeperiod18, timeperiod19, timeperiod20, timeperiod21, timeperiod22, timeperiod23, timeperiod24, timeperiod25)

contents_df <- contents_df %>% mutate(Source = c(NA, table_sources_access),
                                      `Time period` = c(NA, timeperiods_all))

# Number of tables in the accessible worksheet
data_table_tabs <- contents_df$`Sheet name`
table_num_access <- length(data_table_tabs) - 1

# Adding time periods and notes to titles of the data
table_titles <- contents_df$`Sheet title`[2:(table_num_access + 1)]

table_titles <- paste0(table_titles, ', ', timeperiods_all, ' ',  title_notes)

# A notes page, notes_all is made from the update excel file
notes_df2 <- tribble(
  ~"Table number", ~"Note number", ~"Note text",
  "All Tables","[c]", "Confidential: suppressed.",
 "All Tables", "[z]", "Not applicable." )

notes_df <- bind_rows(notes_df2, notes_all)

fcsq_a11y <- new_a11ytable(
  tab_titles = c("Cover", "Contents", data_table_tabs),
  sheet_types = c("cover", "contents", "notes", rep("tables", table_num_access)),
  sheet_titles = c(
    "Family Court Statistics Quarterly Tables",
    "Table of contents",
    "Notes",
    table_titles),
  sources = c(
    NA_character_,
    NA_character_,
    NA_character_,
    table_sources_access
    
  ),
  table_names = c(
    "cover_sheet",
    "table_of_contents",
    "notes_table",
    "Overall_Family_Court_Summary",
    "Children_Act_Summary",
    "Children_Act_Apps_Order_Count",
    "Children_Act_Apps_Child_Count",
    "Children_Act_Orders_Order_Count",
    "Children_Act_Orders_Child_Count",
    "Children_Act_Individual_Children_Age",
    "Children_Act_Parties",
    "Children_Act_High_Court",
    "Care_Disposal_Summary",
    "Private_Law_Disposal_Summary",
    "Overall_time_to_first_disposal",
    "Overall_Legal_Representation",
    "Divorce_Summary",
    "New_Divorce_Summary",
    "Divorce_Progression",
    "Divorce_Progression_Stage_Percentage",
    "Financial_Remedy_Summary",
    "Domestic_Violence_Summary",
    "FMPO_Summary",
    "FGMPO_Summary",
    "Adopt_Apps",
    "Adopt_Ords",
    "COP_Apps",
    "COP_Ords",
    "OPG_Apps",
    "Probate_Summary",
    "Probate_Timeliness"
  ),
  tables = list(
    cover_df,
    contents_df,
    notes_df,
    t1_accessible,
    t2_accessible,
    t3a_accessible,
    t3b_accessible,
    t4a_accessible,
    t4b_accessible,
    t5_accessible,
    t6_accessible,
    t7_accessible,
    t8_accessible,
    t9_accessible,
    t10_accessible,
    t11_accessible,
    t12_accessible,
    t12b_accessible,
    t13_accessible,
    t14_accessible,
    t15_accessible,
    t16_accessible,
    t17_accessible,
    t18_accessible,
    t19_accessible,
    t20_accessible,
    t21_accessible,
    t22_accessible,
    t23_accessible,
    t24_accessible,
    t25_accessible
  )
)

fcsq_wb <- create_a11y_wb(fcsq_a11y)
saveWorkbook(fcsq_wb, "fcsq_accessible.xlsx", overwrite = TRUE)
