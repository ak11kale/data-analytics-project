USE blinkitdb;
GO

SELECT * FROM blinkit_data ;

select count(*) from blinkit_data ; 

update blinkit_data
set Item_Fat_Content = 
case
when Item_Fat_Content In ('LF' , 'low fat') then 'LOW Fat'
when Item_Fat_Content = 'reg' then 'Regular'
ELSE Item_Fat_Content 
END 

SELECT DISTINCT (item_fat_content)FROM blinkit_data ;

select sum(sales) AS total_sales
from blinkit_data ;

select cast(sum(sales)/1000000 as decimal(10,2)) as total_sales_millions
from blinkit_data
where Outlet_Establishment_Year = 2022 

select avg(sales) as avg_sales from blinkit_data
where Outlet_Establishment_Year = 2022 

select cast(avg(sales) as decimal(10,2)) as avg_sales from blinkit_data
where Outlet_Establishment_Year = 2022 

select count(*) as no_of_items from blinkit_data
where Outlet_Establishment_Year = 2022 

select cast(avg(rating) as decimal(10,2)) as avg_rating  from blinkit_data 
where Outlet_Establishment_Year = 2022 

SELECT Outlet_Establishment_Year,
       CAST(SUM(sales)/1000 AS decimal(10,2)) AS total_sales,
       CAST(AVG(sales) AS decimal(10,2)) AS avg_sales,
       COUNT(*) AS no_of_items,
       CAST(AVG(rating) AS decimal(10,2)) AS avg_rating
FROM blinkit_data
GROUP BY Outlet_Establishment_Year
ORDER BY total_sales desc;

SELECT 
    Outlet_Size,
    CAST(SUM(sales)/1000 AS decimal(10,2)) AS total_sales,
    CAST((SUM(sales) * 100.0 / SUM(SUM(sales)) OVER ()) AS decimal(10,2)) AS sales_percentage
FROM blinkit_data
GROUP BY Outlet_Size
ORDER BY total_sales DESC;




SELECT Outlet_Location_Type,
       ISNULL([Low Fat], 0) AS Low_Fat,
       ISNULL([Regular], 0) AS Regular
FROM (
    SELECT Outlet_Location_Type, Item_Fat_Content,
           CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales
    FROM blinkit_data
    GROUP BY Outlet_Location_Type, Item_Fat_Content
) AS SourceTable
PIVOT (
    SUM(Total_Sales)
    FOR Item_Fat_Content IN ([Low Fat], [Regular])
) AS PivotTable
ORDER BY Outlet_Location_Type;

SELECT Outlet_Type,
       CAST(SUM(sales)/1000 AS decimal(10,2)) AS total_sales,
	    CAST((SUM(sales) * 100.0 / SUM(SUM(sales)) OVER ()) AS decimal(10,2)) AS sales_percentage,
       CAST(AVG(sales) AS decimal(10,2)) AS avg_sales,
       COUNT(*) AS no_of_items,
       CAST(AVG(rating) AS decimal(10,2)) AS avg_rating
FROM blinkit_data 
GROUP BY Outlet_Type
ORDER BY total_sales desc;

