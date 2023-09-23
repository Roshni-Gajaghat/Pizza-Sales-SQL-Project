-- Preview of Data
Select * from pizza_sales

--Total revenue
Select Sum(total_price) As Total_Revenue from pizza_sales

--Average order value
Select SUM(total_price) / COUNT(DISTINCT order_id) AS Average_Order_Value from pizza_sales

--Total Pizza Sold
Select SUM(quantity) AS Total_Pizza_Sold from pizza_sales

--Total Orders
Select COUNT(DISTINCT order_id) AS Total_Order_Placed from pizza_sales

--Average_Pizza_Sold_Per_Order
Select CAST (Cast (SUM(quantity) AS Decimal(10,2)) / Cast (COUNT(DISTINCT order_id) AS Decimal(10,2)) AS Decimal(10,2)) 
As Avg_Pizza_Sold_Per_Order 
from pizza_sales

--Hourly Trend for Total Pizzas Sold
Select DATEPART(HOUR, order_time) as Order_hour, SUM(quantity) as Total_Pizzas_Sold
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time)

--Weekly Trends for Total Orders
Select DATEPART(ISO_WEEK, order_date) as Week_Number, YEAR(order_date) as Order_Year, 
COUNT(DISTINCT order_id) as Total_Orders
FROM pizza_sales
GROUP BY DATEPART(ISO_WEEK, order_date), YEAR(order_date)
ORDER BY DATEPART(ISO_WEEK, order_date), YEAR(order_date)

--Percentage of Sales by Pizza Category
SELECT pizza_category, sum(total_price) * 100/(SELECT sum(total_price) from pizza_sales) AS Percentage_of_Total_Sales
from pizza_sales AS Total_Sales
GROUP BY pizza_category
ORDER BY pizza_category

--Percentage of Sales by Pizza Size
SELECT pizza_size,CAST(sum(total_price) * 100/ 
(SELECT sum(total_price) from pizza_sales) AS decimal(10,2)) AS Percentage_of_Total_Sales_by_Size
from pizza_sales 
GROUP BY pizza_size
ORDER BY Percentage_of_Total_Sales_by_Size DESC

--TOP 5 Bestsellers by Revenue
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue FROM pizza_sales 
GROUP BY pizza_name
ORDER BY Total_Revenue DESC

--Bottom 5 Bestsellers by Revenue
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue FROM pizza_sales 
GROUP BY pizza_name
ORDER BY Total_Revenue ASC

--TOP 5 Bestsellers by Quantity
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity FROM pizza_sales 
GROUP BY pizza_name
ORDER BY Total_Quantity DESC

--Bottom 5 Bestsellers by Quantity
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Quantity FROM pizza_sales 
GROUP BY pizza_name
ORDER BY Total_Quantity ASC