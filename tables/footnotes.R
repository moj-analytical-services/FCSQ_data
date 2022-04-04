t15_notes <- c("The types of financial remedy included are as follows: lump sum, maintenance pending suit, property adjustment, periodical payment, pension sharing, pension attachment, secure provision orders and application dismissed.",
               "The HMCTS Reform programme has been rolled out to cover financial remedy cases, with data being entered on the new Core Case Data (CCD) system. Such cases are being copied into FamilyMan (the data source for financial remedy) but please be aware that there are around 2,100 cases that have yet to be copied across. The MoJ and HMCTS are working towards a combined data source that uses both FamilyMan and CCD systems, which will address this existing gap in the data.",
               "Not all applications for financial remedy are correctly recorded in the Familyman database. Analysis of data between 2007/08 and 2010/11 suggest actual figures to be at least 10% higher than those shown above. Most of the 'missing' applications occur in cases where the financial remedy is not contested.",
               "The following application types are not included in these series: for further directions, financial dispute resolution or for interim orders. These are generally after an application had been issued and listed for the first hearing.",
               "These figures relate to the number of disposal events in which one or more types of financial remedy disposals were made (e.g. an order given or a dismissal). Figures on each type of disposals individually were removed from this publication in June 2020 (see accompanying guide for further details)",
               "Some figures may have been revised from previous publications. Minimal changes may be observed in earlier years, whilst larger changes may be seen in more recent quarters")

t16_notes <- c(" '-' indicates data is not available.",
               "A CSV file accompanies this table, which provides data in a machine-readable format that allows a wider range of breakdowns to be produced (including those given in previous publications, for example by ex-parte/on notice and whether power of arrest is attached to order). If you require assistance on using this CSV file, please contact the Statistics team using the details provided at the end of the bulletin.",
               "Applications made can be for both Non-molestation and Occupation orders, so the total number of orders applied for will be greater than the number of applications made.",
               "Some figures may have been revised from previous publications. Minimal changes may be observed in earlier years, whilst larger changes may be seen in more recent quarters",
               "There are different types of applications and orders; exparte (where no notice is given to the respondent) and on notice (where notice is given). This information is not available for total applications or cases as they may include a mix of exparte and on notice types",
               "Some non molestation and occupation orders are applied for and granted in Children Act and Adoption cases rather than domestic violence cases. Only domestic violence cases are included within the cases started/concluded figures.",
               "For domestic violence cases there is no widely used marker for the conclusion of a case; here cases are considered to be concluded in the quarter of the last definitive order in the case.") 
# notes
notes15 <- c("Source:",
             "HMCTS FamilyMan system",
             "",
             "Notes:",
             paste0("1) ", t15_notes[1]),
             paste0("2) ", t15_notes[2]),
             paste0("3) ", t15_notes[3]),
             paste0("4) ", t15_notes[4]),
             paste0("5) ", t15_notes[5]),
             paste0("6) ", t15_notes[6]))

notes16 <- c("Source:",
             "HMCTS FamilyMan system",
             "",
             "Notes:",
             paste0("1) ", t16_notes[1]),
             paste0("2) ", t16_notes[2]),
             paste0("3) ", t16_notes[3]),
             paste0("4) ", t16_notes[4]),
             paste0("5) ", t16_notes[5]),
             paste0("6) ", t16_notes[6]),
             paste0("7) ", t16_notes[7]))