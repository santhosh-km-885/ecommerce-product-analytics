-- Funnel broken down by traffic source/medium
SELECT
  trafficSource.medium AS traffic_medium,
  COUNT(DISTINCT CONCAT(fullVisitorId, CAST(visitId AS STRING))) AS total_sessions,
  COUNT(DISTINCT CASE WHEN hits.eCommerceAction.action_type = '6' 
        THEN CONCAT(fullVisitorId, CAST(visitId AS STRING)) END) AS purchases
FROM
  `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
  UNNEST(hits) AS hits
WHERE
  _TABLE_SUFFIX BETWEEN '20170101' AND '20170131'
GROUP BY
  traffic_medium
ORDER BY
  total_sessions DESC
