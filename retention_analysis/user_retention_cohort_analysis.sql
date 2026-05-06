with clean_date as (
    select user_id,
        full_name,
        email,
        country,
        signup_source,
        signup_device,
        promo_signup_flag,
        to_date(regexp_replace(trim(signup_datetime), '\/|\.', '-'), 'DD-MM-YY') as signup_date
    from cohort_users_raw cur
    where signup_datetime is not null
),
clean_event_date as (
    select user_id,
        event_id,
        event_type,
        revenue,
        to_date(regexp_replace(trim(event_datetime), '\/|\.', '-'), 'DD-MM-YY') as event_date
    from cohort_events_raw cer
    where event_datetime is not null
        and event_type <> 'test_event'
        and event_type is not null
),
union_users_events as (
    select cd.user_id,
        cd.full_name,
        cd.email,
        cd.country,
        cd.signup_source,
        cd.signup_device,
        cd.promo_signup_flag,
        to_char(cd.signup_date, 'YYYY-MM') as cohort_month,
        cd.signup_date::timestamp as signup_date_timestamp,
        ced.event_id,
        ced.event_type,
        ced.revenue,
        to_char(ced.event_date, 'YYYY-MM') as month_event,
        ced.event_date::timestamp as event_date_timestamp,
        ((extract(year from ced.event_date) * 12 + extract(month from ced.event_date)) -
         (extract(year from cd.signup_date) * 12 + extract(month from cd.signup_date))) as month_offset
    from clean_date as cd
    left join clean_event_date as ced on cd.user_id = ced.user_id
)
select promo_signup_flag,
    cohort_month,
    month_offset,
    count(distinct user_id) as users_total
from union_users_events
where month_event >= '2025-01'
    and month_event <= '2025-06'
group by promo_signup_flag, month_offset, cohort_month
order by promo_signup_flag, cohort_month, month_offset;
