-- Get policy holder counts 
SELECT 
  COUNT(*) policy_holder_count
FROM 
(
  -- get policy holder data that make more than 3 calls 
  SELECT
  policy_holder_id, 
  COUNT(case_id) 
  FROM callers
  GROUP BY policy_holder_id
  HAVING COUNT(case_id) >=3 
) AS T