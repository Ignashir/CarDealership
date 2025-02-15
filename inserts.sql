Insert Into Producers (Name, CountryOfOrigin)
VALUES
    ('BMW', 'Germany'),
    ('Toyota', 'Japan'),
    ('Ford', 'USA'),
    ('Fiat', 'Italy'),
    ('Porsche', 'Germany'),
    ('Honda', 'Japan'),
    ('Mercedes-Benz', 'Germany'),
    ('Chevrolet', 'USA'),
    ('Hyundai', 'South Korea'),
    ('Volkswagen', 'Germany');

Insert Into Models (ModelName, ProducerName, TypeOfBody)
VALUES
    ('Camry', 'Toyota', 'Sedan'),
    ('F-150', 'Ford', 'Truck'),
    ('X5', 'BMW', 'SUV'),
    ('911', 'Porsche', 'Coupe'),
    ('500', 'Fiat', 'Hatchback'),
    ('Civic', 'Honda', 'Sedan'),
    ('C-Class', 'Mercedes-Benz', 'Sedan'),
    ('Silverado', 'Chevrolet', 'Truck'),
    ('Tucson', 'Hyundai', 'SUV'),
    ('Golf', 'Volkswagen', 'Hatchback');

INSERT INTO Versions (Year, ModelName, ProducerName)
VALUES
    (2022, 'Camry', 'Toyota'),
    (2023, 'F-150', 'Ford'),
    (2021, 'X5', 'BMW'),
    (2024, '911', 'Porsche'),
    (2008, '500', 'Fiat'),
    (2019, 'Civic', 'Honda'),
    (2020, 'C-Class', 'Mercedes-Benz'),
    ( 2022, 'Silverado', 'Chevrolet'),
    (2021, 'Tucson', 'Hyundai'),
    (2023, 'Golf', 'Volkswagen');

INSERT INTO Person (Pesel, Name, Surname, DateOfBirth, mail, PhoneNumber)
VALUES
    ('12345678901', 'John', 'Doe', '1985-06-15', 'john.doe@example.com', '1234567890'),
    ('23456789012', 'Jane', 'Smith', '1990-09-25', 'jane.smith@example.com', '0987654321'),
    ('34567890123', 'Alice', 'Johnson', '1988-12-10', 'alice.johnson@example.com', '2345678901'),
    ('45678901234', 'Bob', 'Williams', '1979-03-05', 'bob.williams@example.com', '3456789012'),
    ('56789012345', 'Charlie', 'Brown', '2000-07-18', 'charlie.brown@example.com', '4567890123'),
    ('67890123456', 'David', 'Jones', '1995-05-22', 'david.jones@example.com', '5678901234'),
    ('78901234567', 'Emma', 'Davis', '1993-11-09', 'emma.davis@example.com', '6789012345'),
    ('89012345678', 'Frank', 'Garcia', '1982-01-30', 'frank.garcia@example.com', '7890123456'),
    ('90123456789', 'Grace', 'Martinez', '1998-09-12', 'grace.martinez@example.com', '8901234567'),
    ('01234567890', 'Hannah', 'Taylor', '1997-04-03', 'hannah.taylor@example.com', '9012345678');

Insert Into Clients (BankNumber, Address, Pesel)
VALUES
    ('PL60102010260000042270201111', '123 Main St', '12345678901'),
    ('PL60102010260000042270201113', '789 Maple St', '34567890123'),
    ('PL60102010260000042270201114', '101 Oak St', '45678901234'),
    ('PL60102010260000042270201115', '202 Pine St', '56789012345'),
    ('PL60102010260000042270201116', '303 Birch St', '67890123456'),
    ('PL60102010260000042270201120', '707 Fir St', '01234567890');

Insert Into Workers (DateOfEmployment, Position, Pesel)
VALUES
    ('2015-04-20', 'Sales Manager', '23456789012'),
    ('2013-04-20', 'Manager', '78901234567'),
    ('2019-04-20', 'Junior Salesman', '89012345678'),
    ('2016-04-20', 'Senior Salesman', '90123456789');

