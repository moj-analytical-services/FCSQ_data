################################################################################
# Accessible T15
#This is built from using code from regular T15 so run that first

################################################################################

full_t15 <- bind_rows(t15_reg_year, t15_reg_qtr) %>% select(!starts_with("blank"))

colnames(full_t15) <- c('Year', 'Quarter' ,'Uncontested Applications', 'Contested Applications',
                                   'Total Applications', 'Cases starting', 'Uncontested Disposals',
                                   'Initially Contested Disposals', 'Contested Disposals',
                                   'Total Disposals', 'Cases closed')

t15_accessible <- full_t15