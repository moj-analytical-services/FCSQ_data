# notes

t1_notes <- c("'-' indicates data not available due to changes in data collection and recording procedures.",
              "Cases disposed for most case types show the number of cases that were concluded in that quarter, indicated by a final order or a case closure marker. However for domestic violence and forced marriage protection cases there is no widely used marker for the conclusion of a case; here cases are considered to be concluded in the quarter of the last definitive order in the case.",
              "Financial remedy (formerly known as 'ancillary relief') application figures are known to under-represent the actual number of applications made by at least 10% due to data recording issues.",
              "Forced marriage protection orders were introduced on 25 November 2008, and so figures for 2008 do not cover a whole calendar year.",
              "These relate to definitive applications and orders issued under the Adoption and Children Act 2002, including placement, adoption and a few other order types, as shown in the accompanying adoptions csv file.",
              "Case disposal figures for public and private law in 2011 may represent an under-count due to data collection procedures that have now been resolved.",
              "There was a one-off increase in the number of Private law cases in quarter 3 (July to September) 2014 due to an audit by HMCTS of all open private law cases.",
              "Matrimonial matters (including civil partnerships) includes divorce, annulment and judicial separation",
              "Female genital mutilation protection orders were introduced on 17 July 2015, and so figures for Q3 2015 do not cover a whole quarter and figures for 2015 do not cover a whole year",
              "Some figures may have been revised from previous publications. Minimal changes may be observed in earlier years, whilst larger changes may be seen in more recent quarters")


t2_notes <-  c('A CSV file accompanies this table, which provides data in a machine-readable format and gives detailed information about types of orders. Figures for applications and disposals by type of order as published in previous bulletin tables are now given in this CSV file. If you require assistance on using this CSV file, please contact the Statistics team using the details provided at the end of the FCSQ bulletin.',
             'Figures previously published in this table showing the number of children involved in applications, orders and disposals prior to 2011 are now included in the accompanying csv file.',
             'Private law adoptions are not included.',
             'The number of individual children counts children within the specified period. Where a child is involved in two applications in a year across two separate quarters, they will be counted once in each quarter, and once annually. As such, quarterly totals do not sum to annual totals.',
             'The figures in this table differ to the children count in table 3, where children are counted for each order applied for.',
             'An application or disposal can be made in respect of more than one child. Therefore the figures for court events are less than the number of children involved.',
             'A single application can include applications for more than one order, so the total number of orders applied for will be greater than the number of applications made.',
             'Each case is counted only once in the quarter it started (first application made) and in the quarter when its last disposal was made. A case may include more than one application, and therefore the figures for cases are less than the number of children involved and court events.',
             'Orders and total disposal figures do not include interim orders. For interim order numbers please see the accompanying csv file and table 4.',
             'More than one order can be granted in a single event. The number of disposal events counts where orders/disposals are made within a single event as recorded on Familyman.',
             'There was a one-off increase in the number of Private law cases in quarter 3 (July to September) 2014 due to an audit by HMCTS of all open private law cases.',
             'Some figures may have been revised from previous publications. Minimal changes may be observed in earlier years, whilst larger changes may be seen in more recent quarters.')

