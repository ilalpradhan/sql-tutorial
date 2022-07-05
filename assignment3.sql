--1
--select * from Employees

--select * from Customers

select distinct e.city from Employees e
join Customers c on c.city=e.city

--2a 
select distinct c.city from Customers c except( select distinct e.city from Employees e
join Customers c on c.city=e.city)

--2b
Select distinct c.city
From Customers c 
Except
Select e.city
From Employees e

--3a
--select * from Products 
--select * from Orders
--select * from "Order Details"

select p.ProductName, Sum(od.Quantity) [Total Orders]from Products p, [Order Details] as od, Orders o
where od.OrderID=o.OrderID and p.ProductID=od.ProductID
Group By p.ProductName

--4
select t.City, count(*)[Total Products]                        -- counting the (city's )total products
from (Select c.city,od.ProductID, count(*) as [Total Products]  --counting (city and productID )
	from [Order Details] od, Customers c,Orders o 
	where o.OrderID=od.OrderID and c.CustomerID=o.CustomerID
	group by c.city, od.ProductID) t
group by t.City


--5a.

select City
from Customers
except
select City
from Customers
group by City
having Count(*)=1
Union 
select City
from Customers
group by City
having Count(*)=0


--5b
select City
from Customers
except
select City from Customers
group by city
having count(*)<=1


--6
select city, od.productID, count(*) [Total Products] from Customers c, [Order Details] od, Orders o
where o.OrderID=od.OrderID and c.CustomerID=o.CustomerID
group by c.City, od.ProductID
having count(*)>=2

--7
select distinct c.ContactName
from Orders o, Customers c
where c.CustomerID=o.CustomerID and c.City<>o.ShipCity

--8
select distinct top 5 p.ProductName , avg(od.UnitPrice) [Average Price], o.ShipCity
from Products p, Orders o, [Order Details] od
where o.OrderID=od.OrderID and od.ProductID=p.ProductID and p.UnitPrice=od.UnitPrice
group by p.ProductName, o.ShipCity,od.UnitPrice

--9a
select distinct e.City 
from Employees e
where e.City not in(
Select o.ShipCity
from Orders o)

--9b
select distinct e.City 
from Employees e
except
Select o.ShipCity
from Orders o


--10
select * from [Order Details]

Select Distinct o.ShipCity, count(od.OrderID)
From Orders o, [Order Details] od
Group By o.ShipCity, od.OrderID

--11
using Distinct and group by while joining tables.
