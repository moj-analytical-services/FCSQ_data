# Tables. Run Update Excel first to get the regular tables

# Tables
source(paste0(path_to_project, "Accessible_Tables/table1_access.R"))
source(paste0(path_to_project, "Accessible_Tables/table2_access.R"))
source(paste0(path_to_project, "Accessible_Tables/table3_access.R"))
source(paste0(path_to_project, "Accessible_Tables/table4_access.R"))
source(paste0(path_to_project, "Accessible_Tables/table5_access.R"))
source(paste0(path_to_project, "Accessible_Tables/table6_access.R"))
source(paste0(path_to_project, "Accessible_Tables/table7_access.R"))
source(paste0(path_to_project, "Accessible_Tables/table8_access.R"))
source(paste0(path_to_project, "Accessible_Tables/table9_access.R"))
source(paste0(path_to_project, "Accessible_Tables/table10_access.R"))
source(paste0(path_to_project, "Accessible_Tables/table11_access.R"))
source(paste0(path_to_project, "Accessible_Tables/table12_access.R"))
source(paste0(path_to_project, "Accessible_Tables/table12b_access.R"))
source(paste0(path_to_project, "Accessible_Tables/table13_access.R"))
# Likewise Table 14 is now deleted. Sheet names will change, variables will remain the same
source(paste0(path_to_project, "Accessible_Tables/table15_access.R"))
source(paste0(path_to_project, "Accessible_Tables/table16_access.R"))
source(paste0(path_to_project, "Accessible_Tables/table17_access.R"))
source(paste0(path_to_project, "Accessible_Tables/table18_access.R"))
source(paste0(path_to_project, "Accessible_Tables/table19_access.R"))
source(paste0(path_to_project, "Accessible_Tables/table20_access.R"))
source(paste0(path_to_project, "Accessible_Tables/table21_22_access.R"))
source(paste0(path_to_project, "Accessible_Tables/table23_access.R"))
source(paste0(path_to_project, "Accessible_Tables/table24_access.R"))
source(paste0(path_to_project, "Accessible_Tables/table25_access.R"))

# Producing the Excel Tables
source(paste0(path_to_project, "footnotes.R"))
source(paste0(path_to_project, "Accessible_Notes.R"))
source(paste0(path_to_project, "Accessible_Excel.R"))
source(paste0(path_to_project, "Accessible_Formatting.R"))

# Export Notes
readr::write_csv(notes_all, paste0(path_to_project, "Notes.csv"))
