--             KULLANILAN DOCKER KOMUTLARI


--docker ps                    						-> Çalışan container listesi
--docker ps -a                 						-> tüm container listesi
--docker image ls              						-> image listesi
--docker rmi [id||name]        						-> image sil
--docker rm [id||name]         						-> container sil
--docker stop [id||name]       						-> container durdur
--docker start [id|name]       						-> container başlat 
--docker cp .\[filename] [id]:[path]/[filename] 	-> Lokal bilgisayardan container'a dosya kopyalar
--docker run -d --name bilgeadam-sql -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=1q2w3e4R!" -p 12000:1433 -d mcr.microsoft.com/mssql/server

--Kullanılan Şifre : 1q2w3e4R!
--SQL : Structured Query Language

--SQL SERVER default olarak 1433 portunda çalışır
SELECT 2
SELECT 3 * (3 + 4) AS Result
SELECT 1.0 * 23 / 5

--UNION kullanımında tüm sorgu çıktılarındaki kolon sayıları ve sıralı veri türleri aynı olmalı
--UNION DISTICT ederek çıktı üretir: DISTINCT bakınız: aşağıdaki örnekler

SELECT 'Can' AS 'FirstName', 'PERK' AS 'LastName', 33 AS 'Age'
UNION
SELECT 'İsmail', 'KARA', 25
UNION 
SELECT 'Ata', 'TAN', 25
UNION
SELECT 'Kaan', 'ÇALIŞKAN', 25
UNION
SELECT 'Esengül', 'ÖZKUL', 25
UNION
SELECT 'Berk', 'ÖZERDOĞAN', 25
UNION ALL
SELECT 'Berk', 'ÖZERDOĞAN', 25
UNION ALL
SELECT 'Esengül', 'ÖZKUL', 25
--UNION ALL DISTINC özelliği sonraki tablo için kapatır

DROP DATABASE Northwind 
RESTORE DATABASE Northwind FROM DISK = N'/home/Northwind.bak' WITH MOVE 'Northwind' TO '/var/opt/mssql/data/Northwind.mdf', MOVE 'Northwind_Log' TO '/var/opt/mssql/data/Northwind_Log.ldf', REPLACE
----- MİLAT
--RDBMS -> Relational DataBase Management Service
--DML : Data Manipulation Language
--CRUD Operations:
---- CREATE, READ, UPDATE, DELETE

USE Northwind 
-- SELECT [kolon adı], [kolon adi], [kolon adi] AS [gösterilecek başlık] FROM [tabloadı]
-- WHERE [kolon adı] [operatör] [değer] 
SELECT * FROM Products
SELECT * FROM Employees
SELECT * FROM Customers
SELECT FirstName, LastName FROM Employees
SELECT FirstName + ' ' + LastName AS [Full Name] FROM Employees
SELECT CompanyName, ContactName, Country, Phone FROM Customers
SELECT CompanyName, ContactName, Phone FROM Customers WHERE Country = 'Sweden'
SELECT FirstName, LastName, City FROM Employees WHERE Country = 'USA'
SELECT FirstName, LastName, BirthDate FROM Employees WHERE BirthDate < '1960-01-01'
SELECT FirstName, LastName FROM Employees WHERE Country = 'USA' AND City = 'Tacoma'

SELECT p.ProductName AS Name, p.UnitPrice AS Price, p.UnitsInStock AS Stock FROM Products AS p 

--FOREIGN KEY : Verinin referans bilgisi alt tabloda, esas bilgisi üst tabloda olan değere Foreign Key denir. 
-- !!ÖNEMLİ!! -> Foreign Key olan kolon kendi tablosunda benzersiz olmalıdır (unique)

--PRIMARY KEY: Bir kolonun bir tabloda benzersiz şekilde veri tutması özelliğine (unique) Primary Key denir. Ör: TC Kimlik No


-- SELECT [kolon adı], [kolon adi], [kolon adi] AS [gösterilecek başlık] FROM [tabloadı]
-- INNER JOIN [diğer tablo ad] ON [ilişki kolonu] = [diğer ilişki kolonu]
-- WHERE [kolon adı] [operatör] [değer] 
-- ORDER BY [kolon adı veya alias] 
SELECT 
	p.ProductName AS Name, 
	p.UnitPrice AS Price, 
	p.UnitsInStock AS Stock, 
	c.CategoryName AS Category, 
	s.CompanyName AS Company, 
	s.Country  
