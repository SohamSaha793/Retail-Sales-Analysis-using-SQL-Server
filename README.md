# 🛒 Retail Sales Analysis using SQL Server

## 📌 Project Overview
This project focuses on analyzing retail sales data using **SQL Server Management Studio (SSMS)**.  
The goal is to perform **data cleaning, exploration, and business-driven analysis** to extract meaningful insights from raw transactional data.

---

## 🧰 Tools & Technologies
- SQL Server Management Studio (SSMS)
- T-SQL
- Relational Database Concepts
- Window Functions & CTEs

---

## 🗄️ Database Creation
```sql
CREATE DATABASE SQL_PROJECT_P1;
USE SQL_PROJECT_P1;
🧹 Data Cleaning & Preparation
✔ Null Value Checks
Identified missing values across all important columns

Removed records containing null values to ensure data quality

sql
Copy code
DELETE FROM Retail_Sales_Analysis
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
🔍 Data Exploration
Total records count

Unique customers count

Unique product categories

Sales trends across time

📊 Business Questions Answered
1. Sales on a Specific Date
sql
Copy code
SELECT * FROM Retail_Sales_Analysis
WHERE sale_date = '2022-11-05';
2. Clothing Sales (Quantity > 2) in Nov 2022
sql
Copy code
SELECT *
FROM Retail_Sales_Analysis
WHERE category = 'Clothing'
  AND quantiy > 2
  AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';
3. Total Sales by Category
sql
Copy code
SELECT category, SUM(total_sale) AS total_sales
FROM Retail_Sales_Analysis
GROUP BY category;
4. Average Age of Beauty Category Customers
sql
Copy code
SELECT AVG(age) AS avg_age
FROM Retail_Sales_Analysis
WHERE category = 'Beauty';
5. Transactions by Gender & Category
sql
Copy code
SELECT gender, category, COUNT(transactions_id) AS transactions
FROM Retail_Sales_Analysis
GROUP BY gender, category;
6. Best Selling Month Each Year
sql
Copy code
SELECT year, month, avg_sale
FROM (
    SELECT 
        YEAR(sale_date) AS year,
        DATENAME(MONTH, sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        ROW_NUMBER() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS rank
    FROM Retail_Sales_Analysis
    GROUP BY YEAR(sale_date), DATENAME(MONTH, sale_date)
) t
WHERE rank = 1;
7. Top 5 Customers by Sales
sql
Copy code
SELECT TOP 5 customer_id, SUM(total_sale) AS total_sales
FROM Retail_Sales_Analysis
GROUP BY customer_id
ORDER BY total_sales DESC;
8. Sales Shift Analysis
sql
Copy code
WITH hourly_sale AS (
    SELECT *,
           CASE
               WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
               WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
               ELSE 'Evening'
           END AS shift
    FROM Retail_Sales_Analysis
)
SELECT shift, COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;
📈 Key Insights
Identified top-performing categories and customers

Found peak sales months per year

Analyzed customer buying behavior by gender and time of day

Shift-based sales patterns reveal peak order periods

🚀 Conclusion
This project demonstrates strong SQL fundamentals including:

Data Cleaning

Aggregations

Window Functions

CTEs

Business-driven analytical thinking

📎 Author
SOHAM SAHA
Aspiring Data Analyst | SQL | Data Analytics
