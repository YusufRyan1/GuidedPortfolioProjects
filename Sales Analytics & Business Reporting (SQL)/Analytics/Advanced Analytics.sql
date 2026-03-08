--Changes over Time Analysis

select 
year(order_date) as order_year,
Month(order_date) as order_month,
sum(sales_amount) as total_sales,
count(distinct customer_key) as total_customers,
sum(quantity) as total_quantity
from gold.fact_sales 
where order_date is not null
group by year(order_date),Month(order_date)
order by year(order_date),Month(order_date)

--Cumulative analysis
--calculate the total sales per month 
--and the running total of sales over time
select
order_date ,
total_sales,
sum(total_sales) over(order by order_date) as running_total_sales,
avg(avg_price) over (order by order_date) as moving_average
from 
(
select 
datetrunc(month,order_date) as order_date, 
sum(sales_amount) as total_sales,
avg(price) as avg_price
from gold.fact_sales
where order_date is not null
group by datetrunc(month,order_date)
)t

--Performance analysis
/*analyze the yearly performance of products by comparing their sales to both the average sales performance of the product and the previous year's sales*/
with yearly_product_sales as (
select year(fs.order_date) as order_year,
dp.product_name ,
sum(fs.sales_amount) as current_sales
from gold.fact_sales as fs
left join gold.dim_products as dp
on fs.product_key=dp.product_key
where fs.order_date is not null
group by dp.product_name,year(fs.order_date))

select 
order_year,
product_name,
current_sales,
avg(current_sales) over (partition by product_name) as average_sales,
current_sales-avg(current_sales) over (partition by product_name) as diff_AVG,
Case when current_sales-avg(current_sales) over (partition by product_name) >0 then 'Above Average'
	 when current_sales-avg(current_sales) over (partition by product_name) <0 then 'Below Average'
	 Else 'Average'
End avg_change,
--Year over Year analysis
LAG(current_sales) over (partition by product_name order by order_year) as previous_year_sales,
current_sales-LAG(current_sales) over (partition by product_name order by order_year) as diff_PY,
Case when current_sales-LAG(current_sales) over (partition by product_name order by order_year) >0 then 'Increasing'
	 when current_sales-LAG(current_sales) over (partition by product_name order by order_year) <0 then 'Decreasing'
	 Else 'No Change'
End PY_Change
from yearly_product_sales
order by product_name,order_year

--Part to whole analysis
--Which Categories contribute the most to overall sales?
with category_sales as
(
select 
category_name,
sum(sales_amount) as total_sales,
sum(sum(sales_amount)) over () as overall_sales 
from gold.fact_sales as fs 
left join gold.dim_products as dp 
on fs.product_key=dp.product_key
group by category_name)

select 
category_name,
total_sales,
overall_sales,
CONCAT( Round(cast (total_sales as float)/overall_sales *100,2),' %')  as percentage_of_total
from category_sales
order by total_sales desc

--Data Segmentation
/* Segment products into cost ranges and 
count how many products fall into each segment*/
with product_segments as (
select 
product_key ,
product_name,
cost,
case 
	when cost < 100 then 'Below 100'
	when cost >100 and cost <500 then '100-500'
	when cost > 500 and cost <1000 then '500-1000'
	else 'Above 1000'
end cost_range
from gold.dim_products
)
select 
cost_range,
count(product_key) as total_products
from product_segments
group by cost_range


/* Group customers into three segments based on their spending behavior:
	- Vip: Customers with atleast 12 months of history and spending more than $5000
	- Regular: Customers with at least 12 months of history but spending 5000 or less
	- New: Customers with a lifespan less than 12 months 
and find the total number of customers by each group
*/
with customer_spending as (
select 
dc.customer_key,
sum(fs.sales_amount) as total_spending,
MIN(order_date) as first_order,
MAX(order_date) as last_order,
DATEDIFF(month,min(order_date),max(order_date)) life_span_in_months
from gold.fact_sales as fs
left join gold.dim_customers as dc
on fs.customer_key=dc.customer_key 
group by dc.customer_key
)

select customer_segment , 
count(customer_key) as total_customers
from
(
select 
customer_key,
total_spending,
life_span_in_months,
case 
	when life_span_in_months >=12 and total_spending>5000 then 'VIP'
	when life_span_in_months>=12 and total_spending<=5000 then 'Regular'
	else 'New' 
end customer_segment
from customer_spending
)t
group by customer_segment 
order by total_customers desc