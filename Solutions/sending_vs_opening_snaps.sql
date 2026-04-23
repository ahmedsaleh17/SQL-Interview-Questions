-- preparing data
-- cte to calculate the spending time_spent and opening time_spent for each age bucket 
with send_open_time AS
(
  SELECT 
    age_bucket, 
    SUM(CASE WHEN activity_type = 'send' THEN time_spent ELSE 0 END)  time_spent_spending, 
    SUM(CASE WHEN activity_type = 'open' THEN time_spent ELSE 0 END)  time_spent_opening
  FROM activities  act
  JOIN age_breakdown age 
  ON act.user_id = age.user_id
  GROUP BY age_bucket
)

-- 
SELECT 
  age_bucket, 
  ROUND(time_spent_spending / (time_spent_spending + time_spent_opening) * 100.0, 2 ) send_perc,
  ROUND(time_spent_opening / (time_spent_spending + time_spent_opening) * 100.0, 2) open_prec
  
FROM send_open_time