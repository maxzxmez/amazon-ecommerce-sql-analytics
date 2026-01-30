-- Purpose: Clean and standardize Orders report columns.
-- Output: clean_orders (VIEW)

CREATE OR REPLACE VIEW `first-project-mmezhenskyi.case_study.clean_orders` AS
SELECT
  `amazon-order-id`         AS order_id,
  DATE(`purchase-date`)     AS date,
  `order-status`            AS order_status,
  quantity                  AS quantity,
  currency                  AS currency,
  `item-price`              AS item_price,
  `item-promotion-discount` AS promotion_discount,
  `ship-state`              AS ship_state,
  `promotion-ids`           AS promotion_ids
FROM `first-project-mmezhenskyi.case_study.raw_orders`
WHERE `order-status` = 'Shipped';
