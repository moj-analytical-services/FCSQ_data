# notes
t11_notes <- c("Self-representation is determined by the field 'legal representation' in Familyman being left blank. Therefore, this is only a proxy measure and parties without a recorded representative are not necessarily self-representing litigants in person.",
             "Please note that the latest quarters' figures may reduce in future publications, particularly in regard to parties obtaining legal representation as cases progress. Therefore the latest quarter figures should be considered as provisional. ",
             "In this instance 'at least one hearing' refers to non-vacated scheduled hearings, rather than actual hearings that have taken place.",
             "Unrepresented' refers to parties where the REPRESENTATIVE_ID field has been left blank. Therefore they should be considered as parties without a recorded representative, rather than 'litigants in person'.",
             "Financial Remedy (also known as Ancillary Relief) refers to financial settlements when marriages or civil partnerships are dissolved or annulled. It may be for the former spouse or the couple's child(ren) and covers a range of different types of order including periodical payments, lump sum, pension sharing, property adjustment and maintenance pending suit.",
             "These figures will be an undercount as not all applications for financial remedy are correctly recorded in the Familyman database. Analysis of data between 2007/08 and 2010/11 suggest actual figures to be at least 10% higher than those shown above. Most of the 'missing' applications occur in cases where the financial remedy is not contested. ",
             "Matrimony cases only include divorce (including civil partnerships), not annulment or judicial separation.",
             "Typically, there will always be fewer financial remedy cases than divorce cases, as they are effectively a subset of divorce (many cases will be counted in both tables). However, this may not be true for very recent quarters as hearing dates for each type of case are different, i.e. cases appearing in recent quarters in the FR table may have appeared in an earlier quarter of the divorce table.",
             "The majority of Public law applicants are public bodies with access to their own legal resources, however this legal representation is often not recorded. To address this we introduced a new methodology in 2016 Q4 which assumes that all public body applicants have legal representation. ",
             "Please note the latest quarters will likely change in future as more cases are included – for example the proportion of unrepresented parties in divorce cases in Q1 2020 was 23% in the previous bulletin but is now 26%.",
             "Some figures may have been revised from previous publications. Minimal changes may be observed in earlier years, whilst larger changes may be seen in more recent quarters")



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

notes11 <- c("Source:",
             "HMCTS FamilyMan system",
             "",
             "Notes:",
             paste0("1) ", t11_notes[1]),
             paste0("2) ", t11_notes[2]),
             paste0("3) ", t11_notes[3]),
             paste0("4) ", t11_notes[4]),
             paste0("5) ", t11_notes[5]),
             paste0("6) ", t11_notes[6]),
             paste0("7) ", t11_notes[7]),
             paste0("8) ", t11_notes[8]),
             paste0("9) ", t11_notes[9]),
             paste0("10) ", t11_notes[10]),
             paste0("11) ", t11_notes[11]))


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