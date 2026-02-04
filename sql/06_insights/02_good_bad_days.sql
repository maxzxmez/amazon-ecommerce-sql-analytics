-- Purpose: Segment days into GOOD vs BAD based on break-even TACoS and summarize performance.
-- Output: good_bad_days (VIEW)

CREATE OR REPLACE VIEW `first-project-mmezhenskyi.case_study.good_bad_days` AS
WITH labeled_days AS (
  SELECT
    CASE
      WHEN tacos_actual IS NOT NULL AND tacos_actual <= be_tacos THEN 'GOOD'
      ELSE 'BAD'
    END AS day_type,
    *
  FROM `first-project-mmezhenskyi.case_study.kpis_daily`
)

SELECT
  day_type,
  MAX(be_tacos) AS be_tacos,
  COUNT(*) AS days_count,

  SUM(sales_units) AS units,
  ROUND(SUM(sales_revenue), 2) AS revenue,

  ROUND(SAFE_DIVIDE(SUM(sales_units), SUM(sessions)), 9) AS cvr,

  ROUND(SUM(ad_sales), 2) AS ad_revenue,
  ROUND(SUM(org_sales_total), 2) AS organic_revenue,
  ROUND(SAFE_DIVIDE(SUM(ad_sales), SUM(sales_revenue)), 9) AS ad_share,
  ROUND(SAFE_DIVIDE(SUM(org_sales_total), SUM(sales_revenue)), 9) AS organic_share,

  ROUND(SUM(costs_total), 2) AS costs_total,
  ROUND(SUM(post_ad_contribution), 2) AS contribution_after_ads,
  ROUND(SAFE_DIVIDE(SUM(post_ad_contribution), SUM(costs_total)), 9) AS roi,

  ROUND(SAFE_DIVIDE(SUM(ad_spend), SUM(sales_revenue)), 9) AS tacos_actual,
  ROUND(SAFE_DIVIDE(SUM(ad_spend), SUM(ad_sales)), 9)      AS acos_actual

FROM labeled_days
WHERE sales_revenue > 0
GROUP BY day_type
ORDER BY day_type DESC;

SELECT * FROM `first-project-mmezhenskyi.case_study.good_bad_days`;
