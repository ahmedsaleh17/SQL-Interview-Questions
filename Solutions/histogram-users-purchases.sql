-- Main query: Select the most recent transaction details for each user
SELECT
  transaction_date, 
  user_id, 
  purchase_count
FROM
(
  -- Subquery: Calculate purchase counts and rank transactions by date for each user
  SELECT 
    transaction_date, 
    user_id, 
    count(*) as purchase_count, -- Count number of purchases on each transaction date
    -- Rank transactions by date (most recent first) for each user
    row_number() over(partition by user_id order by transaction_date DESC) rn
  FROM user_transactions
  -- Group by date and user to aggregate purchase counts
  GROUP BY transaction_date, user_id
)t  
-- Filter to keep only the most recent transaction (rank = 1) for each user
where rn = 1
-- Sort results chronologically by transaction date
order by transaction_date