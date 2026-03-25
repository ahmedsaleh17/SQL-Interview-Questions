SELECT 
  p.page_id
FROM pages P 
LEFT OUTER JOIN page_likes pl 
ON p.page_id = pl.page_id
WHERE pl.liked_date IS NULL
ORDER BY p.page_id ;  

