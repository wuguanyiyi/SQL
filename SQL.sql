--1.找出和最貴的產品同類別的所有產品
--select p.ProductName,c.CategoryID
--from Products p
--inner join Categories c on c.CategoryID = p.CategoryID
--where c.CategoryID in ( select top 1 c.CategoryID
--						from Products p
--						inner join Categories c on c.CategoryID = p.CategoryID
--						order by p.UnitPrice desc
--					  )
--select top 1 p.UnitPrice,c.CategoryName
--from Products p
--inner join Categories c on c.CategoryID = p.CategoryID
--where c.CategoryName in(select top 1 c.CategoryName from Categories c )
--order by p.UnitPrice desc

--2.找出和最貴的產品同類別最便宜的產品
--select top 1 p.ProductID,p.ProductName
--from Products p
--inner join Categories c on c.CategoryID = p.CategoryID
--where c.CategoryID in ( select top 1 c.CategoryID
--						from Products p
--						inner join Categories c on c.CategoryID = p.CategoryID
--						order by p.UnitPrice desc
--					  )
--order by p.UnitPrice

--3.計算出上面類別最貴和最便宜的兩個產品的價差
--select max(p.UnitPrice)-min(p.UnitPrice)as price_diffence
--from Products p
--inner join Categories c on c.CategoryID = p.CategoryID
--where c.CategoryID in ( select top 1 c.CategoryID
--						from Products p
--						inner join Categories c on c.CategoryID = p.CategoryID
--						order by p.UnitPrice desc
--					  )

--4.找出沒有訂過任何商品的客戶所在的城市的所有客戶
--select c.CustomerID
--from Customers c
--where c.City in(select c.City
--				from Customers c
--				full join Orders o on o.CustomerID = c.CustomerID  --full join null會印出來
--				where o.OrderID is NULL
--				)

--5.找出第 5 貴跟第 8 便宜的產品的產品類別
--select distinct c.CategoryID --distinct過濾重複出現的值
--from Categories c
--inner join Products p on p.CategoryID = c.CategoryID
--where c.CategoryID in ( select  p.CategoryID
--						from Products p
--						order by p.UnitPrice desc
--						offset 4 rows
--						fetch next 1 rows only)
--						or
--						c.CategoryID =( select p.CategoryID
--										 from Products p
--										 order by p.UnitPrice 
--										 offset 7 rows 
--										 fetch next 1 rows only)

--6.找出誰買過第 5 貴跟第 8 便宜的產品
--select distinct c.CustomerID
--from Customers c
--inner join Orders o on o.CustomerID = c.CustomerID
--inner join [Order Details] od on od.OrderID = o.OrderID
--inner join Products p on p.ProductID = od.ProductID
--where p.ProductID in(	select p.ProductID
--						from Products p
--						order by p.UnitPrice desc
--						offset 4 rows
--						fetch next 1 rows only
--					  )or
--					  p.ProductID in(	select p.ProductID
--										from Products p
--										order by p.UnitPrice 
--										offset 7 rows
--										fetch next 1 rows only)

--7.找出誰賣過第 5 貴跟第 8 便宜的產品
--select e.EmployeeID
--from Employees e
--inner join Orders o on o.EmployeeID = e.EmployeeID
--inner join [Order Details] od on od.OrderID = o.OrderID
--inner join Products p on p.ProductID = od.ProductID
--where p.ProductID in(	select p.ProductID
--						from Products p
--						order by p.UnitPrice desc
--						offset 4 rows
--						fetch next 1 rows only
--					  )or
--					  p.ProductID =(	select p.ProductID
--										from Products p
--										order by p.UnitPrice 
--										offset 7 rows
--										fetch next 1 rows only)

--8.找出 13 號星期五的訂單 (惡魔的訂單)
--select OrderID,OrderDate
--from Orders
--where DATEPART(day,OrderDate) = 13 AND DATEPART(weekday,OrderDate) = 6

--9.找出誰訂了惡魔的訂單
--select c.CustomerID,c.CompanyName,o.OrderDate
--from Customers c
--inner join Orders o on c.CustomerID = o.CustomerID
--where o.OrderID in(	select OrderID
--					from Orders
--					where DATEPART(day,OrderDate) = 13 AND DATEPART(weekday,OrderDate) = 6
--				   )

--10.找出惡魔的訂單裡有什麼產品
--select o.OrderID,p.ProductID,p.ProductName
--from Orders o
--inner join [Order Details] od on od.OrderID = o.OrderID
--inner join Products p on p.ProductID = od.ProductID
--where DATEPART(day,OrderDate) = 13 AND DATEPART(weekday,OrderDate) = 6

--11.列出從來沒有打折 (Discount) 出售的產品
--select p.ProductID,od.Discount
--from Products p
--inner join [Order Details] od on od.ProductID = p.ProductID
--where od.Discount = 0

--12.列出購買非本國的產品的客戶
--select c.CustomerID
--from Customers c
--inner join Orders o on o.CustomerID = c.CustomerID
--inner join [Order Details] od on od.OrderID = o.OrderID
--inner join Products p on p.ProductID = od.ProductID
--inner join Suppliers s on s.SupplierID = p.SupplierID
--where c.Country <> s.Country

