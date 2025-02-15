Create Table Producers(
    Name varchar(100) primary key,
    CountryOfOrigin varchar(60)
);

Create Table Models(
    ModelName varchar(100) NOT NULL ,
    ProducerName varchar(100) NOT NULL ,
    TypeOfBody varchar(100) check (TypeOfBody in ('Sedan', 'Hatchback', 'SUV', 'Crossover', 'Coupe',
                                                  'Convertible', 'Truck', 'Minivan', 'Wagon', 'Sports Car')),
    FOREIGN KEY (ProducerName) REFERENCES Producers(Name) ON DELETE CASCADE ON UPDATE CASCADE ,
    PRIMARY KEY (ModelName, ProducerName)
);

Create Table Versions(
    Version_ID INTEGER IDENTITY(1, 1) primary key,
    Year smallint Not Null ,
    ModelName varchar(100),
    ProducerName varchar(100),
    FOREIGN KEY (ModelName, ProducerName) REFERENCES Models(ModelName, ProducerName) ON DELETE SET NULL ON UPDATE CASCADE
);

Create Table Person(
    Pesel char(11) primary key,
    Name varchar(50) NOT NULL ,
    Surname varchar(50) NOT NULL ,
    DateOfBirth DATE,
    mail varchar(50) NOT NULL ,
    PhoneNumber varchar(20) NOT NULL
);

Create Table Clients(
    BankNumber char(34),
    Address varchar(200),
    Pesel char(11) UNIQUE NOT NULL,
    FOREIGN KEY (Pesel) REFERENCES Person(Pesel) ON DELETE CASCADE,
    PRIMARY KEY (Pesel)
);

Create Table Workers(
    DateOfEmployment DATE,
    Position varchar(50) check (Position in ('Sales Manager', 'Manager', 'Junior Salesman', 'Mid Salesman', 'Senior Salesman')),
    Pesel char(11) UNIQUE NOT NULL,
    FOREIGN KEY (Pesel) REFERENCES Person(Pesel) ON DELETE CASCADE,
    PRIMARY KEY (Pesel)
);

Create Table Offers(
   OfferID INTEGER IDENTITY(1, 1) PRIMARY KEY,
   Price MONEY NOT NULL,
   FromDate DATE,
   ToDate DATE,
   Version INTEGER,
   FOREIGN KEY (Version) REFERENCES Versions(Version_ID) ON DELETE CASCADE
);

Create Table Orders(
    OrderID INTEGER primary key,
    Date DATE NOT NULL,
    State varchar(50) check (State in ('Pending', 'Processing', 'In Shipping', 'Delivered', 'Completed')),
    PaymentStatus bit, -- Payed/Not Payed
    DeliveryAddress varchar(50),
    Client char(11) NOT NULL ,
    FOREIGN KEY (Client) REFERENCES Clients(Pesel),
    Worker char(11),
    FOREIGN KEY (Worker) REFERENCES Workers(Pesel) ON DELETE NO ACTION ON UPDATE CASCADE ,
    Offers INTEGER NOT NULL ,
    FOREIGN KEY (Offers) REFERENCES Offers(OfferID)
);


Create Table ExtensionOptions(
    OptionID INTEGER NOT NULL primary key
);

Create Table Config(
    Version_ID INTEGER NOT NULL,
    Option_ID INTEGER NOT NULL,
    FOREIGN KEY (Version_ID) REFERENCES Versions(Version_ID) ON DELETE CASCADE,
    FOREIGN KEY (Option_ID) REFERENCES ExtensionOptions(OptionID) ON DELETE CASCADE,
    PRIMARY KEY (Version_ID, Option_ID)
)

Create Table OfferContainsOption(
    OfferID INTEGER NOT NULL,
    OptionID INTEGER NOT NULL,
    FOREIGN KEY (OfferID) REFERENCES Offers(OfferID) ON DELETE CASCADE,
    FOREIGN KEY (OptionID) REFERENCES ExtensionOptions(OptionID) ON DELETE CASCADE ,
    PRIMARY KEY (OfferID, OptionID)
);

Create Table PossibleOptions(
    OfferID INTEGER NOT NULL ,
    AdditionalOptionID INTEGER NOT NULL ,
    FOREIGN KEY (OfferID) REFERENCES Offers(OfferID) ON DELETE CASCADE,
    FOREIGN KEY (AdditionalOptionID) REFERENCES ExtensionOptions(OptionID) ON DELETE CASCADE,
    PRIMARY KEY (OfferID, AdditionalOptionID)
);

