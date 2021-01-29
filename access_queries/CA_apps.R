snapshot <- "date '2020-10-30'"

#Query below runs the sql statement through Athena, using the dbtools function

#Application type 01 Children characteristics - Children Act
query_CA_child_chars <-glue(
"SELECT  
  TTE.RECEIPT_DATE, 
  TTC.CODE, 
  TTC.DFJ_AREA_ID, 
  TTE.CREATING_COURT, 
  TTE.CASE_NUMBER, 
  TTF.EVENT, 
  TTF.FIELD_MODEL, 
  TTF.VALUE, 
  TTE.Error              
FROM 
 (familyman_dev_v2.EVENTS TTE 
  LEFT JOIN familyman_dev_v2.EVENT_FIELDS  TTF 
    ON TTE.EVENT = TTF.EVENT) 
  LEFT JOIN familyman_dev_v2.COURTS_MV  TTC
    ON TTE.CREATING_COURT = TTC.COURT
WHERE 
(((TTF.FIELD_MODEL)= 'G50_AT' Or (TTF.FIELD_MODEL)= 'U22_AT') 
  AND ((TTE.Error)= 'N'))
  AND TTE.mojap_snapshot_date = {snapshot}
  AND TTF.mojap_snapshot_date = {snapshot}
  AND TTC.mojap_snapshot_date = {snapshot};")

Table_CA_child_chars <- dbtools::read_sql(query_CA_child_chars)

#writing data to s3 so that it can be exported - this is just for initial checks of the data against original Access data
s3tools::write_df_to_csv_in_s3(Table_CA_child_chars, "alpha-family-data/CSVs/CA_child_chars_AP.csv")

#CHILD PARTIES IN EACH CASE
query_CA_parties <-  
"SELECT
 DISTINCT
  CASE_NUMBER, 
  PARTY, 
  ROLE_MODEL
FROM
  familyman_dev_v2.ROLES
WHERE
  ROLE_MODEL IN ('CHLDC')
  AND mojap_snapshot_date = date '2020-10-30';" 
  
Table_CA_parties <- dbtools::read_sql(query_CA_parties)  

#query for count of children by case number
Table_CA_parties %>% group_by(CASE_NUMBER) %>% summarise(count = n())

Table_CA_parties

#Applicant info
query_CA_app_info <- 
"SELECT 
DISTINCT
  R.ROLE, 
  R.REPRESENTATIVE_ROLE, 
  R.ROLE_MODEL, 
  R.PARTY, 
  R.CASE_NUMBER, 
  P.PERSON_GIVEN_FIRST_NAME, 
  P.PERSON_FAMILY_NAME, 
  P.COMPANY, 
  A.POSTCODE, 
  P.GENDER, 
  R.DELETE_FLAG
FROM 
  (familyman_dev_v2.ROLES R INNER JOIN familyman_dev_v2.PARTIES P ON R.PARTY = P.PARTY) 
  LEFT JOIN familyman_dev_v2.ADDRESSES A ON R.ADDRESS = A.ADDRESS
WHERE 
  (((R.ROLE_MODEL)= 'APLC') AND ((R.DELETE_FLAG)= 'N')) 
  OR (((R.ROLE_MODEL)= 'APLZ') AND ((R.DELETE_FLAG)= 'N')) 
  OR (((R.ROLE_MODEL)= 'APLA') AND ((R.DELETE_FLAG)= 'N'))
  AND R.mojap_snapshot_date = date '2020-10-30'
  AND P.mojap_snapshot_date = date '2020-10-30'
  AND A.mojap_snapshot_date = date '2020-10-30';"

Table_CA_app_info <- dbtools::read_sql(query_CA_app_info)

#Respondant info
query_CA_resp_info <- 
"SELECT 
DISTINCT
  R.ROLE, 
  R.REPRESENTATIVE_ROLE, 
  R.ROLE_MODEL, 
  R.PARTY, 
  R.CASE_NUMBER, 
  P.PERSON_GIVEN_FIRST_NAME, 
  P.PERSON_FAMILY_NAME, 
  P.COMPANY, 
  A.POSTCODE, 
  P.GENDER, 
  R.DELETE_FLAG
FROM 
  (familyman_dev_v2.ROLES R INNER JOIN familyman_dev_v2.PARTIES P ON R.PARTY = P.PARTY) 
  LEFT JOIN familyman_dev_v2.ADDRESSES A ON R.ADDRESS = A.ADDRESS
WHERE 
   (((R.ROLE_MODEL)='RSPC') AND ((R.DELETE_FLAG)='N')) 
    OR (((R.ROLE_MODEL)='RSPA') AND ((R.DELETE_FLAG)='N')) 
    OR (((R.ROLE_MODEL)='RSPZ') AND ((R.DELETE_FLAG)='N'))
  AND R.mojap_snapshot_date = date '2020-10-30'
  AND P.mojap_snapshot_date = date '2020-10-30'
  AND A.mojap_snapshot_date = date '2020-10-30';"

Table_CA_resp_info <- dbtools::read_sql(query_CA_resp_info)

#High court events indicator
query_CA_HC <-
"SELECT 
  EXTRACT(YEAR FROM E.RECEIPT_DATE) AS YEAR,
  EXTRACT(MONTH FROM E.RECEIPT_DATE) AS MONTH,
  E.EVENT_MODEL,
  F.VALUE,
  F.FIELD_MODEL,
  E.EVENT,
  E.CASE_NUMBER,
  E.CREATING_COURT,
  E.ERROR,
  SUBSTR(E.CASE_NUMBER,5,1) AS Expr1
FROM 
  familyman_dev_v2.EVENTS E
  LEFT JOIN familyman_dev_v2.EVENT_FIELDS F
    ON E.EVENT = F.EVENT
WHERE
  Extract(YEAR FROM E.RECEIPT_DATE) >= 2011
  AND E.EVENT_MODEL     = 'U22'
  AND F.FIELD_MODEL = 'U22_HC'
  AND E.ERROR             = 'N'
  AND E.mojap_snapshot_date = date '2020-10-30'
  AND F.mojap_snapshot_date = date '2020-10-30';"

Table_CA_HC <- dbtools::read_sql(query_CA_HC)
