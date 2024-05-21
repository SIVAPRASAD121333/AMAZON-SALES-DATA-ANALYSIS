use project_sql;
select * from amazon;
-- select * from project_sql.amazon;
-- select * from project_sql.amazon;

/* Renaming Columns without space */
ALTER TABLE amazon
RENAME COLUMN `Invoice ID` TO invoice_id, 
RENAME COLUMN  Branch TO branch,
RENAME COLUMN  City TO city, 
RENAME COLUMN `Customer` TO customer_type, 
RENAME COLUMN  Gender TO gender, 
RENAME COLUMN `Product line` TO product_line,
RENAME COLUMN `Unit price` TO unit_price,
RENAME COLUMN  Quantity TO quantity,
RENAME COLUMN `Tax 5%` TO VAT,  
RENAME COLUMN  Total TO total,
RENAME COLUMN  Date TO date,
RENAME COLUMN  Time TO time,
RENAME COLUMN  Payment TO payment_method,
RENAME COLUMN cogs TO cogs,
RENAME COLUMN `gross margin percentage` TO gross_margin_percentage,
RENAME COLUMN  `gross income` TO gross_income,
RENAME COLUMN Rating TO rating; 

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'amazon';

/*Data Wrangling : Handling Missing Values,Data Transformation,Filtering and Sorting,Handling Duplicates */
 /* Checking NULL values in each column of the "Amazon" table */
 -- Using CASE statement to check each column for NULL values and sums up the counts --
SELECT
  SUM(CASE WHEN invoice_id IS NULL THEN 1 ELSE 0 END) AS invoice_id_null_count,
  SUM(CASE WHEN branch IS NULL THEN 1 ELSE 0 END) AS branch_null_count,
  SUM(CASE WHEN city IS NULL THEN 1 ELSE 0 END) AS city_null_count,
  SUM(CASE WHEN customer_type IS NULL THEN 1 ELSE 0 END) AS customer_type_null_count,
  SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END) AS gender_null_count,
  SUM(CASE WHEN product_line IS NULL THEN 1 ELSE 0 END) AS product_line_null_count,
  SUM(CASE WHEN unit_price IS NULL THEN 1 ELSE 0 END) AS unit_price_null_count,
  SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) AS quantity_null_count,
  SUM(CASE WHEN VAT IS NULL THEN 1 ELSE 0 END) AS tax_null_count,
  SUM(CASE WHEN total IS NULL THEN 1 ELSE 0 END) AS total_null_count,
  SUM(CASE WHEN date IS NULL THEN 1 ELSE 0 END) AS date_null_count,
  SUM(CASE WHEN time IS NULL THEN 1 ELSE 0 END) AS time_null_count,
  SUM(CASE WHEN payment_method IS NULL THEN 1 ELSE 0 END) AS payment_method_null_count,
  SUM(CASE WHEN cogs IS NULL THEN 1 ELSE 0 END) AS cogs_null_count,
  SUM(CASE WHEN gross_margin_percentage IS NULL THEN 1 ELSE 0 END) AS gross_margin_percentage_null_count,
  SUM(CASE WHEN gross_income IS NULL THEN 1 ELSE 0 END) AS gross_income_null_count,
  SUM(CASE WHEN rating IS NULL THEN 1 ELSE 0 END) AS rating_null_count
FROM amazon;

/* Checking unique values in All Columns*/
/* Checking unique invoice_id in amazon table */
SELECT COUNT(DISTINCT invoice_id) AS distinct_invoice_count
FROM amazon;

/* Checking unique invoice_id in amazon table */
SELECT branch, COUNT(*) AS branch_count
FROM amazon
GROUP BY branch;

SELECT COUNT(DISTINCT branch) AS distinct_branch_count
FROM amazon;

/* Checking unique city in amazon table */
select city,COUNT(*) AS city_count
FROM amazon
GROUP BY city;

/* Checking unique customer_type in amazon table */
select customer_type,COUNT(*) AS customer_type_count
FROM amazon
GROUP BY customer_type;

/* Checking  each unique gender counts in amazon table */
select gender,COUNT(*) AS gender_count
FROM amazon
GROUP BY gender;


/* Checking unique product_line in amazon table */
select product_line,COUNT(*) AS product_line_count
FROM amazon
GROUP BY product_line
order by product_line_count desc  ;

SELECT COUNT(DISTINCT product_line) AS product_line_count
FROM amazon;

/* Checking unique unit_price in amazon table */
select unit_price,COUNT(*) AS unit_price_count
FROM amazon
GROUP BY unit_price ;

SELECT COUNT(DISTINCT unit_price) AS distinct_unit_price_count
FROM amazon; 

