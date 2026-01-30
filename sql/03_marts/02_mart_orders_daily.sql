-- Purpose: Daily aggregated Orders metrics and coupon-related fields.
-- Output: mart_orders_daily (VIEW)

CREATE OR REPLACE VIEW `first-project-mmezhenskyi.case_study.mart_orders_daily` AS
SELECT
  date,

  SUM(quantity) AS units,

  SUM(IF(
    REGEXP_CONTAINS(COALESCE(promotion_ids, ''), r'PLM-')
    AND NOT REGEXP_CONTAINS(LOWER(COALESCE(promotion_ids, '')), r'percentage off'),
    quantity,
    0
  )) AS coupon_units,

  SUM(promotion_discount) AS promotion_discount,

  COUNT(DISTINCT order_id) AS orders,

  COUNT(DISTINCT IF(
    REGEXP_CONTAINS(COALESCE(promotion_ids, ''), r'PLM-')
    AND NOT REGEXP_CONTAINS(LOWER(COALESCE(promotion_ids, '')), r'percentage off'),
    order_id,
    NULL
  )) AS coupon_orders,

  0.025 * SUM(IF(
    REGEXP_CONTAINS(COALESCE(promotion_ids, ''), r'PLM-')
    AND NOT REGEXP_CONTAINS(LOWER(COALESCE(promotion_ids, '')), r'percentage off'),
    (item_price * quantity - promotion_discount),
    0
  )) AS coupon_fee

FROM `first-project-mmezhenskyi.case_study.clean_orders`
GROUP BY date;
