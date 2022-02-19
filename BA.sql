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


















