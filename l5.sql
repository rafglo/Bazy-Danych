--5.1
SELECT OrderID, SUM(UnitPrice * Quantity) as kwota, SUM(Quantity)
FROM `Order Details`
GROUP BY OrderID
ORDER BY kwota DESC
LIMIT 1;

--5.2
SELECT CustomerID, COUNT(*) AS liczba_zamowien
FROM Orders
GROUP BY CustomerID
HAVING liczba_zamowien > 20; 

--5.3
SELECT CONCAT(ROUND(SUM(Discontinued = "01") / COUNT(*) * 100, 0), "%")
FROM Products;

--5.4
SELECT Country, SUM(RIGHT(LEFT(ContactName, LOCATE(' ', ContactName) - 1), 1) = 'a') / COUNT(*) AS odsetek
FROM Customers
GROUP BY Country
ORDER BY odsetek DESC, Country
LIMIT 5;


