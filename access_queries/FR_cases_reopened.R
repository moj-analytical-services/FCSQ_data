#Query below runs the sql statement through Athena, using the dbtools function

#Query is for case reopened events - Financial remedy*/
 
query_FR_reopened <-  
"SELECT 
   E.CASE_NUMBER,
   E.EVENT,
   E.EVENT_MODEL,  
   E.RECEIPT_DATE,  
   E.ENTRY_DATE,
   E.ERROR
FROM 
   familyman_dev_v2.EVENTS E
WHERE 
   E.ERROR  = 'N'
   AND E.EVENT_MODEL = 'G62'
   AND E.mojap_snapshot_date = date '2020-10-30';"

Table_FR_reopened <- dbtools::read_sql(query_FR_reopened)

#writing data to s3 so that it can be exported - this is just for initial checks of the data against original Access data
s3tools::write_df_to_csv_in_s3(Table_FR_reopened, "alpha-family-data/CSVs/FR_reopened_AP.csv")