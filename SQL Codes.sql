-- 1. Total Revenue
select round(sum(total_price),2) as total_revenue
from pizza_sale;

-- 2. Average Order Value 
select round(sum(total_price)/count(distinct order_id),2) as Avg_Order_Value
from pizza_sale;

-- 3. Total Pizzas Sold
select round(sum(quantity), 2) as total_pizzas_sold
from pizza_sale;

-- 4. Total Orders Placed
select count(distinct order_id) as total_orders_placed 
from pizza_sale;

-- 5. Average Pizza per order
-- My Approach (maybe wrong)
select avg(avg_order) as avg_pizza_per_order
from
(select order_id, count(*) as avg_order
from pizza_sale
group by order_id
order by avg_order desc)as x;

-- Actual Approach(right)
select sum(quantity)/count(distinct order_id) as avg_order
from pizza_sale;

-- 6. Daily Trends for Total Orders
select dayname(order_date) Day_name, count(distinct order_id) as per_day_order
from pizza_sale
group by dayname(order_date)
order by per_day_order desc;

-- 7. Monthly Trends for Total Orders
select monthname(order_date) Months, count(distinct order_id) as per_month_order
from pizza_sale
group by monthname(order_date)
order by per_month_order desc;

-- 8. Percentage of Sales per Pizza Category

select pizza_category, round(sum(total_price), 0) as total_sales, round(sum(total_price)*100/(select sum(total_price) from pizza_sale), 2) as per_revenue
from pizza_sale
group by pizza_category;

-- With Filtering 

select pizza_category, round(sum(total_price), 0) as total_sales, 
round(sum(total_price)*100/(select sum(total_price) from pizza_sale where month(order_date) = 1), 2) as PCT
from pizza_sale
where month(order_date) = 1
group by pizza_category
order by PCT desc;

-- 9. Percentage of Sales Per Pizza Size

select pizza_size, round(sum(total_price), 0) as total_sales, round(sum(total_price)*100/(select sum(total_price) from pizza_sale), 2) as PCT
from pizza_sale
group by pizza_size
order by PCT desc;

-- 10. Top 5 Best Seller by Revenue, Total Quantity, Total Orders

-- Revenue
select pizza_name, round(sum(total_price), 2) as revenue
from pizza_sale
group by pizza_name
order by revenue desc
limit 5;

-- Total Quantity
select pizza_name, sum(quantity) as Total_quantity
from pizza_sale
group by pizza_name
order by Total_quantity desc
limit 5;

-- Total Orders
select pizza_name,  count(distinct order_id) as Total_orders
from pizza_sale
group by pizza_name
order by Total_orders desc
limit 5;