--1.��X�M�̶Q�����~�P���O���Ҧ����~
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

--2.��X�M�̶Q�����~�P���O�̫K�y�����~
--select top 1 p.ProductID,p.ProductName
--from Products p
--inner join Categories c on c.CategoryID = p.CategoryID
--where c.CategoryID in ( select top 1 c.CategoryID
--						from Products p
--						inner join Categories c on c.CategoryID = p.CategoryID
--						order by p.UnitPrice desc
--					  )
--order by p.UnitPrice

--3.�p��X�W�����O�̶Q�M�̫K�y����Ӳ��~�����t
--select max(p.UnitPrice)-min(p.UnitPrice)as price_diffence
--from Products p
--inner join Categories c on c.CategoryID = p.CategoryID
--where c.CategoryID in ( select top 1 c.CategoryID
--						from Products p
--						inner join Categories c on c.CategoryID = p.CategoryID
--						order by p.UnitPrice desc
--					  )

--4.��X�S���q�L����ӫ~���Ȥ�Ҧb���������Ҧ��Ȥ�
--select c.CustomerID
--from Customers c
--where c.City in(select c.City
--				from Customers c
--				full join Orders o on o.CustomerID = c.CustomerID  --full join null�|�L�X��
--				where o.OrderID is NULL
--				)

--5.��X�� 5 �Q��� 8 �K�y�����~�����~���O
--select distinct c.CategoryID --distinct�L�o���ƥX�{����
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

--6.��X�ֶR�L�� 5 �Q��� 8 �K�y�����~
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

--7.��X�ֽ�L�� 5 �Q��� 8 �K�y�����~
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

--8.��X 13 ���P�������q�� (�c�]���q��)
--select OrderID,OrderDate
--from Orders
--where DATEPART(day,OrderDate) = 13 AND DATEPART(weekday,OrderDate) = 6

--9.��X�֭q�F�c�]���q��
--select c.CustomerID,c.CompanyName,o.OrderDate
--from Customers c
--inner join Orders o on c.CustomerID = o.CustomerID
--where o.OrderID in(	select OrderID
--					from Orders
--					where DATEPART(day,OrderDate) = 13 AND DATEPART(weekday,OrderDate) = 6
--				   )

--10.��X�c�]���q��̦����򲣫~
--select o.OrderID,p.ProductID,p.ProductName
--from Orders o
--inner join [Order Details] od on od.OrderID = o.OrderID
--inner join Products p on p.ProductID = od.ProductID
--where DATEPART(day,OrderDate) = 13 AND DATEPART(weekday,OrderDate) = 6

--11.�C�X�q�ӨS������ (Discount) �X�⪺���~
--select p.ProductID,od.Discount
--from Products p
--inner join [Order Details] od on od.ProductID = p.ProductID
--where od.Discount = 0

--12.�C�X�ʶR�D���ꪺ���~���Ȥ�
--select c.CustomerID
--from Customers c
--inner join Orders o on o.CustomerID = c.CustomerID
--inner join [Order Details] od on od.OrderID = o.OrderID
--inner join Products p on p.ProductID = od.ProductID
--inner join Suppliers s on s.SupplierID = p.SupplierID
--where c.Country <> s.Country

--13.�C�X�b�P�ӫ����������q���u�i�H�A�Ȫ��Ȥ�
--select c.CustomerID,c.City,e.City
--from Employees e
--inner join Orders o on o.EmployeeID = e.EmployeeID
--inner join Customers c on c.CustomerID =o.CustomerID
--where e.City = c.City
--14.�C�X���ǲ��~�S���H�R�L
--select od.ProductID
--from [Order Details] od
--full join Products p on p.ProductID = od.ProductID
--where od.ProductID is null
----------------------------------------------------------------------------------------

--15.�C�X�Ҧ��b�C�Ӥ�멳���q��
--select o.OrderID,o.OrderDate
--from Orders o
--WHERE o.OrderDate = EOMONTH(o.OrderDate)
--16.�C�X�C�Ӥ�멳��X�����~
--select p.ProductID,o.OrderDate
--from Products p
--inner join [Order Details] od on od.ProductID = p.ProductID
--inner join Orders o on o.OrderID = od.OrderID
--where o.OrderDate in(	select o.OrderDate
--						from Orders o
--						where o.OrderDate = EOMONTH(o.OrderDate)
--					 )
--17.��X���ѹL�̶Q���T�Ӳ��~��������@�Ӫ��e�T�Ӥj�Ȥ�
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
--18.��X���ѹL�P����B�e�T���Ӳ��~���e�T�Ӥj�Ȥ�

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

--19.��X���ѹL�P����B�e�T���Ӳ��~�������O���e�T�Ӥj�Ȥ�
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
--20.�C�X���O�`���B����Ҧ��Ȥᥭ�����O�`���B���Ȥ᪺�W�r�A�H�ΫȤ᪺���O�`���B

--21.�C�X�̼��P�����~�A�H�γQ�ʶR���`���B

--22.�C�X�̤֤H�R�����~
select top 1 p.ProductID,sum(od.Quantity)as total
from [Order Details] od
inner join Products p on od.ProductID = p.ProductID
group by p.ProductID
order by total
--23.�C�X�̨S�H�n�R�����~���O (Categories)
select top 1 c.CategoryID,sum(od.Quantity)as total
from Categories c
inner join Products p on p.CategoryID = c.CategoryID
inner join [Order Details] od on od.ProductID = p.ProductID
group by c.CategoryID
order by total--�i�঳��
--24.�C�X��P��̦n�������ӶR�̦h���B���Ȥ�P�ʶR���B (�t�ʶR�䥦�����Ӫ����~)

--25.�C�X��P��̦n�������ӶR�̦h���B���Ȥ�P�ʶR���B (���t�ʶR�䥦�����Ӫ����~)

--26.�C�X���ǲ��~�S���H�R�L
--select p.ProductID
--from Products p
--inner join [Order Details] od on od.ProductID = p.ProductID
--where od.Quantity is null

--27.�C�X�S���ǯu (Fax) ���Ȥ�M�������O�`���B

--28.�C�X�C�@�ӫ������O�����~�����ƶq

--29.�C�X�ثe�S���w�s�����~�b�L�h�`�@�Q�q�ʪ��ƶq

--30.�C�X�ثe�S���w�s�����~�b�L�h���g�Q���ǫȤ�q�ʹL

--31.�C�X�C����u���U�ݪ��~�Z�`���B

--32.�C�X�C�a�f�B���q�B�e�̦h�����@�ز��~���O�P�`�ƶq

--33.�C�X�C�@�ӫȤ�R�̦h�����~���O�P���B


--34.�C�X�C�@�ӫȤ�R�̦h�����@�Ӳ��~�P�ʶR�ƶq

--35.���ӫ��������A��X�C�@�ӫ����̪�@���q�檺�e�f�ɶ�

--36.�C�X�ʶR���B�Ĥ��W�P�ĤQ�W���Ȥ�A�H�Ψ�ӫȤ᪺���B�t�Z




