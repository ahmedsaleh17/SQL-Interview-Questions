-- CTE: Get max and min issued amounts for each card using window functions
WITH Min_Max_issued AS
(
  SELECT 
    card_name, 
    MAX(issued_amount) OVER(PARTITION BY card_name) AS Max_issued,
    MIN(issued_amount) OVER(PARTITION BY card_name) AS Min_issued
  FROM monthly_cards_issued
)

-- Calculate difference between max and min, sorted descending
SELECT 
  DISTINCT card_name,
  Max_issued - Min_issued AS difference
FROM Min_Max_issued
ORDER BY difference DESC