
SELECT ROUND( 1.0* SUM(CASE WHEN  call_category = 'n/a' OR call_category IS NULL  THEN 1 ELSE NULL END) / COUNT(*) *100 , 1 ) uncategorised_call_pct 
FROM callers
