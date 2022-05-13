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

t3_notes <- c('These figures include renewals of interim orders and it is likely that many individual children and cases are counted multiple times.',
              'The number of disposals shown table 4 are not equal to the corresponding number of applications made during the year, because:
     - disposals in one year may relate to applications made in earlier years; and,
     - an application for one type of order may result in another type of order.',
              'These orders refer to section 50 of the Children Act 1989 and relate to children missing from care or emergency protection.',
              'These orders are related to surrogacy and made under the Human Fertilisation and Embryology Act.',
              'Some applications under the Adoption and Children Act 2002 relating to the removal of a child from the UK and change of surname were incorrectly published within Private Law Children Act statistics. These applications are now correctly reported under the adoption act. Applications under the Children Act for ‘leave to remove a child from the UK’ and ‘leave to change surname’ are recorded within ‘post separation support and dispute resolution’ applications and cannot be separately identified.',
              'The figures for enforcement applications include applications for breach of an enforcement order, as it is not possible to separately identify these from applications for breach of a child arrangement order. The figures also include applications to amend existing orders: to either increase/reduce hours to unpaid work or to change the area where you do unpaid work due to moving house',
              'Some figures may have been revised from previous publications. Minimal changes may be observed in earlier years, whilst larger changes may be seen in more recent quarters')

t4_notes <- c('These figures cover orders made only. Figures for other disposal types (Applications withdrawn, Orders refused and Orders of no order) are given in the CSV file that accompanies this publication.',
              'The number of disposals shown in the table above are not equal to the corresponding number of applications made during the year, because:
                - disposals in one year may relate to applications made in earlier years; and,
              - an application for one type of order may result in another type of order.',
              'These orders refer to sections 33 and 34 of the Family Law Act 1986 and relate to children taken, or missing, from a parent or guardian granted a residence order.',
              "These orders refer to section 50 of the Children Act 1989 and relate to children missing from care or emergency protection.",
              'These orders relate to surrogacy and are made under the Human Fertilisation and Embryology Act.',
              'These figures include renewals of interim orders and it is likely that many individual children and cases are counted multiple times. To note that data on interim orders in 2021 is deemed not to be robust enough for publication whilst Family Public Law is undergoing HMCTS Reform (denoted by :). These series will be reinstated as soon as possible.',
              'These orders have been made relating to the same children on the same day. They are not distinct from the individual Supervision and Special Guardianship Order figures elsewhere in the table.',
              'Some figures may have been revised from previous publications. Minimal changes may be observed in earlier years, whilst larger changes may be seen in more recent quarters')

t5_notes <- c('Some figures may have been revised from previous publications. Minimal changes may be observed in earlier years, whilst larger changes may be seen in more recent quarters',
              'Private law adoptions are not included.',
              '"Other" includes those who were aged 18 by the time the order was made, or where the age was not correctly recorded.',
              '"Unknown" includes those where the date of birth was not recorded.',
              'Please note that the quarterly number of individual children counts the number of individual children within a given quarter, rather than the quarterly breakdown of the number of individual children within a year. As such, the quarterly totals do not sum to the relevant annual total.')

t6_notes <- c('Counts are for the number of parties listed in the first application of any individual case, the number of parties listed may change with subsequent applications.',
              'Private law adoptions are not included.',
              'Some figures may have been revised from previous publications. Minimal changes may be observed in earlier years, whilst larger changes may be seen in more recent quarters')  

t7_notes <- c('Counts are for the number of Public or Private law (Children Act) cases indicated as a High court case at application, and do not include cases such as for Wardship or Child Abduction.',
              'Private law adoptions are not included.',
              'Central London DFJ includes: Central Family Court (Principal Registry of the Family Division), Clerkenwell & Shoreditch, Inner London FPC, Lambeth and Wandsworth',
              'Some figures may have been revised from previous publications. Minimal changes may be observed in earlier years, whilst larger changes may be seen in more recent quarters')

t8_notes <- c('The number of disposals relate to the number of children subject to each order, where an application for a Care or Supervision Order was made. This number is not the same as any numbers given in the Public law CSV file because it covers applications for a Care or Supervision order which can have been made in that or any earlier quarter, and only considers a restricted range of disposal events',
              'Valid disposal types are Care orders, Supervision orders, Residence orders, Special Guardianship orders, Orders refused, Orders of No Order and Applications withdrawn.',
              'The median duration is the time within which half the cases reach a disposal, and provides a more representative measure of how long cases take compared with the average (mean) in situations where the data are skewed, with a few very long-duration cases.',
              'Some figures may have been revised from previous publications. Minimal changes may be observed in earlier years, whilst larger changes may be seen in more recent quarters')

