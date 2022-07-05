
--1 Create a view named “view_product_order_[your_last_name]”, list all products and total ordered quantity for that product.
Create View view_product_order_Pradhan AS
Select p.ProductName, sum(od.Quantity)from Products p
inner join [Order Details] od On p.ProductID=od.ProductID
group by p.ProductName

-- 2. Create a stored procedure “sp_product_order_quantity_[your_last_name]” that accept product id as an input and total quantities of order as output parameter.
CREATE PROC sp_product_order_quantity_Pradhan
@ProductID int,

@QuantityofOrder int out

as 
begin
select @QuantityofOrder = count(*)
from Orders o join [Order Details] od on o.OrderID = od.OrderID
where od.ProductID = @ProductID
end


-- 3. Create a stored procedure “sp_product_order_city_[your_last_name]” that accept product name as an input and top 5 cities that ordered most that product combined with the total quantity of that product ordered from that city as output.
CREATE PROC sp_product_order_city_Pradhan
@productName varchar(20)

AS
BEGIN
SELECT TOP 5 o.ShipCity, SUM(od.Quantity) AS OrderQuantity
FROM Products p INNER JOIN [Order Details] od ON p.ProductID = od.ProductID
INNER JOIN Orders o ON o.OrderID = od.OrderID
WHERE p.ProductName = @productName
GROUP BY ProductName, ShipCity
ORDER BY SUM(od.Quantity) DESC
END


-- 4. Create 2 new tables “people_your_last_name” “city_your_last_name”. City table has two records: {Id:1, City: Seattle}, {Id:2, City: Green Bay}. People has three records: {id:1, Name: Aaron Rodgers, City: 2}, {id:2, Name: Russell Wilson, City:1}, {Id: 3, Name: Jody Nelson, City:2}. Remove city of Seattle. If there was anyone from Seattle, put them into a new city “Madison”. Create a view “Packers_your_name” lists all people from Green Bay. If any error occurred, no changes should be made to DB. (after test) Drop both tables and view.


create table city_Pradhan
(
ID int primary key identity(1,1),
City varchar(15)
)


create table people_Pradhan
(
ID int primary key identity(1,1),
Name varchar(40),
City int foreign key references city_Pradhan(ID) on delete set NULL
)


insert into city_Pradhan values ('Seattle')
insert into city_Pradhan values ('Green Bay')

insert into people_Pradhan values ('Aaron Rodgers', 2)
insert into people_Pradhan values ('Russell Wilson', 1)
insert into people_Pradhan values ('Jody Nelson', 2)

delete city_Pradhan
where City = 'Seattle'

insert into city_Pradhan values ('Madison')

update people_Pradhan
set City = 3
where city is null

create view Packers_Ishit_Pradhan
as
(
select p.Name
from people_Pradhan p join city_Pradhan c on p.City = c.ID
where c.City = 'Green Bay'
)

drop table people_Pradhan, city_Pradhan
drop view Packers_Ishit_Pradhan



-- 5. Create a stored procedure “sp_birthday_employees_[you_last_name]” that creates a new table “birthday_employees_your_last_name” and fill it with all employees that have a birthday on Feb. (Make a screen shot) drop the table. Employee table should not be affected.
CREATE PROC sp_birthday_employees_Pradhan
AS
BEGIN
CREATE TABLE birthday_employees_Pradhan(Id int primary key,
[first name] varchar(20),
[last name] varchar(20),
birthDate datetime)

INSERT INTO birthday_employees_Pradhan(Id, [first name], [last name], birthDate)
SELECT e.EmployeeID, e.FirstName, e.LastName, e.BirthDate FROM Employees e
WHERE month(e.birthDate) = 2
END

EXEC sp_birthday_employees_Pradhan
SELECT * FROM birthday_employees_Pradhan
DROP TABLE birthday_employees_Pradhan

-- 6. How do you make sure two tables have the same data?
-- An inner join to pick up the rows where the primary key exists in both tables, but there is a difference in the value of one or more of the other columns. This would pick up changed rows in original.

--A left outer join to pick up the rows that are in the original tables, but not in the backup table (i.e. a row in original has a primary key that does not exist in backup). This would return rows inserted into the original.

--A right outer join to pick up the rows in backup which no longer exist in the original. This would return rows that have been deleted from the original.
