-- ===================================================================
-- SQL QUERY: Swapped Food Delivery Items
-- PURPOSE: Correct food delivery orders by swapping items between odd-even order pairs
-- LOGIC: Odd orders get the next item, even orders get the previous item
-- USES: Window functions (LEAD, LAG), CASE statement, COALESCE
-- ===================================================================

SELECT
  order_id AS correct_order_id, 
  -- COALESCE: Returns swapped item if available, otherwise returns original item
  COALESCE(
    CASE 
      -- For odd order IDs: get the item from the next order (LEAD)
      WHEN order_id % 2 != 0 THEN LEAD(item) OVER(ORDER BY order_id)
      -- For even order IDs: get the item from the previous order (LAG)
      ELSE LAG(item) OVER (ORDER BY order_id)
    END, 
    -- Fallback to original item if no swap exists (e.g., last order when swapping forward)
    item
  ) AS item
FROM orders
 