t9_notes <- c('Only Private law (Children Act) cases which have been marked as "closed" or with a "final" order have been included in these figures, and so will not match the figures in Tables 1 and 2.',
              'The median duration is the time within which half the cases reach a disposal, and provides a more representative measure of how long cases take compared with the average (mean) in situations where the data are skewed, with a few very long-duration cases.',
              'Some figures may have been revised from previous publications. Minimal changes may be observed in earlier years, whilst larger changes may be seen in more recent quarters')

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

t12_notes <- c("More detailed statistics on divorces in England and Wales are available from the Office for National Statistics (ONS) at: http://www.ons.gov.uk/ons/taxonomy/index.html?nscl=Divorces. Data in ONS publications are based on marriage and adoption data provided by the General Register Office and divorce data (including civil partnerships) provided by the HM Courts and Tribunals Service.",
               "Following the Children and Families Act 2014, couples divorcing are no longer required to provide information on children as part of the divorce process. We have thus decided to remove this field from the accompanying relevant csv file in order to avoid misleading conclusions being made.",
               "Note that when the 'digital' case type filter is selected, the data for for all categories under 'dissolution of marriage' refers only to those that are digital at all stages (i.e. handled by the Courts and Tribunals Service Centres) and excludes any made via a Regional Divorce Centre that may have had petitions made digitally that were subsequently completed via the traditional paper route.",
               "The average timeliness figures are produced by calculating the time from petition (which may be from an earlier period) to the Decree Nisi or Decree Absolute made in that period.",
               "The large volume of decrees nisi seen in Q1 2016 is due to the clearance of the backlog following the creation of the new centralised divorce centre for London and the South East Region during 2015.",
               "Some figures may have been revised from previous publications. Minimal changes may be observed in earlier years, whilst larger changes may be seen in more recent quarters",
               "Due to recording errors for some paper petitions, the date when the petition was issued have been incorrectly recorded as the date the petition was received by HMCTS from September 2020. This has resulted in the receipt and issue date being the same and it is estimated to affect around 48% of paper petitions to December 2021. This means that some petitions recorded as been received in one quarter may have actually been received in an earlier quarter, and this would also shorten times to decree nisi and absolute (by around a week).",
               "Please note that there are around 165 cases missing in 2021 and 45 missing across 2020 and 2019 due to data entry issues.")

t13_notes <- c("Annulments and Judicial Separations are not included. In this table only events that occurred after 1 January 2003 are counted - any financial remedy, hearing and injunction events in the case prior to filing the divorce petition are not counted.",
               "Figures for the more recent quarterly periods will be revised upwards over time as cases progress through the courts",
               "Some figures may have been revised from previous publications. Minimal changes may be observed in earlier years, whilst larger changes may be seen in more recent quarters",
               "Not all applications for financial remedies are correctly recorded on the FamilyMan database. In about 15% of cases with a disposal, no preceding application has been recorded on the system. Most of the 'missing' applications occur in cases where the application was uncontested.",
               "These financial remedy figures cover all types of application and disposal, and are not confined to the types shown in the financial remedy table where only a selected range is used.",
               "These figures include both matrimonial (including civil partnership) and financial remedy hearings.",
               "The number of petitions started in the equivalent quarter which has reached this stage by the date of the most recent quarter (e.g for divorce cases starting in Q4 2021, it is what stage they reached by the end of Q4 2021)",
               "Due to recording errors for some paper petitions, the date when the petition was issued have been incorrectly recorded as the date the petition was received by HMCTS from September 2020. This has resulted in the receipt and issue date being the same and it is estimated to affect around 48% of paper petitions to December 2021. This means that some petitions recorded as been received in one quarter may have actually been received in an earlier quarter, and this would also shorten times to decree nisi and absolute (by around a week).")

t14_notes <- c('Figures are calculated for all petitions made since 1 January 2011. For example, for all the divorce petitions made between Q1 2011 and Q4 2021, 30% reached Decree Nisi within 3 months (or one quarter) after petition.',
               'Some figures may have been revised from previous publications. Minimal changes may be observed in earlier years, whilst larger changes may be seen in more recent quarters',
               'Due to recording errors for some paper petitions, the date when the petition was issued have been incorrectly recorded as the date the petition was received by HMCTS from September 2020. This has resulted in the receipt and issue date being the same and it is estimated to affect around 48% of paper petitions to December 2021. This means that some petitions recorded as been received in one quarter may have actually been received in an earlier quarter, and this would also shorten times to decree nisi and absolute (by around a week).')

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

