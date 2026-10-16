SELECT 
  pipe_name, 
  priority, 
  MIN(dur_secs) as min_duration, 
  AVG(dur_secs) as avg_duration, 
  MAX(dur_secs) as max_duration
  
FROM data_pipes dp 
JOIN batch_jobs bj 
ON SUBSTRING(dp.start_at, 1, 10) = SUBSTRING(bj.started, 1, 10)
WHERE LOWER(dp.status) = 'success' AND dp.start_at > '2026-01-01'
GROUP BY pipe_name, priority; 














