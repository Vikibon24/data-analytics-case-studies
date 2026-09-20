# Sales Analytics — DAX Filter Context & Time Intelligence (Power BI)

A Power BI project built on a retail sales dataset (~8 000 orders, 2020–2022) that focuses on **DAX measures**: how filter context works, how to override it, and how to compare periods.

The goal of the project was not to build a pretty dashboard, but to show control over the calculation layer — implicit vs. explicit measures, `CALCULATE`, filter-modifier functions (`ALL`, `ALLSELECTED`, `ALLEXCEPT`) and time-intelligence functions.

---

## Data model

| Table | Role | Notes |
|---|---|---|
| `factSalesOrders` | Fact | ~8 000 orders: quantity, unit price, unit cost, discount, sales channel, dates |
| `dimCustomers`, `dimProducts`, `dimStoreLocations`, `dimRegions`, `dimSalesTeam` | Dimensions | Star schema, many-to-one, single-direction filtering |
| `DimCalendar` | Date table | Full calendar 2020–2022 with year / quarter / month / week / fiscal attributes |
| `_measures` | Measure table | Empty table used to store all DAX measures in one place |

Key metric of the project: **Order Quantity** — the number of goods sold.

---

## Report pages

### 1. `ДЗ` — filter context

**Multi-row card — sold goods overview**

| Metric | Type |
|---|---|
| Total number of goods sold | implicit measure — `Sum` of `Order Quantity` |
| Average number of goods sold | implicit measure — `Average` of `Order Quantity` |
| Min number of items in an order | explicit DAX measure |
| Max number of items in an order | explicit DAX measure |

Implicit measures were used where a plain aggregation is enough; min/max required explicit measures because they iterate the fact table row by row.

**Cards and table — how filters are applied and removed**

The page contains a year slicer and a table by `Sales Channel`, so the behaviour of each filter modifier can be compared side by side:

- `Online Channel Sales` — adds a filter (`CALCULATE`)
- `Total Sold Goods ALL` — ignores every filter, including the slicer
- `Total Sold Goods ALLSELECTED` — ignores the filters of the visual, but respects the slicer
- `Total Sold Goods ALLEXCEPT` — keeps only `Sales Channel`, removes the rest

Moving the year slicer changes `ALLSELECTED` but leaves `ALL` untouched — which is exactly what the page is meant to demonstrate.

### 2. `Time Series` — period comparison

A table with a year → quarter → month hierarchy and three measures next to the plain quantity:

- year-to-date cumulative total
- the same period of the previous year
- the same period two years ago

---

## Measures

All measures live in the `_measures` table.

**Explicit aggregations**

```dax
Min of Orders =
// min quantity in order
MINX(factSalesOrders, factSalesOrders[Order Quantity])
```

```dax
Max of Orders =
// max quantity in order
MAXX(factSalesOrders, factSalesOrders[Order Quantity])
```

**Base measure**

```dax
Goods Sold Qnt = SUM(factSalesOrders[Order Quantity])
```

**Filter context**

```dax
Online Channel Sales =
// number of sales via the online channel
CALCULATE([Goods Sold Qnt], factSalesOrders[Sales Channel] = "Online")
```

```dax
Total Sold Goods ALL =
CALCULATE([Goods Sold Qnt], ALL())
```

```dax
Total Sold Goods ALLSELECTED =
CALCULATE([Goods Sold Qnt], ALLSELECTED())
```

```dax
Total Sold Goods ALLEXCEPT =
CALCULATE([Goods Sold Qnt], ALLEXCEPT(factSalesOrders, factSalesOrders[Sales Channel]))
```

**Time intelligence**

```dax
Sales Qnt YTD =
// cumulative total sold orders for the current year
TOTALYTD([Goods Sold Qnt], DimCalendar[Date])
```

```dax
Sales Qnt PY YTD =
// number of goods sold during the same period last year
CALCULATE([Goods Sold Qnt], SAMEPERIODLASTYEAR(DimCalendar[Date]))
```

```dax
Sales Qnt 2PY =
// number of goods sold 2 years ago
CALCULATE([Goods Sold Qnt], DATEADD(DimCalendar[Date], -2, YEAR))
```

Quantity-related measures are grouped into display folders so the field list stays readable as the model grows.

---

## What this project demonstrates

- The difference between implicit and explicit measures, and when each is appropriate
- `CALCULATE` as the only function that modifies filter context
- `ALL` / `ALLSELECTED` / `ALLEXCEPT` — three different ways of removing filters, and how a slicer exposes the difference between them
- Time intelligence against a dedicated date table: YTD, year-over-year, two years back
- Model hygiene: a separate measure table, display folders, descriptive measure names

---

## Files

```
├── Sales_DAX_Filter_Context.pbix   # report
└── README.md
```

Open the `.pbix` file in **Power BI Desktop** (free). The data is imported into the file, so no external source or credentials are needed.

---

## Tools

Power BI Desktop · DAX · star-schema data modelling
