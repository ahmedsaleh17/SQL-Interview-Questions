SELECT 
  user_id, 
  DATEDIFF(Last_post_date, first_post_date) AS days_between
FROM
(
  SELECT 
    user_id, 
    MIN(DATE(post_date)) AS first_post_date, 
    MAX(DATE(post_date)) AS last_post_date
  FROM posts 
  WHERE YEAR(DATE(post_date)) =2021 
  GROUP BY user_id
)t
WHERE DATEDIFF(Last_post_date, first_post_date) != 0