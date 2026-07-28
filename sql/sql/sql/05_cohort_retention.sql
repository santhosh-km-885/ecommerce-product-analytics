-- Cohort retention: users whose first visit was in Jan 2017, tracked through Jun 2017
WITH first_visit AS (
  SELECT
    fullVisitorId,
    MIN(PARSE_DATE('%Y%m%d', date)) AS cohort_month
  FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`
  WHERE
    _TABLE_SUFFIX BETWEEN '20170101' AND '20170630'
  GROUP BY
    fullVisitorId
  HAVING
    cohort_month BETWEEN '2017-01-01' AND '2017-01-31'
),
all_visits AS (
  SELECT
    fullVisitorId,
    PARSE_DATE('%Y%m%d', date) AS visit_date
  FROM
    `bigquery-public-data.google_analytics_sample.ga_sessions_*`
  WHERE
    _TABLE_SUFFIX BETWEEN '20170101' AND '20170630'
)
SELECT
  DATE_DIFF(DATE_TRUNC(v.visit_date, MONTH), DATE_TRUNC(f.cohort_month, MONTH), MONTH) AS month_number,
  COUNT(DISTINCT v.fullVisitorId) AS active_users
FROM
  first_visit f
JOIN
  all_visits v
ON
  f.fullVisitorId = v.fullVisitorId
GROUP BY
  month_number
ORDER BY
  month_number