t17_notes <- c("Forced Marriage Protection Orders (FMPOs) were introduced by the Forced Marriage (Civil Protection) Act on 25 November 2008.",
               " '-' indicates data not available due to changes in data collection and recording procedures.",
               "Breakdown by age of the applicant was not collected centrally until 2010.",
               "Breakdown by type of applicant was revised and expanded as from 2010.",
               "Person be to protected includes applicants in person as well as those with legal representation.",
               "Relevant 3rd party applicants are those that can apply on behalf of the Person to be protected (PTBP). As of November 2009 only local authorities have been granted this status.",
               "Other 3rd party applicants include those from the police, family, Official Solicitor/Next Friend/Guardian ad litem and voluntary sector",
               "Note that the number of cases started counts any case that includes a FMPO application. The vast majority of these are Family Law Act cases (which FMPOs sit under) but there are a small number of Children Act and adoption cases included as well",
               "The number of orders made generally exceed the number of applications as FMPOs are sometimes made during the course of applications for other family orders, and there is no differentiation between interim orders and final orders.",
               "Since breach of an FMPO became a criminal offence in June 2014, courts can no longer attach a power of arrest to an FMPO so orders issued after June 2014 should not be considered as having powers of arrest attached to them.",
               "'Other disposals' include those withdrawn, refused, transferred or where an undertaking was accepted.",
               "For forced marriage protection cases there is no widely used marker for the conclusion of a case; here cases are considered to be concluded in the quarter of the last definitive order in the case.",
               "Note that the number of cases concluded counts any case that includes those which has an FMPO order made. The vast majority of these are Family Law Act cases (which FMPOs sit under) but there are a small number of Children Act and adoption cases included as well",
               "Some figures may have been revised from previous publications. Minimal changes may be observed in earlier years, whilst larger changes may be seen in more recent quarters")

t18_notes <- c("Female Genital Mutilation Protection Orders (FGMPOs) came into effect on 17th July 2015.",
               "Person to be protected includes applicants in person as well as those with legal representation.",
               "Relevant 3rd party applicants are those that can apply on behalf of the Person to be protected (PTBP). Only local authorities have been granted this status.",
               "Other 3rd party applicants include those from the police, family, Official Solicitor/Next Friend/Guardian ad litem and voluntary sector.",
               "Note that the number of cases started counts any case that includes a FGMPO application. The vast majority of these are Family Law Act cases (which FGMPOs sit under) but there are a small number of Children Act and adoption cases included as well",
               "As the breach of an FGMPO is a criminal offence, the courts do not need to attach a power of arrest in relation to FGMPOs.",
               "'Other disposals' include those withdrawn, refused, transferred or where an undertaking was accepted.",
               "For FGMPO cases there is no widely used marker for the conclusion of a case; here cases are considered to be concluded in the quarter of the last definitive order in the case.",
               "Note that the number of cases concluded counts any case that includes a FGMPO order made. The vast majority of these are Family Law Act cases (which FGMPOs sit under) but there are a small number of Children Act and adoption cases included as well",
               "Some figures may have been revised from previous publications. Minimal changes may be observed in earlier years, whilst larger changes may be seen in more recent quarters")

t19_notes <- c("These figures includes Standard and 'Other' adoptions (convention adoptions, foreign adoptions and standard adoptions with a foreign element).",
               "Since April 2011 the data no longer distinguishes married and unmarried mixed-sex couples.",
               "'Not stated' refers to applications where the adopter was not recorded.",
               "These are other non-adoption orders made under the Adoption and Children Act 2002, including revocation of placement, change of surname and removal from the UK.",
               "Applications made by a mixed gender couple with one step-parent and one natural parent are categorised as 'Male/female couple'.",
               "Some figures may have been revised from previous publications. Minimal changes may be observed in earlier years, whilst larger changes may be seen in more recent quarters",
               "A CSV file accompanies this table, which provides data in a machine-readable format that allows a wider range of breakdowns to be produced, for example by type of order. If you require assistance on using this CSV file, please contact the Statistics team using the details provided at the end of the bulletin.")

