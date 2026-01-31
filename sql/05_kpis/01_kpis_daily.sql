-- Purpose: Calculate daily KPIs (actual vs break-even TACoS) to support GOOD vs BAD day segmentation.
-- Output: kpis_daily (VIEW)

CREATE OR REPLACE VIEW `first-project-mmezhenskyi.case_study.kpis_daily` AS
WITH base AS (
  SELECT
    date,

    -- Base activity (from final_report)
    views,
    sessions,
    sales_units,
    sales_revenue,

    impressions,
    clicks,
    ad_spend,
    ad_sales,

    order_units,
    coupon_units,
    orders,
    coupon_orders,
    promotion_discount,
    coupon_fee

  FROM `first-project-mmezhenskyi.case_study.final_report`
),

costs AS (
  SELECT
    *,
    -- Unit economics assumptions (same as baseline)
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
)

SELECT
  *,
  -- Revenue split
  ROUND(GREATEST(sales_revenue - ad_sales, 0), 2) AS org_sales_total,
  ROUND(SAFE_DIVIDE(ad_sales, sales_revenue), 4)  AS ad_share,
  ROUND(
    SAFE_DIVIDE(GREATEST(sales_revenue - ad_sales, 0), sales_revenue),
    4
  ) AS org_share,

  -- Performance ratios (daily)
  ROUND(SAFE_DIVIDE(sales_units, sessions), 4)  AS cvr_total,
  ROUND(SAFE_DIVIDE(ad_spend, ad_sales), 4)     AS acos_actual,
  ROUND(SAFE_DIVIDE(ad_spend, sales_revenue), 4) AS tacos_actual,
  ROUND(SAFE_DIVIDE(ad_sales, ad_spend), 2)     AS roas_actual,

  -- Break-even TACoS (daily)
  ROUND(1 - SAFE_DIVIDE(non_ad_costs_total, sales_revenue), 4) AS be_tacos,

  -- Profitability
  ROUND(sales_revenue - costs_total, 2) AS post_ad_contribution,
  ROUND(SAFE_DIVIDE(sales_revenue - costs_total, costs_total), 4) AS roi

FROM costs
ORDER BY date ASC;
