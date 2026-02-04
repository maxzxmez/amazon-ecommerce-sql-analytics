# GOOD vs BAD Days Analysis

## Purpose
This section tests the hypothesis that profitability is primarily driven by advertising efficiency and the quality of traffic/conversion conditions.

Daily performance is segmented using a break-even TACoS benchmark (BE TACoS), then summarized to compare business outcomes under two regimes:
- **GOOD days**: TACoS ≤ BE TACoS
- **BAD days**: TACoS > BE TACoS (or missing TACoS / no sales)

The daily KPI dataset is calculated in:
- `kpis_daily` (VIEW)

The segmentation summary is produced by:
- `good_bad_days` (insight query)

## What Is Compared
The comparison focuses on:
- revenue, units, and conversion rate (CVR),
- ad vs organic revenue split (ad share / organic share),
- actual TACoS and ACoS,
- contribution and ROI.

## Key Findings
Across the analyzed period:
- **GOOD days consistently delivered positive contribution**, while **BAD days drove negative contribution**.
- GOOD days exhibited **higher conversion efficiency (CVR)** and **stronger organic contribution**, indicating healthier demand/traffic conditions.
- BAD days were characterized by **higher paid dependency** and **weaker conversion**, producing TACoS above the break-even threshold.

## Business Meaning
This analysis shows that profitability is not explained by revenue volume alone.  
Instead, it is driven by operating conditions:
- conversion efficiency,
- traffic quality,
- and controlled advertising intensity relative to unit economics.

These findings justify shifting from “scale first” tactics to “scale only when conditions match GOOD-day performance.”

