# Amazon E-commerce SQL Analytics

Automated SQL analytics pipeline for Amazon e-commerce performance analysis.
Focused on unit economics, advertising efficiency, and profitability drivers using real sales and PPC data.

## Project Overview
This project demonstrates an end-to-end analytical workflow for evaluating Amazon e-commerce performance using SQL.
The focus is on unit economics, advertising efficiency, and identifying conditions under which advertising remains profitable.

## Business Problem
Advertising performance had deteriorated, with actual TACoS exceeding the break-even level.
Under such conditions, further scaling of advertising spend leads to losses rather than growth.
The goal of this analysis was to identify when advertising supports profitability and when it destroys value.

## Analytical Approach
The analysis follows a structured, business-oriented workflow:

Raw data → Data cleaning → Data integration → Baseline performance assessment → Hypothesis testing (GOOD vs BAD days) → Business recommendations

A break-even TACoS benchmark was calculated based on unit economics and used as a control threshold to segment daily performance.

## Key Insights
- Days operating below the break-even TACoS consistently generated positive contribution.
- Higher conversion rates and balanced ad dependency were the primary drivers of profitability.
- Average performance metrics masked significant structural differences between profitable and unprofitable days.

## Business Recommendations
- Use break-even TACoS as a daily guardrail for advertising spend.
- Prioritize campaigns and traffic patterns associated with profitable days.
- Avoid scaling advertising during periods of structurally low conversion efficiency.

## Repository Structure
sql/   → Layered SQL pipeline (raw → clean → marts → final → KPIs → insights)  
docs/  → Methodology, baseline metrics, and analytical notes



## Tools & Skills Demonstrated
- SQL (BigQuery): CTEs, calendar tables, KPI modeling
- Data modeling and metric design
- Unit economics and profitability analysis
- Business-focused analytical storytelling
