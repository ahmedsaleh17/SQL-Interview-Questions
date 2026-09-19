SELECT
  ad_campaign,
  COUNT(impression_id) AS impressions,
  SUM(revenue) AS total_revenue,
  ROUND(100 * SUM(clicked) / COUNT(impression_id), 1) AS ctr
FROM ad_impressions
GROUP BY ad_campaign
HAVING COUNT(impression_id) > 16
ORDER BY ctr DESC