Create Table SelectedOptions(
    OrderID INTEGER NOT NULL ,
    OptionID INTEGER NOT NULL ,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (OptionID) REFERENCES ExtensionOptions(OptionID) ON DELETE CASCADE,
    PRIMARY KEY (OrderID, OptionID)
);

Create Table ExtraOptions(
    ExtraOptionID INTEGER IDENTITY(1, 1) PRIMARY KEY,
    ExtraPrice MONEY NOT NULL,
    OptionID INTEGER,
    FOREIGN KEY (OptionID) REFERENCES ExtensionOptions(OptionID) ON DELETE CASCADE,
    OfferID INTEGER,
    FOREIGN KEY (OfferID) REFERENCES Offers(OfferID) ON DELETE CASCADE
);

Create Table SelectedExtraOptions(
    OrderID INTEGER NOT NULL ,
    AdditionalOptionID INTEGER,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (AdditionalOptionID) REFERENCES ExtraOptions(ExtraOptionID) ON DELETE CASCADE,
    PRIMARY KEY (OrderID, AdditionalOptionID)
);

Create Table Engine(
    Type varchar(50) check (Type in ('Gasoline', 'Diesel', 'LPG')),
    Displacement smallint NOT NULL,
    HP smallint NOT NULL,
    Torque smallint NOT NULL,
    LitersPer100km FLOAT(2),
    OptionID INTEGER NOT NULL,
    FOREIGN KEY (OptionID) REFERENCES ExtensionOptions(OptionID) ON DELETE CASCADE,
    PRIMARY KEY (OptionID)
);

Create Table Coloristics(
    OutsideOrInside bit NOT NULL,
    Color varchar(50) check (Color in ('Red', 'Black', 'Blue', 'Green', 'Yellow', 'White', 'Silver', 'Gray', 'Orange', 'Purple')),
    TypeOfPaint varchar(50) check (TypeOfPaint in ('Matte', 'Pearl scent', 'Solid', 'Metallic', 'Special-Finish')),
    OptionID INTEGER NOT NULL,
    FOREIGN KEY (OptionID) REFERENCES ExtensionOptions(OptionID) ON DELETE CASCADE,
    PRIMARY KEY (OptionID)
);

Create Table Tires(
    Name varchar(50) NOT NULL,
    Manufacturer varchar(50) NOT NULL,
    Type varchar(50) check (Type in ('Winter', 'All-Season', 'Summer', 'All-Terrain', 'Performance')),
    Range INTEGER NOT NULL,
    LifeSpan tinyint NOT NULL ,
    OptionID INTEGER NOT NULL,
    FOREIGN KEY (OptionID) REFERENCES ExtensionOptions(OptionID) ON DELETE CASCADE,
    PRIMARY KEY (OptionID)
);

Create Table Cars(
    VINNumber char(17) PRIMARY KEY,
    Weight smallint,
    Version INTEGER,
    FOREIGN KEY (Version) REFERENCES Versions(Version_ID) ON DELETE NO ACTION ON UPDATE NO ACTION,
    Engine INTEGER,
    FOREIGN KEY (Engine) REFERENCES Engine(OptionID) ON DELETE NO ACTION ON UPDATE NO ACTION,
    Tires INTEGER ,
    FOREIGN KEY (Tires) REFERENCES Tires(OptionID) ON DELETE NO ACTION ON UPDATE NO ACTION,
    InsideColor INTEGER,
    FOREIGN KEY (InsideColor) REFERENCES Coloristics(OptionID) ON DELETE SET NULL ON UPDATE NO ACTION,
    OutsideColor INTEGER,
    FOREIGN KEY (OutsideColor) REFERENCES Coloristics(OptionID) ON DELETE NO ACTION ON UPDATE NO ACTION,
    OrderID INTEGER UNIQUE,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

Create Table Hardware(
    ElementType varchar(50) check (ElementType in ('Monitor', 'TouchPad', 'Speakers')),
    Characteristic varchar(50) check (Characteristic in ('None', 'Small', 'Medium', 'Large')),
    OptionID INTEGER NOT NULL,
    FOREIGN KEY (OptionID) REFERENCES ExtensionOptions(OptionID) ON DELETE CASCADE,
    PRIMARY KEY (OptionID)
);

Create Table EquippedHardware(
    CarVIN char(17),
    HardwareID INTEGER NOT NULL,
    FOREIGN KEY (CarVIN) REFERENCES Cars(VINNumber) ON DELETE CASCADE ,
    FOREIGN KEY (HardwareID) REFERENCES Hardware(OptionID) ON DELETE CASCADE,
    PRIMARY KEY (CarVIN, HardwareID)
);
