# Adopt SQL extracts for applications and orders, also for details of applicants and children

# Applicants - creating the adopter type - for use in other queries
sql_adopt_applicants <- glue("
/* All cases counting the number of applicants on each case, with min/max gender/rtcd */
adopt_all_applicants AS(
SELECT
  r.case_number,
  r.role,
  f.value AS rtc,
  p.gender
FROM {database}.parties p
INNER JOIN {database}.roles r
  ON p.party = r.party
INNER JOIN {database}.role_fields f
  ON r.role = f.role
WHERE p.mojap_snapshot_date = DATE{snapshot_date}
  AND r.mojap_snapshot_date = DATE{snapshot_date}
  AND f.mojap_snapshot_date = DATE{snapshot_date}
  AND r.role_model = 'APLZ'
  AND f.field_model = 'APLZ_RTC'),

/* Counting the number of applicants on each case, with min/max gender/rtc */
adopt_group_applicants AS(
SELECT
  case_number,
  COUNT(role) AS number_applicants,
  MIN(gender) AS min_sex,
  MAX(gender) AS max_sex,
  MIN(rtc) AS min_rtc,
  MAX(rtc) AS max_rtc
FROM adopt_all_applicants
GROUP BY case_number),

/* Specifying the type of adopter */
adopt_adopter AS(
SELECT
  case_number,
  number_applicants,
  min_sex,
  max_sex,
  min_rtc,
  max_rtc,
  CASE
  
/* Special cases */
    WHEN min_rtc = 'Foster Carer' AND max_rtc = 'Sibling'
        THEN 'Other or not stated'
    WHEN number_applicants > 1 AND min_sex=1 AND max_sex=2 AND min_rtc = 'Uncle' AND max_rtc = 'Uncle'
        THEN 'Other or not stated'
    WHEN min_rtc = 'Aunt' AND max_rtc = 'Grandmother'
        THEN 'Other or not stated'
    WHEN number_applicants > 1 AND min_rtc = 'Sibling' AND max_rtc = 'Sibling'
        THEN 'Other or not stated'
        
/* General processing */  
    WHEN min_rtc LIKE 'Step%' OR max_rtc LIKE 'Step%'
        THEN 'Step parent'
    WHEN min_rtc LIKE 'Natural%' OR max_rtc LIKE 'Natural%'
        THEN 'Other or not stated'
    WHEN number_applicants > 2 
        THEN 'Other or not stated'
    WHEN min_rtc = 'Other' OR max_rtc = 'Other'
        THEN 'Other or not stated'
    WHEN (min_rtc IN ('Child','Adoption Agency','Central Authority','Home Office','Local Authority','Voluntary Organisation') 
      AND max_rtc IN ('Child','Adoption Agency','Central Authority','Home Office','Local Authority','Voluntary Organisation')) 
        THEN 'Other or not stated'
    WHEN (min_rtc IN ('Child','Adoption Agency','Central Authority','Home Office','Local Authority','Voluntary Organisation') 
      OR max_rtc IN ('Child','Adoption Agency','Central Authority','Home Office','Local Authority','Voluntary Organisation')) 
        THEN 'Sole applicant'
    WHEN number_applicants > 1 AND min_sex=1 AND max_sex=1
        THEN 'Same sex couple'
    WHEN number_applicants > 1 AND min_sex=2 AND max_sex=2
        THEN 'Same sex couple'
    WHEN number_applicants > 1 AND min_sex=1 AND max_sex=2
        THEN 'M/F couple'
    WHEN number_applicants > 1
        THEN 'Other or not stated'
    ELSE 'Sole applicant'
    END AS adopter
FROM adopt_group_applicants)
")

# Country of birth - Generating a list of the country of birth for each case
sql_adopt_country_of_birth <- glue("
adopt_country_of_birth AS(
SELECT
  f.event,
  LOWER(f.value) AS country_of_birth,
  e.case_number
FROM {database}.event_fields f
LEFT JOIN {database}.events e
ON f.event = e.event
WHERE f.field_model IN('A70_5','A76_2','A77_10','A78_13','A12_1','A15_1')
  AND f.mojap_snapshot_date = DATE{snapshot_date}
  AND e.mojap_snapshot_date = DATE{snapshot_date})
")

# Children - Generating a list of all the children with the DOB and gender
sql_adopt_children <- glue("
adopt_children AS(
SELECT DISTINCT
  r.case_number,
  r.role,
  r.party,
  DATE(p.dob) AS dob,
  CASE WHEN p.gender=1 THEN 'Male'
        WHEN p.gender=2 THEN 'Female'
        ELSE 'Unknown'
        END AS child_sex
FROM {database}.parties p
INNER JOIN {database}.roles r
  ON p.party = r.party
WHERE r.role_model = 'CHLDZ'
  AND r.mojap_snapshot_date = DATE{snapshot_date}
  AND p.mojap_snapshot_date = DATE{snapshot_date})
")

# Applications - table of all applications and the adopter type
# Please note that further processing is carried out in the Adopt script
sql_adopt_all_apps <- glue(
  "
/* First generating a list of the adopter type for each case */
WITH {sql_adopt_applicants},

/* U21 adoption act events */
adopt_u21_events AS(
SELECT e.case_number,
  e.event,
  CASE 
    WHEN e.receipt_date IS NULL AND e.entry_date <= date_parse(g.value,'%Y-%m-%d') 
        THEN e.entry_date
    WHEN e.receipt_date IS NULL OR date_parse(g.value,'%Y-%m-%d') <= receipt_date 
      THEN date_parse(g.value,'%Y-%m-%d')
    ELSE e.receipt_date 
    END AS app_date,
  f.value AS app_type,
  h.value AS high_court
FROM {database}.events e
INNER JOIN {database}.event_fields f
  ON e.event = f.event
INNER JOIN {database}.event_fields g
  ON e.event = g.event
INNER JOIN {database}.event_fields h
  ON e.event = h.event
WHERE e.mojap_snapshot_date = DATE'2020-10-30'
  AND f.mojap_snapshot_date = DATE'2020-10-30'
  AND g.mojap_snapshot_date = DATE'2020-10-30'
  AND h.mojap_snapshot_date = DATE'2020-10-30'
  AND e.event_model = 'U21'
  AND f.field_model = 'U21_1'
  AND g.field_model = 'U21_2'
  AND h.field_model = 'U21_HC'),

/* G50 adoption act events */
adopt_g50_events AS(
SELECT e.case_number,
  e.event,
  CASE WHEN e.receipt_date IS NULL 
          THEN e.entry_date
        ELSE e.receipt_date 
        END AS app_date,
  CASE WHEN f.value LIKE '%RUK%' AND f.value LIKE '%CCS%' 
          THEN 'RUK,CCS'
        WHEN f.value LIKE '%RUK%' 
          THEN 'RUK'
        WHEN f.value LIKE '%CCS%' 
          THEN 'CCS'
        END AS app_type,
  'N' AS high_court
FROM {database}.events e
INNER JOIN {database}.event_fields f
  ON e.event = f.event
WHERE e.mojap_snapshot_date = DATE'2020-10-30'
  AND f.mojap_snapshot_date = DATE'2020-10-30'
  AND f.field_model = 'G50_AT'
  AND (f.value LIKE '%RUK%' OR f.value LIKE '%CCS%')),

/* Binding together the U21 and G50 events*/
adopt_all_events AS(
SELECT case_number,
  app_date,
  EXTRACT(year FROM app_date) AS year,
  EXTRACT(quarter FROM app_date) AS quarter,
  event,
  app_type,
  high_court,
  CASE WHEN app_type IN('AO','CA','PFO','AD','PF','SP')
     THEN 1
    ELSE 0
    END AS no_other_flag
FROM adopt_u21_events
WHERE case_number <> 'CV11Z00105'

UNION ALL

SELECT case_number,
  app_date,
  EXTRACT(year FROM app_date) AS year,
  EXTRACT(quarter FROM app_date) AS quarter,
  event,
  app_type,
  high_court,
  CASE WHEN app_type IN('AO','CA','PFO','AD','PF','SP')
     THEN 1
    ELSE 0
    END AS no_other_flag
FROM adopt_g50_events
WHERE case_number <> 'CV11Z00105')

/* Joining the adopter information onto the application and creating a separate entry for each application type*/
SELECT a.case_number,
  a.app_date AS receipt_date,
  a.year,
  a.quarter,
  a.event,
  CAST(SUBSTR(CAST(a.event AS varchar),1,3) AS integer) AS court_code,
  app_type_new,
  CASE WHEN app_type_new IN('AO','AD','SP',' AO',' AD',' SP') 
          THEN 'Standard'
        WHEN app_type_new IN('CA',' CA') 
          THEN 'Convention'
        WHEN app_type_new IN('PF','PFO',' PF',' PFO') 
          THEN 'Foreign'
        WHEN app_type_new IN('PLA','FO',' PLA', ' FO') 
          THEN 'Placement'
        WHEN app_type_new IN('RPLA','VPLA',' RPLA',' VPLA') 
          THEN 'Revoke or vary placement'
        WHEN app_type_new IN('CNO',' CNO') 
          THEN 'Contact S26'
        WHEN app_type_new IN('RCNO','VCNO',' RCNO',' VCNO') 
          THEN 'Revoke or vary contact S26'
        WHEN app_type_new IN('CCS',' CCS') 
          THEN 'Change surname'
        WHEN app_type_new IN('RUK',' RUK') 
          THEN 'Remove child from UK'
        WHEN app_type_new IN('OR','PT10', 'PT9','S84','S88','S89',' OR',' PT10', ' PT9',' S84',' S88',' S89') 
          THEN 'Other order type'
        END AS app_type,
  CASE WHEN app_type_new IN('AO','AD','CA','PF','PFO','SP',' AO',' AD',' CA',' PF',' PFO',' SP') AND no_other_flag = 1 
          THEN 'Adoption'
        WHEN app_type_new IN('AO','AD','CA','PF','PFO','SP',' AO',' AD',' CA',' PF',' PFO',' SP')
          THEN 'Adoption+other'
        ELSE 'Non-adoption'
        END AS adoption,
  a.high_court,
  CASE WHEN b.adopter IS NULL
          THEN 'Other or not stated'
        ELSE b.adopter
        END AS adopter
FROM adopt_all_events a
CROSS JOIN UNNEST(SPLIT(a.app_type,',')) AS t(app_type_new)
LEFT JOIN adopt_adopter b
  ON a.case_number=b.case_number
WHERE app_type_new IN('AO','CA','PFO','AD','PF','SP','FO','PLA','RPLA','VPLA','CNO','RCNO','VCNO','CCS','RUK','OR','PT10','PT9','S84','S88','S89',' AO',' CA',' PFO',' AD',' PF',' SP',' FO',' PLA',' RPLA',' VPLA',' CNO',' RCNO',' VCNO',' CCS',' RUK',' OR',' PT10',' PT9',' S84',' S88',' S89')
")

# Orders - table of all orders with the adopter type, country of birth (where relevent), age and gender of child
# Please note that further processing is carried out in the Adopt script
sql_adopt_all_ords <- glue(
  "
/* First generating a list of the adopter type for each case */
WITH {sql_adopt_applicants},

/* Generating a list of the country of birth for each case */
{sql_adopt_country_of_birth},
  
/* Generating a list of all the children with the DOB and gender */
{sql_adopt_children},

/* Extracting the order type */
adopt_order_type AS(
SELECT
  event,
  value AS order_type
FROM {database}.event_fields f
WHERE mojap_snapshot_date = DATE{snapshot_date}
  AND field_model IN('A73_1','A74_2','A80_4','G63_1','ORDNOM_5','ORDREF_5','A81_5')),

  
/* Extracting the basic event information and joining on order type */
adopt_orders AS(
SELECT 
  e.case_number,
  e.event,
  CASE WHEN e.receipt_date IS NULL 
          THEN e.entry_date
        ELSE e.receipt_date 
        END AS receipt_date,
  c.country_of_birth,
  CASE WHEN e.event_model IN('A15','A76','A77') 
          THEN 'Adoption'
        WHEN e.event_model IN('G63','ORDREF','ORDNOM') 
          THEN 'No order made'
        ELSE 'Non-adoption'
        END AS adoption,
  CASE WHEN e.event_model='A77'
          THEN 'Convention'
        WHEN country_of_birth <> '' AND e.event_model='A76'
          THEN '?Foreign?'
        WHEN e.event_model IN('A76','A15')
          THEN 'Standard'
        WHEN e.event_model IN('A12','A70')
          THEN 'Placement'
        WHEN e.event_model IN('A13','A71','A71')
          THEN 'Placement_revoke_or_vary'
        WHEN o.order_type='CNO'
          THEN 'Contact S26'
        WHEN o.order_type IN('RCNO','VCNO','OFNC')
          THEN 'Revoke or vary contact S26'
        WHEN o.order_type = 'CCS'
          THEN 'Change surname'
        WHEN e.event_model IN('A75','A78','A79','A80')
          THEN 'Other order type'
        WHEN e.event_model='ORDNOM'
          THEN 'No order made'
        WHEN e.event_model = 'ORDREF'
          THEN 'Order refused'
        WHEN e.event_model = 'G63'
          THEN 'Application withdrawn'
        END AS type
FROM {database}.events e
LEFT JOIN adopt_order_type o
  ON e.event = o.event
LEFT JOIN adopt_country_of_birth c
  ON e.event = c.event
WHERE e.mojap_snapshot_date = DATE{snapshot_date}
  AND e.case_number <> 'CV11Z00105'
  AND e.error = 'N'
  AND e.event_model IN('A12','A13','A15','A70','A71','A72','A73','A74','A75','A76','A77','A78','A79','A80','G63','ORDREF','ORDNOM')
  AND (e.event_model NOT IN('G63','ORDNOM','ORDREF') OR e.case_number LIKE '____A%' OR e.case_number LIKE '____Z%'))
  
/* Adding on details relating to parties */
SELECT 
  o.case_number,
  o.receipt_date,
  EXTRACT(year FROM o.receipt_date) AS year,
  EXTRACT(quarter FROM o.receipt_date) AS quarter,
  o.event,
  CAST(SUBSTR(CAST(o.event AS varchar),1,3) AS integer) AS court_code,
  o.country_of_birth,
  o.adoption,
  o.type,
  c.child_sex,
  DATE_DIFF('day',c.dob,o.receipt_date)/365.25 AS child_age,
  CASE WHEN o.receipt_date IS NULL OR c.dob IS NULL
          THEN 'Unknown'
        WHEN DATE_DIFF('day',c.dob,o.receipt_date)/365.25 < 0
          THEN 'Other'
        WHEN DATE_DIFF('day',c.dob,o.receipt_date)/365.25 < 1
          THEN '<1 year'
        WHEN DATE_DIFF('day',c.dob,o.receipt_date)/365.25 < 5
          THEN '1-4 years'
        WHEN DATE_DIFF('day',c.dob,o.receipt_date)/365.25 < 10
          THEN '5-9 years'
        WHEN DATE_DIFF('day',c.dob,o.receipt_date)/365.25 < 15
          THEN '10-14 years'
        WHEN DATE_DIFF('day',c.dob,o.receipt_date)/365.25 < 18
          THEN '15-17 years'
        ELSE 'Other'
        END AS age_band,
  a.adopter
FROM adopt_orders o
LEFT JOIN adopt_children c
  ON o.case_number = c.case_number
LEFT JOIN adopt_adopter a
  ON o.case_number = a.case_number
")