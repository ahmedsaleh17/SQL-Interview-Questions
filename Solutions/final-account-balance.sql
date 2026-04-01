-- Calculate total deposits and withdrawals per account
WITH CTE_Total AS 
(
SELECT 
  account_id, 
  -- Sum all deposits for each account
  SUM(CASE WHEN transaction_type = 'Deposit' THEN amount END) deposit_amount,
  -- Sum all withdrawals for each account
  SUM(CASE WHEN transaction_type = 'Withdrawal' THEN amount END) withdraw_amount
FROM transactions
GROUP BY account_id
) 


-- Calculate net balance for each account
SELECT 
  account_id, 
  deposit_amount - withdraw_amount AS final_amount
FROM CTE_Total 


