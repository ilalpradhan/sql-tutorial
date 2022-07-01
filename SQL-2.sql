
--1 products in product table
Select Distinct Count(ProductNumber) from Production.Product

--2
Select Count(*) [SubcategoryNotNull]
From Production.Product s
Where s.ProductSubcategoryID is not null

--3
Select s.ProductSubcategoryID, Count(*)[Countedproducts]
From Production.Product s
Where s.ProductSubcategoryID is not null
Group By s.ProductSubcategoryID

--4
Select Count(*) [SubcategoryWithNoSubcategoryId]
From Production.Product s
Where s.ProductSubcategoryID is null


--5
select Sum(Quantity)[sumOfProducts]
from Production.ProductInventory

--6

Select ProductID, Sum(Quantity) [TheSum]
From Production.ProductInventory 
Where LocationID = 40
Group By ProductID
Having Sum(Quantity) < 100

--7
Select Shelf,ProductID, Sum(Quantity) [TheSum]
From Production.ProductInventory 
Where LocationID = 40
Group By Shelf,ProductID
Having Sum(Quantity) < 100


--8
select avg(Quantity)[average]
from Production.ProductInventory
where LocationID=10


--9
Select ProductID,Shelf, avg(Quantity)[TheAvg]
from Production.ProductInventory
Group by  ProductID, Shelf

--10
Select ProductID,Shelf, avg(Quantity)[TheAvg]
from Production.ProductInventory
where Shelf<>'N/A'
Group by  ProductID, Shelf

--11
select  Color,  Class, count(*)[TheCount],avg(ListPrice) [AvgPrice]
from Production.Product
where Color IS NOT NULL AND Class IS NOT NULL
group by Color, Class

--12
select c.Name [Country], p.Name [Province]
from Person.CountryRegion [c]
join Person.StateProvince [p]
on p.CountryRegionCode=c.CountryRegionCode

--13
select c.Name [Country], p.Name [Province]
from Person.CountryRegion [c]
join Person.StateProvince [p]
on p.CountryRegionCode=c.CountryRegionCode
where c.Name in ('Germany','Canada')


--14
Select c.Name as Country, p.Name as Province
From person.CountryRegion c JOIN person.StateProvince p
On c.CountryRegionCode = p.CountryRegionCode

--13.
Select c.Name as Country, p.Name as Province
From person.CountryRegion c JOIN person.StateProvince p
On c.CountryRegionCode = p.CountryRegionCode
Where c.Name in ('Germany','Canada')

-- 14.
Select p.ProductID, p.productname, o.orderdate
From dbo.products p, dbo.[Order Details] od, dbo.orders o
Where p.productid = od.productid and od.orderid = o.orderid
and o.orderdate >= '1997-06-30'

-- 15.
Select TOP 5 Count(*) as [Number of Orders], o.shippostalcode
From dbo.orders o
Where o.shippostalcode IS NOT NULL
Group By o.shippostalcode

-- 16.
Select TOP 5 Count(*) as [Number of Orders], o.shippostalcode
From dbo.orders o
Where o.OrderDate >= '1997-06-30' AND o.shippostalcode IS NOT NULL
Group By o.shippostalcode

-- 17.
Select c.city, count(*)
From dbo.customers c
Group By c.city

-- 18.
Select c.city, count(*)
From dbo.customers c
Group By c.city
Having Count(*) > 2

-- 19.
Select c.contactname, o.orderdate
From dbo.customers c JOIN dbo.orders o
On c.customerid = o.customerid
Where o.orderdate > '1998-01-01'
Order By o.OrderDate

-- 20.
Select c.contactname, o.orderdate
From dbo.customers c JOIN dbo.orders o
On c.customerid = o.customerid
Where o.orderdate = '1998-05-06'
Order By o.OrderDate

-- 21.
Select c.contactname, Count(*) as Purchases
From dbo.customers c Join dbo.orders o
On c.customerid = o.customerid
Group By c.contactname

-- 22.
select
    c.contactname,
    count(*) as Products

from dbo.customers c join dbo.orders o
on c.customerid = o.customerid

group by c.contactname

having count(*) > 100
--There is none?


-- 23.
Select s.CompanyName, c.CompanyName
From dbo.shippers s, dbo.suppliers c

-- 24.
Select o.orderdate, p.productname
From dbo.products p, dbo.[Order Details] od, dbo.orders o
Where p.productid = od.productid and od.orderid = o.orderid
Order By o.OrderDate

-- 25.
Select e1.EmployeeID,e1.FirstName, e2.FirstName ,e2.EmployeeID, e1.Title
From dbo.employees e1, dbo.Employees e2
Where e1.title = e2.title and e1.EmployeeID > e2.EmployeeID

-- 26.
Select r.ReportsTo, Count(*) as TheCount
From dbo.employees r
Where ReportsTo is not null
Group By r.ReportsTo
Having Count(*) > 2

-- 27.
Select c.City, c.CompanyName, c.ContactName, 'Customers' as Type
From Customers c
UNION
Select s.City, s.CompanyName, s.ContactName, 'Suppliers'
From Suppliers s
