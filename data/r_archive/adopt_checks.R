# Adoption checks

adopt_checks_function <- function(){
  # Calling the SQL code for the extracts 
  source(paste0(path_to_project, "adopt_sql.R"))
  
  # RTC
  # Lists all RTC combinations that aren't 'Other or not stated'. Also excluded where there is only one
  # applicant as they will be either 'Step parent' or 'Sole applicant' or 'Other or not stated'. Also
  # excluded where min_rtc is 'Adopter' as we won't know about the relationship to the other applicant
  # from that
  
  # Add any new special cases in the applicant part of the adoption code - near the start of the script
  
  # Current special cases:
  # - Foster carer and sibling recorded as mixed-sex couple
  # - A male uncle and a female uncle recorded as a mixed-sex couple
  # - Aunt and grandmother recorded as same-sex couple
  # - Two siblings recorded as a same-sex couple
  
  sql_adopt_rtc_check <- glue("
/* First generating a list of the adopter type for each case */
WITH {sql_adopt_applicants}

/* Now grouping up to look for any new anomalies to add */
SELECT
  number_applicants,
  min_sex,
  max_sex,
  min_rtc,
  max_rtc,
  adopter,
  COUNT(*) AS count
FROM adopt_adopter
WHERE adopter <> 'Other or not stated'
AND number_applicants > 1
AND min_rtc <> 'Adopter'
GROUP BY
  number_applicants,
  min_sex,
  max_sex,
  min_rtc,
  max_rtc,
  adopter
ORDER BY count
")
  
  # Create a list to check for special cases
  adopt_rtc_check <- dbtools::read_sql(sql_adopt_rtc_check)
  View(adopt_rtc_check)
  
  # Add any special cases to the Adopt_SQL code for applicants
  
  
  # Country of birth
  # Creating a list of the different countries of birth, and keeping those not currently designated as UK/non-UK/Unknown
  sql_adopt_birth_country_check <- glue("
WITH {sql_adopt_country_of_birth}

SELECT DISTINCT country_of_birth
FROM adopt_country_of_birth
")
  
  adopt_birth_country_check <- dbtools::read_sql(sql_adopt_birth_country_check) %>%
    dtplyr::lazy_dt() %>%
    left_join(birth_country_lookup, by="country_of_birth") %>%
    filter(is.na(nationality)==TRUE) %>%
    as.data.table()
  
  # Allocating any countries of birth not seen previously, to either UK, foreign or unknown
  # 9 is unknown, 2 for non-UK and 1 for UK
  
  # View list of uncategorised birth places
  View(adopt_birth_country_check)
}
# Create a data table classifying the birth places. 
# country_of_birth should be a vector of the different places
# nationality should be 9,2 or 1 depending on the type of place

#adopt_birth_country_new <- data.table::data.table(
#  country_of_birth = c("name of place"),
#  nationality = c(2,1,9))

# Joining on the new places of birth and exporting the lookup
#birth_country_lookup <- birth_country_lookup %>%
#  bind_rows(adopt_birth_country_new)
#write_df_to_csv_in_s3(birth_country_lookup, glue("alpha-family-data/CSVs/lookups/adopt_birth_country_lookup.csv"), overwrite = TRUE, row.names = FALSE)


