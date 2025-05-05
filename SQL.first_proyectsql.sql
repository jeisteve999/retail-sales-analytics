use curso_sql

CREATE TABLE [retail_sales_dataset] (
    [Transaction ID] INT PRIMARY KEY NOT NULL,
    [Date] DATE NULL,
    [Customer ID] INT NULL,
    [Gender] VARCHAR(50) NULL,
    [Age] INT NULL,
    [Product Category] VARCHAR(50) NULL,
    [Quantity] INT NULL,
    [Price per Unit] MONEY NOT NULL,
    [TotalAmount_money] VARCHAR(50) NOT NULL
);


create table Retail_database(
TransactionID VARCHAR(10) primary key, 
Date date not null,
CustomerID varchar(10) not null,
Gender VARCHAR(10) not null,
Age VARCHAR(10) not null,
ProductCategory VARCHAR(30) not null,
Quantity int not null,
PriceperUnit money not null,
TotalAmount int not null,
);


CREATE TABLE [dbo].[retail_sales_dataset](
	[Transaction ID] [varchar](50) NULL,
	[Date] [date] NULL,
	[Customer ID] [varchar](50) NULL,
	[Gender] [varchar](50) NULL,
	[Age] [varchar](50) NULL,
	[Product_Category] [varchar](50) NULL,
	[Quantity] [int] NULL,
	[Price per Unit] [money] NULL,
	[Total Amount] [varchar](50) NULL,
	[TotalAmount_money] [money] NULL
) 
GO


select * from [retail_sales_dataset]

ALTER TABLE [retail_sales_dataset]
ALTER COLUMN [Customer ID] VARCHAR(50) NULL;


--Searching wrong values in Total_amount 
select [Total Amount] from [retail_sales_dataset] WHERE ISNUMERIC(replace(replace([Total Amount], '$', ''), ',', '')) = 0;

---changing from varchar to money

ALTER TABLE [retail_sales_dataset] ADD [TotalAmount_money] MONEY;

--Updating Column

UPDATE [retail_sales_dataset] SET [TotalAmount_money] =CAST(REPLACE(REPLACE([Total Amount], '$', ''), ',', '') AS MONEY);


---Drop column 
ALTER TABLE [Retail_database]
DROP COLUMN TotalAmount;


--- Total men and women 
SELECT 
  Gender, 
  SUM([TotalAmount_money]) AS Total_amount_by_gender
FROM [dbo].[retail_sales_dataset]
GROUP BY Gender



---Avegare total amount 
SELECT AVG ([TotalAmount_money]) AS average_sale FROM [retail_sales_dataset];

---Max Total Amount
SELECT max ([TotalAmount_money]) AS max_sale FROM [retail_sales_dataset];

--- Min total amount
SELECT min ([TotalAmount_money]) AS min_sale FROM [retail_sales_dataset];


--Age distribution
SELECT Age_group, count (*) as total_personas from (SELECT Age,
case
    WHEN Age between 18 and 20 then '10-20'
	WHEN Age between 21 and 30 then '20-30'
	WHEN Age between 31 and 40 then '30-40'
	WHEN Age between 41 and 50 then '40-50'
	WHEN Age between 51 and 60 then '50-60'
    ELSE '+60'
  end as Age_group
  from [retail_sales_dataset]
) As sub
GROUP BY Age_group
ORDER BY Age_group;

SELECT TransactionID, SUM([TotalAmount_money]) AS Total_amount_by_customer FROM [retail_sales_dataset] GROUP BY TransactionID

SELECT TransactionID, SUM([TotalAmount_money]) AS Total_amount_by_customer FROM [retail_sales_dataset] GROUP BY TransactionID

SELECT format([Date], 'YYYY-MM') AS MES, SUM([TotalAmount_money]) AS Total_Mensual from [retail_sales_dataset] group by format([Date],'YYYY-MM') order by mes;

---Total amount By month 
SELECT format([Date], 'yyyy-MM') AS MES, SUM([TotalAmount_money]) AS Total_Mensual from [retail_sales_dataset] group by format([Date],'yyyy-MM') order by mes;

---Total amount By month Other query 
SELECT 
    FORMAT(CAST([Date] AS DATE), 'yyyy-MM') AS MES,
    SUM([TotalAmount_money]) AS Total_Mensual
FROM [retail_sales_dataset]
GROUP BY FORMAT(CAST([Date] AS DATE), 'yyyy-MM')
ORDER BY MES;

