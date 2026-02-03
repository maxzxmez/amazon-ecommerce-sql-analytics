-- Purpose: Calculate a period-level break-even TACoS benchmark used as a constant threshold for segmentation.
-- Output: be_tacos_benchmark (VIEW)

CREATE OR REPLACE VIEW `first-project-mmezhenskyi.case_study.be_tacos_benchmark` AS
WITH totals AS (
  SELECT
    SUM(sales_units)   AS units_total,
    SUM(sales_revenue) AS revenue_total,
    SUM(promotion_discount) AS discount_total,
    SUM(coupon_fee)    AS coupon_fee_total
  FROM `first-project-mmezhenskyi.case_study.final_report`
)
SELECT
  ROUND(
    1 - SAFE_DIVIDE(
          (
            (units_total * 13)
            + (units_total * 6.10)
            + ((revenue_total - discount_total) * 0.15)
            + discount_total
            + coupon_fee_total
          ),
          revenue_total
        ),
    9
  ) AS be_tacos
FROM totals;
