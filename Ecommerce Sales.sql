/* 
E-commerce Sales Dashboard

Skills Used: SELECT, MAX, SUM, COUNT, YEAR, DATEPART, DATENAME, GROUP BY, WHERE, JOIN, CAST, DECIMAL, ORDER BY, WITH, DISTINCT, LEFT JOIN, TOP
*/

SELECT 
  * 
FROM 
  ecommerce_data;

-- Selecting all data from the ecommerce_data table to enable a comprehensive view of all recorded transactions, products, customer details, and other relevant information. --

SELECT 
  DISTINCT(
    YEAR(order_date)
  ) 
FROM 
  ecommerce_data;

-- Identifying the range of years present in the dataset by extracting unique years from the order_date field, which helps in understanding the time span covered by the sales data. --

SELECT 
  SUM(sales_per_order) AS YTD_Total_Sales 
FROM 
  ecommerce_data 
WHERE 
  YEAR(order_date) = '2022';

-- Calculating the total sales for the year 2022, providing an overview of the revenue generated up to the current date within that year. --

SELECT 
  DATENAME(MONTH, order_date) AS Month_Name, 
  MONTH(order_date) Month_Order, 
  SUM(sales_per_order) AS YTD_Total_Sales 
FROM 
  ecommerce_data 
WHERE 
  YEAR(order_date) = '2022' 
GROUP BY 
  DATENAME(MONTH, order_date), 
  MONTH(order_date) 
ORDER BY 
  MONTH(order_date);

-- Analyzing the total sales on a month-by-month basis for 2022, allowing us to track sales performance and identify trends or seasonal variations within the year. --

WITH a AS (
  SELECT 
    SUM(sales_per_order) AS YTD_Total_Sales 
  FROM 
    ecommerce_data 
  WHERE 
    YEAR(order_date) = 2022
), 
b AS (
  SELECT 
    SUM(sales_per_order) AS PYTD_Total_Sales 
  FROM 
    ecommerce_data 
  WHERE 
    YEAR(order_date) = '2021'
) 
SELECT 
  (
    YTD_Total_Sales - PYTD_Total_Sales
  ) / PYTD_Total_Sales * 100 
FROM 
  a, 
  b;

-- Calculating the year-over-year growth in total sales by comparing the total sales of 2022 with those of 2021, expressed as a percentage to assess how much the sales have increased or decreased. --

SELECT 
  SUM(profit_per_order) AS YTD_Profit 
FROM 
  ecommerce_data 
WHERE 
  YEAR(order_date) = '2022';

-- Calculating the total profit for the year 2022, providing insight into the financial gain made from sales after accounting for costs up to the current date within that year. --

SELECT 
  DATENAME(MONTH, order_date) AS Month_Name, 
  MONTH(order_date) AS Month_Number, 
  CAST(
    SUM(profit_per_order) AS DECIMAL (10, 2)
  ) AS YTD_Profit 
FROM 
  ecommerce_data 
WHERE 
  YEAR(order_date) = '2022' 
GROUP BY 
  DATENAME(MONTH, order_date), 
  MONTH(order_date) 
ORDER BY 
  MONTH(order_date);

-- Analyzing the profit on a month-by-month basis for 2022, allowing us to track profitability trends and determine which months were the most or least profitable. --

WITH a AS (
  SELECT 
    SUM(profit_per_order) AS YTD_Profit 
  FROM 
    ecommerce_data 
  WHERE 
    YEAR(order_date) = '2022'
), 
b AS (
  SELECT 
    SUM(profit_per_order) AS PYTD_Profit 
  FROM 
    ecommerce_data 
  WHERE 
    YEAR(order_date) = '2021'
) 
SELECT 
  (YTD_Profit - PYTD_Profit) / PYTD_Profit * 100 AS YoY_growth 
FROM 
  a, 
  b;

-- Calculating the year-over-year growth in profit by comparing the total profit of 2022 with that of 2021, expressed as a percentage to assess profitability improvement or decline. --

SELECT 
  SUM(order_quantity) AS YTD_Quantity 
FROM 
  ecommerce_data 
