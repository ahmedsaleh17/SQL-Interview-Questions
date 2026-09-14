-- SOL STEPS 
-- FIRST, GET THE FIRST & LAST DAY FOR EACH AD CAMPAIGN 
WITH First_Last_days AS 
(
  SELECT 
    ad_campaign,
    DATE(MIN(impression_time)) First_day, 
    DATE(MAX(impression_time)) Last_day
  FROM ad_impressions
  GROUP BY ad_campaign
)
-- SECOND, JOIN MAIN TABLE WITH THE PREVIOUS CTE TO GET THE COUNT OF IMPRESSION IN THE FIRST AND LAST DAY 
-- THEN, GET THE PRECENTAGE BY DIVIDE THE COUNTS OF THE FIRST AND LAST DAYS BY TOTAL COUNTS 
SELECT 
  ad.ad_campaign, 
  ROUND(100.0*SUM(CASE WHEN DATE(impression_time) = First_day THEN 1 ELSE 0 END) / COUNT(*), 3) AS first_day_pct,
  ROUND(100.0*SUM(CASE WHEN DATE(impression_time) = Last_day THEN 1 ELSE 0 END) / COUNT(*), 3) AS  last_day_pct
FROM ad_impressions ad 
JOIN First_Last_days fld 
ON ad.ad_campaign = fld.ad_campaign
GROUP BY ad.ad_campaign





