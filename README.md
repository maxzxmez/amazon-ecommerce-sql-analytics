# Amazon E-commerce SQL Analytics

Automated SQL analytics pipeline for Amazon e-commerce performance analysis.
Focused on unit economics, advertising efficiency, and profitability drivers using real sales and PPC data.

## Project Overview
This project demonstrates an end-to-end analytical workflow for evaluating Amazon e-commerce performance using SQL.
The focus is on unit economics, advertising efficiency, and identifying conditions under which advertising remains profitable.

The analysis was initially explored using spreadsheet-based methods and later refactored into a fully automated SQL pipeline to improve reproducibility, scalability, and analytical rigor.

## Business Problem
Advertising performance had deteriorated, with actual TACoS exceeding the break-even level.
Under such conditions, further scaling of advertising spend leads to losses rather than growth.

The goal of this analysis was to identify when advertising supports profitability and when it destroys value.

## Analytical Approach
The analysis follows a structured, business-oriented workflow:

Raw data → Data cleaning → Data integration → Baseline performance assessment →  Hypothesis testing (GOOD vs BAD days) → Business recommendations

A break-even TACoS benchmark was calculated based on unit economics and used as a control threshold to segment daily performance.

## Key Insights
- Days operating below the break-even TACoS consistently generated positive contribution.
- Higher conversion rates and a healthier balance between organic and paid traffic were the primary drivers of profitability.
- Average performance metrics masked significant structural differences between profitable and unprofitable days.

## Business Recommendations
Business recommendations are anchored to performance observed during profitable (GOOD) days rather than hypothetical targets.

- Use break-even TACoS as a daily operational guardrail to control advertising efficiency and prevent value destruction.
- Prioritize traffic sources and campaign conditions associated with GOOD days, which consistently demonstrate higher conversion rates and stronger organic contribution.
- Treat the organic share and conversion levels observed during GOOD days as realistic performance benchmarks under the current cost structure.
- Avoid scaling advertising during periods where conversion efficiency structurally deviates from GOOD-day performance, as such conditions historically resulted in negative contribution.

These recommendations reflect conditions the business has already achieved, ensuring feasibility and alignment with observed data.

## Repository Structure
- `sql/` → Layered SQL analytics pipeline (raw → clean → marts → final → KPIs → insights)
- `docs/` → Analytical methodology, baseline metrics, and business insights
- `presentation/` → Business-facing presentation summarizing key findings and recommendations

## Presentation
The included presentation summarizes the business insights derived from this analysis.
The SQL pipeline reproduces and formalizes the analytical logic behind these insights using an automated and scalable approach.



## Tools & Skills Demonstrated
- SQL (BigQuery): CTEs, calendar tables, KPI modeling, analytical segmentation
- Data modeling and metric design
- Unit economics and profitability analysis
- Spreadsheet-based analysis and validation (Google Sheets)
- Data visualization and KPI communication (tables and charts)
- Business-focused analytical storytelling
