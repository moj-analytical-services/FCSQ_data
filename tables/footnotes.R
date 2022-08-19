
# Number of tables is set and used to get a vector containing the number of the tables
# There are 26 tables with table 12b but that has the same table number despite being on a different tab
no_tables <- 25
no_tables_seq <- append(seq(no_tables), '12b', after = 12)
table_numbers <- glue('Table {no_tables_seq}')

# Creates a list of notes that correspond to a particular table
notes_list <- map(table_numbers, ~ notes_select(notes_import, .x))

table_sources_reg <- c("HMCTS FamilyMan and Core Case Data",
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
                   "HMCTS ProbateMan system to Q1 2019, HMCTS Core Case Data from Q2 2019, HMCTS E-Filing service (contested cases only)",
                   "HMCTS Core Case Data")

# notes added to regular tables
reg_notes <- map2(notes_list, table_sources_reg, make_reg_notes)
names(reg_notes) <- glue('notes{no_tables_seq}')

#Binding to use variable names instead of having to refer to the list
rlang::env_bind(rlang::current_env(), !!!reg_notes)
