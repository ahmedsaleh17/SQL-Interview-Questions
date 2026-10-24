SELECT 
  *, 
  duration_seconds * 1.0 as duration_decimal, 
  1.0 * MAX(duration_seconds) OVER()  - duration_seconds AS diff_from_longest
FROM content_items


