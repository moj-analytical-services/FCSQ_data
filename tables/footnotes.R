
# Number of tables is set and used to get a vector containing the number of the tables
# There are 25 tables in R. The old table 14 has been dropped. Table 12b and 10b but that has the same table number despite being on a different tab

# Note Table 14 has been removed but due to keeping variable names the same in R, note14 will simply be ignored
no_tables <- 25
no_tables_seq <- append(seq(no_tables), '10b', after = 10) %>% append('12b', after = 13)
table_numbers <- glue('Table {no_tables_seq}')

# Creates a list of notes that correspond to a particular table

#Removing revision notices for now. Will handle later
notes_rev <- notes_import %>% filter(str_detect(Lookup, "Revision"))
notes_no_rev <- notes_import %>% filter(!str_detect(Lookup, "Revision"))

rev_notes_list <- map(no_tables_seq, ~ notes_select(notes_rev, .x))
names(rev_notes_list) <- glue('t{no_tables_seq}')
notes_list <- map(no_tables_seq, ~ notes_select(notes_no_rev, .x))

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
                   "HMCTS Core Case Data",
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

# notes added to regular tables
reg_notes <- pmap(list(notes_list, table_sources_reg, rev_notes_list), make_reg_notes)
names(reg_notes) <- glue('notes{no_tables_seq}')

#Binding to use variable names instead of having to refer to the list
rlang::env_bind(rlang::current_env(), !!!reg_notes)
