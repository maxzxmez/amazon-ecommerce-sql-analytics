-- Purpose: Clean and standardize PPC report columns.
-- Output: clean_ppc (VIEW)
CREATE OR REPLACE VIEW `first-project-mmezhenskyi.case_study.clean_ppc` AS
SELECT
  PARSE_DATE('%b %d, %Y', Date)   AS date,
  Impressions                     AS impressions,
  Clicks                          AS clicks,
  CTR                             AS ctr,
  CPC                             AS cpc,
  Ad_Spend                        AS ad_spend,
  Ad_Sales                        AS ad_sales,
  ACOS                            AS acos,
  ROAS                            AS roas
FROM `first-project-mmezhenskyi.case_study.ppc_report`;
