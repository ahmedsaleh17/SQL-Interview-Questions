SELECT 
  user_id, 
  spend, 
  transaction_date
FROM
(
    -- rank customer transaction based on user id as partition and order each partition by date to get the third 
  SELECT 
    *,  
    ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY transaction_date) RN
  FROM transactions 
)AS T 
WHERE RN = 3 