/* Checking unique quantity in amazon table */
select quantity,COUNT(*) AS city_count
FROM amazon
GROUP BY quantity
order by quantity ;

SELECT COUNT(DISTINCT quantity) AS distinct_quantity_count
FROM amazon;

/* Checking unique VAT/tax 5% in amazon table */
SELECT COUNT(DISTINCT VAT) AS distinct_VAT_count
FROM amazon;

/* Checking unique total count in amazon table */
SELECT COUNT(DISTINCT total) AS distinct_total_count
FROM amazon;

/* Checking unique date count in amazon table */
SELECT COUNT(DISTINCT date) AS distinct_date_count
FROM amazon;

/* Checking unique time count in amazon table */
SELECT COUNT(DISTINCT time) AS distinct_time_count
FROM amazon;

/* Checking unique payment_method in amazon table */
SELECT COUNT(DISTINCT payment_method) AS payment_method_count
FROM amazon;

select payment_method,COUNT(*) AS payment_method_count
FROM amazon
GROUP BY payment_method;

/* Checking unique COGS in amazon table */
SELECT COUNT(DISTINCT cogs) AS cogs_count
FROM amazon;

/* Checking unique gross_margin_percentage in amazon table */
SELECT COUNT(DISTINCT gross_margin_percentage) AS gross_margin_percentage_count
FROM amazon;

select gross_margin_percentage,COUNT(*) AS gross_margin_percentage_count
FROM amazon
GROUP BY gross_margin_percentage;

/* Checking unique gross_income in amazon table */
SELECT COUNT(DISTINCT gross_income) AS gross_income_count
FROM amazon;

/* Checking unique rating in amazon table */
SELECT COUNT(DISTINCT rating) AS gross_income_count
FROM amazon;


/* Feature Engineering */
-- Add a new column named timeofday to give insight of sales in the Morning, Afternoon and Evening.

SELECT 
    *, 
    CASE 
        WHEN TIME >= '00:00:00' AND TIME < '12:00:00' THEN 'Morning'
        WHEN TIME >= '12:00:00' AND TIME < '18:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END AS timeofday
FROM amazon;

-- permanently add timeofday

-- Update the timeofday column based on the time ranges
SELECT time, 
    CASE 
        WHEN TIME >= '00:00:00' AND TIME < '12:00:00' THEN 'Morning'
        WHEN TIME >= '12:00:00' AND TIME < '18:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END AS timeofday
FROM amazon;
alter table amazon add column timeofday  varchar(20);
update amazon
set timeofday= (
 CASE 
        WHEN TIME >= '00:00:00' AND TIME < '12:00:00' THEN 'Morning'
        WHEN TIME >= '12:00:00' AND TIME < '18:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END
);

-- Add a new column named `day_name` that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri).

select *,dayname(date) as dayname
from amazon;
-- Update the day_name column with the abbreviated day names
select *, DATE_FORMAT(Date, '%a') as dayname 
from amazon;

-- permanently add dayname column
select date, dayname(date)
from amazon;

alter table amazon add column dayname varchar(10);
update  amazon
set dayname= dayname(date);
-- Add a new column named monthname that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar)
select *,monthname(date) as monthname
from amazon;
-- Update the day_name column with the abbreviated month names
SELECT 
    *,
    DATE_FORMAT(Date, '%b') AS monthname
FROM amazon;

-- permanently add monthname

select date, monthname(date) from amazon;
alter table amazon add column monthname varchar(20);
update  amazon
set monthname= monthname(date);

select * from amazon;
-- coulmn count
SELECT COUNT(*)
FROM information_schema.columns
WHERE table_schema = 'project_sql'
AND table_name = 'amazon';


-- Business Questions To Answer:
-- 1. What is the count of distinct cities in the dataset?
select distinct city from amazon;
select count(distinct city) as distinct_city_count from amazon;
select city,COUNT(*) AS city_count
FROM amazon
GROUP BY city; 

-- 2. For each branch, what is the corresponding city?
select distinct city,branch from amazon; 

-- Product Analysis
-- 3.What is the count of distinct product lines in the dataset?
select count(distinct product_line) as distinct_product_line_count  from amazon;

-- 4.Which payment method occurs most frequently? 
select payment_method, count( payment_method) as count
from amazon
group by payment_method
order by  count desc; 

-- 5. Which product line has the highest sales? 
select product_line, count(product_line) as count from amazon 
group by product_line order by count desc limit 1 ; 

-- 6. How much revenue is generated each month? 
Select monthname as Month, round(sum(total),2) as Total_Revenue 
from amazon
group by monthname
order by Total_Revenue Desc ;