t20_notes <- c("Some statistics on adoptions in England and Wales are available from the Office for National Statistics (ONS) at: http://www.ons.gov.uk/ons/taxonomy/index.html?nscl=Adoptions. Data in ONS publications are based on adoption data provided by the General Register Office, which maintains the Adopted Child Register using copies of adoption orders issued by courts. There are small differences between the number of adoptions as recorded by the two sets of statistics. Please see the joint statement produced by MoJ, ONS and GRO on the differences in these adoption statistics attached to the 2012 Q4 edition of Court Statistics Quarterly for further details.",
               "These figures includes Standard and 'Other' adoptions (convention adoptions, foreign adoptions and standard adoptions with a foreign element).",
               "Since April 2011 the data no longer distinguishes married and unmarried mixed-sex couples.",
               "'Not stated' refers to applications where the adopter was not recorded.",
               "In a small number of cases the child's sex is not known, so these figures may not sum exactly to the total.",
               "'Other' includes those who were aged 18 by the time the order was made, or where the age was recorded as under 0.",
               "'Unknown' includes those where the date of birth was not recorded.",
               "These are other non-adoption orders made under the Adoption and Children Act 2002, including revocation of placement, change of surname and removal from the UK.",
               "'Other disposals' include those withdrawn, refused and orders of no order.",
               "A CSV file accompanies this table, which provides data in a machine-readable format that allows a wider range of breakdowns to be produced, for example by type of order. If you require assistance on using this CSV file, please contact the Statistics team using the details provided at the end of the bulletin.",
               "Orders for which applications were made by a mixed gender couple with one step-parent and one natural parent are categorised as 'Male/female couple'.",
               "Some figures may have been revised from previous publications. Minimal changes may be observed in earlier years, whilst larger changes may be seen in more recent quarters")
               


# notes added to regular tables

notes1 <- c("Source:",
             "HMCTS FamilyMan and HMCTS Core Case Data",
             "",
             "Notes:",
            glue("{seq_along(t1_notes)}) {t1_notes}"))


notes2 <- c("Source:",
             "HMCTS FamilyMan system",
             "",
             "Notes:",
            glue("{seq_along(t2_notes)}) {t2_notes}"))

notes3 <- c("Source:",
            "HMCTS FamilyMan system",
            "",
            "Notes:",
            glue("{seq_along(t3_notes)}) {t3_notes}"))

notes4 <- c("Source:",
            "HMCTS FamilyMan system",
            "",
            "Notes:",
            glue("{seq_along(t4_notes)}) {t4_notes}"))

notes5 <- c("Source:",
             "HMCTS FamilyMan system",
             "",
             "Notes:",
            glue("{seq_along(t5_notes)}) {t5_notes}"))

notes6 <- c("Source:",
            "HMCTS FamilyMan system",
            "",
            "Notes:",
            glue("{seq_along(t6_notes)}) {t6_notes}"))

notes7 <- c("Source:",
            "HMCTS FamilyMan system",
            "",
            "Notes:",
            glue("{seq_along(t7_notes)}) {t7_notes}"))

notes8 <- c("Source:",
            "HMCTS FamilyMan system",
            "",
            "Notes:",
            glue("{seq_along(t8_notes)}) {t8_notes}"))

notes9 <- c("Source:",
            "HMCTS FamilyMan system",
            "",
            "Notes:",
            glue("{seq_along(t9_notes)}) {t9_notes}"))

notes10 <- c("Source:",
             "HMCTS FamilyMan and HMCTS Core Case Data",
             "",
             "Notes:",
             glue("{seq_along(t10_notes)}) {t10_notes}"))

notes11 <- c("Source:",
             "HMCTS FamilyMan and HMCTS Core Case Data",
             "",
             "Notes:",
             glue("{seq_along(t11_notes)}) {t11_notes}"))

notes12 <- c("Source:",
             "HMCTS FamilyMan and HMCTS Core Case Data",
             "",
             "Notes:",
             glue("{seq_along(t12_notes)}) {t12_notes}"))

notes13 <- c("Source:",
             "HMCTS FamilyMan and HMCTS Core Case Data",
             "",
             "Notes:",
             glue("{seq_along(t13_notes)}) {t13_notes}"))

notes14 <- c("Source:",
             "HMCTS FamilyMan system",
             "",
             "Notes:",
             glue("{seq_along(t14_notes)}) {t14_notes}"))


notes15 <- c("Source:",
             "HMCTS FamilyMan system",
             "",
             "Notes:",
             glue("{seq_along(t15_notes)}) {t15_notes}"))

notes16 <- c("Source:",
             "HMCTS FamilyMan system",
             "",
             "Notes:",
             glue("{seq_along(t16_notes)}) {t16_notes}"))

notes17 <- c("Source:",
             "HMCTS FamilyMan system",
             "",
             "Notes:",
             glue("{seq_along(t17_notes)}) {t17_notes}"))

notes18 <- c("Source:",
             "HMCTS FamilyMan system",
             "",
             "Notes:",
             glue("{seq_along(t18_notes)}) {t18_notes}"))

notes19 <- c("Source:",
             "HMCTS FamilyMan system",
             "",
             "Notes:",
             glue("{seq_along(t19_notes)}) {t19_notes}"))

notes20 <- c("Source:",
             "HMCTS FamilyMan system",
             "",
             "Notes:",
             glue("{seq_along(t20_notes)}) {t20_notes}"))