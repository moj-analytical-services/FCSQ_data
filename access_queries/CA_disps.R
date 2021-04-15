#Query below runs the sql statement through Athena, using the dbtools function

#EVENTS PART 1
#CURRENTLY A BIG DIFF BETWEEN AP NUMBERS AND ACCESS NUMBERS SO NEED TO LOOK AT
query_CA_disp_events <-
"SELECT 
  E.EVENT,
  E.CASE_NUMBER,
  E.EVENT_MODEL,
  E.RECEIPT_DATE,
  E.ENTRY_DATE,
  E.ERROR,
  E.CREATING_COURT,
  C.CODE
FROM 
  familyman_dev_v2.EVENTS E
  INNER JOIN familyman_dev_v2.courts_mv C
   ON E.CREATING_COURT = C.COURT
WHERE
(E.EVENT_MODEL IN ('C23','C25','C26','C27','C28','C29',
                   'C30','C31','C32A','C32B','C33','C34A','C34B','C35A','C35B','C37',
                   'C38A','C38B','C39','C40','C42','C43A','C44A','C44B','C45A','C45B',
                   'C53','C80','C81','C82') AND E.ERROR = 'N')  
  OR  (E.EVENT_MODEL = 'CPA' AND E.ERROR = 'N')
AND E.mojap_snapshot_date = date '2020-10-30'
AND C.mojap_snapshot_date = date '2020-10-30';"

Table_CA_disp_events <- dbtools::read_sql(query_CA_disp_events)


# CO CODE (Consent data)
query_CA_CO_data <-
"SELECT
  E.EVENT, 
  E.CASE_NUMBER, 
  E.EVENT_MODEL, 
  E.RECEIPT_DATE, 
  E.Error, 
  E.CREATING_COURT, 
  C.CODE, 
  F.FIELD_MODEL, 
  F.VALUE
FROM 
  (familyman_dev_v2.EVENTS E INNER JOIN familyman_dev_v2.EVENT_FIELDS F ON E.EVENT = F.EVENT) 
  INNER JOIN familyman_dev_v2.COURTS_MV C ON E.CREATING_COURT = C.COURT
WHERE (((E.Error)= 'N') AND ((F.FIELD_MODEL) In ('C21_CO','C23_CO','C24_CO','C25_CO',
                                                 'C26_CO','C27_CO','C28_CO','C29_CO','C30_CO','C31_CO','C32A_CO','C32B_CO','C33_CO','C34A_CO','C34B_CO','C35A_CO','C35B_CO',
                                                 'C36_CO','C37_CO','C38A_CO','C38B_CO','C39_CO','C40_CO','C42_CO','C43_CO','C43A_CO','C44A_CO','C44B_CO','C45A_CO','C45B_CO',
                                                 'C53_CO','C80_CO','C81_CO','C82_CO','CPA_CO','ORDNOM_CO','ORDREF_CO')))
AND E.mojap_snapshot_date = date '2020-10-30'
AND F.mojap_snapshot_date = date '2020-10-30'
AND C.mojap_snapshot_date = date '2020-10-30';"

Table_CA_CO_data <- dbtools::read_sql(query_CA_CO_data)
