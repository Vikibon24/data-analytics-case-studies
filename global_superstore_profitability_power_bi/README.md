# Global Superstore — Profitability Analysis (Power BI)

A multi-page Power BI report for a global distributor operating in the US and worldwide. The business question: **where is the company actually making money, and what is quietly destroying the margin?**

The report covers 51 290 order lines / 25 728 orders placed between 2012 and 2015 across 5 markets and 164 countries.

---

## Key findings

- **Shipping cost eats almost the entire profit.** Gross profit is $1.47M on $12.6M of sales (11.6% margin), but shipping costs total $1.36M — leaving roughly $109K, under 1% of revenue. Any profitability discussion that ignores delivery cost is misleading.
- **Discount is not a growth lever here.** Orders above a certain discount level generate volume but negative net profit; the discount page quantifies how much revenue each discount band brings and what is left after profit.
- **Profitability is uneven across markets and shipping modes** — the regional page breaks sales, profit and shipping cost down by market → region → country → state → city, and by ship mode.

*(Replace these bullets with your own final numbers and screenshots once the report is published.)*

---

## Data model

Star schema built in Power Query and Power BI Desktop.

| Table | Rows | Role |
|---|---|---|
| `factOrders` | 51 290 | Fact: sales, quantity, discount, profit, shipping cost, order priority, ship mode |
| `dimProduct` | 3 788 | Product ID, category, sub-category, product name |
| `dimAdress` | 3 787 | Postal code, city, state, country, region, market |
| `dimCustomers` | 17 415 | Customer ID, name, segment |
| `dimReturns` | 1 079 | Returned orders |
| `dimSalesReps` | 24 | Sales representative per region |
| `dimDate` | 1 461 | Date table generated in DAX (`CALENDAR` + `ADDCOLUMNS`), marked as a date table |
| `_measure` | — | Empty table holding all measures |

**Data preparation (Power Query)**
- Tables renamed to reflect their content (`factOrders`, `dim…`) instead of the source sheet names
- Header rows promoted where the source sheet started with a junk row
- `null` postal codes replaced with `"no code"` (non-US addresses have no ZIP)
- A composite address key — `Postal Code & ": " & City` — created in both `factOrders` and `dimAdress`, because neither postal code nor city alone is unique

**Modelling**
- Star schema, many-to-one, single-direction filters
- Date table built in DAX and connected to `factOrders[Order Date]`; a second, inactive relationship to `Ship Date`
- Hierarchies: **Product** (Category → Sub-Category → Product Name) and **Location** (Market → Region → Country → State → City)

---

## Measures

```dax
Total Sales $ = SUM(factOrders[Sales])

Total Profit $ = SUM(factOrders[Profit])

Total Shipping Cost = SUM(factOrders[Shipping Cost])

-- profit after delivery cost: the metric the business actually runs on
Net Profit after Shipping = [Total Profit $] - [Total Shipping Cost]

Relative Profit % = DIVIDE([Total Profit $], [Total Sales $])

Total Orders = DISTINCTCOUNT(factOrders[Order ID])

Total Units = SUM(factOrders[Quantity])

Average Order Value = DIVIDE([Total Sales $], [Total Orders])

Total Discount $ = SUMX(factOrders, factOrders[Sales] * factOrders[Discount])

Net Profit LY =
CALCULATE([Net Profit after Shipping], SAMEPERIODLASTYEAR(dimDate[Date]))

Net Profit YoY = [Net Profit after Shipping] - [Net Profit LY]

Net Profit YoY % =
DIVIDE([Net Profit after Shipping] - [Net Profit LY], [Net Profit LY])
```

---

## Report pages

### 1. Financial Overview
Headline cards for sales, profit and orders, a sales-and-profit trend line over time, top products by volume, and the split of sales across markets. A year slicer drives the whole page.

### 2. Monthly Trends
A matrix down to month level showing sales, shipping cost, profit after shipping, the same period last year and the year-over-year delta, with conditional formatting on the change. Category and region slicers allow the same view to be cut by product line or geography.

### 3. Discount Analysis
Every discount level with the number of orders, revenue generated and profit left. This is where the cost of discounting becomes visible. Slicers: market, category / sub-category, year.

### 4. Regional Analysis
Sales, profit and shipping cost by market → region → country → state → city, crossed with product category, plus a breakdown by shipping mode and a decomposition tree for exploring where profit is lost.

### 5. Order Details *(hidden — drill-through)*
Line-level detail for a selected discount level or shipping mode, reachable by drilling through from the analytical pages. Not visible by default: browsing 51 000 rows has no value on its own, it only makes sense in the context of a specific segment.

---

## Files

```
├── Global_Superstore_Profitability.pbix
├── README.md
└── screenshots/
    ├── 01_financial_overview.png
    ├── 02_monthly_trends.png
    ├── 03_discount_analysis.png
    └── 04_regional_analysis.png
```

Open the `.pbix` in **Power BI Desktop** (free). Data is imported into the file — no external connection required.

Source data: `superstore_dataset.xlsx` (orders, products, addresses, customers, returns, sales representatives).
