WITH compined_cloud_costs AS
(
  SELECT region, svc_name, amount
  FROM cloud_costs
  UNION ALL 
  SELECT region, svc_name, amount
  FROM cost_allocs
)
  
SELECT 
  DISTINCT
  region, 
  FIRST_VALUE(svc_name) OVER(PARTITION BY region ORDER BY amount DESC) AS most_expensive,
  FIRST_VALUE(svc_name) OVER(PARTITION BY region ORDER BY amount ASC) AS cheapest
FROM compined_cloud_costs 



