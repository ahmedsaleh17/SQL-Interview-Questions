-- Query to find users who have shopping sprees (makes purchases on 3 or more consecutive days.)
SELECT 
  user_id
FROM 
(
  -- Subquery: Calculate days between current transaction and transaction 2 positions ahead
  SELECT 
    user_id, 
    -- LEAD retrieves the transaction_date from 2 rows ahead, partitioned by user_id
    -- This helps identify transactions that are 2 days apart
    LEAD(transaction_date, 2) OVER(PARTITION BY user_id ORDER BY transaction_date) ::date - transaction_date ::date AS days
  FROM transactions
) T 
-- Filter for transactions where the gap between 1st and 3rd transaction is exactly 2 days
WHERE days = 2