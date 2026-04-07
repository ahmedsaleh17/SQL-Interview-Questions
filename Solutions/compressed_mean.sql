SELECT ROUND(
    (SUM(item_count * order_occurrences) * 1.0 
     / SUM(order_occurrences))::DECIMAL,
    1
)
FROM items_per_order;