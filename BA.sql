--             KULLANILAN DOCKER KOMUTLARI


--docker ps                    -> Çalışan container listesi
--docker ps -a                 -> tüm container listesi
--docker image ls              -> image listesi
--docker rmi [id||name]        -> image sil
--docker rm [id||name]         -> container sil
--docker stop [id||name]       -> container durdur
--docker start [id|name]       -> container başlat 
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