FROM Products AS p 
INNER JOIN Categories AS c ON p.CategoryID = c.CategoryID 
INNER JOIN Suppliers AS s ON p.SupplierID = s.SupplierID 
WHERE p.CategoryID = 1
ORDER BY Name

SELECT p.ProductName AS Name, p.UnitPrice * p.UnitsInStock AS [Total Price] FROM Products AS p 
ORDER BY 2 DESC -- 2 demek 2. sıradaki kolon demek

--GÜN 2

SELECT * FROM Orders
WHERE CustomerID = 'ALFKI'

SELECT od.OrderID, p.ProductName, p.UnitPrice,  od.UnitPrice, od.Quantity, od.Discount 
FROM [Order Details] od
INNER JOIN Products p ON od.ProductID = p.ProductID 
WHERE p.UnitPrice <> od.UnitPrice 

-- Sipariş Detayında ürünün fiyatı, satış fiyatı ve diğer bilgileri, sipariş tarihi
SELECT p.ProductName, p.UnitPrice,  od.UnitPrice, od.Quantity, od.Discount, o.OrderDate  
FROM [Order Details] od
INNER JOIN Products p ON od.ProductID = p.ProductID 
INNER JOIN Orders o ON od.OrderID = o.OrderID 
WHERE od.OrderID = 10250

--Sipariş Detayındaki indirim bilgileri
SELECT 
	UnitPrice * Quantity AS Orijinal, 
	UnitPrice * Quantity * (1 - Discount) AS Indirimli,
	UnitPrice * Quantity * Discount AS Indirim
FROM [Order Details] od 
WHERE OrderID = 10250
--AGGREATE FUNCTIONS -> COUNT, SUM, AVG, MIN, MAX

--Toplam kazanç
SELECT SUM(UnitPrice * Quantity * (1 - Discount)) AS Summary -- ROUND(kolon, 2) 2 basamağa yuvarlar
FROM [Order Details] od 
WHERE OrderID = 10250

--Siparişlerdeki ortalama kazanç nedir
SELECT AVG(UnitPrice * Quantity * (1 - Discount)) AS Average FROM [Order Details]

-- 1-n relation (1 veriye karşılık n adet verinin tutulması) => 1 Customer'ın n tane siparişi olabilir
--Kaç adet sipariş var
SELECT COUNT(0)
FROM Orders o 
INNER JOIN Customers c ON c.CustomerID = o.CustomerID 

--GROUP BY
--Müşterilerin çoktan aza sipariş verme sayısı
SELECT c.CustomerID, COUNT(0) AS [Order Count]
FROM Orders o 
INNER JOIN Customers c ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID 
ORDER BY [Order Count] DESC

--En çok sipariş veren 10 müşteri
SELECT TOP 10 c.CustomerID, COUNT(0) AS [Order Count]
FROM Orders o 
INNER JOIN Customers c ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID 
ORDER BY [Order Count] DESC

--En çok sipariş veren 6 müşteri
SELECT TOP 6 WITH TIES c.CustomerID, COUNT(0) AS [Order Count]
FROM Orders o 
INNER JOIN Customers c ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID 
ORDER BY [Order Count] DESC --8 kayıt döner çünkü 6. satıra ait veriye eşit başka 2 satır daha var

-------------       -----------  
--ALFKI | 6         BOTTM | 9         
--ANATR | 4         BERGS | 8         
--ANTON | 3         ALFKI | 6         
--...               ...
--...               ...
--BOTTM | 9         ANTON | 3

SELECT TOP 3 c.CustomerID, c.ContactName, c.Phone, COUNT(0) AS [Order Count]
FROM Orders o 
INNER JOIN Customers c ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.ContactName, c.Phone 
ORDER BY [Order Count] DESC

--İndirimlerden ne kadar zarar elde edildi
SELECT 
	SUM(UnitPrice * Quantity) AS [Total Amount], 
	SUM(UnitPrice * Quantity * Discount) AS [Total Discount],
	SUM(UnitPrice * Quantity * Discount) / SUM(UnitPrice * Quantity) * 100 AS Ratio -- KEKO Yöntem
FROM [Order Details]

-- TODO: Ay ay ne kadar indirim yapılmış

