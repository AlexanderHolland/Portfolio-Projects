/* 
Car Sales Dashboard

Skills Used: SELECT, SUM, AVG, COUNT, WHERE, YEAR, MONTH, DATENAME, DATEPART, GROUP BY, ORDER BY, WITH, JOIN, OVER, CAST.
*/

SELECT 
  * 
FROM 
  [Car Sales];

-- Selecting all columns and rows from the Car Sales table to review the dataset before analysis --

SELECT 
  SUM(Price) AS YTD_Total_Sales 
FROM 
  [Car Sales] 
WHERE 
  YEAR(Date) = '2023';

-- Calculating the total sales revenue for the year-to-date (YTD) for 2023 by summing up all car prices for that year --

SELECT 
  SUM(Price) AS MTD_Total_Sales 
FROM 
  [Car Sales] 
WHERE 
  YEAR(Date) = '2023' 
  AND MONTH(Date) = '12' 
GROUP BY 
  YEAR(Date), 
  MONTH(Date) 
ORDER BY 
  YEAR(Date), 
  MONTH(Date);

-- Calculating the total sales revenue for the month-to-date (MTD) for December 2023, to analyze sales performance for the current month --

SELECT 
  YEAR(Date) as Year, 
  MONTH(Date) as Month_Number, 
  DATENAME(MONTH, Date) AS Month, 
  SUM(Price) AS Total_Sales
FROM 
  [Car Sales] 
GROUP BY 
  YEAR(Date), 
  MONTH(Date), 
  DATENAME(MONTH, Date) 
ORDER BY 
  YEAR(Date), 
  MONTH(Date);

-- Analyzing total sales revenue on a month-over-month basis across the years 2022 and 2023 to identify trends and seasonality in sales --

WITH YTD_CTE AS (
  SELECT 
    CAST(
      SUM(Price) AS DECIMAL (18, 2)
    ) AS YTD_Total_Sales 
  FROM 
    [Car Sales] 
  WHERE 
    YEAR(Date) = '2023'
), 
PYTD_CTE AS (
  SELECT 
    CAST(
      SUM(Price) AS DECIMAL (18, 2)
    ) AS PYTD_Total_Sales 
  FROM 
    [Car Sales] 
  WHERE 
    YEAR(Date) = '2022'
) 
SELECT 
  (
    YTD_Total_Sales - PYTD_Total_Sales
  ) AS Sales_Difference 
FROM 
  YTD_CTE, 
  PYTD_CTE;

-- Comparing the year-to-date (YTD) total sales between 2023 and 2022 to determine the absolute difference in sales revenue between the two years --

WITH YTD_CTE AS (
  SELECT 
    CAST(
      SUM(Price) AS DECIMAL (18, 2)
    ) AS YTD_Total_Sales 
  FROM 
    [Car Sales] 
  WHERE 
    YEAR(Date) = '2023'
), 
PYTD_CTE AS (
  SELECT 
    CAST(
      SUM(Price) AS DECIMAL (18, 2)
    ) AS PYTD_Total_Sales 
  FROM 
    [Car Sales] 
  WHERE 
    YEAR(Date) = '2022'
) 
SELECT 
  (
    (
      YTD_Total_Sales - PYTD_Total_Sales
    ) / PYTD_Total_Sales * 100
  ) AS YoY_Growth_Total_Sales
FROM 
  YTD_CTE, 
  PYTD_CTE;

-- Calculating the year-over-year (YoY) growth in total sales by comparing 2023's YTD sales against 2022's YTD sales and expressing the difference as a percentage --

SELECT 
  AVG(Price) AS YTD_AVG_Price 
FROM 
  [Car Sales] 
WHERE 
  YEAR(Date) = '2023';

-- Calculating the year-to-date (YTD) average price of cars sold in 2023 to assess pricing trends over the year --

SELECT 
  AVG(Price) AS MTD_AVG_Price 
FROM 
  [Car Sales] 
WHERE 
  YEAR(Date) = '2023' 
  AND MONTH(Date) = '12' 
GROUP BY 
  YEAR(Date), 
  MONTH(Date) 
ORDER BY 
  YEAR(Date), 
  MONTH(Date);

-- Calculating the month-to-date (MTD) average price of cars sold in December 2023 to analyze the current month's pricing trend --

SELECT 
  YEAR(Date) as Year, 
  MONTH(Date) as Month_Number, 
  DATENAME(MONTH, Date) AS Month, 
  AVG(Price) AS AVG_Price 
