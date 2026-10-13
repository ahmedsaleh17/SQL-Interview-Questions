SELECT
  user_id,
  COUNT(view_id) total_views
FROM page_views
WHERE viewed_at BETWEEN '2025-01-01' AND '2025-12-28'
GROUP BY user_id


