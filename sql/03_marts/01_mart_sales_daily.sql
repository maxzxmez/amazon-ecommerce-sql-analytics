-- Purpose: Daily aggregated Sales KPIs.
-- Output: mart_sales_daily (VIEW)

CREATE OR REPLACE VIEW `first-project-mmezhenskyi.case_study.mart_sales_daily` AS
SELECT
  date,
  SUM(revenue)                           AS revenue,
  SUM(units)                             AS units,
  SUM(views)                             AS views,
  SUM(sessions)                          AS sessions,
  SAFE_DIVIDE(SUM(units), SUM(sessions)) AS cvr
FROM `first-project-mmezhenskyi.case_study.clean_sales`
GROUP BY date;
