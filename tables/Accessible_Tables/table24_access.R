# Table 24 accessible

# First the csv is reshaped and then columns other than contested probate are added
t24_accessible_a <- probate_csv %>% pivot_wider(names_from = `Grant Type`,
                            values_from = c(Grants_issued, Applications_made)) %>% 
  filter(`Applicant Type` != 'Not Specified') %>% 
  transmute(Year,
            Quarter,
            `Digital or Paper` = Digital_paper_channel,
            `Applicant Type`,
            `Applications Made: Grant of Probate` = `Applications_made_Grant of Probate`,
            `Applications Made: Grant of Administration with Will annexed` = `Applications_made_Grant of Administration with Will annexed`,
            `Applications Made: Grant of Administration` = `Applications_made_Grant of Administration`,
            `Applications Made: All grant types` = `Applications_made_All grant types`,
            `Grants issued: Grant of Probate` = `Grants_issued_Grant of Probate`,
            `Grants issued: Grant of Administration with Will annexed` = `Grants_issued_Grant of Administration with Will annexed`,
            `Grants issued: Grant of Administration` = `Grants_issued_Grant of Administration`,
            `Grants issued: All grant types` = `Grants_issued_All grant types`,
            `Grants revoked` = `Grants_issued_Grants revoked`,
            `Standing Search` = `Grants_issued_Standing Search`
            )


# Now working on contested probate. All contested probate is paper for now
contest_probate_access_all <- contest_probate %>% transmute(Year,
                              Quarter = NA,
                              `Digital or Paper` = 'All',
                              `Applicant Type` = 'All',
                              `Contested Probate cases` = Contested_probate)

contest_probate_access_paper <- contest_probate %>% transmute(Year,
                                         Quarter = NA,
                                         `Digital or Paper` = 'Paper',
                                         `Applicant Type` = 'All',
                                         `Contested Probate cases` = Contested_probate)


contest_probate_access <- bind_rows(contest_probate_access_all, contest_probate_access_paper)

# Joining to the rest of the probate information. Converting Quarter to character as well so binding works correctly
t24_accessible_b <- t24_accessible_a %>% left_join(contest_probate_access, by = c("Year", "Quarter", "Digital or Paper", "Applicant Type")) %>% 
  mutate(Quarter = as.character(Quarter)) %>% arrange(Year, Quarter)

# Now ordering properly. NAs are replaced with -1 as usual
t24_accessible <- bind_rows(t24_accessible_b %>% filter(is.na(Quarter)), 
                            t24_accessible_b %>% filter(!is.na(Quarter)) %>% 
                              mutate(Quarter = paste0('Q', Quarter))) %>% 
  filter(!(Year == 2019 & Quarter %in% c('Q1', 'Q2'))) %>% 
  arrange(`Digital or Paper`, `Applicant Type`) %>% 
  mutate(across(where(is.numeric), ~replace_na(.x, -1)))