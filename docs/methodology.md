# Methodology

## Goal
This project evaluates Amazon e-commerce performance with a focus on unit economics and advertising efficiency.  
The main objective is to identify conditions under which advertising supports profitability and conditions under which it destroys value.

## Data Sources
The analysis uses three primary report types:
- **Sales report** (traffic and storefront performance): revenue, units, sessions, views, conversion rate (CVR).
- **PPC report** (advertising performance): impressions, clicks, ad spend, ad-attributed sales.
- **Orders report** (order-level transactions and promotions): quantities, item price, promotion discounts, and promotion identifiers.

## Data Processing Approach
The SQL workflow is organized as a layered pipeline:
1. **Raw**: unify monthly extracts into consistent raw objects.
2. **Clean**: standardize column names and formats.
3. **Marts**: aggregate daily metrics for Sales, PPC, and Orders.
4. **Final**: join daily marts using a calendar table to ensure complete date coverage.
5. **KPIs**: calculate daily unit economics and performance metrics.
6. **Insights**: run analytical queries to compare performance regimes and derive recommendations.

This separation keeps business logic reproducible and scalable, while allowing insight queries to remain focused and interpretable.

## Metric Logic (High Level)
Key business metrics are computed in SQL:
- **CVR (Conversion Rate)**: units / sessions
- **ACoS**: ad spend / ad sales
- **TACoS**: ad spend / total revenue
- **Contribution (post-ad)**: revenue − total costs (including ads and non-ad costs)
- **ROI**: contribution / total costs

## Break-even TACoS (Benchmark)
A **break-even TACoS (BE TACoS)** benchmark is calculated from unit economics to represent the maximum advertising-to-revenue ratio that still allows the business to operate at break-even.

This benchmark is treated as a constant threshold for the analyzed period and is used to segment daily performance into regimes.

## GOOD vs BAD Day Segmentation
Daily performance is segmented using:
- **GOOD days**: daily TACoS ≤ BE TACoS
- **BAD days**: daily TACoS > BE TACoS (or missing TACoS / no sales)

This approach converts an abstract profitability question into an operational, measurable rule.

## Why Daily Granularity
Aggregate metrics can hide structural differences between profitable and unprofitable performance states.  
Daily segmentation exposes differences in:
- conversion efficiency,
- organic vs paid revenue balance,
- advertising dependency,
- contribution and ROI.

These differences form the foundation for actionable business recommendations.

## Deliverables
- **SQL pipeline**: reproducible metric computation and segmentation logic.
- **Presentation**: business-facing narrative and recommendations aligned with observed performance.
- **Docs**: methodology and interpretation linking SQL outputs to business conclusions.

