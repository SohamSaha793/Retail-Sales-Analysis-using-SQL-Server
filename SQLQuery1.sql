--RETAIL SALES ANALYSIS--

--CREATE DATABSE--
CREATE DATABASE SQL_PROJECT_P1;
--USE DATABSE--
USE SQL_PROJECT_P1;

--NULL CHECKING
SELECT sum(CASE WHEN transactions_id is null then 1 else 0 end) as transaction_id,
sum(CASE WHEN sale_date is null then 1 else 0 end),
sum(CASE WHEN sale_time is null then 1 else 0 end),
sum(CASE WHEN customer_id is null then 1 else 0 end) as customer_id,
sum(CASE WHEN gender is null then 1 else 0 end),
sum(CASE WHEN age is null then 1 else 0 end) as age,
sum(CASE WHEN category is null then 1 else 0 end),
sum(CASE WHEN quantiy is null then 1 else 0 end),
sum(CASE WHEN price_per_unit is null then 1 else 0 end) as price_per_unit,
sum(CASE WHEN cogs is null then 1 else 0 end),
sum(CASE WHEN total_sale is null then 1 else 0 end) as total_sale
from Retail_Sales_Analysis;

select *FROM Retail_Sales_Analysis
where transactions_id is null or
sale_date is null or
sale_time is null or
customer_id is null or
gender is null or
age is null or
category is null or
quantiy is null or
price_per_unit is null or
cogs is null or
total_sale is null;

 --Data Exploration & Cleaning

--- **Record Count**: Determine the total number of records in the dataset
SELECT COUNT(*) AS TOTAL_RECORD FROM Retail_Sales_Analysis;

--- **Customer Count**: Find out how many unique customers are in the dataset
SELECT COUNT(DISTINCT customer_id) AS TOTAL_CUSTOMER from Retail_Sales_Analysis;

--- **Category Count**: Identify all unique product categories in the dataset
SELECT DISTINCT category from Retail_Sales_Analysis;

- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.
--check
SELECT *FROM Retail_Sales_Analysis
WHERE transactions_id is null or
sale_date is null or
sale_time is null or
customer_id is null or
gender is null or
age is null or
category is null or
quantiy is null or
price_per_unit is null or
cogs is null or
total_sale is null;
--delete
delete FROM Retail_Sales_Analysis
WHERE transactions_id is null or
sale_date is null or
sale_time is null or
customer_id is null or
gender is null or
age is null or
category is null or
quantiy is null or
price_per_unit is null or
cogs is null or
total_sale is null;

--Data Analysis & Findings
--The following SQL queries were developed to answer specific business questions:
-- **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
SELECT *FROM Retail_Sales_Analysis
where sale_date='2022-11-05';

--**Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 2 in the month of Nov-2022**:
SELECT *FROM Retail_Sales_Analysis
where category  LIKE '%Clothing%' and
quantiy>2 and
sale_date between '2022-11-01' and '2022-11-30';

--**Write a SQL query to calculate the total sales (total_sale) for each category.**:
SELECT category,sum(total_sale) as total
from Retail_Sales_Analysis
group by category;

--**Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
SELECT AVG(age) AS AVG_AGE from Retail_Sales_Analysis
WHERE category='Beauty';

--**Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
SELECT gender,category,count(transactions_id) as no_of_transactions,ROW_NUMBER() OVER (PARTITION BY gender order by count(transactions_id) desc)
as rnk
from Retail_Sales_Analysis
group by gender,category;

--**Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:

select year,month,avg_sale
from
(SELECT year(sale_date) as year,datename(month,sale_date) as month,avg(total_sale) as avg_sale,
row_number() over (partition by year(sale_date) order by avg(total_sale) desc) as rank
from Retail_Sales_Analysis
group by year(sale_date),datename(month,sale_date)) as t1
where rank=1;

--**Write a SQL query to find the top 5 customers based on the highest total sales **:
select top 5
customer_id,sum(total_sale)
from Retail_Sales_Analysis
GROUP BY customer_id
order by sum(total_sale) desc;

--**Write a SQL query to find the number of unique customers who purchased items from each category.**:
SELECT COUNT(*) AS CUSTOMER_COUNT FROM 
(SELECT customer_id
    FROM Retail_Sales_Analysis
    GROUP BY customer_id
    HAVING COUNT(DISTINCT category) =
           (SELECT COUNT(DISTINCT category) FROM Retail_Sales_Analysis))T;
--**Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:

with hourly_sale
as
(SELECT *,
           CASE
               WHEN DATEPART(HOUR,sale_time) < 12 THEN 'Morning'
               WHEN DATEPART(HOUR,sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
               ELSE 'Evening'
           END AS shift
    FROM Retail_Sales_Analysis
    )
    select shift,count(*) as no_Of_orders
    into shift_sale
    from hourly_sale
    group by shift;

 select *from shift_sale;


