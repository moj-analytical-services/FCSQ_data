#Table 14 accessible

#This is just the regular version but with more detailed column names

t14_accessible <- t14_reg %>% rename(`Stage of divorce case reached` = Stage,
                   `0 to 1 quarters after petition` = `0`,
                   `1 to 2 quarters after petition` = `1`,
                   `2 to 3 quarters after petition` = `2`,
                   `3 to 4 quarters after petition` = `3`,
                   `4 to 5 quarters after petition` = `4`,
                   `5 to 6 quarters after petition` = `5`,
                   `6 to 7 quarters after petition` = `6`,
                   `7 to 8 quarters after petition` = `7`,
                   `8 to 9 quarters after petition` = `8`,
                   `9 to 10 quarters after petition` = `9`,
                   `10 or more quarters after petition` = `10+`)