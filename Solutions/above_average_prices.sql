/* First, get the average lowest base price for each product  */
WITH product_base_price AS (
  SELECT
    product_id,
    MIN(total_amount) AS base_price
  FROM transactions
  GROUP BY product_id
)

SELECT
  product_id,
  MIN(total_amount) AS base_price
FROM transactions
GROUP BY product_id
HAVING MIN(total_amount) > (
  SELECT
    AVG(base_price)
  FROM product_base_price
)