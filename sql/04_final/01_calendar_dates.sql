-- Purpose: Calendar table providing complete date coverage for time-series analysis.
-- Output: calendar_dates (VIEW)
CREATE OR REPLACE VIEW `first-project-mmezhenskyi.case_study.calendar_dates` AS
SELECT
  calendar_date AS date
FROM UNNEST(GENERATE_DATE_ARRAY('2025-11-01', '2026-12-31')) AS calendar_date;