--HAVING
-- en çok alışveriş yapan ve alışveriş sayısın 20'den çok olan ilk 10 müşteri
SELECT TOP 10 c.CustomerID, COUNT(0) AS [Order Count]
FROM Orders o 
INNER JOIN Customers c ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID 
HAVING COUNT(0) > 20 -- AGGREATE FUNCTION için filtreleme yapabilmek için kullanılır
ORDER BY [Order Count] DESC

-- Toplam alışverişi 5000 lirayı geçmeyen müşterilerin telefon numaraları ve isimleri
SELECT 
	c.CompanyName AS Name, 
	c.Phone AS Phone,
	ROUND(SUM(od.UnitPrice * od.Quantity * (1-od.Discount)), 2) AS Summary
FROM Orders o
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.CompanyName, c.Phone
HAVING SUM(od.UnitPrice * od.Quantity * (1-od.Discount)) < 5000
ORDER BY 3 ASC

---JOIN Türleri
SELECT p.ProductName, c.CategoryName FROM Categories c 
INNER JOIN Products p ON c.CategoryID = p.CategoryID -- Sadece JOIN de olur
ORDER BY c.CategoryID DESC

SELECT p.ProductName, c.CategoryName FROM Categories c 
LEFT JOIN Products p ON c.CategoryID = p.CategoryID -- LEFT OUTER JOIN de olur
ORDER BY c.CategoryID DESC

SELECT p.ProductName, c.CategoryName FROM Categories c 
RIGHT JOIN Products p ON c.CategoryID = p.CategoryID -- RIGHT OUTER JOIN
ORDER BY c.CategoryID DESC

SELECT p.ProductName, c.CategoryName FROM Categories c 
FULL OUTER JOIN Products p ON c.CategoryID = p.CategoryID 
ORDER BY c.CategoryID DESC

SELECT p.ProductName, c.CategoryName FROM Categories c 
CROSS JOIN Products p 
ORDER BY c.CategoryID DESC

--DATETIME FONKSIYONLARI
SELECT DATEPART(YEAR, GETDATE())
SELECT DATEDIFF(MONTH, '1988-02-08', GETDATE())
SELECT DATEDIFF(MONTH, '2017-05-08', GETDATE()) / 4 ---> Ah seni bekleyeli belki 14 bahar geçti :D
SELECT FORMAT(GETDATE(), 'dd MMMM yyyy')
SELECT DATEADD(MONTH, 3, GETDATE()) 
SELECT DATEADD(SECOND, 30, GETDATE()) 
SELECT DATEADD(DAY, 3, '2022-01-01')
-- Intervals -> YEAR, MONTH, DAY, HOUR, MINUTE, SECOND, MILLISECOND

--Personel Yaşları
SELECT FirstName, LastName, DATEDIFF(YEAR, BirthDate, GETDATE()) AS Age  FROM Employees 

--En yaşlı çalışan
SELECT TOP 1 WITH TIES FirstName, LastName, DATEDIFF(YEAR, BirthDate, GETDATE()) AS Age  
FROM Employees 
ORDER BY Age DESC

SELECT TOP 1 WITH TIES FirstName, LastName, DATEDIFF(YEAR, BirthDate, GETDATE()) AS Age  
FROM Employees 
ORDER BY BirthDate

--LIKE 
SELECT ContactName, CompanyName FROM Customers c 
WHERE ContactName LIKE 'mar%'
ORDER BY ContactName

SELECT ContactName, CompanyName FROM Customers c 
WHERE ContactName LIKE '%ler'
ORDER BY ContactName

--CASE WHEN
SELECT 
	FirstName, 
	LastName, 
	CASE Country 
		WHEN 'USA' THEN 'Amerika' 
		WHEN 'UK' THEN 'İngiltere' 
		ELSE 'Tanımsız' 
	END AS Country 
FROM Employees
--Kritik Seviye 10
SELECT 
	ProductName,
	CASE WHEN UnitsInStock > 10 THEN 'Stokta Var'
		 WHEN UnitsInStock BETWEEN 1 AND 10 THEN 'Kritik Seviye'
		 ELSE 'Yok'
	END AS Status
FROM Products 

