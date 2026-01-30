-- Purpose: Standardize Sales report columns for downstream aggregation.
-- Output: clean_sales (VIEW)

CREATE OR REPLACE VIEW `first-project-mmezhenskyi.case_study.clean_sales` AS
SELECT
  Date     AS date,
  Revenue  AS revenue,
  Units    AS units,
  Views    AS views,
  Sessions AS sessions,
  CVR      AS cvr
FROM `first-project-mmezhenskyi.case_study.sales_report`;
