# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `p1_retail_db`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
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
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
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
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
select * from retail_sales
where sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
select * from retail_sales
where category = 'clothing' and sale_date BETWEEN '2022-11-01' AND '2022-11-30' and quantiy >= 4;

```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
select category, sum(total_sale) as net_sale, count(﻿transactions_id) as no_of_orders from retail_sales group by category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
select round(avg(age),2) as avg_age from retail_sales where category = 'Beauty';
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
select * from retail_sales where total_sale > 1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
select category, gender, count(*) as gender_count from retail_sales group by category, gender order by category;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
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
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
select 
	customer_id, 
    sum(total_sale) as sum_of_sale
    from retail_sales 
    group by customer_id
    order by sum_of_sale desc
    limit 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
select 
	category,
    count(distinct customer_id) as no_of_cust
    from retail_sales
    group by category
    order by no_of_cust;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. 

