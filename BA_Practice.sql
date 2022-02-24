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




--#####################---20.02.2022 (Ders2)---####################



-- Customers tablosundan CompanyName'i 'Hu' ile başlayan kayıtları çekiniz.
-- Customers tablosunda ConmpanyName'i 'A' ile başlayan ContactName'i 'o' ile biten verileri dönen sorguyu yazınız 
-- Employee tablosundan FirstNameinin içinde 'e' harfi olan kayıtları dönünüz.


SELECT * FROM Customers
WHERE CompanyName LIKE 'Hu%'
SELECT * FROM Customers
WHERE CompanyName LIKE 'A%' AND ContactName LIKE '%o'
SELECT * FROM Employees
WHERE FirstName LIKE '%e%'


-- psychology okuyan çalışanlarım hangileri? (adı soyadı tek bir kolonda yazsın)

SELECT FirstName + ' ' + LastName as [Adı Soyadı]
FROM Employees 
WHERE Notes LIKE '%psychology%' 


-- ## DISTINCT tekrarlı verilerden sadece bir tanesini getirir.

SELECT DISTINCT Title from Employees 

-- Hangi ülkelere ihracat yapıyorum ?.
-- Kaç farklı ülkeye ihracat yapıyorum..? (COUNT())


SELECT DISTINCT Country FROM Customers
SELECT COUNT(DISTINCT Country) FROM Customers


-- ## TOP 
SELECT * FROM Employees
SELECT TOP 2 * FROM Employees
SELECT TOP 50 PERCENT * FROM Employees


--En Pahalı 5 ürünüm nedir? (ProductName, UnitPrice)

SELECT TOP 5 ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC

--En pahalı ürünümün adı,fiyatı ve kategorisinin adı nedir?

SELECT TOP 1 p.ProductName, p.UnitPrice, c.CategoryName  FROM
Products p
INNER JOIN Categories c ON c.CategoryID = p.CategoryID 
ORDER BY UnitPrice DESC

-- Order tablosunda ki siparişleri siparişi veren müşteri ve ilgilenen çalışanın adları ve telefon numaraları ile listeleyiniz.

SELECT 
 	o.OrderID as [Order No], 
 	c.CompanyName as [Customer Name], 
 	c.Phone as [Customer Tel No], 
 	e.FirstName + ' ' + e.LastName as [Employee Name],
 	e.HomePhone as [Employee Home No]
FROM Orders o 
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID 




--Geciken siparişlerimin tarihi, müşterisinin adını listeleyelim.

SELECT o.OrderDate, c.CompanyName FROM Orders o 
INNER JOIN Customers c ON o.CustomerID = c.CustomerID 
WHERE o.RequiredDate < o.ShippedDate 

SELECT o.OrderDate, c.CompanyName FROM Orders o 
INNER JOIN Customers c ON o.CustomerID = c.CustomerID 
WHERE DATEDIFF(DAY, o.RequiredDate, o.ShippedDate) > 0 



--Satışlarımı kaç günde teslim etmişim? (OrderID, gün sayısını, büyükten küçüğe sıralayalım.)
--Çalışanlarımın Ad, Soyad ve Yaşları (GETDATE(), (c# DateTime.Now))

SELECT 
	OrderID, 
	DATEDIFF(DAY, OrderDate, ShippedDate) AS [Total Day]
FROM Orders
ORDER BY 2 DESC

SELECT 
	FirstName + ' ' + LastName AS [Adı Soyadı],
	DATEDIFF(YEAR, BirthDate, GETDATE()) AS [Yaşı]
FROM Employees
ORDER BY [Yaşı] DESC


--Şirketim, şimdiye kadar ne kadar ciro yapmış..? (SUM, ROUND)

SELECT SUM(UnitPrice*Quantity*(1-Discount)) AS [Toplam Ciro]
FROM [Order Details]


--Ortalama Ürün Fiyatım nedir? (AVG)

SELECT AVG(UnitPrice) FROM Products
 

-- Hangi çalışanım hangi çalışanıma bağlı? (çalışanın adı, müdürünün adı)

SELECT 
	e.FirstName [Çalışan], 
	e2.FirstName [Reports To] 
FROM Employees e 
INNER JOIN Employees e2 ON e.ReportsTo = e2.EmployeeID

SELECT 
	e.FirstName [Çalışan], 
	e2.FirstName [Reports To] 
FROM Employees e 
LEFT JOIN Employees e2 ON e.ReportsTo = e2.EmployeeID 


-- Her kategoride kaç tane ürün var? (CategoryName - Count)

SELECT c.CategoryName, COUNT(p.ProductName) FROM Products p 
INNER JOIN Categories c ON c.CategoryID = p.CategoryID 
GROUP BY c.CategoryName 




-- Hangi siparişten ne kadar kazanmışım ? (orderID, toplam kazanç)

SELECT * FROM [Order Details]
ORDER BY OrderID 


SELECT 
	OrderID, 
	ROUND(SUM(UnitPrice * Quantity * (1 - Discount)),2) AS [Total Price] 
FROM [Order Details]
GROUP BY OrderID 
ORDER BY 2 DESC

--ÖDEV

--1) 'Ürün Adı', 'Ürün Fiyatı', 'Ortalama Satış Fiyatı' tablosunu oluşturunuz.
--2) Çalışanlarım ne kadarlık satış yapmışlar? (Gelir bazında) ('Çalışanın Adı', 'Toplam Satış Tutarı' kolonlarını bekliyorum).
--3) Ürünlere göre satışım nasıl? (Ürün-Adet-Gelir Raporu)('Ürün Sayısı', 'Ürün Adedi', 'Toplam Tutar' kolonlarını bekliyorum).
--4) 1997 yılında en çok satış yapan çalışanımın ID,Ad soyad, Toplam Satış Tutarı tablosunu oluşturunuz.




