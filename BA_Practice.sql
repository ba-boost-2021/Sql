-- CRUD Create Read Update Delete

-- ##SELECT ifadesi
-- SELECT column1, column2, column3 FROM table_name 
-- SELECT * FROM table_name
-- SELECT ile bir sonuç tablosu oluþur (result-set)

-- seçtiðiniz 5 tabloyu bütün columnlerle listeleyecek 5 ayrý query yazýn.


SELECT * FROM Customers 
SELECT ContactName, CompanyName, City, CustomerID FROM Customers
SELECT o.OrderDate, o.ShipName FROM Orders AS o 
SELECT * FROM Employees

-- ## WHERE Clause
-- WHERE kayýtlarý filtrelemeye yarar.
-- SELECT column1, column2 FROM table_name WHERE condition

-- ##AND(&& c#),OR(|| c#) ve NOT(! c#) operatörleri (mantýksal), = (== c#), !=, >,<,>=,<= (matematiksel)
-- SELECT * FROM table_name WHERE condition1 AND condition2 OR condition3

SELECT * FROM Employees WHERE EmployeeID >= 1 AND EmployeeID < 6
SELECT LastName , FirstName  FROM Employees WHERE EmployeeID >= 1 AND EmployeeID < 6

SELECT * FROM Employees WHERE EmployeeID = 1 -- eþit olan 
SELECT * FROM Employees WHERE EmployeeID != 1 -- eþit olmayan (deðili)
SELECT * FROM Employees WHERE NOT EmployeeID = 1 -- eþit olmayan (deðili)
SELECT LastName , FirstName  FROM Employees WHERE NOT (EmployeeID >= 1 AND EmployeeID < 6)

-- string ifadeler için eþitlik   column = 'string_ifade'.
--1.)Category tablosundan CategoryName'i 'Condiments' olan kayýdýn 'Description'ýný çeken queryi yazýnýz.


SELECT * FROM Categories
SELECT c.Description AS Taným FROM Categories AS c WHERE c.CategoryName = 'Condiments'


/**
-- Category tablosundan CategoryID si 4 ten büyük olan verileri çeken query i yazýnýz 
-- Customer tablosundan Ülkesi Almanya olan verileri çekiniz
-- Customer tablosundan Ülkesi Meksika veya Fransa olan verileri çekiniz. 
 **/

SELECT * FROM Categories WHERE CategoryID > 4
SELECT * FROM Customers WHERE Country = 'Germany'
SELECT * FROM Customers WHERE Country = 'Mexico' OR Country = 'France'

-- ## NULL VALUES 
-- IS NULL, IS NOT NULL

-- SELECT * FROM table_name WHERE column_name IS NULL/IS NOT NULL

--SELECT * FROM Customers WHERE Region = NULL --bu ifade yanlýþtýr.
SELECT * FROM Customers WHERE Region IS NULL
SELECT * FROM Customers WHERE Region IS NOT NULL

-- 3-)
-- Customer tablosundan Fax ve Region kolonlarý Null olan verilerin CompanyName kolonlarýný çekiniz.
-- Customer tablosundan ülkesi UK veya USA olan ancak Region kolonlarý null olmayan verileri çekiniz.
-- Customer tablosundan fax numarasý null, region null olmayan verilerin Address lerini çekiniz.

SELECT CompanyName FROM Customers WHERE Fax IS NULL AND Region IS NULL
SELECT * FROM Customers WHERE (Country = 'USA' OR Country = 'UK') AND Region IS NOT NULL
SELECT Address FROM Customers WHERE Fax IS NULL AND Region IS NOT NULL

-- ## BETWEEN operatörü
-- kullanýlabilecek tipler --> numbers, text, date
-- SELECT * FROM table_name WHERE column_name BETWEEN value1 AND value2 -- baþlangýç ve bitiþ deðerleri DAHÝLDÝR.

SELECT * FROM Employees WHERE EmployeeID BETWEEN 1 AND 3

SELECT * FROM Employees Order By LastName ASC 
SELECT * FROM Employees Order By LastName DESC 
SELECT * FROM Employees WHERE LastName BETWEEN 'Buchanan' AND 'Leverling'

-- 4.)
-- Employee tablosundan EmployeeID si 3 ile 8 arasýnda olan verileri hem between kullanarak hemde kullanmadan çeken iki sorguyu yazýnýz 
-- Employee tablosundan BirthDate'i '01.09.1958' olan verinin LastName FirstName ve HomePhone kolonlarýný dönen sorguyu yazýnýz.
-- Employee tablosundan Title ý 'Sales Representative' olan ve HireDate i 11.15.1994 ten büyük ve eþit olan verilerin
-- Adý Soyadýný tek bir kolonda(Adý Soyadý) gösterecek sorguyu yazýnýz.

SELECT * FROM Employees WHERE EmployeeID BETWEEN 3 AND 8
SELECT * FROM Employees WHERE EmployeeID >= 3 AND EmployeeID <= 8
SELECT FirstName , LastName , HomePhone FROM Employees WHERE BirthDate = '01.09.1958'
SELECT FirstName + ' ' + LastName AS [Adý Soyadý] FROM Employees WHERE Title = 'Sales Representative' AND HireDate >= '11.15.1994'


-- ## IN operatörü 
-- SELECT * FROM table_name WHERE column_name IN (value1, value2, ...)

SELECT * FROM Employees WHERE EmployeeID IN (1,3,5)
SELECT * FROM Employees WHERE FirstName IN ('Nancy', 'Andrew')

--5.)
-- Employee tablosundan employeeID si 1,3,5,6 olan verileri listeleyiniz. -- bunu in kullanmadan nasýl yaparýz?
-- OrderDetail tablosundan miktarlarý 10,25,20 olan verileri listeleyiniz.

SELECT * FROM Employees WHERE EmployeeID IN (1,3,5,6)
SELECT * FROM Employees WHERE EmployeeID = 1 OR EmployeeID = 3 OR EmployeeID = 5 OR EmployeeID = 6
SELECT UnitPrice * Quantity as [Total Price] FROM [Order Details] WHERE Quantity IN (10,25,20) 

-- ##INNER JOIN

-- SELECT * FROM table1 INNER JOIN table2 ON table1.column_name = table2.column_name

SELECT p.ProductName , s.CompanyName, s.ContactTitle, c.CategoryName  FROM Products p 
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID 
INNER JOIN Categories c ON c.CategoryID = p.CategoryID 

SELECT * FROM Suppliers s 
SELECT p.ProductName , p.SupplierID  FROM Products p

SELECT s.CompanyName, s.SupplierID  FROM Suppliers s WHERE s.SupplierID = 1

--6.)
-- Order tablosunda ki sipariþleri sipariþi veren müþteri ve ilgilenen çalýþanýn adlarý 
-- ve telefon numaralarý ile listeleyiniz.
-- (kolonlara uygun isimler veriniz)

SELECT e.FirstName , c.ContactName , o.OrderDate , e.HomePhone , c.Phone as 'Müþteri No'  FROM Orders o 
INNER JOIN Customers c ON o.CustomerID = c.CustomerID 
INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID 


-- ÖDEV: kendi senaryolarýnýzý yaratarak Northwind üzerinden 30 tane sorgu tasarlayýnýz.
-- NOT: öðrendiðimiz bütün kavramlarý kullanmaya özen gösterin.