/* 
Car Sales Dashboard

Skills Used: SELECT, SUM, AVG, COUNT, WHERE, YEAR, MONTH, DATENAME, DATEPART, GROUP BY, ORDER BY, WITH, JOIN, OVER, CAST.

*/

SELECT 
  * 
FROM 
  [Car Sales];

-- Selecting the data we are going to be using --

SELECT 
  SUM(Price) AS YTD_Total_Sales 
FROM 
  [Car Sales] 
WHERE 
  YEAR(Date) = '2023';

-- Finding year to date total sales --

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

-- Finding month to date total sales --

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

  -- Looking at month over month total sales across 2022 - 2023 --

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

-- Finding difference between year to date sales and previous year to date sales --
-- Ran into problem (arithmetic overflow), increased the number of integers allowed before the decimal point to 18 from 10 --

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
  
-- Finding year over year growth in total sales --

SELECT 
  AVG(Price) AS YTD_AVG_Price 
FROM 
  [Car Sales] 
WHERE 
  YEAR(Date) = '2023';

-- Finding year to date average price --

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

-- Finding month to date average price --

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

  -- Looking at month over month average price sales across 2022 - 2023 --

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

-- Finding the difference between year to date average price and previous year to date average price --

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

-- Finding year over year growth for average price

SELECT 
  COUNT(Car_id) AS YTD_Cars_Sold 
FROM 
  [Car Sales] 
WHERE 
  YEAR(Date) = '2023';

-- Finding year to date cars sold --

SELECT 
  COUNT(Car_id) AS MTD_Cars_Sold 
FROM 
  [Car Sales] 
WHERE 
  YEAR(Date) = '2023' 
  AND MONTH(Date) = '12';

-- Finding month to date cars sold --

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

-- Looking at month over month cars sold across 2022 - 2023 --

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

-- Finding difference between year to date cars sold and previous year to date cars sold --

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

-- Finding year on year growth in cars sold --

SELECT 
  DATEPART(WEEK, Date), 
  SUM(Price) 
FROM 
  [Car Sales] 
WHERE 
  YEAR(Date) = '2023' 
GROUP BY 
  DATEPART(WEEK, Date) 
ORDER BY 
  DATEPART(WEEK, Date);

-- Finding year to date sales by week --

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
  
-- Finding year to date total sales by body style --

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

-- Finding year to date total sales by color --

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
  d.PCT_Total_Sales 
FROM 
  a 
  JOIN b ON a.Company = b.Company 
  JOIN c ON a.Company = c.Company 
  JOIN d ON a.Company = d.Company 
ORDER BY 
  a.Company;


-- Finding catergory wise sales trend --

SELECT 
    Company, 
    AVG(Price) AS YTD_AVG_Price, 
    COUNT(Car_id) AS Cars_Sold, 
    SUM(Price) AS YTD_Total_Sales, 
    CAST(SUM(Price) AS DECIMAL(10,2)) * 100.0 / SUM(SUM(Price)) OVER () AS PCT_Total_Sales
FROM 
    [Car Sales]
WHERE 
    YEAR(Date) = 2023
GROUP BY 
    Company
ORDER BY 
    Company;

-- Used chatgpt to find a more efficent way to recieve the same result--
-- The PCT_Total_Sales calculation uses a window function (SUM(SUM(Price)) OVER ()) to calculate the total sales across all companies within the year 2023. This avoids the need for a separate CTE or subquery

SELECT 
  Company, 
  AVG(Price) AS YTD_AVG_Price, 
  COUNT(Car_id) AS Cars_Sold, 
  SUM(Price) AS YTD_Total_Sales, 
  CAST(
    SUM(Price) AS DECIMAL(10, 2)
  ) * 100.0 / SUM(
    SUM(Price)
  ) OVER () AS PCT_Total_Sales 
FROM 
  [Car Sales] 
WHERE 
  YEAR(Date) = 2023 
GROUP BY 
  Company 
ORDER BY 
  Company;








