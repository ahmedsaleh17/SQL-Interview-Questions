SELECT
  COUNT(DISTINCT owner_id) AS distinct_owners
FROM api_tokens
WHERE issued BETWEEN '2026-01-01' AND '2026-12-31'








