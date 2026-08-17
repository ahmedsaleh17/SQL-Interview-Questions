SELECT
  session_id, 
  user_id, 
  session_duration_sec
FROM user_sessions
WHERE session_duration_sec <  100 
AND CAST(session_start AS DATE) BETWEEN '2026-01-01' AND '2026-12-31';



-- ANOTHER SOLUTION 
SELECT
  session_id,
  user_id,
  session_duration_sec
FROM user_sessions
WHERE session_duration_sec < 100
AND STRFTIME('%Y', session_start) = '2026'