--13.列出在同個城市中有公司員工可以服務的客戶
--select c.CustomerID,c.City,e.City
--from Employees e
--inner join Orders o on o.EmployeeID = e.EmployeeID
--inner join Customers c on c.CustomerID =o.CustomerID
--where e.City = c.City
--14.列出那些產品沒有人買過
--select od.ProductID
--from [Order Details] od
--full join Products p on p.ProductID = od.ProductID
--where od.ProductID is null
----------------------------------------------------------------------------------------

--15.列出所有在每個月月底的訂單
--select o.OrderID,o.OrderDate
--from Orders o
--WHERE o.OrderDate = EOMONTH(o.OrderDate)
--16.列出每個月月底售出的產品
--select p.ProductID,o.OrderDate
--from Products p
--inner join [Order Details] od on od.ProductID = p.ProductID
--inner join Orders o on o.OrderID = od.OrderID
--where o.OrderDate in(	select o.OrderDate
--						from Orders o
--						where o.OrderDate = EOMONTH(o.OrderDate)
--					 )
--17.找出有敗過最貴的三個產品中的任何一個的前三個大客戶
--select top 3 c.CustomerID,c.CompanyName,sum(od.UnitPrice*od.Quantity*(1-od.Discount))as total
--from Customers c
--inner join Orders o on o.CustomerID = c.CustomerID
--inner join [Order Details] od on od.OrderID = o.OrderID
--inner join Products p on p.ProductID = od.ProductID
--where p.ProductID in(	select top 3 p.ProductID
--						from Products p
--						order by p.UnitPrice desc
--					)
--group by c.CustomerID,c.CompanyName
--order by total desc
--18.找出有敗過銷售金額前三高個產品的前三個大客戶

select top 3 c.CustomerID,c.CompanyName,sum(od.UnitPrice*od.Quantity*(1-od.Discount))as SalesAmount
from Customers c
inner join Orders o on o.CustomerID = c.CustomerID
inner join [Order Details] od on od.OrderID = o.OrderID
inner join Products p on od.ProductID = p.ProductID
where p.ProductID in(	select top 3 od.ProductID
						from [Order Details] od
						inner join Products p on p.ProductID = od.ProductID
						inner join Orders o on o.OrderID = od.OrderID
						group by od.ProductID
						order by sum(p.UnitPrice*od.Quantity*(1 - od.Discount))desc
					 )
group by c.CustomerID,C.CompanyName
order by SalesAmount DESC

--19.找出有敗過銷售金額前三高個產品所屬類別的前三個大客戶
select top 3 c.CustomerID,c.CompanyName,sum(od.UnitPrice*od.Quantity*(1-od.Discount))as SalesAmount
from Customers c
inner join Orders o on o.CustomerID = c.CustomerID
inner join [Order Details] od on od.OrderID = o.OrderID
inner join Products p on od.ProductID = p.ProductID
where p.ProductID in(	select top 3 od.ProductID
						from [Order Details] od
						inner join Products p on p.ProductID = od.ProductID
						inner join Orders o on o.OrderID = od.OrderID
						group by od.ProductID
						order by sum(p.UnitPrice*od.Quantity*(1 - od.Discount))desc
					 )
group by c.CustomerID,C.CompanyName
order by SalesAmount DESC 
--20.列出消費總金額高於所有客戶平均消費總金額的客戶的名字，以及客戶的消費總金額

--21.列出最熱銷的產品，以及被購買的總金額

--22.列出最少人買的產品
select top 1 p.ProductID,sum(od.Quantity)as total
from [Order Details] od
inner join Products p on od.ProductID = p.ProductID
group by p.ProductID
order by total
--23.列出最沒人要買的產品類別 (Categories)
select top 1 c.CategoryID,sum(od.Quantity)as total
from Categories c
inner join Products p on p.CategoryID = c.CategoryID
inner join [Order Details] od on od.ProductID = p.ProductID
group by c.CategoryID
order by total--可能有錯
--24.列出跟銷售最好的供應商買最多金額的客戶與購買金額 (含購買其它供應商的產品)

--25.列出跟銷售最好的供應商買最多金額的客戶與購買金額 (不含購買其它供應商的產品)

--26.列出那些產品沒有人買過
--select p.ProductID
--from Products p
--inner join [Order Details] od on od.ProductID = p.ProductID
--where od.Quantity is null

--27.列出沒有傳真 (Fax) 的客戶和它的消費總金額

--28.列出每一個城市消費的產品種類數量

--29.列出目前沒有庫存的產品在過去總共被訂購的數量

--30.列出目前沒有庫存的產品在過去曾經被那些客戶訂購過

--31.列出每位員工的下屬的業績總金額

--32.列出每家貨運公司運送最多的那一種產品類別與總數量

--33.列出每一個客戶買最多的產品類別與金額


--34.列出每一個客戶買最多的那一個產品與購買數量

--35.按照城市分類，找出每一個城市最近一筆訂單的送貨時間

--36.列出購買金額第五名與第十名的客戶，以及兩個客戶的金額差距




