SELECT 
  city, 
  COUNT(t.*) total_orders
FROM trades AS t 
INNER JOIN users AS u 
ON t.user_id = u.user_id
WHERE t.status = 'Completed'
GROUP BY city 
ORDER BY total_orders DESC
LIMIT 3 