-- Purpose: Evaluate overall business performance for the selected period.
-- Notes:
-- - Used to establish baseline metrics (average and break-even TACoS).
-- - Serves as a reference for daily performance segmentation (GOOD vs BAD days).
WITH base_metrics AS (
  SELECT
    SUM(views)                                                      AS views_total,
    SUM(sessions)                                                   AS sessions_total,  
    SUM(sales_units)                                                AS units_total,
    ROUND(SUM(sales_revenue),2)                                     AS revenue_total,

    ROUND(SUM(sales_units) * 13, 2)                                 AS cogs_total,
    ROUND(SUM(sales_units) * 6.10, 2)                               AS fba_total,
    ROUND((SUM(sales_revenue) - SUM(promotion_discount)) * 0.15, 2) AS amazon_fee_total,
    ROUND(SUM(promotion_discount),2)                                AS discount_total,
    ROUND(SUM(coupon_fee),2)                                        AS coupon_fee_total,
    ROUND(SUM(ad_spend),2)                                          AS ad_spend_total,
    ROUND(SUM(ad_sales),2)                                          AS ad_sales_total  
  FROM `first-project-mmezhenskyi.case_study.final_report`
),

calculated_totals AS (
  SELECT
    *,    
    ROUND(revenue_total - ad_sales_total, 2)                                                                 AS org_sales_total,    
    ROUND(cogs_total + fba_total + amazon_fee_total + discount_total + ad_spend_total + coupon_fee_total, 2) AS costs_total
  FROM base_metrics
)

SELECT
  *,  
  ROUND(SAFE_DIVIDE(units_total, sessions_total), 4)                 AS cvr_total,
  ROUND(SAFE_DIVIDE(org_sales_total, revenue_total), 4)              AS org_share,
  ROUND(revenue_total - costs_total, 2)                              AS post_ad_contribution,
  ROUND(SAFE_DIVIDE((revenue_total - costs_total), costs_total), 4)  AS roi,
  ROUND(SAFE_DIVIDE(ad_spend_total, ad_sales_total), 4)              AS total_acos,
  ROUND(SAFE_DIVIDE(ad_sales_total, ad_spend_total), 2)              AS total_roas,
  ROUND(SAFE_DIVIDE(ad_spend_total, revenue_total), 4)               AS total_tacos,
  ROUND(
  1 - SAFE_DIVIDE(
        (cogs_total
         + fba_total
         + amazon_fee_total
         + discount_total
         + coupon_fee_total),
        revenue_total
      ),
  4
) AS be_tacos
FROM calculated_totals;