SELECT 
	CASE TitleOfCourtesy 
		WHEN 'Mr.' THEN 'Male'
		WHEN 'Mrs.' THEN 'Female'
		WHEN 'Ms.' THEN 'Female'
		ELSE 'Unknown'
	END AS Gender,
	FirstName + ' ' + LastName AS FullName 
FROM Employees

--COALESCE
SELECT 
	FirstName, 
	LastName,
	COALESCE(Region, City, Country, 'No Region') AS Region
FROM Employees

--GÜN 3

SELECT '           Mustafa Kemal Atatürk          '
SELECT LEN('           Mustafa Kemal Atatürk          ')
SELECT TRIM('           Mustafa Kemal Atatürk          ')
SELECT LTRIM('           Mustafa Kemal Atatürk          ')
SELECT RTRIM('           Mustafa Kemal Atatürk          ')
SELECT LEN(TRIM('           Mustafa Kemal Atatürk          ')) 
SELECT SUBSTRING('Mustafa Kemal Atatürk', 0, 14) 

SELECT mka.value AS Name, c.CategoryName FROM STRING_SPLIT('Mustafa Kemal Atatürk', ' ') mka
CROSS JOIN Categories c 

-- Database uyumluluk versiyonunu String Split in çalışabileceği versiyona yükselltik (Backup dosyası 100 sayılı uyumluluk modunda idi)
ALTER DATABASE Northwind SET COMPATIBILITY_LEVEL = 150

SELECT name, compatibility_level FROM sys.databases -- sistemimizdeki veritabanı uyumluluk seviyesi kontrolü için

SELECT TRANSLATE('2*[3+4]/{7-2}', '[]{}', '()()'); -- denedik translate değilmiş :D

--Tekilleştirme amaçlı yazılır
SELECT DISTINCT
	p.ProductName,
	o.OrderDate 
FROM [Order Details] od 
INNER JOIN Orders o ON od.OrderID = od.OrderID 
INNER JOIN Products p ON p.ProductID = od.ProductID 

SELECT p.ProductName, o.OrderDate, COUNT(0) AS Count
FROM [Order Details] od 
INNER JOIN Orders o ON od.OrderID = od.OrderID 
INNER JOIN Products p ON p.ProductID = od.ProductID 
WHERE o.OrderDate BETWEEN '1996-12-01' AND '1996-12-31' AND p.ProductID = 3
GROUP BY p.ProductName, o.OrderDate 

----
SELECT p.ProductName, p.UnitPrice, p.UnitsInStock  FROM Products p 
INNER JOIN Categories c ON c.CategoryID = p.CategoryID 
WHERE c.CategoryName LIKE 'Cond%';


--Sub Query
SELECT p.ProductName, p.UnitPrice, p.UnitsInStock  FROM Products p  
WHERE p.CategoryID = (SELECT TOP 1 c.CategoryId FROM Categories c WHERE c.CategoryName LIKE 'Cond%')


--IN Kullanımı
SELECT p.ProductName, p.UnitPrice, p.UnitsInStock  FROM Products p  
WHERE p.CategoryID = 1 OR p.CategoryID = 2

SELECT p.ProductName, p.UnitPrice, p.UnitsInStock  FROM Products p
WHERE p.CategoryID IN (1, 2)

-- EXIST
-- STOKTA TÜKENMİŞ ÜRÜNLERİ KATEGORİLERİ
SELECT c.CategoryName 
FROM Categories c 
WHERE EXISTS (SELECT p.ProductName FROM Products AS p 
			  WHERE p.CategoryID = c.CategoryID AND p.UnitsInStock = 0);

SELECT c.CategoryName 
FROM Categories c 
WHERE CategoryID IN (SELECT DISTINCT p.CategoryID FROM Products p
					 WHERE p.UnitsInStock = 0)

-- ROLL UP
SELECT p.ProductName, DATEPART(YEAR, o.OrderDate) AS Year, DATEPART(MONTH, o.OrderDate) AS Month, SUM(od.UnitPrice * od.Quantity) AS Total 
FROM Orders o 
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID 
INNER JOIN Products p ON p.ProductID = od.ProductID
GROUP BY p.ProductName, DATEPART(YEAR, o.OrderDate), DATEPART(MONTH, o.OrderDate)
WITH ROLLUP 
ORDER BY ProductName

