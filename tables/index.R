# Code to fill in the Index table

# Content #########################################################################################

if(pub_quarter=="1"){
  pub_months <- "January to March"
  pub_months_short <- "Jan-Mar"
} else if(pub_quarter=="2"){
  pub_months <- "April to June"
  pub_months_short <- "Apr-Jun"
} else if(pub_quarter=="3"){
  pub_months <- "July to September"
  pub_months_short <- "Jul-Sep"
} else if(pub_quarter=="4"){
  pub_months <- "October to December"
  pub_months_short <- "Oct-Dec"
} else{
  pub_months <- "unknown quarter"
}

titleindex <- paste0("Family Court Statistics Quarterly, ", pub_months, " ", pub_year)

timeperiod <- data.frame(c(paste0("2008 - ", pub_year, " (", pub_months_short, ")"),
                           paste0("2008 - ", pub_year, " (", pub_months_short, ")"),
                           paste0("2008 - ", pub_year, " (", pub_months_short, ")"),
                           paste0("2008 - ", pub_year, " (", pub_months_short, ")"),
                           paste0("2008 - ", pub_year, " (", pub_months_short, ")"),
                           paste0("2008 - ", pub_year, " (", pub_months_short, ")"),
                           paste0("2008 - ", pub_year, " (", pub_months_short, ")"),
                           paste0("2008 - ", pub_year, " (", pub_months_short, ")"),
                           paste0("2011 - ", pub_year, " (", pub_months_short, ")"),
                           paste0("2011 - ", pub_year, " (", pub_months_short, ")"),
                           paste0("2011 - ", pub_year, " (", pub_months_short, ")"),
                           paste0("2011 - ", pub_year, " (", pub_months_short, ")"),
                           paste0("2011 - ", pub_year, " (", pub_months_short, ")"),
                           paste0("2011 - ", pub_year, " (", pub_months_short, ")"),
                           paste0("2011 - ", pub_year, " (", pub_months_short, ")"),
                           paste0("2003 - ", pub_year, " (", pub_months_short, ")"),
                           paste0("2008 (Oct-Dec) - ", pub_year, " (", pub_months_short, ")"),
                           paste0("2015 (Jul-Sep) - ", pub_year, " (", pub_months_short, ")"),
                           paste0("2011 - ", pub_year, " (", pub_months_short, ")"),
                           paste0("2011 - ", pub_year, " (", pub_months_short, ")"),
                           paste0("2008 - ", pub_year, " (", pub_months_short, ")"),
                           paste0("2008 - ", pub_year, " (", pub_months_short, ")"),
                           paste0("2008 - ", pub_year, " (", pub_months_short, ")"),
                           paste0("2012 - ", pub_year, " (", pub_months_short, ")"),
                           paste0("2019 (Apr-Jun) - ", pub_year, " (", pub_months_short, ")")))

publish_dates <- data.frame(c(paste0("Published ", pub_date), paste0("Next update ", next_pub_date)))

# Output ##########################################################################################

# title
openxlsx::writeData(wb = template,
                    sheet = 'Index',
                    x = titleindex,
                    startRow = 1,
                    colNames = F)
openxlsx::addStyle(wb = template,
                   sheet = 'Index',
                   style = openxlsx::createStyle(textDecoration = "bold"),
                   rows = 1,
                   cols = 1,
                   stack = T,
                   gridExpand = T)

# time period
openxlsx::writeData(wb = template,
                    sheet = 'Index',
                    x = timeperiod,
                    startRow = 6,
                    startCol = 4,
                    colNames = F)

# publishing dates
openxlsx::writeData(wb = template,
                    sheet = 'Index',
                    x = publish_dates,
                    startRow = 39,
                    colNames = F)