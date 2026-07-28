-- Baseline mobile add-to-cart and purchase counts, used as input for the A/B test simulation
SELECT
  COUNT(DISTINCT CASE WHEN hits.eCommerceAction.action_type = '3' 
        THEN CONCAT(fullVisitorId, CAST(visitId AS STRING)) END) AS mobile_add_to_cart,
  COUNT(DISTINCT CASE WHEN hits.eCommerceAction.action_type = '6' 
        THEN CONCAT(fullVisitorId, CAST(visitId AS STRING)) END) AS mobile_purchases
FROM
  `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
  UNNEST(hits) AS hits
WHERE
  _TABLE_SUFFIX BETWEEN '20170101' AND '20170131'
  AND device.deviceCategory = 'mobile'
