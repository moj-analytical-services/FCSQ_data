# General functions for processing data from FamilyMan in the Analytical Platform
# Could look to move them to the fcsrap package once code for extracting data from the platform is complete
# Currently easier to keep the functions here whilst changes may be needed

# A function to take the application or order level data and group to case starts or cases disposed
case_groups <- function(event_data, start_end){
  
  event_data <- event_data %>% as.data.table()
  
  if(start_end == 'start'){                                                                   # case starts
    case_data <-
      event_data %>%
      dtplyr::lazy_dt() %>%                                    
      group_by(case_number) %>%                                                               # one entry per case number
      summarise(min_receipt_date = min(receipt_date)) %>%                                     # for each case number, keep just the minimum receipt date
      left_join(event_data, by=c("case_number","min_receipt_date"="receipt_date")) %>%        # join on the rest of the application information by case number and minimum receipt date
      group_by(case_number, receipt_date, year, quarter) %>%                                  # one entry per case number, min receipt date, year and quarter
      summarise(court_code = min(court_code)) %>%                                             # for each row above, take the minimum court code (decides court code to use if multiple apps on the first receipt date)
      as.data.table()
    
  } else if(start_end == 'end'){                                                              # cases disposed
    case_data <-
      event_data %>%
      dtplyr::lazy_dt() %>%
      group_by(case_number) %>%                                                               # one entry per case number
      summarise(max_receipt_date = max(receipt_date)) %>%                                     # for each case number, keep just the minimum receipt date
      left_join(event_data, by=c("case_number","max_receipt_date"="receipt_date")) %>%        # join on the rest of the application information by case number and minimum receipt date
      group_by(case_number, receipt_date, year, quarter) %>%                                  # one entry per case number, min receipt date, year and quarter
      summarise(court_code = min(court_code)) %>%                                             # for each row above, take the minimum court code (decides court code to use if multiple apps on the first receipt date)
      as.data.table()
  }
  
  return(case_data)
}