SELECT 
  item_count as mode 
FROM items_per_order
WHERE order_occurrences =
(
  SELECT max(order_occurrences) 
  FROM items_per_order
)