ALTER TABLE [retail_sales_dataset]
ALTER COLUMN [Date] DATE;

SELECT FORMAT(CAST([Date] AS DATE), 'yyyy-MM') FROM retail_sales_dataset;


--Total Amount spent by age
SELECT 
    CASE
	    WHEN Age BETWEEN 18 AND 20 THEN '10-20'
		WHEN Age BETWEEN 21 AND 30 THEN '20-30'
		WHEN Age BETWEEN 31 AND 40 THEN '30-40'
		WHEN Age BETWEEN 41 AND 50 THEN '40-50'
		WHEN Age BETWEEN 51 AND 60 THEN '50-60'
		ELSE '+60'
END AS Age_group,
count(*) AS Total_personas,
sum(TotalAmount_money) AS Total_Amount
From retail_sales_dataset
Group by
    CASE
	    WHEN Age BETWEEN 18 AND 20 THEN '10-20'
        WHEN Age BETWEEN 21 AND 30 THEN '20-30'
        WHEN Age BETWEEN 31 AND 40 THEN '30-40'
        WHEN Age BETWEEN 41 AND 50 THEN '40-50'
        WHEN Age BETWEEN 51 AND 60 THEN '50-60'
        ELSE '+60'
END 
Order by Age_group;

---Changing column values 
ALTER TABLE [retail_sales_dataset]
ALTER COLUMN [Quantity] INT;

--Total quantity bought by age 
SELECT 
    CASE
	    WHEN Age BETWEEN 18 AND 20 THEN '10-20'
		WHEN Age BETWEEN 21 AND 30 THEN '20-30'
		WHEN Age BETWEEN 31 AND 40 THEN '30-40'
		WHEN Age BETWEEN 41 AND 50 THEN '40-50'
		WHEN Age BETWEEN 51 AND 60 THEN '50-60'
		ELSE '+60'
END AS Age_group,
count(*) AS Total_Personas,
sum([Quantity]) AS Total_quantity_bought_by_age From retail_sales_dataset
GROUP BY
    CASE
	    WHEN Age BETWEEN 18 AND 20 THEN '10-20'
        WHEN Age BETWEEN 21 AND 30 THEN '20-30'
        WHEN Age BETWEEN 31 AND 40 THEN '30-40'
        WHEN Age BETWEEN 41 AND 50 THEN '40-50'
        WHEN Age BETWEEN 51 AND 60 THEN '50-60'
        ELSE '+60'
END 
Order by Age_group;

--Sum of prices by category

SELECT Product_Category, SUM([Price per Unit]) AS TotalPricePerCategory
FROM retail_sales_dataset
GROUP BY Product_Category
ORDER BY Product_Category;

------ Changing values in the column 
ALTER TABLE [retail_sales_dataset]
ALTER COLUMN [Product_Category] MONEY;

----Renaming column name

EXEC sp_rename 'dbo.retail_sales_dataset.[Product Category]', 'Product_Category', 'COLUMN';

--- Try to found the information of the column 

SELECT TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME LIKE '%Product%';


--- Product category bought for age_group 

SELECT 
    CASE
	    WHEN Age BETWEEN 18 AND 20 THEN '10-20'
		WHEN Age BETWEEN 21 AND 30 THEN '20-30'
		WHEN Age BETWEEN 31 AND 40 THEN '30-40'
		WHEN Age BETWEEN 41 AND 50 THEN '40-50'
		WHEN Age BETWEEN 51 AND 60 THEN '50-60'
		ELSE '+60'
    END AS Age_group, 
    [Product_Category],
sum([Quantity]) AS age_group_boughts 
from retail_sales_dataset
Group by
    CASE
	    WHEN Age BETWEEN 18 AND 20 THEN '10-20'
        WHEN Age BETWEEN 21 AND 30 THEN '20-30'
        WHEN Age BETWEEN 31 AND 40 THEN '30-40'
        WHEN Age BETWEEN 41 AND 50 THEN '40-50'
        WHEN Age BETWEEN 51 AND 60 THEN '50-60'
        ELSE '+60'
END,
[Product_Category]
Order by [Product_Category], Age_group;


--- Age, product category and Quantity bought
SELECT Age, [Product_Category], COUNT(*) as Quantity_bought
FROM retail_sales_dataset
GROUP BY Age, [Product_Category]
HAVING COUNT(*) > 1;




