-- Data Analysis & Business Key Problems & answers 
-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 2 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from retail_sales
where sale_date = '2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 2 in the month of Nov-2022
select 
*
from retail_sales
where 
category = 'Clothing'
and FORMAT(sale_date, 'yyyy-MM') = '2022-11'
and quantiy > 2

--Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select 
category,
sum(total_sale) total_sales
from retail_sales
group by category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select 
category,
avg(age) avg_age
from retail_sales
group by category
having category = 'Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select 
* 
from retail_sales
where total_sale > 1000

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select 
category,
gender,
count(transactions_id) transactions
from retail_sales
group by category,
gender
order by 1

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select * from (
	select 
	 YEAR(sale_date) year,
	 month(sale_date) month,
	 round(avg(total_sale),2) avgsale,
	 rank() over(partition by YEAR(sale_date) order by round(avg(total_sale),2) desc) rank_sales
	from retail_sales
	group by YEAR(sale_date), month(sale_date)
) t1
where rank_sales = 1

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select top 5
customer_id,
sum(total_sale) as total_sale
from retail_sales
group by customer_id
order by total_sale desc

---- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category,
count(distinct customer_id) as unique_customers
from retail_sales group by category

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

with Hourly_Sales as 
(
SELECT *,
    CASE 
        WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift
FROM retail_sales
)
select 
shift,
count(Transactions_id) no_of_orders
from Hourly_Sales
group by shift
