--1
--select * from Employees

--select * from Customers

select distinct e.city from Employees e
join Customers c on c.city=e.city

--2a z
select distinct c.city from Customers c except( select distinct e.city from Employees e
join Customers c on c.city=e.city)

--2b
select distinct c.city from Customers c
left outer join Employees e On c.City=e.City
--where c.City<>e.City
--3a
