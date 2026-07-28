with revenue_per_month as (
	select  user_id,
			date_trunc('month', payment_date) as  payment_month,
			sum(revenue_amount_usd) as revenue_per_user
	from project.games_payments
	group by user_id, date_trunc('month', payment_date)
),
auxiliary_months_columns as(
	select	user_id,
			payment_month,
			revenue_per_user,
			lag(revenue_per_user) over (partition by user_id order by payment_month) as previous_month_revenue_per_user,
			lag(payment_month) over (partition by user_id order by payment_month) as previous_paid_month,
			min(payment_month) over (partition by user_id) as first_paid_month,
			lead(payment_month) over (partition by user_id order by payment_month) as next_paid_month,
			payment_month + interval '1 month' as expected_paid_month
	from revenue_per_month
),
general_main_metrics as(
	select	user_id,
			revenue_per_user,
			(case when first_paid_month = payment_month then  revenue_per_user else 0 end) as new_mrr,
			(case when payment_month = first_paid_month then 1 else 0 end) as is_new_user,
			payment_month,
			expected_paid_month,
			(case when next_paid_month is null or next_paid_month != expected_paid_month
				  then 1 else 0 end) as churned_users,
			(case when next_paid_month is null or next_paid_month != expected_paid_month
				  then revenue_per_user else 0 end) as churned_revenue,
			(case when previous_paid_month = payment_month - interval '1 month'
				  and revenue_per_user > previous_month_revenue_per_user
				  then revenue_per_user - previous_month_revenue_per_user else 0  end) as expansion_mrr,
			(case when revenue_per_user < previous_month_revenue_per_user
				  and previous_paid_month = payment_month - interval '1 month'
				  then revenue_per_user - previous_month_revenue_per_user else 0  end) as contraction_mrr
	from auxiliary_months_columns
),
monthly_totals as (
	select  payment_month,
	        sum(revenue_per_user) as mrr_this_month,
	        round(sum(revenue_per_user) / count(distinct user_id), 2) as arppu_this_month
	from revenue_per_month
	group by payment_month
)
select	gmm.user_id,
		gpu.language,
		gpu.age,
		gpu.has_older_device_model as device,
		gmm.revenue_per_user,
		gmm.new_mrr,
		gmm.is_new_user,
		gmm.payment_month,
		gmm.expected_paid_month,
		gmm.churned_users,
		gmm.churned_revenue,
		gmm.expansion_mrr,
		gmm.contraction_mrr,
		mt.arppu_this_month,
		mt.mrr_this_month
from general_main_metrics as gmm
join monthly_totals as mt on mt.payment_month = gmm.payment_month
join games_paid_users as gpu on gpu.user_id = gmm.user_id
order by payment_month





