-- select only 10 rows
select top 10 * 
from dbo.retail_sales 

-- Data Cleaning
-- total rows in table
select count(*) Total_Records
from retail_sales

-- find null record in table
select * from retail_sales
where 
	transactions_id is null
	or sale_date is null
	or sale_time is null
	or gender is null
	or category is null 
	or quantiy is null
	or price_per_unit is null
	or cogs is null
	or total_sale is null

-- delete records where we had null
delete from retail_sales
where transactions_id is null
	or sale_date is null
	or sale_time is null
	or gender is null
	or category is null 
	or quantiy is null
	or price_per_unit is null
	or cogs is null
	or total_sale is null


-- Data Exploration

-- How many sales we have 
select count(*) as total_Sale from retail_sales

-- How many Unique Customers we have 
select count(distinct customer_id) as unique_customers from retail_sales

-- what are diff unique categories available
select distinct category from retail_sales

