#Query below runs the sql statement through Athena, using the dbtools function

#Query is for children act case reopened events

query_CA_reopened <- 
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
  E.EVENT_MODEL = 'G62'
  AND E.ERROR = 'N'
  AND E.mojap_snapshot_date = date '2020-10-30';"

Table_CA_reopened <- dbtools::read_sql(query_CA_reopened)

#writing data to s3 so that it can be exported - this is just for initial checks of the data against original Access data
s3tools::write_df_to_csv_in_s3(Table_CA_reopened, "alpha-family-data/CSVs/CA_reopened_AP.csv")