WHERE 
  YEAR(order_date) = '2022';

-- Finding the total quantity of products sold in 2022, providing insight into the volume of sales up to the current date within that year. --

SELECT 
  DATENAME(MONTH, order_date) AS Month_Name, 
  MONTH(order_date) AS Month_Number, 
  SUM(order_quantity) AS Total_Quantity 
FROM 
  ecommerce_data 
WHERE 
  YEAR(order_date) = '2022' 
GROUP BY 
  DATENAME(MONTH, order_date), 
  MONTH(order_date) 
ORDER BY 
  MONTH(order_date);

-- Analyzing the total quantity of products sold on a month-by-month basis for 2022, helping to understand sales volume trends and identify periods of higher or lower demand. --

WITH a AS (
  SELECT 
    CAST(
      SUM(order_quantity) AS DECIMAL (10, 2)
    ) AS YTD_Quantity 
  FROM 
    ecommerce_data 
  WHERE 
    YEAR(order_date) = '2022'
), 
b AS (
  SELECT 
    CAST(
      SUM(order_quantity) AS DECIMAL (10, 2)
    ) AS PYTD_Quantity 
  FROM 
    ecommerce_data 
  WHERE 
    YEAR(order_date) = '2021'
) 
SELECT 
  (
    (YTD_Quantity - PYTD_Quantity) / PYTD_Quantity * 100
  ) AS YoY_Quantity 
FROM 
  a, 
  b;

-- Calculating the year-over-year growth in the total quantity sold by comparing 2022 with 2021, expressed as a percentage to evaluate changes in sales volume. --

SELECT 
  (
    SUM(profit_per_order) / SUM(sales_per_order) * 100
  ) AS YTD_Profit_Margin 
FROM 
  ecommerce_data 
WHERE 
  YEAR(order_date) = '2022';

-- Calculating the profit margin for 2022, expressed as a percentage of sales, providing insight into how much profit is retained from sales after accounting for costs. --

SELECT 
  DATENAME(MONTH, order_date), 
  MONTH(order_date), 
  (
    SUM(profit_per_order) / SUM(sales_per_order) * 100
  ) AS YTD_Profit_Margin 
FROM 
  ecommerce_data 
WHERE 
  YEAR(order_date) = '2022' 
GROUP BY 
  DATENAME(MONTH, order_date), 
  MONTH(order_date) 
ORDER BY 
  MONTH(order_date);

-- Analyzing the profit margin on a month-by-month basis for 2022, allowing us to assess how profit margins fluctuate over the course of the year. --

WITH a AS (
  SELECT 
    CAST(
      (
        SUM(profit_per_order) / SUM(sales_per_order) * 100
      ) AS DECIMAL (10, 2)
    ) AS YTD_Profit_Margin 
  FROM 
    ecommerce_data 
  WHERE 
    YEAR(order_date) = '2022'
), 
b AS (
  SELECT 
    CAST(
      (
        SUM(profit_per_order) / SUM(sales_per_order) * 100
      ) AS DECIMAL (10, 2)
    ) AS PYTD_Profit_Margin 
  FROM 
    ecommerce_data 
  WHERE 
    YEAR(order_date) = '2021'
) 
SELECT 
  (
    (
      YTD_Profit_Margin - PYTD_Profit_Margin
    ) / PYTD_Profit_Margin * 100
  ) AS YoY_Profit_Margin 
FROM 
  a, 
  b;

-- Calculating the year-over-year change in profit margin by comparing 2022 with 2021, expressed as a percentage to assess how the efficiency of profit generation has changed. --

WITH a AS (
  SELECT 
    category_name, 
    SUM(sales_per_order) AS YTD_Total_Sales 
  FROM 
    ecommerce_data 
  WHERE 
    YEAR(order_date) = '2022' 
  GROUP BY 
    category_name
), 
b AS (
  SELECT 
    category_name, 
    SUM(sales_per_order) AS PYTD_Total_Sales 
  FROM 
    ecommerce_data 
  WHERE 
    YEAR(order_date) = '2021' 
  GROUP BY 
    category_name
) 
SELECT 
  a.category_name, 
  CAST(
    a.YTD_Total_Sales AS DECIMAL (10, 2)
  ) AS YTD_Total_Sales, 
  CAST(
    b.PYTD_Total_Sales AS DECIMAL (10, 2)
  ) AS PYTD_Total_Sales, 
  CAST(
    (
      YTD_Total_Sales - PYTD_Total_Sales
    ) / PYTD_Total_Sales * 100 AS DECIMAL (10, 2)
  ) AS YoY_growth 
