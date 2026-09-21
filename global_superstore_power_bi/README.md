# Global Superstore — Profitability Analysis

## Tech Stack
 - **Tool:** Power BI Desktop

## Project Overview

A report designed to help understand the organization’s current challenges and identify potential opportunities to improve the profitability of a large product distributor operating in the U.S. market and worldwide.

---

## Key findings

1. Shipping wipes out almost all of the profit. Revenue is $12.6M and gross profit $1.47M (11.6%), but shipping costs $1.36M. Profit after shipping is about $109K — under 1% of revenue. Revenue grew from $2.26M in 2012 to $4.30M in 2015, yet net margin never rose above ~1%: the company is growing without becoming more profitable.

2. Discounts above 10% lose money.


| Discount | Share of revenue | Profit after shipping | Net margin |
|---|---|---|---|
| 0% | 55% | $1 023K | 15% |
| 1-10% | 16% | $126K | 6% |
| 11-20% | 14%| -$19K | -1% |
| 21-30% | 3% | -$62K | -16% |
| 30%+ | 12% | -$959K | -62% |

---
Losses start at around 25%, but their size is concentrated at the top: 92% of all discount-driven losses (–$959K of –$1.04M) come from discounts above 30%. That band brings only 12% of revenue and loses more than the whole business earns after shipping.

3. Express shipping is sold at a loss. First Class and Same Day are negative after shipping cost (–6% net margin each); only Standard Class is profitable (+4%). Delivery pricing for fast modes does not cover its cost.

4. Only two markets are profitable after shipping. Europe (+$104K) and USCA (+$55K) carry the business. Asia Pacific — the largest market with 32% of revenue — is slightly negative, as are LATAM and Africa.

5. Furniture is the weakest category. 32% of revenue, but –$156K after shipping (–4%). Technology and Office Supplies are both around +3%.

Where to look first: set a hard limit of 20% on discounts, with anything above it requiring approval; reprice or restrict First Class / Same Day delivery, and review furniture pricing and logistics — especially in Asia Pacific.

## Data model

Star schema built in Power Query and Power BI Desktop.

| Table | Role |
|---|---|
| `factOrders` | Fact: sales, quantity, discount, profit, shipping cost, order priority, ship mode |
| `dimProduct` | Product ID, category, sub-category, product name |
| `dimAdress` | Postal code, city, state, country, region, market |
| `dimCustomers` | Customer ID, name, segment |
| `dimReturns` | Returned orders |
| `dimSalesReps` | Sales representative per region |
| `dimDate` | 	Date table generated in DAX (CALENDAR + ADDCOLUMNS), marked as a date table |
| `_measure` | 	Empty table holding all measures |

---
Implicit measures were used where a plain aggregation is enough; min/max required explicit measures because they iterate the fact table row by row.

**Data preparation (Power Query)**

- Tables renamed to reflect their content (`factOrders`, `dim...`)
- Header rows promoted where the source sheet started with a junk row
- `null` postal codes replaced with "`no code`" (non-US addresses have no ZIP)
- A composite address key — `Postal Code & ": " & City` — created in both `factOrders` and `dimAdress`, because neither postal code nor city is unique on its own; 100% of order lines match an address

**Modelling**

- Star schema, many-to-one, single-direction filters
- `dimDate` connected to `factOrders[Order Date]`
- Hierarchies: Product (Category → Sub-Category → Product Name) and Location (Market → Region → Country → State → City)

---

## Measures

All measures live in the `_measures` table.

Total Revenue $ = SUM(factOrders[Sales])

Total Profit $ = SUM(factOrders[Profit])

Total Shipping Cost = SUM(factOrders[Shipping Cost])

Total Profit Ship Cost = [Total Profit $] - [Total Shipping Cost]

Relative Profit % = DIVIDE([Total Profit $], [Total Revenue $])

Total Orders = DISTINCTCOUNT(factOrders[Order ID])

Average Order Value = DIVIDE([Total Revenue $], [Total Orders])

Total Discount $ = SUMX(factOrders, factOrders[Sales] * factOrders[Discount])

Profit with Ship LY =
CALCULATE([Total Profit with Ship Cost], SAMEPERIODLASTYEAR(dimDate[Date]))

Profit with Ship YoY = [Total Profit with Ship Cost] - [Profit with Ship LY]

Profit with Ship YoY % =
DIVIDE([Total Profit with Ship Cost] - [Profit with Ship LY], [Profit with Ship LY])

Quantity-related measures are grouped into display folders so the field list stays readable as the model grows.

---

## Report pages

1. Financial Overview

Headline cards for revenue, profit after shipping and number of orders; revenue and profit over time; top products by volume; revenue split by market. A year slicer drives the page.

2. Monthly Trends

A matrix down to month level: revenue, shipping cost, profit after shipping, the same period last year and the year-over-year change. Category and region slicers cut the same view by product line or geography.

3. Discount Analysis

Every discount level with units sold, revenue and profit after shipping — this is where the cost of discounting becomes visible. Slicers: market, category / sub-category, year.

4. Regional Analysis

Profit by market → region → country → state → city, crossed with product category; orders and profit by shipping mode; a decomposition tree for exploring where volume comes from.

5. Order Details (hidden, drill-through)

Line-level detail for a selected product or market, opened by right-click → Drill through from any page. Hidden by default.

---

## Files

```
- Global_Superstore_Profitability.pbix
- README.md
- screenshots/
    ├── 01_financial_overview.png
    ├── 02_monthly_trends.png
    ├── 03_discount_analysis.png
    └── 04_regional_analysis.png
```

Open the `.pbix` file in **Power BI Desktop**. Data is imported into the file — no external connection required.

