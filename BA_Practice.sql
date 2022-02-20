-- CRUD Create Read Update Delete

-- ##SELECT ifadesi
-- SELECT column1, column2, column3 FROM table_name 
-- SELECT * FROM table_name
-- SELECT ile bir sonuç tablosu oluşur (result-set)

-- seçtiğiniz 5 tabloyu bütün columnlerle listeleyecek 5 ayrı query yazın.


SELECT * FROM Customers 
SELECT ContactName, CompanyName, City, CustomerID FROM Customers
SELECT o.OrderDate, o.ShipName FROM Orders AS o 
SELECT * FROM Employees

-- ## WHERE Clause
-- WHERE kayıtları filtrelemeye yarar.
-- SELECT column1, column2 FROM table_name WHERE condition

-- ##AND(&& c#),OR(|| c#) ve NOT(! c#) operatörleri (mantıksal), = (== c#), !=, >,<,>=,<= (matematiksel)
-- SELECT * FROM table_name WHERE condition1 AND condition2 OR condition3

SELECT * FROM Employees WHERE EmployeeID >= 1 AND EmployeeID < 6
SELECT LastName , FirstName  FROM Employees WHERE EmployeeID >= 1 AND EmployeeID < 6

SELECT * FROM Employees WHERE EmployeeID = 1 -- eşit olan 
SELECT * FROM Employees WHERE EmployeeID != 1 -- eşit olmayan (değili)
SELECT * FROM Employees WHERE NOT EmployeeID = 1 -- eşit olmayan (değili)
SELECT LastName , FirstName  FROM Employees WHERE NOT (EmployeeID >= 1 AND EmployeeID < 6)

-- string ifadeler için eşitlik   column = 'string_ifade'.
--1.)Category tablosundan CategoryName'i 'Condiments' olan kayıdın 'Description'ını çeken queryi yazınız.


SELECT * FROM Categories
SELECT c.Description AS Tanım FROM Categories AS c WHERE c.CategoryName = 'Condiments'


/**
-- Category tablosundan CategoryID si 4 ten büyük olan verileri çeken query i yazınız 
-- Customer tablosundan Ülkesi Almanya olan verileri çekiniz
-- Customer tablosundan Ülkesi Meksika veya Fransa olan verileri çekiniz. 
 **/

SELECT * FROM Categories WHERE CategoryID > 4
SELECT * FROM Customers WHERE Country = 'Germany'
SELECT * FROM Customers WHERE Country = 'Mexico' OR Country = 'France'

-- ## NULL VALUES 
-- IS NULL, IS NOT NULL

-- SELECT * FROM table_name WHERE column_name IS NULL/IS NOT NULL

--SELECT * FROM Customers WHERE Region = NULL --bu ifade yanlıştır.
SELECT * FROM Customers WHERE Region IS NULL
SELECT * FROM Customers WHERE Region IS NOT NULL

-- 3-)
-- Customer tablosundan Fax ve Region kolonları Null olan verilerin CompanyName kolonlarını çekiniz.
-- Customer tablosundan ülkesi UK veya USA olan ancak Region kolonları null olmayan verileri çekiniz.
-- Customer tablosundan fax numarası null, region null olmayan verilerin Address lerini çekiniz.

SELECT CompanyName FROM Customers WHERE Fax IS NULL AND Region IS NULL
SELECT * FROM Customers WHERE (Country = 'USA' OR Country = 'UK') AND Region IS NOT NULL
SELECT Address FROM Customers WHERE Fax IS NULL AND Region IS NOT NULL

-- ## BETWEEN operatörü
-- kullanılabilecek tipler --> numbers, text, date
-- SELECT * FROM table_name WHERE column_name BETWEEN value1 AND value2 -- başlangıç ve bitiş değerleri DAHÝLDÝR.

SELECT * FROM Employees WHERE EmployeeID BETWEEN 1 AND 3

SELECT * FROM Employees Order By LastName ASC 
SELECT * FROM Employees Order By LastName DESC 
SELECT * FROM Employees WHERE LastName BETWEEN 'Buchanan' AND 'Leverling'

-- 4.)
-- Employee tablosundan EmployeeID si 3 ile 8 arasında olan verileri hem between kullanarak hemde kullanmadan çeken iki sorguyu yazınız 
-- Employee tablosundan BirthDate'i '01.09.1958' olan verinin LastName FirstName ve HomePhone kolonlarını dönen sorguyu yazınız.
-- Employee tablosundan Title ı 'Sales Representative' olan ve HireDate i 11.15.1994 ten büyük ve eşit olan verilerin
-- Adı Soyadını tek bir kolonda(Adı Soyadı) gösterecek sorguyu yazınız.

SELECT * FROM Employees WHERE EmployeeID BETWEEN 3 AND 8
SELECT * FROM Employees WHERE EmployeeID >= 3 AND EmployeeID <= 8
SELECT FirstName , LastName , HomePhone FROM Employees WHERE BirthDate = '01.09.1958'
SELECT FirstName + ' ' + LastName AS [Adı Soyadı] FROM Employees WHERE Title = 'Sales Representative' AND HireDate >= '11.15.1994'


-- ## IN operatörü 
-- SELECT * FROM table_name WHERE column_name IN (value1, value2, ...)

SELECT * FROM Employees WHERE EmployeeID IN (1,3,5)
SELECT * FROM Employees WHERE FirstName IN ('Nancy', 'Andrew')

--5.)
-- Employee tablosundan employeeID si 1,3,5,6 olan verileri listeleyiniz. -- bunu in kullanmadan nasıl yaparız?
-- OrderDetail tablosundan miktarları 10,25,20 olan verileri listeleyiniz.

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
-- Order tablosunda ki siparişleri siparişi veren müşteri ve ilgilenen çalışanın adları 
-- ve telefon numaraları ile listeleyiniz.
-- (kolonlara uygun isimler veriniz)

SELECT e.FirstName , c.ContactName , o.OrderDate , e.HomePhone , c.Phone as 'Müşteri No'  FROM Orders o 
INNER JOIN Customers c ON o.CustomerID = c.CustomerID 
INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID 


-- ÖDEV: kendi senaryolarınızı yaratarak Northwind üzerinden 30 tane sorgu tasarlayınız.
-- NOT: öğrendiğimiz bütün kavramları kullanmaya özen gösterin.