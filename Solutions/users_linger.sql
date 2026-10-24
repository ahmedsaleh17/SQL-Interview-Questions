SELECT 
  os_name, 
  AVG(session_duration_sec) avg_duration 
FROM user_sessions us 
JOIN devices d 
ON us.device_id = d.device_id 
AND d.device_type = 'mobile'
GROUP BY os_name
ORDER BY avg_duration DESC 
LIMIT 1; 