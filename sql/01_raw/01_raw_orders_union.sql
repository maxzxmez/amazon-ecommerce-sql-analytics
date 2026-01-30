-- Purpose: Combine monthly Amazon Orders reports into a single raw layer object.
-- Output: raw_orders (VIEW)

CREATE OR REPLACE VIEW `first-project-mmezhenskyi.case_study.raw_orders` AS
SELECT
  *
FROM `first-project-mmezhenskyi.case_study.orders_november`

UNION ALL

SELECT
  *
FROM `first-project-mmezhenskyi.case_study.orders_december`;
