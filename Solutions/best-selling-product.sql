SELECT 
  category_name, 
  product_name
FROM 
(
SELECT 
  p.product_name, 
  p.category_name, 
  ps.sales_quantity, 
  ps.rating,
  DENSE_RANK() OVER(PARTITION BY p.category_name ORDER BY ps.sales_quantity DESC, rating DESC) AS ranking
FROM products AS p 
JOIN product_sales AS ps 
ON p.product_id = ps.product_id
)T
WHERE ranking = 1