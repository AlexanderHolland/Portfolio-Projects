/* 
Amazon Sales Dashboard

Skills Used: SELECT, MAX, SUM, COUNT, YEAR, DATEPART, GROUP BY, WHERE, JOIN, CAST, DECIMAL, ORDER BY, WITH`
*/

SELECT 
  * 
FROM 
  Amazon_Combined_Data;

-- Selecting all data from the Amazon_Combined_Data table to review the entire dataset. This helps to understand what information is available, including every column and row, for further analysis. --

SELECT 
  MAX(
    YEAR(Order_date)
  ) 
FROM 
  Amazon_Combined_Data;

-- Identifying the most recent year of order data in the dataset. This query finds the latest year in which orders were recorded, helping to determine the current period of sales data available for analysis. --

SELECT 
  SUM(Price_Dollar) 
FROM 
  Amazon_Combined_Data 
WHERE 
  YEAR(Order_Date) = 2022;

-- Calculating the total revenue generated from sales in the year 2022. This query sums the price of all orders placed within the year 2022, providing insight into the overall financial performance year-to-date. --

SELECT 
  SUM(Price_Dollar) 
FROM 
  Amazon_Combined_Data 
WHERE 
  DATEPART(quarter, Order_Date) = '4' 
  AND YEAR(Order_date) = 2022;

-- Calculating the total revenue for the fourth quarter of 2022. This query sums the sales made during the last quarter of the year, helping to assess the company's performance during this specific period. --

SELECT 
  COUNT(Product_Description) 
FROM 
  Amazon_Combined_Data 
WHERE 
  YEAR(Order_Date) = '2022';

-- Counting the total number of products sold in the year 2022. This query tallies every product ordered in 2022, providing an overview of the volume of sales transactions during the year. --

SELECT 
  SUM(Number_of_reviews) 
FROM 
  Amazon_Combined_Data 
WHERE 
  YEAR(Order_Date) = '2022';
  
-- Calculating the total number of customer reviews received in 2022. This query sums the reviews associated with orders from 2022, offering a metric for customer engagement and feedback during that year. --

SELECT 
  YEAR(Order_Date) AS Year, 
  MONTH(Order_Date) AS Month_Order, 
  DATENAME(MONTH, Order_Date) AS Month, 
  SUM(Price_Dollar) AS YTD_Total_Sales 
FROM 
  Amazon_Combined_Data 
WHERE 
  YEAR(Order_Date) = '2022' 
GROUP BY 
  YEAR(Order_Date), 
  MONTH(Order_Date), 
  DATENAME(MONTH, Order_Date) 
ORDER BY 
  MONTH(Order_Date);
 
-- Analyzing total sales by month for the year 2022. This query aggregates sales data by month, showing the monthly distribution of revenue. It helps to identify trends and peak sales months throughout the year. --

SELECT 
  YEAR(Order_Date) AS Year, 
  DATEPART(WEEK, Order_Date) AS Week_Number, 
  SUM(Price_Dollar) AS YTD_Total_Sales 
FROM 
  Amazon_Combined_Data 
WHERE 
  YEAR(Order_Date) = '2022' 
GROUP BY 
  YEAR(Order_Date), 
  DATEPART(WEEK, Order_Date), 
  DATENAME(MONTH, Order_Date) 
ORDER BY 
  DATEPART(WEEK, Order_Date);
  
-- Analyzing total sales by week for the year 2022. This query provides a week-by-week breakdown of sales, showing how revenue was distributed across each week. It helps to pinpoint periods of high or low sales activity within the year. --

SELECT 
  TOP 5 Product_Description, 
  SUM(Price_Dollar) AS YTD_Total_Sales 
FROM 
  Amazon_Combined_Data 
WHERE 
  YEAR(Order_Date) = '2022' 
GROUP BY 
  Product_Description 
ORDER BY 
  SUM(Price_Dollar) DESC;

-- Identifying the top 5 best-selling products in terms of revenue for the year 2022. This query ranks products based on their total sales, highlighting the most financially successful items sold during the year. --

SELECT 
  TOP 5 Product_Description, 
  SUM(Number_of_reviews) AS YTD_Total_Reviews 
FROM 
  Amazon_Combined_Data 
WHERE 
  YEAR(Order_Date) = '2022' 
GROUP BY 
  Product_Description 
ORDER BY 
  SUM(Number_of_reviews) DESC; 
  
-- Identifying the top 5 most reviewed products in 2022. This query ranks products by the total number of customer reviews they received, indicating which products garnered the most customer feedback during the year. --

WITH a AS (
    SELECT 
      Product_Category, 
      SUM(Price_Dollar) AS Total_Sales 
    FROM 
      Amazon_Combined_Data 
    WHERE 
      YEAR(Order_Date) = 2022 
    GROUP BY 
      Product_Category
  ), 
  b AS (
    SELECT 
      Product_Category, 
      SUM(Price_Dollar) AS QTD_Sales 
    FROM 
      Amazon_Combined_Data 
    WHERE 
      DATEPART(quarter, Order_Date) = '4' 
      AND YEAR(Order_Date) = 2022 
    GROUP BY 
      Product_Category
  ), 
  c AS (
    SELECT 
      Product_Category, 
      CAST(
        SUM(Price_Dollar) * 100 / (
          SELECT 
            SUM(Price_Dollar) 
          FROM 
            Amazon_Combined_Data 
          WHERE 
            YEAR(Order_Date) = '2022'
        ) AS DECIMAL (10, 2)
      ) AS PCT_Sales 
    FROM 
      Amazon_Combined_Data 
    WHERE 
      YEAR(Order_Date) = 2022 
    GROUP BY 
      Product_Category
  ) 
SELECT 
  a.Product_Category, 
  a.Total_Sales, 
  b.QTD_Sales, 
  c.PCT_Sales 
FROM 
  a 
  JOIN b ON a.Product_Category = b.Product_Category 
  JOIN c ON a.Product_Category = c.Product_Category 
ORDER BY 
  a.Total_Sales DESC;

-- Analyzing total sales, quarter-to-date sales, and percentage of total sales by product category for the year 2022. This query provides a comprehensive view of how each product category performed, allowing for a comparison of overall sales, sales in the current quarter, and each category's contribution to the total annual revenue. --
