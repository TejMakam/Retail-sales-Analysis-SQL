-- Create database - Sales
Create database Sales;
Use Sales;

-- Create Table 
-- Create Table retail_sales
-- 		(
-- 			transactions_id	INT PRIMARY KEY,
-- 			sale_date DATE,	
-- 			sale_time TIME,
-- 			customer_id INT,
-- 			gender VARCHAR(15),	
-- 			age INT,	
--          category VARCHAR(20),	
-- 			quantiy	INT,
-- 			price_per_unit FLOAT,
-- 			cogs FLOAT,
-- 			total_sale FLOAT
-- 		);
                    
Drop table retail_sales;

select * from retail_sales;

select count(*) from retail_sales;

select * from retail_sales
where ﻿transactions_id is NULL;

select * from retail_sales
where sale_date is NULL;

select * from retail_sales
where sale_time is NULL;

select * from retail_sales
where customer_id is NULL;

select * from retail_sales
where gender is NULL;

select * from retail_sales
where age is NULL;

select * from retail_sales
where category is NULL;

select * from retail_sales
where quantiy is NULL;

select * from retail_sales
where price_per_unit is NULL;

select * from retail_sales
where cogs is NULL;

select * from retail_sales
where total_sale is NULL;

-- DATA CLEANING
select * from retail_sales
where
	﻿transactions_id is NULL
    or
    sale_date is NULL
    or
    sale_time is NULL
    or
    customer_id is NULL
    or
    gender is NULL
    or
    age is NULL
    or
    category is NULL
    or
    quantiy is NULL
    or
    price_per_unit is NULL
    or
    cogs is NULL
    or
    total_sale is NULL;
    
-- delete from retail_sales where transactions_id is NULL or sale_date is NULL or sale_time is NULL or customer_id is NULL or gender is NULL or age is NULL or category is NULL or quantiy is NULL or price_per_unit is NULL or cogs is NULL or total_sale is NULL; 

-- DATA EXPLORING

-- How many sales?
select count(*) as transactions_id from retail_sales;

-- How many unique customer?
select count(distinct customer_id) as customer_id from retail_sales;

-- how many catergories?
select distinct category from retail_sales;

-- Data Analysis and Business Key Problems and Answers

-- Q1 Write a SQL query to retrieve all columns for sales made on 2022-11-05
select * from retail_sales
where sale_date = '2022-11-05';	

-- Q2 Write SQL query to retrieve all transactions where the category is 'clothing' and the quantity sold is more than 10 in the month of Nov-2022
select * from retail_sales
where category = 'clothing' and sale_date BETWEEN '2022-11-01' AND '2022-11-30' and quantiy >= 4;

-- Q3 Write a SQL query to calculate the total sales for each category
select category, sum(total_sale) as net_sale, count(﻿transactions_id) as no_of_orders from retail_sales group by category;

-- Q4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
select round(avg(age),2) as avg_age from retail_sales where category = 'Beauty';

-- Q5 Write a SQL query to find all transactions where the total_sales is greater than 1000
select * from retail_sales where total_sale > 1000;

-- Q6 Write a SQL query to find the total number of transactions made by each gender in each category
select category, gender, count(*) as gender_count from retail_sales group by category, gender order by category;

-- Q7 Write a SQL query to calculate the average sale for each month. Find out the best selling month in each year.
select * from 
(
   select 
	Year(sale_date) as year, 
    month(sale_date) as month, 
    avg(total_sale) as avg_sale, 
    RANK() over(partition by Year(sale_date) order by avg(total_sale) desc) as Rank_
    from retail_sales group by year,month
    ) as T1 
    where rank_=1;
    
-- Q8 Write a SQL query to find top 5 customers based on the highest total sales
select 
	customer_id, 
    sum(total_sale) as sum_of_sale
    from retail_sales 
    group by customer_id
    order by sum_of_sale desc
    limit 5;
    
-- Q9 Write a SQL query to find the number of unique customers who purchased items from each category
select 
	category,
    count(distinct customer_id) as no_of_cust
    from retail_sales
    group by category
    order by no_of_cust;
    
-- Q10 Write a SQL query to create each shift and number of orders (Ex: Morning <= 12, Afternoo  between 12 & 17, Evening > 17)

WITH hourly_sales
as 
(
	select *, 
		Case
			When Hour(sale_time) < 12 THEN 'Morning'
			When Hour(sale_time) Between 12 and 17 THEN 'Afternoon'
			ELSE 'Evening'
		END as shift
	from retail_sales
)
Select 
	shift,
    count('transactions_id') as total_orders
    from hourly_sales
    group by shift;
    
-- END OF PROJECT