------------------######---24.02.2022---######----------------------------
--Ödev 1

SELECT * FROM [Order Details] od Order by ProductID

SELECT 
	p.ProductName AS [Ürünün Adı], 
	p.UnitPrice AS [Asıl Fiyatı], 
	ROUND(AVG(od.UnitPrice * (1 - od.Discount)),2) AS [Satış Fiyatı]  
FROM Products p 
LEFT JOIN [Order Details] od ON od.ProductID  = p.ProductID
GROUP BY p.ProductName, p.UnitPrice  
ORDER BY p.ProductName


--INSERT INTO Products (ProductName, CategoryID) VALUES ('Deneme', 1)

SELECT * FROM [Order Details] od 
WHERE od.ProductID IN (SELECT ProductID FROM Products WHERE ProductName = 'Deneme')

SELECT * FROM [Order Details] od 
INNER JOIN Products p ON p.ProductID = od.ProductID 
WHERE p.ProductName = 'Deneme'

SELECT * FROM [Order Details] od 
WHERE od.ProductID IN (SELECT ProductID FROM Products WHERE ProductName = 'Chai' OR ProductName = 'Chang')

SELECT * FROM [Order Details] od 
WHERE od.ProductID = CAST((SELECT ProductID FROM Products WHERE ProductName = 'Deneme') AS NUMERIC)


-- Ödev 2

SELECT 
	e.FirstName + ' ' + e.LastName AS [Adı Soyadı],
	ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)),2) AS [Sepet Toplamları]
FROM Employees e 
INNER JOIN Orders o ON o.EmployeeID = e.EmployeeID 
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY e.FirstName + ' ' + e.LastName
ORDER BY [Adı Soyadı]


-- Ödev 3


SELECT 
	p.ProductName AS Adı, 
	SUM(od.Quantity) AS Adet, 
	SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS Gelir 
FROM Products p
INNER JOIN [Order Details] od ON od.ProductID = p.ProductID 
GROUP BY p.ProductName 
ORDER BY Adet DESC



-- Ödev4


SELECT 
	e.EmployeeID,
	e.FirstName,
	SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS Satış
FROM [Order Details] od 
INNER JOIN Orders o ON o.OrderID = od.OrderID 
INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
WHERE YEAR(o.OrderDate) = 1997 
--WHERE DATEPART(YEAR, o.OrderDate) = 1997 
GROUP BY e.EmployeeID, e.FirstName






-- Müşterilerimin içinde en uzun isimli müşteri (harf sayısı) (LEN --> String Function)

SELECT MAX(LEN(CompanyName)) FROM Customers


-- Hangi kargo şirketine toplam ne kadar ödeme yapmışım? (Şirket id, name , toplam ödeme)


SELECT 
	s.ShipperID,
	s.CompanyName AS [Şirket Adı],
	SUM(o.Freight) AS [Ödenen Ücret]
FROM Shippers s 
INNER JOIN Orders o ON o.ShipVia = s.ShipperID 
GROUP BY s.ShipperID, s.CompanyName 



-- Ocak ayında en çok sattığım ürünün, ürün adı, kategorisi, satış tutarı (fiyat)


SELECT TOP 1 WITH TIES
	p.ProductName AS [Ürün Adı], 
	c.CategoryName AS [Kategori Adı],
	ROUND(SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)),2) AS [Toplam Satış Tutarı],
	SUM(od.Quantity) [Toplam Miktar]
FROM Orders o
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
INNER JOIN Products p ON p.ProductID = od.ProductID
INNER JOIN Categories c ON c.CategoryID = p.CategoryID
WHERE MONTH(o.OrderDate) = 1
GROUP BY p.ProductName, c.CategoryName
ORDER BY [Toplam Miktar] DESC


 --1000 Adetten fazla satılan ürünler nelerdir?

SELECT 
	p.ProductName,
	SUM(od.Quantity) AS [Miktar]
FROM [Order Details] od 
INNER JOIN Products p ON p.ProductID = od.ProductID 
GROUP BY p.ProductName
HAVING SUM(od.Quantity) > 1000 


 --50 den fazla satış yapan çalışanlarımı bulunuz. (çalışanın adı soyadı, satış miktarı)

SELECT 
	e.FirstName Adı,
	COUNT(e.FirstName) AS Adet
FROM Orders o 
INNER JOIN Employees e ON e.EmployeeID = o.EmployeeID 
GROUP BY e.FirstName
HAVING COUNT(e.FirstName) > 50
ORDER BY Adet DESC



-- Fiyat Ortalamanın altında bir fiyata sahip ürünlerimin adı ve fiyatı nedir? (ipucu SUB query)


SELECT AVG(UnitPrice) FROM Products

SELECT 
	ProductName,
	UnitPrice
FROM Products
WHERE UnitPrice < (SELECT AVG(UnitPrice) FROM Products)
ORDER BY UnitPrice 


--Ödev
--1) -- Ürünlerde ki Discontinued kolonundan yararlanarak Ürünleri Satışının durdurulup durdurulmadığını listeleyiniz 
--(Duranlarda 'Durduruldu', Devam edenlerde 'Devam Ediyor' yazmalı)

--2) Hangi Müşterilerim hiç sipariş vermemiş..? (JOIN kullanmadan çözünüz!)