-- CUBE
SELECT p.ProductName, DATEPART(YEAR, o.OrderDate) AS Year, DATEPART(MONTH, o.OrderDate) AS Month, SUM(od.UnitPrice * od.Quantity) AS Total 
FROM Orders o 
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID 
INNER JOIN Products p ON p.ProductID = od.ProductID
GROUP BY p.ProductName, DATEPART(YEAR, o.OrderDate), DATEPART(MONTH, o.OrderDate)
WITH CUBE 
ORDER BY ProductName, Year, Month

--GROUPING SETS
SELECT p.ProductName, DATEPART(YEAR, o.OrderDate) AS Year, DATEPART(MONTH, o.OrderDate) AS Month, SUM(od.UnitPrice * od.Quantity) AS Total 
FROM Orders o 
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID 
INNER JOIN Products p ON p.ProductID = od.ProductID
GROUP BY GROUPING SETS (p.ProductName, (DATEPART(YEAR, o.OrderDate), DATEPART(MONTH, o.OrderDate)))
ORDER BY ProductName 


SELECT NULL AS ProductName,  NULL AS Year, NULL AS Month, SUM(UnitPrice * Quantity) Total FROM [Order Details] od
UNION
SELECT p.ProductName, DATEPART(YEAR, o.OrderDate) AS Year, DATEPART(MONTH, o.OrderDate) AS Month, SUM(od.UnitPrice * od.Quantity) AS Total 
FROM Orders o 
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID 
INNER JOIN Products p ON p.ProductID = od.ProductID
WHERE p.ProductID = 1 AND DATEPART(YEAR, o.OrderDate) = 1996 
GROUP BY p.ProductName, DATEPART(YEAR, o.OrderDate), DATEPART(MONTH, o.OrderDate)
UNION
SELECT p.ProductName, DATEPART(YEAR, o.OrderDate) AS Year, NULL AS Month, SUM(od.UnitPrice * od.Quantity) AS Total 
FROM Orders o 
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID 
INNER JOIN Products p ON p.ProductID = od.ProductID
WHERE p.ProductID = 1 AND DATEPART(YEAR, o.OrderDate) = 1996 
GROUP BY p.ProductName, DATEPART(YEAR, o.OrderDate)
-- ... ve diğer super master keko çözüm


SET STATISTICS TIME OFF
SET STATISTICS IO OFF


--- ROW_NUMBER & OVER
SELECT ROW_NUMBER () OVER(ORDER BY SUM(od.UnitPrice * od.Quantity)) AS OrderNo,  p.ProductName, DATEPART(YEAR, o.OrderDate) AS Year, SUM(od.UnitPrice * od.Quantity) AS Total 
FROM Orders o 
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID 
INNER JOIN Products p ON p.ProductID = od.ProductID
WHERE DATEPART(YEAR, o.OrderDate) = 1996 
GROUP BY p.ProductName, DATEPART(YEAR, o.OrderDate)


SELECT 
	ROW_NUMBER () OVER(PARTITION BY DATEPART(YEAR, o.OrderDate) ORDER BY p.ProductName) AS OrderNo,  
	p.ProductName, 
	DATEPART(YEAR, o.OrderDate) AS Year, 
	SUM(od.UnitPrice * od.Quantity) AS Total 
FROM Orders o 
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID 
INNER JOIN Products p ON p.ProductID = od.ProductID
GROUP BY p.ProductName, DATEPART(YEAR, o.OrderDate)

--CRUD : Create, Read, Update, Delete
--CREATE : Oluşturma -> SQL => INSERT

INSERT INTO Categories (CategoryName, Description) VALUES ('Electronics', 'Devices that are works with electricty')
INSERT INTO Categories (CategoryName, Description) VALUES ('Furniture', 'Wooden stuffs')

SELECT TOP 5 * FROM Suppliers ORDER BY SupplierID DESC
SELECT TOP 5 * FROM Categories ORDER BY CategoryID DESC

SELECT c.CategoryName, COUNT(0) AS Count FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID
GROUP BY CategoryName
ORDER BY Count

SELECT p.ProductName, p.UnitPrice, s.CompanyName, s.Phone FROM Products p
LEFT JOIN Suppliers s ON p.SupplierID = s.SupplierID 

INSERT INTO Products (ProductName, CategoryID, UnitPrice, UnitsInStock)
VALUES ('Trust Microphone', 9, 110, 24)

