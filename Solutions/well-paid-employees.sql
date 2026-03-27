-- self join 
SELECT 
  e.employee_id AS employee_id, 
  e.name AS employee_name
FROM employee e 
INNER JOIN employee mang 
on e.manager_id = mang.employee_id 
WHERE e.salary > mang.salary
LIMIT 5;