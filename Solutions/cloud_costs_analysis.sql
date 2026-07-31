-- Display all service name that has average cost greater than the overall average cost 
SELECT 
  DISTINCT svc_name 
FROM 
(
    -- use window function to find the overall average and average cost per service name
  SELECT 
    svc_name, 
    avg(amount) over() overall_avg, 
    avg(amount) over(partition by svc_name) avg_cost
  FROM cloud_costs 
) T
WHERE avg_cost > overall_avg
ORDER BY svc_name 




