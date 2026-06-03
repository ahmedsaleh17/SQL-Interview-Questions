SELECT 
  card_name, 
  issued_amount
FROM 
(
SELECT 
  card_name, 
  issued_amount,
  ROW_NUMBER() OVER(PARTITION BY card_name ORDER BY issue_year,issue_month) ranking 
FROM monthly_cards_issued
)T 
WHERE ranking = 1 
ORDER BY issued_amount DESC 