FROM 
  [Car Sales] 
GROUP BY 
  YEAR(Date), 
  MONTH(Date), 
  DATENAME(MONTH, Date) 
ORDER BY 
  YEAR(Date), 
  MONTH(Date);

-- Analyzing the average price of cars sold on a month-over-month basis across 2022-2023 to identify pricing trends and fluctuations --

WITH YTD_AVG_CTE AS (
  SELECT 
    AVG(Price) AS YTD_AVG_Price 
  FROM 
    [Car Sales] 
  WHERE 
    YEAR(Date) = '2023'
), 
PYTD_AVG_CTE AS (
  SELECT 
    AVG(Price) AS PYTD_AVG_Price 
  FROM 
    [Car Sales] 
  WHERE 
    YEAR(Date) = '2022'
) 
SELECT 
  (YTD_AVG_Price - PYTD_AVG_Price) AS AVG_Sales_Difference 
FROM 
  YTD_AVG_CTE, 
  PYTD_AVG_CTE;

-- Comparing the year-to-date (YTD) average price between 2023 and 2022 to determine the absolute difference in the average sales price of cars between the two years --

WITH YTD_AVG_CTE AS (
  SELECT 
    CAST(
      AVG(Price) AS DECIMAL (10, 2)
    ) AS YTD_AVG_Price 
  FROM 
    [Car Sales] 
  WHERE 
    YEAR(Date) = '2023'
), 
PYTD_AVG_CTE AS (
  SELECT 
    CAST(
      AVG(Price) AS DECIMAL (10, 2)
    ) AS PYTD_AVG_Price 
  FROM 
    [Car Sales] 
  WHERE 
    YEAR(Date) = '2022'
) 
SELECT 
  (
    (YTD_AVG_Price - PYTD_AVG_Price) / PYTD_AVG_Price * 100
  ) AS YoY_Growth_AVG_Price 
FROM 
  YTD_AVG_CTE, 
  PYTD_AVG_CTE;

-- Calculating the year-over-year (YoY) growth in the average sales price of cars by comparing 2023's YTD average price against 2022's and expressing the difference as a percentage --

SELECT 
  COUNT(Car_id) AS YTD_Cars_Sold 
FROM 
  [Car Sales] 
WHERE 
  YEAR(Date) = '2023';

-- Counting the total number of cars sold year-to-date (YTD) in 2023 to assess sales volume for the year --

SELECT 
  COUNT(Car_id) AS MTD_Cars_Sold 
FROM 
  [Car Sales] 
WHERE 
  YEAR(Date) = '2023' 
  AND MONTH(Date) = '12';

-- Counting the total number of cars sold month-to-date (MTD) in December 2023 to assess sales volume for the current month --

SELECT 
  YEAR(Date) as Year, 
  MONTH(Date) as Month_Number, 
  DATENAME(MONTH, Date) AS Month, 
  COUNT(Car_id) AS Cars_Sold 
FROM 
  [Car Sales] 
GROUP BY 
  YEAR(Date), 
  MONTH(Date), 
  DATENAME(MONTH, Date) 
ORDER BY 
  YEAR(Date), 
  MONTH(Date);

-- Analyzing the number of cars sold on a month-over-month basis across 2022-2023 to identify trends in sales volume --

WITH YTD_Cars_Sold_CTE AS (
  SELECT 
    COUNT(Car_id) AS YTD_Cars_Sold 
  FROM 
    [Car Sales] 
  WHERE 
    YEAR(Date) = '2023'
), 
PYTD_Cars_Sold_CTE AS (
  SELECT 
    COUNT(Car_id) AS PYTD_Cars_Sold 
  FROM 
    [Car Sales] 
  WHERE 
    YEAR(Date) = '2022'
) 
SELECT 
  (YTD_Cars_Sold - PYTD_Cars_Sold) AS Cars_Sold_Difference 
FROM 
  YTD_Cars_Sold_CTE, 
  PYTD_Cars_Sold_CTE;

-- Comparing the year-to-date (YTD) number of cars sold between 2023 and 2022 to determine the absolute difference in sales volume between the two years --

