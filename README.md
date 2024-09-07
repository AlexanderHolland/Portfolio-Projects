# Pizza Sales Dashboard

### Dashboard Link: 
[View Dashboard](https://app.powerbi.com/view?r=eyJrIjoiOGJmYTdiYzctYjUzYi00ODg4LWI5NTktZWNkM2E5OWU5ZjE1IiwidCI6ImQyZWNmMmFkLTQ3ZTQtNDgxMi1hODAzLWVmMGZiNGNkODBmMiJ9)

### SQL Link: 
[View SQL Script](https://github.com/AlexanderHolland/Portfolio-Projects/blob/main/Pizza%20Sales.sql)

Our company is focused on pizza sales, and to effectively track and analyze our performance, we need a comprehensive Pizza Sales Dashboard in Power BI.

**Objective**: 
Design and develop a dynamic, interactive Pizza Sales Dashboard that visualizes critical KPIs related to pizza sales. The dashboard will help us understand our sales performance over time and make data-driven decisions.

**Problem Statement**: 
The dashboard should provide real-time insights into key performance indicators for our pizza sales data. This will enable informed decisions, monitor progress, and identify trends and growth opportunities.

### Key Sales Metrics:
- **Total Revenue**: Sum of all pizza order prices.
- **Average Order Value**: Average spend per order.
- **Total Pizzas Sold**: Total quantity of pizzas sold.
- **Total Orders**: Total number of orders placed.
- **Average Pizzas Per Order**: Average number of pizzas per order.

### Chart Requirements:
- **Weekly Trend for Total Orders**:  
  Bar chart illustrating weekly total order trends. Highlighted the day with the most sales using conditional formatting.
  
- **Monthly Trend for Total Orders**:  
  Line chart showing total orders by month with markers for clear identification of trends.
  
- **Percentage of Sales by Pizza Category**:  
  Pie chart displaying sales distribution across pizza categories.
  
- **Percentage of Sales by Pizza Size**:  
  Pie chart representing sales distribution by pizza size.
  
- **Total Pizzas Sold by Pizza Category**:  
  Funnel chart showing pizzas sold per category.
  
- **Top 5 Best Sellers by Revenue, Quantity, and Orders**:  
  Bar chart highlighting the top 5 best-selling pizzas. Used conditional formatting for emphasis.
  
- **Bottom 5 Worst Sellers by Revenue, Quantity, and Orders**:  
  Bar chart showcasing the bottom 5 worst-selling pizzas with conditional formatting.

### Steps Followed:

1. **Data Quality Check / Data Cleaning**:  
   - **Load Data**: Imported the dataset from SQL Server into Power BI Desktop.  
     ![SQL Server](https://github.com/user-attachments/assets/61c2b3a8-12e1-4a6f-a98f-b64d1481ee8d)
     
   - **Data Quality Check**: Used Power Query Editor to remove null values and filter rows.  
     ![Data Preview](https://github.com/user-attachments/assets/bb898399-fecc-4351-8f5d-1400550210bf)
     
   - **Replace Values**: Standardized data in the 'pizza_size' column using Power Query.  
     ![Replace Value](https://github.com/user-attachments/assets/2c805197-80ee-47c8-aa49-7382b0302743)

2. **Enhanced Data Visualization with DAX**:  
   - **Create Day of the Week Column**:  
     Used Power Query’s Add Column to extract the day name from the order date.  
     ![Creating Date Name](https://github.com/user-attachments/assets/37ed8724-9213-409d-b6e6-7d929abb4b53)

3. **DAX Calculations**:
   - Created a column for month ordering:  
     ```DAX
     Month Order = MONTH(pizza_sales[order_date])
     ```
     
   - Shortened day and month names:  
     ```DAX
     Order Day = UPPER(LEFT(pizza_sales[Day Name], 3))
     Order Month = UPPER(LEFT(pizza_sales[Month Name], 3))
     ```
     
   - Created custom day names using DAX:  
     ```DAX
     Week Day = FORMAT(pizza_sales[order_date], "DDDD")
     ```
     
   - Ordered weekdays numerically:  
     ```DAX
     Week Order = WEEKDAY(pizza_sales[order_date])
     ```

4. **KPIs and Measures**:

   - **Total Revenue**:  
     ```DAX
     Total Revenue = SUM(pizza_sales[total_price])
     ```  
     ![Total Revenue](https://github.com/user-attachments/assets/e0f5e1be-9892-476b-9af4-b47e74449d82)
     
   - **Average Order Value**:  
     ```DAX
     Average Order Value = [Total Revenue] / [Total Orders]
     ```  
     ![Average Order Value](https://github.com/user-attachments/assets/f7a1d37e-6ec1-44e1-80c1-f1e184f845c8)
     
   - **Total Pizzas Sold**:  
     ```DAX
     Total Pizzas Sold = SUM(pizza_sales[quantity])
     ```  
     ![Total Pizzas Sold](https://github.com/user-attachments/assets/d7d131a8-a207-497c-ae8f-15121782ec1b)
     
   - **Total Orders**:  
     ```DAX
     Total Orders = DISTINCTCOUNT(pizza_sales[order_id])
     ```  
     ![Total Orders](https://github.com/user-attachments/assets/7d3cced7-e238-47d4-87f4-1f556e0d73ed)
     
   - **Average Pizzas Per Order**:  
     ```DAX
     Average Pizzas Per Order = [Total Pizzas Sold] / [Total Orders]
     ```  
     ![Average Pizzas Per Order](https://github.com/user-attachments/assets/759e9e12-aeb2-4254-9949-9788fadccca0)

5. **Chart Requirements:**

   - **Weekly Trend for Total Orders**:  
     We created a bar chart that showed the weekly total order trend. Conditional formatting was used to highlight the day with the highest sales.  
     ![Daily Trend](https://github.com/user-attachments/assets/1fcc4fa6-40b8-4fc4-8106-f26e8f7e429d)

   - **Monthly Trend for Total Orders**:  
     A line chart was created to illustrate total orders by month. Background and data markers were added for clarity.  
     ![Area Chart](https://github.com/user-attachments/assets/61f848fc-acd6-40cf-8290-29f8a438572d)

   - **Percentage of Sales by Pizza Category**:  
     We generated a pie chart to display the distribution of sales across pizza categories.  
     ![Sales by Pizza Category](https://github.com/user-attachments/assets/257f28df-bb17-4fed-a694-1f77dae5fa5b)

   - **Percentage of Sales by Pizza Size**:  
     A pie chart was created to represent the percentage of sales by pizza size.  
     ![Sales by Pizza Size](https://github.com/user-attachments/assets/52d0ddb0-15b7-4fe3-8ce3-a150541fbc7f)

   - **Total Pizzas Sold by Pizza Category**:  
     A funnel chart was created to present the total number of pizzas sold for each pizza category.  
     ![Total Pizzas Sold by Category](https://github.com/user-attachments/assets/a8cf5675-36f7-4b44-82e1-f1f57feff60f)

   - **Top 5/Bottom 5 Best Sellers by Revenue, Total Quantity, and Total Orders**:  
     A bar chart was created to highlight the top and bottom 5 selling pizzas based on Revenue, Total Quantity, and Total Orders. Conditional formatting was used to effectively visualize the data.  
     ![Top Bottom 5](https://github.com/user-attachments/assets/562db75c-c39d-448f-b742-1d0921f66ef7)

6. **Creating Sliders:**

   - **Category Slider**:  
     A category slider was created for the dashboard to allow dynamic, real-time changes for analysis based on category.  
     ![Category Slicer](https://github.com/user-attachments/assets/5339c4aa-806f-4178-b9e3-2618d8be6897)

   - **Date Slider**:  
     A date slider was created to enable data filtering in real-time, allowing for alternative analysis.  
     ![Date Slicer](https://github.com/user-attachments/assets/fe296365-8316-427e-9b79-7f377731e092)

7. **Creating Navigation Buttons**


   - Implemented "Home" and "Best/Worst Seller" buttons to enable navigation between different pages. 
      ![Navigational Buttons](https://github.com/user-attachments/assets/bd5e7d06-dd31-45e6-a3b9-043ffb1abb58)
### Snapshot of Dashboard (Power BI Desktop):
#### Overview:
![Dash 1](https://github.com/user-attachments/assets/10e6e641-d83a-4f87-8691-ecb8147148b8)

#### Details:
![Dash 2](https://github.com/user-attachments/assets/267ab106-8f5e-4b62-8d3f-c3edb1d709fd)

### Insights:
- **Busiest Day**: Friday had the highest number of pizza orders, with 3,500 total orders.
- **Busiest Month**: July saw the most orders, with 1,935 orders, showing a gradual increase from February to July.
- **Pizza Category Insights**: Classic Pizzas made up 26.91% of total sales, followed by Supreme (25.46%) and Chicken (23.96%).
- **Pizza Size Breakdown**: Large pizzas dominated sales, followed by Medium (30.49%).

### Top Performers:
- **Top Pizza by Revenue**: Thai Chicken Pizza - $43,000
- **Top Pizza by Quantity**: Classic Deluxe - 2,500 pizzas
- **Top Pizza by Total Orders**: Classic Deluxe - 2,300 orders

### Bottom Performers:
- **Bottom Pizza by Revenue**: Brie Carre - $12,000
- **Bottom Pizza by Quantity**: Brie Carre - 490 pizzas
- **Bottom Pizza by Total Orders**: Brie Carre - 480 orders


