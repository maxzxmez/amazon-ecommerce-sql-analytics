-- Purpose: Final analytical dataset combining sales, PPC, and order metrics with full date coverage.
-- Output: final_report (VIEW)
CREATE OR REPLACE VIEW `first-project-mmezhenskyi.case_study.final_report` AS
SELECT
  c.date AS date,

  -- Sales (daily)
  s.revenue   AS sales_revenue,
  s.units     AS sales_units,
  s.sessions  AS sessions,
  s.views     AS views,
  s.cvr       AS cvr,

  -- PPC (daily)
  p.ad_spend      AS ad_spend,
  p.ad_sales      AS ad_sales,
  p.impressions   AS impressions,
  p.clicks        AS clicks,
  p.ctr           AS ctr,
  p.cpc           AS cpc,
  p.acos          AS acos,
  p.roas          AS roas,

  -- Orders / Coupons (daily)
  o.units            AS order_units,
  o.coupon_units     AS coupon_units,
  o.orders           AS orders,
  o.coupon_orders    AS coupon_orders,
  o.promotion_discount,
  o.coupon_fee,

 
FROM `first-project-mmezhenskyi.case_study.calendar_dates` c
LEFT JOIN `first-project-mmezhenskyi.case_study.sales_daily`  s ON c.date = s.date
LEFT JOIN `first-project-mmezhenskyi.case_study.ppc_daily`    p ON c.date = p.date
LEFT JOIN `first-project-mmezhenskyi.case_study.orders_daily`  o ON c.date = o.date
ORDER BY date ASC;