t10_notes <- c("Self-representation is determined by the field 'legal representation' in Familyman being left blank. Therefore, this is only a proxy measure and parties without a recorded representative are not necessarily self-representing litigants in person.",
               "Adoption timeliness figures cover applications for standard, convention and foreign adoptions. They do not cover placement cases. Q3 2014 figures were inflated by a data cleansing exercise which involved closing old cases, which particularly affected the mean disposal time.",
               "Divorce timeliness figures (measured to decree nisi) include annulments and judicial separations, as well as financial remedies. The representation status may refer to divorce (including civil partnerships) or financial remedy proceedings (formerly known as 'ancillary relief'). Cases involving financial remedies are those which had an application or order made for one or more financial remedies at the time the data was extracted for this publication.",
               "Duration is calculated from the earliest application/petition date (or date the case was transferred in to the court if earlier) to the date of the earliest disposal/decree nisi.",
               "The mean duration is calculated as the total of all durations within the category, divided by the number of orders/decrees nisi. Median figures can now be found in the csv file that accompanies this table.",
               "A party is considered 'applicant-represented' if at least one applicant has a recorded representative, and likewise for respondents.",
               "'All types' includes a small number of disposals where representation status is unknown, so may exceed the sum of the other categories. In addition, these figures may not be identical to those given in other tables for various reasons - such as incomplete or invalid data, or for Public and Private law the fact that the above figures only relate to specific order types.",
               "The large volume of decree nisi (disposals) seen in Q1 and Q2 2016 is due to the clearance of the backlog following the creation of the new centralised divorce centre for London and the South East Region during 2015.",
               "The majority of Public law applicants are public bodies with access to their own legal resources - however, this legal representation is often not recorded. To address this we introduced a new methodology which assumes that all public body applicants have legal representation.",
               "Some figures may have been revised from previous publications. Minimal changes may be observed in earlier years, whilst larger changes may be seen in more recent quarters",
               "Due to recording errors for some paper petitions, the date when the petition was issued have been incorrectly recorded as the date the petition was received by HMCTS from September 2020. This has resulted in the receipt and issue date being the same and it is estimated to affect around 47% of paper petitions to June 2021. This means that some petitions recorded as been received in one quarter may have actually been received in an earlier quarter, and this would also shorten times to decree nisi and absolute (by around a week).",
               "As a result of moving to a more robust data source of FamilyMan (for paper cases) and Core Case Data (CCD, for digital cases) for financial remedy, we are unable to provide Q4 2021 (and 2021) timeliness figures for this release. This information will be added in the next publication due June 2022.")

               
               
               
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

notes1 <- c("Source:",
             "HMCTS FamilyMan and HMCTS Core Case Data",
             "",
             "Notes:",
             paste0("1) ", t1_notes[1]),
             paste0("2) ", t1_notes[2]),
             paste0("3) ", t1_notes[3]),
             paste0("4) ", t1_notes[4]),
             paste0("5) ", t1_notes[5]),
             paste0("6) ", t1_notes[6]),
             paste0("7) ", t1_notes[7]),
             paste0("8) ", t1_notes[8]),
             paste0("9) ", t1_notes[9]),
             paste0("10) ", t1_notes[10]))


notes2 <- c("Source:",
             "HMCTS FamilyMan system",
             "",
             "Notes:",
             paste0("1) ", t2_notes[1]),
             paste0("2) ", t2_notes[2]),
             paste0("3) ", t2_notes[3]),
             paste0("4) ", t2_notes[4]),
             paste0("5) ", t2_notes[5]),
             paste0("6) ", t2_notes[6]),
             paste0("7) ", t2_notes[7]),
             paste0("8) ", t2_notes[8]),
             paste0("9) ", t2_notes[9]),
             paste0("10) ", t2_notes[10]),
             paste0("11) ", t2_notes[11]),
             paste0("12) ", t2_notes[12]))

notes10 <- c("Source:",
             "HMCTS FamilyMan and HMCTS Core Case Data",
             "",
             "Notes:",
             paste0("1) ", t10_notes[1]),
             paste0("2) ", t10_notes[2]),
             paste0("3) ", t10_notes[3]),
             paste0("4) ", t10_notes[4]),
             paste0("5) ", t10_notes[5]),
             paste0("6) ", t10_notes[6]),
             paste0("7) ", t10_notes[7]),
             paste0("8) ", t10_notes[8]),
             paste0("9) ", t10_notes[9]),
             paste0("10) ", t10_notes[10]),
             paste0("11) ", t10_notes[11]),
             paste0("12) ", t10_notes[12]))

notes11 <- c("Source:",
             "HMCTS FamilyMan and HMCTS Core Case Data",
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