Insert Into Offers (Price, FromDate, ToDate, Version)
VALUES
    (100000, '2023-01-01', '2024-12-20', 2),
    (200000, '2024-01-01', '2024-12-30', 4),
    (150000, '2023-06-01', '2025-05-31', 3),
    (80000, '2023-03-01', '2025-02-28', 5),
    (90000, '2022-09-01', '2024-08-31', 6),
    (120000, '2023-07-01', '2025-06-30', 7),
    (180000, '2024-01-01', '2025-12-31', 8),
    (160000, '2023-08-01', '2025-07-31', 9),
    (75000, '2022-11-01', '2024-10-31', 10),
    (210000, '2024-03-01', '2025-12-31', 1);


Insert Into Orders (OrderID, Date, State, PaymentStatus, DeliveryAddress, Client, Worker, Offers)
VALUES
    (1, GETDATE(), 'Pending', 0, 'Jaskowa 10a', '12345678901', '23456789012', 1),
    (2, GETDATE(), 'Pending', 0, 'Oak St 42', '34567890123', '89012345678', 3),
    (3, '2024-01-01', 'In Shipping', 0, 'Maple St 5', '45678901234', '89012345678', 4),
    (4, GETDATE(), 'Pending', 0, 'Spruce St 12', '56789012345', '90123456789', 5),
    (5, GETDATE(), 'Completed', 1, 'Cedar St 78', '67890123456', '90123456789', 6),
    (6, GETDATE(), 'Completed', 1, 'Cedar St 78', '67890123456', '90123456789', 7),
    (7, GETDATE(), 'Completed', 1, 'Main St 99', '01234567890', '90123456789', 10);

Insert Into ExtensionOptions (OptionID)
VALUES (1), (2), (3), (4), (5), (6), (7),
       (8), (9), (10), (11), (12), (13), (14),
       (15), (16), (17), (18), (19), (20), (21),
       (22), (23), (24), (25), (26);

INSERT INTO ExtraOptions (ExtraPrice, OptionID, OfferID)
VALUES
    (1000, 5, 1),
    (1500, 4, 3),
    (2000, 5, 3),
    (500, 5, 4),
    (1500, 6, 5),
    (3500, 4, 6);

INSERT INTO OfferContainsOption (OfferID, OptionID)
VALUES
    (1, 1),
    (1, 17),
    (1, 7),
    (1, 8),

    (2, 2),
    (2, 19),
    (2, 9),
    (2, 10),

    (3, 1),
    (3, 26),
    (3, 11),
    (3, 12),

    (4, 2),
    (4, 25),
    (4, 13),
    (4, 14),

    (5, 3),
    (5, 22),
    (5, 15),
    (5, 16),

    (6, 2),
    (6, 21),
    (6, 7),
    (6, 8),

    (7, 3),
    (7, 20),
    (7, 9),
    (7, 10),

    (8, 2),
    (8, 23),
    (8, 11),
    (8, 12),

    (9, 1),
    (9, 22),
    (9, 13),
    (9, 14),

    (10, 2),
    (10, 21),
    (10, 15),
    (10, 14);;

INSERT INTO PossibleOptions (OfferID, AdditionalOptionID)
VALUES
    (1, 1),
    (1, 17),
    (1, 7),
    (1, 8),
    (1, 16),
    (1, 14),
    (1, 12),
    (1, 10),

    (2, 2),
    (2, 19),
    (2, 9),
    (2, 10),
    (2, 11),
    (2, 12),
    (2, 13),
    (2, 14),
    (2, 15),

    (3, 1),
    (3, 26),
    (3, 11),
    (3, 12),
    (3, 16),
    (3, 17),
    (3, 19),
    (3, 2),
    (3, 3),
    (3, 4),

    (4, 2),
    (4, 25),
    (4, 13),
    (4, 14),

    (5, 3),
    (5, 22),
    (5, 15),
    (5, 16),

    (6, 2),
    (6, 21),
    (6, 7),
    (6, 8),

    (7, 3),
    (7, 20),
    (7, 9),
    (7, 10),

    (8, 2),
    (8, 23),
    (8, 11),
    (8, 12),

    (9, 1),
    (9, 22),
    (9, 13),
    (9, 14),

    (10, 2),
    (10, 21),
    (10, 15),
    (10, 14);

