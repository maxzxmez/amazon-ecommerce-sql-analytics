-- Purpose: Daily aggregated PPC KPIs, recalculated from totals.
-- Output: mart_ppc_daily (VIEW)

CREATE OR REPLACE VIEW `first-project-mmezhenskyi.case_study.mart_ppc_daily` AS
SELECT
  date,
  SUM(impressions) AS impressions,
  SUM(clicks)      AS clicks,
  SUM(ad_spend)    AS ad_spend,
  SUM(ad_sales)    AS ad_sales,

  SAFE_DIVIDE(SUM(clicks), SUM(impressions)) AS ctr,
  SAFE_DIVIDE(SUM(ad_spend), SUM(clicks))    AS cpc,
  SAFE_DIVIDE(SUM(ad_spend), SUM(ad_sales))  AS acos,
  SAFE_DIVIDE(SUM(ad_sales), SUM(ad_spend))  AS roas

FROM `first-project-mmezhenskyi.case_study.clean_ppc`
GROUP BY date;
