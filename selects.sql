
-- Wyświetl samochody wyprodukowane przez niemieckie przedsiębiorstwa z wersja z roku 2000, posortowane od najczęściej zamawianych do najrzadziej (JOIN)

SELECT ModelName, COUNT(*) as NumberOfOrders FROM Cars
JOIN Versions ON Cars.Version = Versions.Version_ID
LEFT JOIN Producers ON Versions.ProducerName = Producers.Name
WHERE Producers.CountryOfOrigin = 'Germany' --AND Versions.Year = 2000
GROUP BY ModelName
ORDER BY NumberOfOrders DESC;

-- Wyswiel nazwiska osób, które zakupiły samochód o wadze poniżej 1,5 tony z oponami wyprodukowanymi przez Michellin (JOIN)

SELECT Person.Name, Surname FROM Person
RIGHT JOIN Clients on Person.Pesel = Clients.Pesel
JOIN Orders on Clients.Pesel = Orders.Client
JOIN Cars on Orders.OrderID = Cars.OrderID
JOIN Tires on Cars.Tires = Tires.OptionID
WHERE Tires.Manufacturer = 'Michelin' --AND Cars.Weight < 1.5;
GROUP BY Person.Name, Surname

-- Wyswietl ile aut wyprodukowanych przez poszczególne przedsiębiorstwa, zostało zamówione w kolorze łososiowym i kosztuje wiecej niz 100 000. (VIEW, AGGREG)
CREATE VIEW OrdersPrice AS
    SELECT Orders.OrderID, Orders.Date, COALESCE(SUM(ExtraPrice), 0) + SUM(Price) as PriceSum, Workers.Pesel as Worker FROM Orders
    JOIN Offers on Orders.Offers = Offers.OfferID
    LEFT JOIN SelectedExtraOptions ON Orders.OrderID = SelectedExtraOptions.OrderID
    LEFT JOIN ExtraOptions ON SelectedExtraOptions.AdditionalOptionID = ExtraOptions.ExtraOptionID
    JOIN Workers on Orders.Worker = Workers.Pesel
    GROUP BY Orders.OrderID, Workers.Pesel, Orders.Date;

SELECT * FROM OrdersPrice


SELECT * FROM Versions -- COUNT(*) as 'Number of white colored cars, over 100k'
RIGHT JOIN Cars ON Versions.Version_ID = Cars.Version
JOIN Coloristics ON Cars.OutsideColor = Coloristics.OptionID
JOIN OrdersPrice on Cars.OrderID = OrdersPrice.OrderID
WHERE OrdersPrice.PriceSum > 100000 AND Coloristics.Color = 'White'
-- GROUP BY Versions.ProducerName

DROP VIEW OrdersPrice

-- Wyświetl ilość zamówionych aut, i srednią cene dla każdego producenta

SELECT Versions.ProducerName as Producer, SUM(OrdersPrice.PriceSum) as TotalAmount, AVG(OrdersPrice.PriceSum) as AveragePerCar, COUNT(*) as AmountOfCarsSold FROM Orders
JOIN OrdersPrice ON Orders.OrderID = OrdersPrice.OrderID
JOIN Offers ON Orders.Offers = Offers.OfferID
JOIN Versions ON Offers.Version = Versions.Version_ID
WHERE Orders.State = 'Completed' AND Orders.PaymentStatus = 'TRUE'
GROUP BY Versions.ProducerName
ORDER BY COUNT(*)

-- Most common tire for each Model

SELECT ModelName, Manufacturer, Type, Amount FROM (
                  SELECT
                      Versions.ModelName,
                      Tires.Manufacturer,
                      Tires.Type,
                      COUNT(*) as Amount,
                      ROW_NUMBER() over (PARTITION BY Versions.ModelName ORDER BY COUNT(*) DESC) as Ranking
                  FROM Orders O
                           JOIN Offers ON O.Offers = Offers.OfferID
                           JOIN Versions ON Offers.Version = Versions.Version_ID
                           JOIN SelectedOptions S ON O.OrderID = S.OrderID
                           JOIN Tires ON Tires.OptionID = S.OptionID
                  GROUP BY Versions.ModelName, Tires.Manufacturer, Tires.Type
              ) as Ranki
WHERE Ranking = 1