FROM 
  a 
  JOIN b ON a.category_name = b.category_name 
GROUP BY 
  a.category_name, 
  a.YTD_Total_Sales, 
  b.PYTD_Total_Sales
ORDER BY 
  a.YTD_Total_Sales ASC;

-- Comparing the year-to-date and previous year-to-date sales by product category to calculate the year-over-year growth within each category, helping to identify which product categories are growing or declining. --

SELECT 
  TOP 5 product_name, 
  CAST(
    SUM(sales_per_order) AS DECIMAL (10, 2)
  ) AS Top_5_YTD_Total_Sales 
FROM 
  ecommerce_data 
WHERE 
  YEAR(order_date) = '2022' 
GROUP BY 
  product_name 
ORDER BY 
  SUM(sales_per_order) DESC;

-- Identifying the top 5 products by year-to-date total sales, showcasing the best-performing products in terms of revenue generation for 2022. --

SELECT 
  TOP 5 product_name, 
  CAST(
    SUM(sales_per_order) AS DECIMAL (10, 2)
  ) AS Bottom_5_YTD_Total_Sales 
FROM 
  ecommerce_data 
WHERE 
  YEAR(order_date) = '2022' 
GROUP BY 
  product_name 
ORDER BY 
  SUM(sales_per_order) ASC;

-- Identifying the bottom 5 products by year-to-date total sales, highlighting the least-performing products in terms of revenue generation for 2022. --

SELECT 
  customer_region, 
  CAST(
    SUM(sales_per_order) AS DECIMAL (10, 2)
  ) AS YTD_Total_Sales, 
  CAST(
    (
      CAST(
        SUM(sales_per_order) AS DECIMAL (10, 2)
      ) / (
        SELECT 
          SUM(sales_per_order) 
        FROM 
          ecommerce_data 
        WHERE 
          YEAR(order_date) = '2022'
      ) * 100
    ) AS DECIMAL (10, 2)
  ) AS Total_Sales 
FROM 
  ecommerce_data 
WHERE 
  YEAR(order_date) = '2022' 
GROUP BY 
  customer_region;

-- Analyzing year-to-date sales by customer region, providing insight into regional performance and identifying the most and least profitable regions. --

SELECT 
  shipping_type, 
  CAST(
    SUM(sales_per_order) AS DECIMAL (10, 2)
  ) AS YTD_Total_Sales, 
  CAST(
    (
      CAST(
        SUM(sales_per_order) AS DECIMAL (10, 2)
      ) / (
        SELECT 
          SUM(sales_per_order) 
        FROM 
          ecommerce_data 
        WHERE 
          YEAR(order_date) = '2022'
      ) * 100
    ) AS DECIMAL (10, 2)
  ) AS Total_Sales 
FROM 
  ecommerce_data 
WHERE 
  YEAR(order_date) = '2022' 
GROUP BY 
  shipping_type;

-- Analyzing year-to-date sales by shipping type, providing insight into how different shipping methods contribute to overall sales and their relative importance. --

SELECT 
  a.customer_region, 
  b.name AS State, 
  CAST(
    SUM(a.sales_per_order) AS DECIMAL (10, 2)
  ) AS Total_Sales 
FROM 
  ecommerce_data a 
  LEFT JOIN us_state_long_lat_codes b ON a.customer_state = b.name 
GROUP BY 
  a.customer_region, 
  b.name 
ORDER BY 
  SUM(a.sales_per_order) DESC;

-- Analyzing year-to-date sales by customer region and state, providing detailed geographical insights and identifying the highest and lowest performing states within each region. --

