# Northwind Traders — Orders, Employees & Logistics

## Tech Stack
 - **Tool:** Power BI Desktop

## Project Overview

A Power BI report for a delicatessen retailer. The report answers three questions the management team asked: how orders are distributed, how the sales team performs, and how reliable the logistics partners are.

Data: 830 orders / 2 155 order lines, July 2013 – May 2015 (2015 is a partial year), 3 shipping partners, 9 employees, 21 countries.

## Key findings

1. The three logistics partners perform identically — the choice of partner is not a quality lever.

| Partner | Orders | Share | On-time |
|---|---|---|---|
| United Package | 326 | 39% | 95% |
| Federal Shipping |255 | 31% | 96% |
| Speedy Express | 249 | 30% | 95% |

The gap is one percentage point. If delivery reliability needs to improve, the cause is not the carrier — it is upstream, in order processing.

2. Delays follow employees, not carriers

On-time rates by employee run from 90% to 98% — a much wider spread than between carriers. The delay starts before the order reaches the carrier.

3. 21 orders were never shipped

That is 2.5% of all orders. They are neither late nor delivered, so they fall out of the on-time metric entirely. Nobody was tracking them.

4. Revenue is concentrated

Three customers — QUICK-Stop, Ernst Handel, Save-a-lot Markets — bring $320K, 25% of total revenue, on 89 of 830 orders.

5. Discounts are moderate

$88.7K given away, 6.5% of revenue before discount.

## Report pages

1. Financial Overview — revenue over time, total revenue, orders, discount and shipping cost. Best customers, orders by country, split by carrier.

2. Logistics Overview — orders per carrier, on-time rate, volume per carrier by year, and a matrix of orders by country and carrier.

3. Employee Performance — orders per employee, revenue, discount given and the weighted discount rate, plus order volume by year and quarter.

4. Employee Order History (hidden, opens by drill-through) — every order of one employee: order ID, date, customer, value, discount, delivery status. Cards for orders, revenue, weighted discount and on-time rate.

**Data preparation in Power Query)**

- Tables renamed after their content, not after the source CSV files
- Header rows promoted, data types set (dates, integers, percentage for discount)
- Broken characters from the source encoding cleaned out of names
- freight renamed to shippingCost

## DAX

**Calculated columns**

OrderPrice = dimOrder_details[unitPrice] * dimOrder_details[quantity]

orderPriceWithDiscount = dimOrder_details[unitPrice] * dimOrder_details[quantity]
                       * (1 - dimOrder_details[discount])

TotalPrice = SUMX(RELATEDTABLE(dimOrder_details), dimOrder_details[OrderPrice])

deliveryStatus =
IF(ISBLANK(factOrders[shippedDate]), "Not Shipped",
   IF(factOrders[shippedDate] <= factOrders[requiredDate], "On-time", "Late"))

**Measures**

Revenue and discount are calculated on order lines, so they stay correct when the report is filtered by product or category.

Gross Revenue = SUM(dimOrder_details[OrderPrice])

Total_discount $ =
SUM(dimOrder_details[OrderPrice]) - SUM(dimOrder_details[orderPriceWithDiscount])

Total_discount % =
VAR price_before_discount = SUM(dimOrder_details[OrderPrice])
RETURN DIVIDE([Total_discount $], price_before_discount)

Total_orders = DISTINCTCOUNT(factOrders[orderID])

Ontime delivery count = CALCULATE(COUNTROWS(factOrders), factOrders[deliveryStatus] = "On-time")
Late delivery count   = CALCULATE(COUNTROWS(factOrders), factOrders[deliveryStatus] = "Late")

Late_delivery % =
VAR late_delivery   = [Late delivery count]
VAR ontime_delivery = [Ontime delivery count]
RETURN DIVIDE(late_delivery, late_delivery + ontime_delivery)

Ontime delivery % =
DIVIDE([Ontime delivery count], [Ontime delivery count] + [Late delivery count])

## Files

```
- Northwind_Traders.pbix
- README.md
- screenshots/
    ├── Financial_Overview.png
    ├── Logistics Overview.png
    ├── Employee Perfomance.png
    └── Employee Order History.png
```

Open the `.pbix` file in **Power BI Desktop**. Data is imported into the file — no external connection required.

