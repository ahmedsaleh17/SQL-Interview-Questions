SELECT
  SUBSTRING(username, 1, 1) initial,
  COUNT(user_id) as user_count,
  ROUND(100.0* COUNT(user_id) / (SELECT COUNT(*) FROM users), 1) as pct
FROM users
GROUP BY SUBSTRING(username, 1, 1)
order by user_count DESC, initial 


