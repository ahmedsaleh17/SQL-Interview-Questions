-- postegresql version solution 
SELECT 
  COUNT(*) FILTER(WHERE device_type = 'laptop') laptop_views,
  COUNT(*) FILTER(WHERE device_type IN ('tablet', 'phone')) mobile_views
FROM viewership;


-- mysql version solution 
SELECT 
  SUM(CASE WHEN device_type = 'laptop' THEN 1 END) AS laptop_views, 
  SUM(CASE WHEN device_type IN('tablet', 'phone') THEN 1 END) AS mobile_views
FROM viewership 