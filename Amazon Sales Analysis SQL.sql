create Database Amazon;
use Amazon;

## Data Engineering

# Rename the Table
rename table `amazon sales data` to sales;

# Remove the safe mode for update
SET SQL_SAFE_UPDATES = 0;

# Add a Shipping days gap column
Alter table sales
add column `Shipping Gap` int;

# Add Values in that column
UPDATE Sales
SET `Shipping Gap` = DATEDIFF(`Ship Date`, `Order Date`);

# View the Table
select * from sales;

# Change the Data type of order date and shhping date column
UPDATE sales
SET `order date` = STR_TO_DATE(`order date`, '%m/%d/%Y');
UPDATE sales
SET `Ship date` = STR_TO_DATE(`ship date`, '%m/%d/%Y');

## Sales Analysis

# Total Sales
Select Round(sum(`Total Revenue`)) as Total_Revenue From Sales;

# Total Order
select count(`order ID`) As `Total Order` from sales;

# Total Unit Sold
select sum(`Units sold`) As `Total unit sold` From sales;

# Total Overall cost
select Round(sum(`Total cost`)) As `Total cost` From sales;

# Total Revenue by Sales Channel
Select `sales channel`, Round(sum(`Total Revenue`)) As `Total Sales`
from sales
group by `sales channel`
order by `Total sales` desc;

# Total Revenue By Region
Select `region`, Round(sum(`Total Revenue`)) As `Total Sales`
from sales
group by `Region`
order by `Total sales` desc;

# Year wise Revenue
Select Year(`order date`)as Year, Round(sum(`Total Revenue`)) As `Total Sales`
from sales
group by Year
order by `Total sales` desc;

#Month wise Revenue
Select Monthname(`order date`)as Month, Round(sum(`Total Revenue`)) As `Total Sales`
from sales
group by Month
order by `Total sales` desc;

# Revenue By Order Priority
Select `Order Priority`, Round(sum(`Total Revenue`)) As `Total Sales`
from sales
group by `Order priority`
order by `Total sales` desc;

#Revenue by Item Type
Select `Item Type`, Round(sum(`Total Revenue`)) As `Total Sales`
from sales
group by `item Type`
order by `Total sales` desc;

# Total unit sold by Item type
Select `Item Type`, Round(sum(`Units sold`)) As `Total unit sold`
from sales
group by `item Type`
order by `Total unit sold` desc;

# Top 5 country as per Revenue
Select country, round(sum(`Total revenue`)) as `Total sales`
From Sales
Group by Country
Order by `Total Sales` Desc
Limit 5;

# Buttom 5 country as per Revenue
Select country, round(sum(`Total revenue`)) as `Total sales`
From Sales
Group by Country
Order by `Total Sales` Asc
Limit 5;

##Profit Analysis

# Total Profit
Select Round(sum(`Total Profit`)) from Sales;

## Total Profit by Sales Channel
Select `Sales Channel`, Round(sum(`Total Profit`))  as `Total Profit`
from Sales
Group by `Sales Channel`
Order by `Total Profit` Desc;

# Total Profit By Order Priority
Select `Order Priority`, Round(sum(`Total Profit`))  as `Total Profit`
from Sales
Group by `Order priority`
Order by `Total Profit` Desc;

# Total Profit By Region
Select `Region`, Round(sum(`Total Profit`))  as `Total Profit`
from Sales
Group by `Region`
Order by `Total Profit` Desc;

#Total Profit by Item Type
Select `Item Type`, Round(sum(`Total Profit`))  as `Total Profit`
from Sales
Group by `Item Type`
Order by `Total Profit` Desc;

# Year wise Profit
select year(`Order date`) As Year, round(Sum(`Total Profit`)) As Profit
from sales
group by Year
Order by Profit desc;

#Month wise Profit
select Monthname(`Order date`) As Month, round(Sum(`Total Profit`)) As Profit
from sales
group by Month
Order by Profit desc;

# Top 10 Country as per Profit
select country, round(sum(`Total profit`)) As Profit
from sales
group by Country
order by Profit desc
limit 10;

# Buttom 10 country as per Profit
select country, round(sum(`Total profit`)) As Profit
from sales
group by Country
order by Profit asc
limit 10;

#Shipping Gap analyze

#Average Shipping Gap
select avg(`Shipping gap`) from sales;

#Highest shiping Gap Delivery
select max(`Shipping Gap`) from sales;

#Lowest shiping Gap Delivery
select min(`Shipping Gap`) from sales
where `shipping gap`>0 ;

#Year wise Average shipping Gap
select year(`order date`) Year,round(avg(`Shipping gap`)) as `Avg Shipping Gap`
from sales
group by year
order by `Avg Shipping Gap` Desc;

#Reason wise Average shipping Gap
select Region, Country, round(avg(`Shipping gap`)) as `Avg Shipping Gap`
from sales
Group by Region, Country
order by Region,`avg shipping gap` desc;

#Country wise average shipping Gap
Select Country, round(avg(`Shipping gap`)) as `Avg Shipping Gap`
from sales
Group by country
order by `Avg Shipping Gap` desc
limit 5;


# Average Shipping Gap in Order to Item Type
Select `Item Type`, round(avg(`Shipping gap`)) as `Avg Shipping Gap`
from Sales
Group by `Item Type`
Order by `Avg Shipping Gap` Desc;

#Sales Channel wise Average shipping Gap
Select `Sales Channel`, round(avg(`Shipping gap`)) as `Avg Shipping Gap`
from Sales
Group by `Sales channel`
Order by `Avg Shipping Gap` Desc;

# Average Shipping Gap in Order to Order Priority
Select `Order priority`, round(avg(`Shipping gap`)) as `Avg Shipping Gap`
from Sales
Group by `Order Priority`
Order by `Avg Shipping Gap` Desc;