-- Show all price ranges for all offered cars (minimal configuration, maximal configuration) (SUBQUERY)

SELECT
    CONCAT(Versions.ProducerName, ' ', Versions.ModelName, ' ', Versions.Year) as Name,
    Price as MinPrice ,
    (SELECT SUM(MaxPrice.PRICEMAX) as MaxConfig
     FROM (SELECT COALESCE(MAX(ExtraPrice), 0) as PRICEMAX FROM Offers
        JOIN ExtraOptions on Offers.OfferID = ExtraOptions.OfferID
        JOIN Engine on Engine.OptionID = ExtraOptions.ExtraOptionID
        WHERE Offers.OfferID = o.OfferID
        UNION
        SELECT COALESCE(MAX(ExtraPrice), 0) as PRICEMAX FROM Offers
        JOIN ExtraOptions on Offers.OfferID = ExtraOptions.OfferID
        JOIN Tires on Tires.OptionID = ExtraOptions.ExtraOptionID
        WHERE Offers.OfferID = o.OfferID
        UNION
        SELECT COALESCE(MAX(ExtraPrice), 0) as PRICEMAX FROM Offers
        JOIN ExtraOptions on Offers.OfferID = ExtraOptions.OfferID
        JOIN Coloristics on Coloristics.OptionID = ExtraOptions.ExtraOptionID
        WHERE Offers.OfferID = o.OfferID AND Coloristics.OutsideOrInside = 0
        UNION
        SELECT COALESCE(MAX(ExtraPrice), 0) as PRICEMAX FROM Offers
        JOIN ExtraOptions on Offers.OfferID = ExtraOptions.OfferID
        JOIN Coloristics on Coloristics.OptionID = ExtraOptions.ExtraOptionID
        WHERE Offers.OfferID = o.OfferID AND Coloristics.OutsideOrInside = 1
        UNION
        SELECT COALESCE(SUM(COALESCE(HardwarePrices.HardwarePriceMax, 0)), 0) as PRICEMAX
        FROM (SELECT MAX(ExtraPrice) as HardwarePriceMax
        FROM Offers
        JOIN ExtraOptions on Offers.OfferID = ExtraOptions.OfferID
        JOIN Hardware on Hardware.OptionID = ExtraOptions.ExtraOptionID
        WHERE Offers.OfferID = o.OfferID
        GROUP BY ElementType) as HardwarePrices
        ) as MaxPrice) + Price as MaxConfigPrice
FROM Offers o
LEFT JOIN Versions ON o.Version = Versions.Version_ID

-- Show earnings/statistics for each employee
SELECT Name,
       Surname,
       YEAR(Orders.Date) AS OrderYear,
       SUM(SummedEarnings) as TotalEarnings,
       AVG(SummedEarnings) as AverageEarnPerOrder
FROM Person
         JOIN Workers ON Workers.Pesel = Person.Pesel
         JOIN Orders ON Workers.Pesel = Orders.Worker
         JOIN (
    SELECT Year(Date) as YearEarns, Worker, SUM(PriceSum) as SummedEarnings FROM OrdersPrice
    GROUP BY Date, Worker
) as WorkerEarn ON WorkerEarn.Worker = Workers.Pesel
GROUP BY Name, Surname, Orders.Date
ORDER BY Name, Surname, OrderYear;

-- List the employees amount of orders for each year (SUBQUERY)
-- Dynamic approach
DECLARE @years NVARCHAR(MAX) = ''
DECLARE @sql NVARCHAR(MAX) = ''

SELECT @years = STRING_AGG(QUOTENAME(dt), ', ')
FROM (SELECT DISTINCT YEAR(Date) as dt FROM Orders) as OY;

SET @sql = '
SELECT
    Name,
    Surname, ' + @years + '
FROM (
    SELECT Name, Surname, YEAR(Orders.Date) AS OrderYear FROM Person
    JOIN Workers ON Workers.Pesel = Person.Pesel
    JOIN Orders ON Workers.Pesel = Orders.Worker
) AS SourceTable
PIVOT (
    COUNT(OrderYear)
    FOR OrderYear IN (' + @years + ')
) AS PivotTable
ORDER BY Name, Surname;
';
PRINT @sql
EXEC sp_executesql @sql;