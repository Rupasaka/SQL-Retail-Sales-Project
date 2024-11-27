create table retail_sales(transaction_id int PRIMARY KEY,sales_date DATE,sales_time TIME,customer_id INT,gender VARCHAR(20),age INT,category VARCHAR(20),quantity INT,price_per_unit FLOAT,cogs FLOAT,total_sale FLOAT);
--Data cleaning
select count(*) from retail_sales;
select count(distinct transaction_id) from retail_sales;
select * from retail_sales where quantity is NULL;
delete from retail_sales where  quantity is null;

-- Data Exploration

-- How many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales

-- How many uniuque customers we have ?

SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales;



SELECT DISTINCT category FROM retail_sales;

Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select * from retail_sales where sales_date = '2022-11-05'; 11

Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

select * from retail_sales where category = 'Clothing' and quantity >= 4 and TO_CHAR(sales_date, 'YYYY-MM') = '2022-11';

Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select sum(total_sale), category from retail_sales group by category;

Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select round(avg(age),2) from retail_sales where category = 'Beauty';

Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select count(transaction_id) from retail_sales where total_sale > 1000;

Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select count(transaction_id),gender,category from retail_sales group by gender,category order by category;


Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1

 Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

 select customer_id, sum(total_sale) as total from retail_sales group by 1 order by 2 DESC limit 5;


Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select count(distinct customer_id) from retail_sales group by category;


Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale
AS
(
select *,
CASE
when extract(hour from sales_time) < 12 then 'Morning'
when extract(hour from sales_time) >12 and extract(hour from sales_time) < 17 then 'Afternoon'
else ' evening'
end as shift
from retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift














