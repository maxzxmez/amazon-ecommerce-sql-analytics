-- Purpose: Calculate daily KPIs (actual vs break-even TACoS) to support GOOD vs BAD day segmentation.
-- Output: kpis_daily (VIEW)

CREATE OR REPLACE VIEW `first-project-mmezhenskyi.case_study.kpis_daily` AS
WITH base AS (
  SELECT
    date,
    views, sessions, sales_units, sales_revenue,
    impressions, clicks, ad_spend, ad_sales,
    order_units, coupon_units, orders, coupon_orders,
    promotion_discount, coupon_fee
  FROM `first-project-mmezhenskyi.case_study.final_report`
),
costs AS (
  SELECT
    *,
    ROUND(sales_units * 13, 2)                            AS cogs_total,
    ROUND(sales_units * 6.10, 2)                          AS fba_total,
    ROUND((sales_revenue - promotion_discount) * 0.15, 2) AS amazon_fee_total,
    ROUND(
      (sales_units * 13)
      + (sales_units * 6.10)
      + ((sales_revenue - promotion_discount) * 0.15)
      + promotion_discount
      + coupon_fee,
      2
    ) AS non_ad_costs_total,
    ROUND(
      (sales_units * 13)
      + (sales_units * 6.10)
      + ((sales_revenue - promotion_discount) * 0.15)
      + promotion_discount
      + coupon_fee
      + ad_spend,
      2
    ) AS costs_total
  FROM base
),
bench AS (
  SELECT be_tacos
  FROM `first-project-mmezhenskyi.case_study.be_tacos_benchmark`
)

SELECT
  c.*,

  -- Benchmark break-even TACoS (constant threshold)
  b.be_tacos AS be_tacos,

  -- Revenue split
  ROUND(GREATEST(c.sales_revenue - c.ad_sales, 0), 2) AS org_sales_total,
  ROUND(SAFE_DIVIDE(c.ad_sales, c.sales_revenue), 4)  AS ad_share,
  ROUND(SAFE_DIVIDE(GREATEST(c.sales_revenue - c.ad_sales, 0), c.sales_revenue), 4) AS org_share,

  -- Performance ratios (daily)
  ROUND(SAFE_DIVIDE(c.sales_units, c.sessions), 4)     AS cvr_total,
  ROUND(SAFE_DIVIDE(c.ad_spend, c.ad_sales), 4)        AS acos_actual,
  ROUND(SAFE_DIVIDE(c.ad_spend, c.sales_revenue), 4)   AS tacos_actual,
  ROUND(SAFE_DIVIDE(c.ad_sales, c.ad_spend), 2)        AS roas_actual,

  -- Profitability
  ROUND(c.sales_revenue - c.costs_total, 2) AS post_ad_contribution,
  ROUND(SAFE_DIVIDE(c.sales_revenue - c.costs_total, c.costs_total), 4) AS roi

FROM costs c
CROSS JOIN bench b
ORDER BY date ASC;
