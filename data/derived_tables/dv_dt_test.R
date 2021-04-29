# DV SQL extracts for applications and orders using the derived tables

# 1. Applications - table of all applications and whether NMO/OO and Ex-parte/On notice
# 2. Orders - table of all orders and whether NMO/OO, Ex-parte/On notice and with POA/not POA

# 1. Applications - table of all applications and whether NMO/OO and Ex-parte/On notice
sql_dv_all_apps_der <- glue("
SELECT 
case_number,
receipt_date,
extract(year FROM receipt_date) AS year,
extract(quarter FROM receipt_date) AS quarter,
event,
CAST(SUBSTR(CAST(event AS varchar),1,3) AS integer) AS court_code,
CASE WHEN app_type LIKE 'On Notice%' THEN 'On notice'
  ELSE 'Ex parte'
  END AS notice_type,
CASE WHEN app_type LIKE '%Occupation' THEN 'Occupation'
  ELSE 'Non-molestation'
  END AS order_type

FROM {der_database}.events_derived
CROSS JOIN UNNEST(application_type_description_array) AS t(app_type)

WHERE mojap_snapshot_date = DATE{snapshot_date}
    AND event_model IN ('U22', 'G50')
    AND (app_type LIKE 'On Notice%' OR app_type LIKE 'Exparte%')")

# 2. Orders - table of all orders and whether NMO/OO, Ex-parte/On notice and with POA/not POA
sql_dv_all_ords_der <- glue("
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

/* Creating a table with all the applications and orders for NMO and OO listed once */
SELECT 
  events_derived.case_number,
  events_derived.receipt_date,
  extract(year FROM events_derived.receipt_date) AS year,
  extract(quarter FROM events_derived.receipt_date) AS quarter,
  events_derived.event,
  CAST(SUBSTR(CAST(events_derived.event AS varchar),1,3) AS integer) AS court_code,
  CASE WHEN ord_type LIKE '%Occupation' THEN 'Occupation'
    ELSE 'Non-molestation'
    END AS order_type, 
  CASE WHEN respondent_attendance.value IS NOT NULL
          THEN 'Ex parte'
        ELSE 'On notice'
        END AS notice_type,
  CASE WHEN poa_flag.flag = 'T'
          THEN 'POA'
        ELSE 'n/a'
        END AS poa
        
FROM {der_database}.events_derived
CROSS JOIN UNNEST(order_type_description_if_in_fields_array) AS t(ord_type)

LEFT JOIN respondent_attendance
  ON events_derived.event = respondent_attendance.event
LEFT JOIN poa_flag
  ON events_derived.case_number = poa_flag.case_number

WHERE event_model IN('FL404B','FL404')
  AND ord_type IN('Non-Molestation', 'Occupation')
  AND events_derived.mojap_snapshot_date = DATE{snapshot_date}
")