INSERT INTO SelectedExtraOptions (OrderID, AdditionalOptionID) VALUES
   (1, 5),
   (3, 4),
   (3, 5),
   (4, 5),
   (5, 6),
   (6, 4);

INSERT INTO SelectedOptions (OrderID, OptionID)
VALUES
    (1, 1),
    (1, 17),
    (1, 7),
    (1, 8),

    (2, 2),
    (2, 19),
    (2, 9),
    (2, 10),

    (3, 1),
    (3, 26),
    (3, 11),
    (3, 12),

    (4, 2),
    (4, 25),
    (4, 13),
    (4, 14),

    (5, 3),
    (5, 22),
    (5, 15),
    (5, 16),

    (6, 2),
    (6, 21),
    (6, 7),
    (6, 8),

    (7, 3),
    (7, 20),
    (7, 9),
    (7, 10);

INSERT INTO Engine (Type, Displacement, HP, Torque, LitersPer100km, OptionID)
VALUES
      ('Gasoline', 2000, 150, 250, 7.5, 1),
      ('Diesel', 2500, 200, 300, 8.0, 2),
      ('LPG', 1500, 100, 300, 3.0, 3);

INSERT INTO Coloristics (OutsideOrInside, Color, TypeOfPaint, OptionID)
VALUES
      (1, 'Red', 'Matte', 7),
      (0, 'Black', 'Solid', 8),
      (1, 'Blue', 'Metallic', 9),
      (0, 'White', 'Pearl scent', 10),
      (1, 'Green', 'Matte', 11),
      (0, 'Silver', 'Metallic', 12),
      (1, 'Yellow', 'Solid', 13),
      (0, 'Gray', 'Special-Finish', 14),
      (1, 'Orange', 'Metallic', 15),
      (0, 'Purple', 'Matte', 16);

INSERT INTO Tires (Name, Manufacturer, Type, Range, LifeSpan, OptionID)
VALUES
    ('WinterPro', 'Michelin', 'Winter', 50000, 5, 17),
    ('AllRoad', 'Bridgestone', 'All-Season', 60000, 6, 18),
    ('EcoGrip', 'Goodyear', 'Summer', 45000, 4, 19),
    ('MudMaster', 'Pirelli', 'All-Terrain', 40000, 3, 20),
    ('RainTrek', 'Continental', 'All-Season', 55000, 6, 21),
    ('UltraSport', 'Hankook', 'Performance', 35000, 7, 22),
    ('TrailBlazer', 'Yokohama', 'All-Terrain', 50000, 5, 23),
    ('SnowGrip', 'Nokian', 'Winter', 48000, 6, 24),
    ('CityRunner', 'Dunlop', 'Summer', 53000, 4, 25),
    ('SpeedX', 'Falken', 'Performance', 38000, 3, 26);

INSERT INTO Config (Version_ID, Option_ID) VALUES
    (8, 3),
    (2, 1);

INSERT INTO Cars (VINNumber, Weight, Version, Engine, Tires, InsideColor, OutsideColor, OrderID) VALUES
     ('1HGCM82633A123456', 1500, 2, 1, 17, 7, 8, 1),
     ('1HGCM82633A123457', 1400, 3, 2, 19, 9, 10, 2),
     ('1HGCM82633A123458', 1600, 4, 1, 26, 11, 12, 3),
     ('1HGCM82633A123459', 1450, 5, 2, 25, 13, 14, 4),
     ('1HGCM82633A123460', 1550, 6, 3, 22, 15, 16, 5),
     ('1HGCM82633A123461', 1500, 7, 2, 21, 7, 8, 6),
     ('1HGCM82633A123462', 1650, 8, 3, 20, 9, 10, 7);

INSERT INTO Hardware (ElementType, Characteristic, OptionID) VALUES
    ('Monitor', 'Large', 4),
    ('Speakers', 'Small', 5),
    ('Touchpad', 'Medium', 6);

INSERT INTO EquippedHardware (CarVIN, HardwareID) VALUES
    ('1HGCM82633A123456', 5),
    ('1HGCM82633A123458', 4),
    ('1HGCM82633A123458', 5),
    ('1HGCM82633A123459', 5),
    ('1HGCM82633A123460', 6),
    ('1HGCM82633A123461', 4);
