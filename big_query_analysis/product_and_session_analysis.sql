-- view repeated fields for a user
select user_pseudo_id,
    timestamp_micros(event_timestamp) as event_timestamp,
    event_name,
    event_params,
    user_properties,
    items
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131`,
unnest(items) as items
where items.item_name is not null or items.item_name != 'not set'
limit 1;


-- determining the size of arrays
select user_pseudo_id,
    timestamp_micros(event_timestamp) as event_timestamp,
    event_name,
    event_params,
    user_properties,
    items,
    array_length(event_params) as event_count,
    array_length(user_properties) as properties_count,
    array_length(items) as items_count
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131`,
unnest(items) as i
where i.item_name is not null or i.item_name != 'not set'
limit 1;


-- deploying event_params
select user_pseudo_id,
    event_name,
    event_params.key,
    event_params.value.string_value,
    event_params.value.int_value,
    event_params.value.double_value
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131`,
unnest(items) as i
left join
unnest(event_params) as event_params
on true
where i.item_name is not null or i.item_name != 'not set'
order by event_params.key asc
limit 1;


-- frequency analysis of event parameters
select distinct event_params.key, count(*) as count_key
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_2021*`,
unnest(event_params) as event_params
group by event_params.key
order by count_key desc;


-- deploying items
select user_pseudo_id,
    timestamp_micros(event_timestamp) as event_timestamp,
    items.item_id,
    items.item_name,
    items.item_category,
    items.price,
    items.quantity
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131`,
unnest(items) as items
limit 20;


-- summary table by products
select count(*) as count_quatity,
    sum(items.quantity) as total_quantity,
    sum(items.quantity) * items.price as total_income
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131`,
unnest(items) as items
group by items.price
order by total_income desc;


-- filtering by value inside an array
select distinct event_name
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131`
where exists (select true from unnest(items) as items where items.item_category = 'Apparel');


-- working with partitions via _table_suffix
select count(distinct user_pseudo_id) as unique_users,
    count(*) as total_events,
    countif(event_name = 'purchase') as total_event_purchase,
    _table_suffix as date
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
group by _table_suffix
order by date;


-- ranking users by cost
select distinct user_pseudo_id as unique_users,
    sum(ecommerce.purchase_revenue_in_usd * ecommerce.total_item_quantity) as total_sum,
    rank() over (order by sum(ecommerce.purchase_revenue_in_usd * ecommerce.total_item_quantity) desc) as rank_num,
    dense_rank() over (order by sum(ecommerce.purchase_revenue_in_usd * ecommerce.total_item_quantity) desc) as dense_rank_num,
    row_number() over (order by sum(ecommerce.purchase_revenue_in_usd * ecommerce.total_item_quantity) desc) as row_num
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
group by user_pseudo_id
order by total_sum desc
limit 20;


-- numbering events in a session
with event_row_number as (
 select user_pseudo_id,
      event_name,
      row_number() over (partition by user_pseudo_id, event_params.value.int_value order by event_timestamp) as row_num
 from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131`,
 unnest(event_params) as event_params
 where event_params.key = 'ga_session_id'
 ),
event_name_session_start_count as (
 select event_name,
      count(*) as session_start_count,
 from event_row_number
 where row_num = 1
 group by event_name
 )
select event_name
from event_name_session_start_count
order by session_start_count desc
limit 1;
