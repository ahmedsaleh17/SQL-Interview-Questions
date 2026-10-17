/* Above the Fold
MetaAsked inMeta

We score how well search did on each query: a 1 when the user clicked nothing, a 3 when they clicked one of the top three results, 
and a 2 when they clicked a result further down. Leave a query unrated when its click outcome was never captured, and return each query ID with its score.
*/


SELECT 
  query_id, 
  CASE 
    WHEN clicked_result <= 3 THEN 3 
    WHEN clicked_result > 3 THEN 2  
    ELSE NULL
  END AS rating
FROM search_queries