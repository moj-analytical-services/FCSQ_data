# DV SQL extracts for applications and orders

# 1. Applications - table of all applications and whether NMO/OO and Ex-parte/On notice
# 2. Orders - table of all orders and whether NMO/OO, Ex-parte/On notice and with POA/not POA

# 1. Applications - table of all applications and whether NMO/OO and Ex-parte/On notice
sql_dv_all_apps <- glue("
/* Creating a table with all the applications for NMO and OO listed once */
  SELECT 
  events.case_number,
  events.receipt_date,
  EXTRACT(year FROM events.receipt_date) AS year,
  EXTRACT(quarter FROM events.receipt_date) AS quarter,
  event_fields.event,
  CAST(SUBSTR(CAST(event_fields.event AS varchar),1,3) AS integer) AS court_code,
  CASE WHEN t.value_new LIKE '%NM%' THEN 'Non-molestation'
    ELSE 'Occupation'
    END AS order_type,
  CASE WHEN value_new IN('EO', 'ENM', ' EO', ' ENM') THEN 'Ex parte'
    ELSE 'On notice'
    END AS notice_type
  
  FROM {database}.event_fields
  INNER JOIN {database}.events
    ON event_fields.event = events.event
  CROSS JOIN UNNEST(SPLIT(value,',')) AS t(value_new)
  
  WHERE field_model IN('U22_AT','G50_AT')
    AND value_new IN('EO', 'ONO', 'ENM', 'ONM', ' EO', ' ONO', ' ENM', ' ONM')
    AND events.error = 'N'
    AND event_fields.mojap_snapshot_date = DATE{snapshot_date}
    AND events.mojap_snapshot_date = DATE{snapshot_date}
")

# 2. Orders - table of all orders and whether NMO/OO, Ex-parte/On notice and with POA/not POA
sql_dv_all_ords <- glue("
/* Creating a respondent attendance flag to determine the notice type of orders */
WITH respondent_attendance AS(
  SELECT 
    value, 
    event
  FROM {database}.event_fields
  WHERE field_model IN('FL404_5','FL404B_5')
  AND value = 'F'
  AND mojap_snapshot_date = DATE{snapshot_date}),

/* Creating a Power of Arrest flag for orders */  
poa_flag AS(
  SELECT DISTINCT 
    case_number,
    'T' AS flag
  FROM {database}.events
  INNER JOIN {database}.event_fields
  ON events.event = event_fields.event
  WHERE 
    ((events.event_model = 'FL406' AND events.error = 'N')
    OR (event_fields.field_model = 'FL404B_8' AND event_fields.value = 'Y' AND events.error = 'N')
    OR (event_fields.field_model = 'FL404_67'))
    AND events.mojap_snapshot_date = DATE{snapshot_date}
    AND event_fields.mojap_snapshot_date = DATE{snapshot_date})

/* Creating a table with all the orders for NMO and OO listed once */
SELECT 
  events.case_number,
  events.receipt_date,
  EXTRACT(year FROM events.receipt_date) AS year,
  EXTRACT(quarter FROM events.receipt_date) AS quarter,
  event_fields.event,
  CAST(SUBSTR(CAST(event_fields.event AS varchar),1,3) AS integer) AS court_code,
  CASE WHEN t.value_new LIKE '%NM%' THEN 'Non-molestation'
        ELSE 'Occupation'
        END AS order_type,
  CASE WHEN respondent_attendance.value IS NOT NULL
          THEN 'Ex parte'
        ELSE 'On notice'
        END AS notice_type,
  CASE WHEN poa_flag.flag = 'T'
          THEN 'POA'
        ELSE 'n/a'
        END AS poa
        
FROM {database}.event_fields
INNER JOIN {database}.events
  ON event_fields.event = events.event
CROSS JOIN UNNEST(SPLIT(value,',')) AS t(value_new)
LEFT JOIN respondent_attendance
  ON event_fields.event = respondent_attendance.event
LEFT JOIN poa_flag
  ON events.case_number = poa_flag.case_number

WHERE field_model IN('FL404B_7','FL404_79')
  AND value_new IN('NM', 'OCC',' NM', ' OCC')
  AND events.error = 'N'
  AND event_fields.mojap_snapshot_date = DATE{snapshot_date}
  AND events.mojap_snapshot_date = DATE{snapshot_date}
")