WITH YTD_Cars_Sold_CTE AS (
  SELECT 
    CAST(
      COUNT(Car_id) AS DECIMAL (10, 2)
    ) AS YTD_Cars_Sold 
  FROM 
    [Car Sales] 
  WHERE 
    YEAR(Date) = '2023'
), 
PYTD_Cars_Sold_CTE AS (
  SELECT 
    CAST(
      COUNT(Car_id) AS DECIMAL (10, 2)
    ) AS PYTD_Cars_Sold 
  FROM 
    [Car Sales] 
  WHERE 
    YEAR(Date) = '2022'
) 
SELECT 
  (
    (YTD_Cars_Sold - PYTD_Cars_Sold) / PYTD_Cars_Sold * 100
  ) AS YoY_Growth_Cars_Sold 
FROM 
  YTD_Cars_Sold_CTE, 
  PYTD_Cars_Sold_CTE;

-- Calculating the year-over-year (YoY) growth in the number of cars sold by comparing 2023's YTD sales volume against 2022's and expressing the difference as a percentage --

SELECT 
  DATEPART(WEEK, Date) AS Week_Number, 
  SUM(Price) AS Total_Sales
FROM 
  [Car Sales] 
WHERE 
  YEAR(Date) = '2023' 
GROUP BY 
  DATEPART(WEEK, Date) 
ORDER BY 
  DATEPART(WEEK, Date);

-- Analyzing the total sales revenue on a week-by-week basis for the year 2023 to identify weekly trends in sales performance --

SELECT 
  Body_Style, 
  SUM(Price) AS Total_Sales 
FROM 
  [Car Sales] 
WHERE 
  YEAR(Date) = 2023 
GROUP BY 
  Body_Style 
ORDER BY 
  SUM(Price) DESC;

-- Analyzing total sales revenue by car body style for the year 2023 to determine which body styles contributed the most to overall sales --

SELECT 
  Color, 
  SUM(Price) AS Total_Sales 
FROM 
  [Car Sales] 
WHERE 
  YEAR(Date) = 2023 
GROUP BY 
  Color
ORDER BY 
  SUM(Price) DESC;

-- Analyzing total sales revenue by car color for the year 2023 to determine which colors were most popular among buyers --

WITH a AS (
  SELECT 
    Company, 
    AVG(Price) AS YTD_AVG_Price 
  FROM 
    [Car Sales] 
  WHERE 
    YEAR(Date) = 2023 
  GROUP BY 
    Company
), 
b AS (
  SELECT 
    Company, 
    COUNT(Car_id) AS Cars_Sold 
  FROM 
    [Car Sales] 
  WHERE 
    YEAR(Date) = 2023 
  GROUP BY 
    Company
), 
c AS (
  SELECT 
    Company, 
    SUM(Price) AS YTD_Total_Sales 
  FROM 
    [Car Sales] 
  WHERE 
    YEAR(Date) = 2023 
  GROUP BY 
    Company
), 
d AS (
  SELECT 
    Company, 
    CAST(
      SUM(Price) AS DECIMAL(10, 2)
    ) * 100.0 / (
      SELECT 
        SUM(Price) 
      FROM 
        [Car Sales] 
      WHERE 
        YEAR(Date) = 2023
    ) AS PCT_Total_Sales 
  FROM 
    [Car Sales] 
  WHERE 
    YEAR(Date) = 2023 
  GROUP BY 
    Company
) 
SELECT 
  a.Company, 
  a.YTD_AVG_Price, 
  b.Cars_Sold, 
  c.YTD_Total_Sales, 
  CAST(d.PCT_Total_Sales AS DECIMAL (10,2)) AS PCT_Total_Sales
FROM 
  a 
  JOIN b ON a.Company = b.Company 
  JOIN c ON a.Company = c.Company 
  JOIN d ON a.Company = d.Company 
ORDER BY 
  a.Company;

-- Analyzing category-wise (company-wise) sales trends by combining average price, total number of cars sold, total sales revenue, and percentage of total sales for each company using Common Table Expressions (CTEs) --

SELECT 
    Company, 
    AVG(Price) AS YTD_AVG_Price, 
    COUNT(Car_id) AS Cars_Sold, 
    SUM(Price) AS YTD_Total_Sales, 
    CAST(CAST(SUM(Price) AS DECIMAL(10,2)) * 100.0 / SUM(SUM(Price)) OVER () AS DECIMAL(10,2)) AS PCT_Total_Sales
FROM 
    [Car Sales]
WHERE 
    YEAR(Date) = 2023
GROUP BY 
    Company
ORDER BY 
    Company;

-- Rewriting the previous query using a more efficient approach by leveraging a window function to calculate the percentage of total sales across all companies within the year 2023, eliminating the need for separate CTEs or subqueries --
