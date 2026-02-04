# Baseline Business Performance

## Purpose
The baseline view provides a period-level snapshot of overall business performance.  
It establishes whether the current operating model is economically sustainable and serves as the reference point for deeper analysis.

Baseline metrics are computed from the consolidated dataset (`final_report`) using the query:
- `baseline_business_performance.sql`

## What the Baseline Measures
The baseline summarizes:
- scale (revenue, units, sessions),
- efficiency (CVR),
- advertising intensity (TACoS),
- profitability (contribution and ROI),
- and a unit-economics-derived profitability threshold (BE TACoS).

## Key Baseline Interpretation
The baseline showed that:
- **actual TACoS exceeded the break-even TACoS**, indicating that advertising spend was not fully supported by contribution margin under the current cost structure;
- under these conditions, **increasing advertising spend would amplify losses** rather than generate profitable growth.

This conclusion does not depend on a single day or campaign and indicates a structural performance constraint.

## Why Baseline Is Not Enough
Period averages can mask the fact that the business may operate under different daily regimes:
- some days are profitable and sustainable,
- others systematically destroy value.

Therefore, the next step is to segment daily performance to identify which conditions produce profitable outcomes.

## Next Step
Using the break-even TACoS benchmark computed in the baseline step, daily performance is segmented into **GOOD** and **BAD** days to quantify the drivers of profitability and support evidence-based business recommendations.

