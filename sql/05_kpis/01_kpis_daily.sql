-- Purpose: Calculate daily KPIs (actual vs break-even TACoS) to support GOOD vs BAD day segmentation.
-- Output: kpis_daily (VIEW)

CREATE OR REPLACE VIEW `first-project-mmezhenskyi.case_study.kpis_daily` AS
SELECT
  date,

  -- Base activity
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
  coupon_fee,

  -- Daily unit economics (based on your baseline assumptions)
  ROUND(sales_units * 13, 2)                                 AS cogs_total,
  ROUND(sales_units * 6.10, 2)                               AS fba_total,
  ROUND((sales_revenue - promotion_discount) * 0.15, 2)      AS amazon_fee_total,

  -- Non-ad costs (exclude ad_spend)
  ROUND(
    (sales_units * 13)
    + (sales_units * 6.10)
    + ((sales_revenue - promotion_discount) * 0.15)
    + promotion_discount
    + coupon_fee,
    2
  ) AS non_ad_costs_total,

  -- Total costs (include ad_spend)
  ROUND(
    (sales_units * 13)
    + (sales_units * 6.10)
    + ((sales_revenue - promotion_discount) * 0.15)
    + promotion_discount
    + coupon_fee
    + ad_spend,
    2
  ) AS costs_total,

  -- Revenue split
  ROUND(GREATEST(sales_revenue - ad_sales, 0), 2)            AS org_sales_total,
  ROUND(SAFE_DIVIDE(ad_sales, sales_revenue), 4)             AS ad_share,
  ROUND(SAFE_DIVIDE(GREATEST(sales_revenue - ad_sales, 0), sales_revenue), 4) AS org_share,

  -- Performance ratios (daily)
  ROUND(SAFE_DIVIDE(sales_units, sessions), 4)               AS cvr_total,
  ROUND(SAFE_DIVIDE(ad_spend, ad_sales), 4)                  AS acos_actual,
  ROUND(SAFE_DIVIDE(ad_spend, sales_revenue), 4)             AS tacos_actual,
  ROUND(SAFE_DIVIDE(ad_sales, ad_spend), 2)                  AS roas_actual,

  -- Break-even TACoS (daily, based on non-ad costs)
  ROUND(
    1 - SAFE_DIVIDE(
          (
            (sales_units * 13)
            + (sales_units * 6.10)
            + ((sales_revenue - promotion_discount) * 0.15)
            + promotion_discount
            + coupon_fee
          ),
          sales_revenue
        ),
    4
  ) AS be_tacos,

  -- Profitability
  ROUND(sales_revenue - (
        (sales_units * 13)
        + (sales_units * 6.10)
        + ((sales_revenue - promotion_discount) * 0.15)
        + promotion_discount
        + coupon_fee
        + ad_spend
      ), 2) AS post_ad_contribution,

  ROUND(
    SAFE_DIVIDE(
      (
        sales_revenue - (
          (sales_units * 13)
          + (sales_units * 6.10)
          + ((sales_revenue - promotion_discount) * 0.15)
          + promotion_discount
          + coupon_fee
          + ad_spend
        )
      ),
      (
        (sales_units * 13)
        + (sales_units * 6.10)
        + ((sales_revenue - promotion_discount) * 0.15)
        + promotion_discount
        + coupon_fee
        + ad_spend
      )
    ),
    4
  ) AS roi

FROM `first-project-mmezhenskyi.case_study.final_report`
ORDER BY date ASC;
