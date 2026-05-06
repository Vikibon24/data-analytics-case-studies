--- User spending analysis ---
select o.user_id,
    sum(p.product_price * quantity) as total_cost
from orders_sql_project as o
left join order_items_sql_project as oi on o.order_id = oi.order_id
left join products_sql_project as p on oi.product_id = p.product_id
group by user_id
order by total_cost desc;

--- Combining data from different channels ---
select user_id,
    order_date,
    order_id as all_orders_id
from orders_sql_project
where user_id is not null
union all
select user_id,
    order_date,
    store_order_id as all_orders_id
from store_orders
where user_id is not null
order by user_id, order_date, all_orders_id;

--- Search for products in both channels ---
select product_id
from order_items_sql_project
intersect
select product_id
from store_order_items
order by product_id;

--- Identify active buyers ---
select o.user_id
from orders_sql_project as o
where order_id in (
    select order_id
    from order_items_sql_project
    where quantity > 2
)
intersect
select s.user_id
from store_orders as s
where store_order_id in (
    select store_order_id
    from store_order_items
    where quantity > 2
)
order by user_id;

--- Calculate the average online check ---
select avg(total_check) as avg_check
from (
    select o.order_id,
        sum(p.product_price * quantity) as total_check
    from payments_sql_project pay
    left join order_items_sql_project o on pay.order_id = o.order_id
    left join products_sql_project p on o.product_id = p.product_id
    where pay.payment_status = 'Оплачено'
    group by o.order_id
) as order_check;

--- Channel purchase statistics ---
with products_quantity_stores as (
    select oi.order_id,
        oi.quantity,
        'online' as store_type
    from order_items_sql_project as oi
    union all
    select soi.store_order_id,
        soi.quantity,
        'offline' as store_type
    from store_order_items as soi
)
select store_type,
    sum(quantity) as total_quantity,
    count(distinct order_id) as total_orders
from products_quantity_stores
group by store_type
order by store_type, total_quantity, total_orders;

--- Identifying top popular products ---
with users_products as (
    select o.user_id,
        oi.product_id
    from orders_sql_project as o
    left join order_items_sql_project as oi on o.order_id = oi.order_id
    where o.user_id is not null
    union all
    select so.user_id,
        soi.product_id
    from store_orders as so
    left join store_order_items as soi on so.store_order_id = soi.store_order_id
    where so.user_id is not null
)
select product_id,
    count(distinct user_id) as users_count
from users_products
group by product_id
order by users_count desc
limit 3;

--- Comparing average checks ---
select avg(total_check) as avg_check,
    'online' as shop_type
from (
    select osp.order_id,
        sum(psp.product_price * quantity) as total_check
    from orders_sql_project as osp
    left join order_items_sql_project as oisp on osp.order_id = oisp.order_id
    left join products_sql_project psp on oisp.product_id = psp.product_id
    group by osp.order_id
) as online_amount
union all
select avg(total_check) as avg_check,
    'offline' as shop_type
from (
    select so.store_order_id,
        sum(psp.product_price * quantity) as total_check
    from store_orders as so
    left join store_order_items as soi on so.store_order_id = soi.store_order_id
    left join products_sql_project psp on soi.product_id = psp.product_id
    group by so.store_order_id
) as offline_amount
order by 1;

--- Finding customers with expensive online purchases ---
with all_orders as (
    select osp.user_id,
        oisp.product_id
    from orders_sql_project osp
    left join order_items_sql_project oisp on oisp.order_id = osp.order_id
    union all
    select so.user_id,
        soi.product_id
    from store_orders so
    left join store_order_items soi on so.store_order_id = soi.store_order_id
)
select distinct a.user_id
from all_orders a
left join products_sql_project psp on a.product_id = psp.product_id
where psp.product_price > (
    select avg(psp2.product_price) as avg_product_price
    from store_order_items soi
    left join products_sql_project psp2 on soi.product_id = psp2.product_id
    where soi.product_id in (
     select product_id
     from store_order_items
    )
)
and a.user_id is not null
order by a.user_id;

--- Analyzing high-value orders by month ---
with all_orders as (
    select osp.user_id,
        osp.order_id,
        osp.order_date,
        oisp.quantity,
        oisp.product_id
    from orders_sql_project osp
    left join order_items_sql_project oisp on osp.order_id = oisp.order_id
    union all
    select so.user_id,
        so.store_order_id,
        so.order_date,
        soi.quantity,
        soi.product_id
    from store_orders so
    left join store_order_items soi on so.store_order_id = soi.store_order_id
),
avg_check as (
    select sum(psp.product_price * ao.quantity) / count(distinct ao.order_id) as avg_check
    from all_orders ao
    left join products_sql_project psp on psp.product_id = ao.product_id
),
order_above_avg as (
    select ao.user_id,
        extract(month from ao.order_date) as order_month,
        sum(psp.product_price * ao.quantity) as order_check
    from all_orders as ao
    left join products_sql_project as psp on ao.product_id = psp.product_id
    group by ao.user_id, ao.order_id, ao.order_date
    having sum(psp.product_price * ao.quantity) > (select avg_check from avg_check)
)
select order_month,
    count(distinct user_id) as user_count
from order_above_avg
where user_id is not null
group by order_month
order by order_month;
