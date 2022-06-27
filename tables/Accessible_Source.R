# Tables. Run Update Excel first to get the regular tables

#If the regular version has been run before, This is set to TRUE. If FALSE tables needed to create the accessible version are loaded
regular_run <- TRUE

if (!regular_run){
  source('~/FCSQ_data/tables/variables.R')
  source(paste0(path_to_project, "getdata.R"))
  source(paste0(path_to_project, "table_1_change.R"))
  source(paste0(path_to_project, "Regular_Tables/table1_reg.R"))
  source(paste0(path_to_project, "Regular_Tables/table2_reg.R"))
  source(paste0(path_to_project, "Regular_Tables/table5_reg.R"))
  source(paste0(path_to_project, "Regular_Tables/table6_reg.R"))
  source(paste0(path_to_project, "Regular_Tables/table7_reg.R"))
  source(paste0(path_to_project, "Regular_Tables/table8_reg.R"))
  source(paste0(path_to_project, "Regular_Tables/table9_reg.R"))
  source(paste0(path_to_project, "Regular_Tables/table12_reg.R"))
  source(paste0(path_to_project, "Regular_Tables/table13_reg.R"))
  source(paste0(path_to_project, "Regular_Tables/table14_reg.R"))
  source(paste0(path_to_project, "Regular_Tables/table15_reg.R"))
  source(paste0(path_to_project, "Regular_Tables/table17_reg.R"))
  source(paste0(path_to_project, "Regular_Tables/table18_reg.R"))
  source(paste0(path_to_project, "Regular_Tables/table19_reg.R"))
  source(paste0(path_to_project, "Regular_Tables/table20_reg.R"))
  source(paste0(path_to_project, "Regular_Tables/table21_22_reg.R"))
  source(paste0(path_to_project, "Regular_Tables/table23_reg.R"))
}

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
source(paste0(path_to_project, "Accessible_Tables/table13_access.R"))
source(paste0(path_to_project, "Accessible_Tables/table14_access.R"))
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
source(paste0(path_to_project, "Accessible_Excel.R"))
source(paste0(path_to_project, "Accessible_Formatting.R"))

# Export Notes
readr::write_csv(notes_all, paste0(path_to_project, "Notes.csv"))
