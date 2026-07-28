-- Funnel broken down by device type (desktop/mobile/tablet)
SELECT
  device.deviceCategory AS device_type,
  COUNT(DISTINCT CONCAT(fullVisitorId, CAST(visitId AS STRING))) AS total_sessions,
  COUNT(DISTINCT CASE WHEN hits.eCommerceAction.action_type = '2' 
        THEN CONCAT(fullVisitorId, CAST(visitId AS STRING)) END) AS product_views,
  COUNT(DISTINCT CASE WHEN hits.eCommerceAction.action_type = '3' 
        THEN CONCAT(fullVisitorId, CAST(visitId AS STRING)) END) AS add_to_cart,
  COUNT(DISTINCT CASE WHEN hits.eCommerceAction.action_type = '6' 
        THEN CONCAT(fullVisitorId, CAST(visitId AS STRING)) END) AS purchases
FROM
  `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
  UNNEST(hits) AS hits
WHERE
  _TABLE_SUFFIX BETWEEN '20170101' AND '20170131'
GROUP BY
  device_type
ORDER BY
  total_sessions DESC