INSERT INTO Products (ProductName, CategoryID, UnitPrice, UnitsInStock)
VALUES ('EPSON Projector', 9, 820, 9)

INSERT INTO Products (ProductName, CategoryID, SupplierID, UnitPrice, UnitsInStock)
VALUES ('LINGO Chair', 10, 30, 340, 120)

INSERT INTO Suppliers (CompanyName, ContactName, City, Country, Phone)
VALUES ('Perktronics Ltd.', 'Can Perk', 'Ankara', 'Turkey', '+90 555 444 55 55')

SELECT * FROM Products WHERE CategoryID IN (9, 10)
------
-- UPDATE
UPDATE Products SET SupplierID = 31 WHERE ProductID = 78
UPDATE Products SET SupplierID = 30 WHERE ProductID = 79

UPDATE Products SET SupplierID = 30 WHERE SupplierID = 31

DELETE FROM Suppliers WHERE SupplierID = 31
-- ÖNEMLİ !!!!
-- DELETE ve UPDATE sorgularında, kesinkes WHERE kullanılmalıdır!!!!!
-- Aksi halde geri dönülmez veri kayıpları yaşanabilir

-- NO NO NO NO !!!!
--UPDATE Products SET UnitPrice = 5 
--DELETE FROM [Order Details]
--DELETE FROM Products
--USE master
--DROP DATABASE Northwind

SELECT * FROM Employees


UPDATE Employees SET BirthDate = DATEADD(YEAR, 30, BirthDate), 
					 HireDate = DATEADD(YEAR, 30, HireDate)

UPDATE Employees SET BirthDate = DATEADD(YEAR, 5, BirthDate), 
					 HireDate = DATEADD(YEAR, 5, HireDate)

UPDATE Employees SET HireDate = DATEADD(YEAR, -1, HireDate)

SELECT * FROM Employees
SELECT TOP 20 * FROM Orders

SELECT OrderDate, ShippedDate
FROM Orders
WHERE EmployeeID = 9
--KISS
UPDATE Orders SET OrderDate = DATEADD(YEAR, 25, OrderDate),
				  ShippedDate = DATEADD(YEAR, 25, ShippedDate),
				  RequiredDate = DATEADD(YEAR, 25, ShippedDate)

UPDATE Orders SET OrderDate = DATEADD(YEAR, -2, OrderDate),
				  ShippedDate = DATEADD(YEAR, -2, ShippedDate)

DECLARE @CID char(5)
SET @CID = 'ERNSH'
INSERT INTO Orders (CustomerID, EmployeeID, OrderDate, ShipCity, ShipCountry)
VALUES (@CID, 
		9, 
		GETDATE(), 
		(SELECT City FROM Customers WHERE CustomerID = @CID), 
		(SELECT Country FROM Customers WHERE CustomerID = @CID))

SELECT TOP 1 * FROM Orders ORDER BY OrderID DESC

INSERT INTO [Order Details]
VALUES (11078, 78, 110, 1, 0),
	   (11078, 79, 803.6, 1, 0.02),
	   (11078, 80, 340, 2, 0),
	   (11078, 62, 49.3, 6, 0),
	   (11078, 76, 18, 1, 0)

SELECT p.ProductName, ROUND(SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)), 2) AS Summary 
FROM [Order Details] od
INNER JOIN Products p ON p.ProductID = od.ProductID
WHERE od.OrderID = 11078
GROUP BY p.ProductName

UPDATE [Order Details] SET UnitPrice = 820 WHERE OrderID = 11078 AND ProductID = 79

SELECT 
	CONCAT(FORMAT(o.OrderDate, 'yyMMdd'), o.OrderID) AS [Invoice Number],
	ROUND(SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)), 2) AS [Summary]
FROM Orders o
INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
WHERE o.CustomerID = 'ERNSH'
GROUP BY CONCAT(FORMAT(o.OrderDate, 'yyMMdd'), o.OrderID)
ORDER BY [Invoice Number] DESC

SELECT * FROM Products
ORDER BY ProductID
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY

SELECT ContactName, Phone, 'C' AS Type
INTO Contacts --!!! BAKIN BURASI ÇOK ÖNEMLİ :D
FROM Customers
UNION
SELECT FirstName + ' ' + LastName, HomePhone, 'E'
FROM Employees

SELECT * FROM Contacts WHERE Type = 'E'