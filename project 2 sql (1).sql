use thank_u;
show tables;


-- 1. How many unique cities does the data have?
SELECT COUNT(DISTINCT city) AS unique_cities FROM WalmartSalesData;

-- 2. In which city is each branch?
SELECT branch, city FROM WalmartSalesData;


-- 1. How many unique product lines does the data have?
SELECT COUNT(DISTINCT Productline) AS unique_product_lines FROM WalmartSalesData;

-- 2. What is the most common payment method?
SELECT Payment, COUNT(*) AS frequency 
FROM WalmartSalesData 
GROUP BY Payment
ORDER BY frequency DESC 
LIMIT 1;

-- 3. What is the most selling product line?
SELECT productline, SUM(quantity) AS total_sold 
FROM WalmartSalesData 
GROUP BY productline 
ORDER BY total_sold DESC 
LIMIT 1;

-- 4. What is the total revenue by month?
SELECT month, SUM(TOTAL/1.18) AS total_revenue 
FROM WalmartSalesData  
GROUP BY month;

-- 5. What month had the largest COGS?
SELECT month, SUM(COGS) AS total_cogs 
FROM WalmartSalesData  
GROUP BY month 
ORDER BY total_cogs DESC 
LIMIT 1;

-- 6. What product line had the largest revenue?
SELECT productline, SUM(TOTAL/1.18) AS total_revenue 
FROM WalmartSalesData 
GROUP BY productline 
ORDER BY total_revenue DESC 
LIMIT 1;

-- 5. What is the city with the largest revenue?
SELECT city, SUM(TOTAL/1.18) AS total_revenue 
FROM WalmartSalesData 
GROUP BY city 
ORDER BY total_revenue DESC 
LIMIT 1;

-- 6. What product line had the largest VAT?
SELECT productline, SUM(VAT) AS total_VAT 
FROM WalmartSalesData 
GROUP BY productline 
ORDER BY total_VAT DESC 
LIMIT 1;

-- 7. Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
SELECT *,
       CASE WHEN total_sold > average_sales THEN 'Good'
            ELSE 'Bad' 
       END AS sales_performance
FROM (SELECT productline,
             SUM(quantity) AS total_sold,
             AVG(SUM(quantity)) OVER () AS average_sales
      FROM WalmartSalesData 
      GROUP BY productline) AS subquery;


-- 8. Which branch sold more products than average product sold?
SELECT branch
FROM WalmartSalesData
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(total_quantity) FROM (SELECT branch, SUM(quantity) AS total_quantity FROM WalmartSalesData GROUP BY branch) AS avg_per_branch);


-- 9. What is the most common product line by gender?
SELECT gender, productline, COUNT(*) AS frequency
FROM WalmartSalesData
GROUP BY gender, productline
ORDER BY frequency DESC
LIMIT 1;

-- 12. What is the average rating of each product line?
SELECT productline, AVG(rating) AS average_rating
FROM WalmartSalesData
GROUP BY productline;



-- ### Sales

-- 1. Number of sales made in each time of the day per weekday?
SELECT week AS weekday, 
       HOUR(time) AS hour_of_day, 
       COUNT(*) AS number_of_sales
FROM WalmartSalesData
GROUP BY weekday, hour_of_day
order by weekday;

-- 2. Which of the customer types brings the most revenue?
SELECT customertype, SUM(total/1.18) AS total_revenue 
FROM WalmartSalesData
GROUP BY customertype 
ORDER BY total_revenue DESC 
LIMIT 1;

-- 3. Which city has the largest tax percent/ VAT (**Value Added Tax**)?
SELECT city
-- , MAX(VAT) AS largest_VAT_percent
FROM WalmartSalesData
GROUP BY city having max(vat) limit 1;

-- 4. Which customer type pays the most in VAT?
SELECT customertype, SUM(VAT) AS total_VAT_paid
FROM WalmartSalesData
GROUP BY customertype
ORDER BY total_VAT_paid DESC
LIMIT 1;




-- ### Customer

-- 1. How many unique customer types does the data have?
SELECT COUNT(DISTINCT Customertype ) AS unique_customer_types FROM WalmartSalesData;

-- 2. How many unique payment methods does the data have?
SELECT COUNT(DISTINCT Payment) AS unique_payment_methods FROM WalmartSalesData;

-- 3. What is the most common customer type?
SELECT customertype, COUNT(*) AS frequency 
FROM WalmartSalesData
GROUP BY customertype 
ORDER BY frequency DESC 
LIMIT 1;

-- 4. Which customer type buys the most?
SELECT customertype, SUM(quantity) AS total_products_bought 
FROM WalmartSalesData
GROUP BY customertype 
ORDER BY total_products_bought DESC 
LIMIT 1;

-- 5. What is the gender of most of the customers?
SELECT gender, COUNT(*) AS frequency 
FROM WalmartSalesData 
GROUP BY gender 
ORDER BY frequency DESC 
LIMIT 1;

-- 6. What is the gender distribution per branch?
SELECT branch, gender, COUNT(*) AS frequency 
FROM WalmartSalesData 
GROUP BY branch, gender;

-- 7. Which time of the day do customers give most ratings?
SELECT HOUR(Time) AS hour_of_day, COUNT(*) AS number_of_ratings
FROM WalmartSalesData
GROUP BY hour_of_day
ORDER BY number_of_ratings DESC
LIMIT 1;

-- 8. Which time of the day do customers give most ratings per branch?
SELECT branch, HOUR(Time) AS hour_of_day, COUNT(*) AS number_of_ratings
FROM WalmartSalesData
GROUP BY branch, hour_of_day
ORDER BY branch, number_of_ratings DESC
limit 1;

-- 9. Which day fo the week has the best avg ratings?
SELECT week AS weekday, AVG(rating) AS average_rating
FROM WalmartSalesData
GROUP BY weekday
ORDER BY average_rating DESC
LIMIT 1;

-- 10. Which day of the week has the best average ratings per branch?
SELECT branch, week AS weekday, AVG(rating) AS average_rating
FROM WalmartSalesData
GROUP BY branch, weekday
ORDER BY branch, average_rating DESC;
