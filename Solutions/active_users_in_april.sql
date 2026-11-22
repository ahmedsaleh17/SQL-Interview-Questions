SELECT COUNT(DISTINCT u.user_id) active_users_with_transactions
FROM transactions t 
JOIN users u 
ON t.user_id = u.user_id 
WHERE u.user_id IS NOT NULL 
AND u.account_status = 'active'
AND t.transaction_date BETWEEN '2026-04-01' AND '2026-04-30'