-- 7. In which month did the cost of goods sold reach its peak? 
select monthname as month, round(sum(cogs),2) as cogs
from amazon
group by monthname
order by cogs desc;


-- 8. Which product line generated the highest revenue? 
select product_line, round(sum(total),2) as Total_revenue 
from amazon
group by product_line
order by Total_revenue  desc; 

-- 9. In which city was the highest revenue recorded? 
select customer_type, round (sum(total), 2) as total_revenue
from amazon
group by customer_type
order by total_revenue desc;

-- 10. Which product line incurred the highest Value Added Tax? 
select product_line, round(sum(VAT),2) as Valueable_Tax
from amazon
group by product_line
order by Valueable_Tax  desc; 

-- 11. For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad." 
-- Add the new column to the table
ALTER TABLE amazon
ADD COLUMN product_line_status VARCHAR(20);

-- Calculate the average total from the amazon table
SET @avg_total = (SELECT AVG(Total) FROM amazon);

-- Update the product_line_status based on the condition
UPDATE amazon
SET product_line_status = CASE 
    WHEN Total > @avg_total THEN 'Good' 
    ELSE 'Bad'
END;



SELECT product_line,round(SUM(total),2) as total_sales,round(AVG(total),2) as avg_sales,
    CASE
        WHEN SUM(total) > (SELECT AVG(total) FROM amazon) THEN 'Good'
        ELSE 'Bad'
    END AS sales_status
FROM 
    amazon
GROUP BY 
    product_line;
    
-- 12. Identify the branch that exceeded the average number of products sold. 
select branch , sum(quantity) as qty
from amazon
group by branch
having sum(quantity) > 
 (select  avg(quantity) from amazon); 
 
 -- 13. Which product line is most frequently associated with each gender? 
 select
 gender,
    product_line,
    count(gender) as total_count
from amazon
group by gender, product_line
order by total_count desc; 

-- 14. Calculate the average rating for each product line. 
select product_line, round(avg (rating) , 2) as avg_rating
from amazon
group by product_line
order by avg_rating desc;



/* Sales Analysis */
-- 15. Count the sales occurrences for each time of day on every weekday. 
select timeofday, count(*) as total_sales
from amazon
where dayname = "Sunday"
group by timeofday
order by total_sales desc;

-- 16. Identify the customer type contributing the highest revenue. 
select customer_type, round (sum(total), 2) as total_revenue
from amazon
group by customer_type
order by total_revenue desc; 

-- 17. Determine the city with the highest VAT percentage. 
select city, round(avg(VAT),2) as value_added_tax
from amazon
group by city
order by value_added_tax desc;

-- 18. Identify the customer type with the highest VAT payments. 
select customer_type, round(avg(VAT),2) as value_added_tax
from amazon
group by customer_type
order by value_added_tax desc; 

-- 19. What is the count of distinct customer types in the dataset? 
select count(distinct (customer_type))  as distinct_customer_type_count  from amazon;
select distinct (customer_type) from amazon;


-- 20.  What is the count of distinct payment methods in the dataset?
select count(distinct (payment_method)) as distinct_payment_methods_count  from amazon; 
select distinct (payment_method) as distinct_payment_methods  from amazon;

-- 21. Which customer type occurs most frequently? 
select customer_type, count(*) as total_count
from amazon
group by customer_type
order by total_count desc;

-- 22. Identify the customer type with the highest purchase frequency. 
select customer_type, count(*) as total_count
from amazon
group by customer_type
order by total_count desc; 

-- 23. Determine the predominant gender among customers. 
select gender, count(*) as gender_count
from amazon
group by gender
order by gender_count desc;  


-- 24. Examine the distribution of genders within each branch. 
SELECT branch,gender,COUNT(*) AS gender_count
FROM amazon GROUP BY branch ,gender order by branch asc,gender_count desc;

-- 25. Identify the time of day when customers provide the most ratings. 
select timeofday, round(avg(rating),2) as avg_rating
from amazon
group by timeofday
order by avg_rating desc;

-- 26. Determine the time of day with the highest customer ratings for each branch. 
select timeofday,branch,
    round(avg(rating),2) as avg_rating
from amazon
group by timeofday, branch
order by branch,avg_rating desc ;

-- 27. Identify the day of the week with the highest average ratings. 
select dayname, round(avg(rating),2) as avg_rating
from amazon
group by dayname
order by avg_rating desc; 

-- 28. Determine the day of the week with the highest average ratings for each branch. 
select dayname,branch,
    round(avg(rating),2) as avg_rating
from amazon
group by dayname,branch 
order by branch asc,avg_rating desc;

/* Thank you*/

