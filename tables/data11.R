# Code to fill in Table 11 source - from the CSV


# Import ##########################################################################################
# Create tables from the CSVs

# Packages ########################################################################################

library(dplyr)
library(mojrap)
library(openxlsx)
library(glue)
library(readr)
library(Rs3tools)

# Variables #######################################################################################

pub_year <- 2022                                                              # Specify the publication year and quarter for the output name
pub_quarter <- 4
pub_date <- "30 March 2023"
next_pub_date <- "29th June 2023"
annual_year <- 2022
path_to_project = '~/FCSQ_data/'                                       # UPDATE ONLY IF YOU CHANGE THE LOCATION OF THE PROJECT FILES
csv_folder <- paste0("alpha-family-data/CSVs/CSV_bulletin/",pub_year, " Q",pub_quarter,"/") #
Rs3tools::download_file_from_s3(glue("{csv_folder}CSV Legal Representation National {pub_year} Q{pub_quarter}.csv"), "CSVs/csv_legrep.csv", overwrite = TRUE)
csv_legrep <- read_csv(paste0(path_to_project, "CSVs/csv_legrep.csv")) %>% 
  rename_with(tolower) %>%
  mutate(case_type = ifelse(case_type=="Divorce", "Divorce (incl. FR)", case_type))

# Processing ######################################################################################

# quarterly #####################################
# cases started
legrep_cases_q <- csv_legrep %>%
  filter(category=='Cases') %>%
  group_by(case_type, year, quarter) %>%
  summarise(cases=sum(count)) %>%
  ungroup()

# cases with at least one hearing
legrep_cases_hearing_q <- csv_legrep %>%
  filter(category=='Cases with a hearing') %>%
  group_by(case_type, year, quarter) %>%
  summarise(cases_hearing=sum(count)) %>%
  ungroup()

# represented applicants
legrep_app_rep_q <- csv_legrep %>%
  filter(category=='Party', party=='Applicant', representation=='Y') %>%
  group_by(case_type, year, quarter) %>%
  summarise(app_rep=sum(count)) %>%
  ungroup()

# unrepresented applicants
legrep_app_unrep_q <- csv_legrep %>%
  filter(category=='Party', party=='Applicant', representation=='N') %>%
  group_by(case_type, year, quarter) %>%
  summarise(app_unrep=sum(count)) %>%
  ungroup()

# represented respondents
legrep_res_rep_q <- csv_legrep %>%
  filter(category=='Party', party=='Respondent', representation=='Y') %>%
  group_by(case_type, year, quarter) %>%
  summarise(res_rep=sum(count)) %>%
  ungroup()

# unrepresented respondents
legrep_res_unrep_q <- csv_legrep %>%
  filter(category=='Party', party=='Respondent', representation=='N') %>%
  group_by(case_type, year, quarter) %>%
  summarise(res_unrep=sum(count)) %>%
  ungroup()

# combined
legrep_lookup_quarter <- legrep_cases_q %>%
  left_join(legrep_cases_hearing_q, by=c('case_type', 'year', 'quarter')) %>%
  left_join(legrep_app_rep_q, by=c('case_type', 'year', 'quarter')) %>%
  left_join(legrep_app_unrep_q, by=c('case_type', 'year', 'quarter')) %>%
  left_join(legrep_res_rep_q, by=c('case_type', 'year', 'quarter')) %>%
  left_join(legrep_res_unrep_q, by=c('case_type', 'year', 'quarter')) %>%
  mutate(total_parties=app_rep+app_unrep+res_rep+res_unrep, lookup=paste0(case_type,"|", year, "|Q", quarter))

# annually ######################################
# cases started
legrep_cases_a <- csv_legrep %>%
  filter(category=='Cases') %>%
  group_by(case_type, year) %>%
  summarise(cases=sum(count)) %>%
  ungroup()

# cases with at least one hearing
legrep_cases_hearing_a <- csv_legrep %>%
  filter(category=='Cases with a hearing') %>%
  group_by(case_type, year) %>%
  summarise(cases_hearing=sum(count)) %>%
  ungroup()

# represented applicants
legrep_app_rep_a <- csv_legrep %>%
  filter(category=='Party', party=='Applicant', representation=='Y') %>%
  group_by(case_type, year) %>%
  summarise(app_rep=sum(count)) %>%
  ungroup()

# unrepresented applicants
legrep_app_unrep_a <- csv_legrep %>%
  filter(category=='Party', party=='Applicant', representation=='N') %>%
  group_by(case_type, year) %>%
  summarise(app_unrep=sum(count)) %>%
  ungroup()

# represented respondents
legrep_res_rep_a <- csv_legrep %>%
  filter(category=='Party', party=='Respondent', representation=='Y') %>%
  group_by(case_type, year) %>%
  summarise(res_rep=sum(count)) %>%
  ungroup()

# unrepresented respondents
legrep_res_unrep_a <- csv_legrep %>%
  filter(category=='Party', party=='Respondent', representation=='N') %>%
  group_by(case_type, year) %>%
  summarise(res_unrep=sum(count)) %>%
  ungroup()

# combined
legrep_lookup_annual <- legrep_cases_a %>%
  left_join(legrep_cases_hearing_a, by=c('case_type', 'year')) %>%
  left_join(legrep_app_rep_a, by=c('case_type', 'year')) %>%
  left_join(legrep_app_unrep_a, by=c('case_type', 'year')) %>%
  left_join(legrep_res_rep_a, by=c('case_type', 'year')) %>%
  left_join(legrep_res_unrep_a, by=c('case_type', 'year')) %>%
  filter(year <= annual_year) %>% 
  mutate(total_parties=app_rep+app_unrep+res_rep+res_unrep, lookup=paste0(case_type,"|", year, "|"))

# output
legrep_lookup <- bind_rows(legrep_lookup_quarter,legrep_lookup_annual) %>%
  select(-c(case_type, year, quarter)) %>%
  relocate(lookup) %>%
  arrange(lookup)

# Export ##########################################################################################
# to export as a CSV
Rs3tools::write_df_to_csv_in_s3(legrep_lookup, glue("{csv_folder}legrep_lookup_{pub_year}_Q{pub_quarter}.csv"), overwrite = TRUE, row.names = FALSE)
