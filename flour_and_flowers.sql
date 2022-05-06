DROP DATABASE IF EXISTS flour_and_flowers;
CREATE DATABASE flour_and_flowers;
USE flour_and_flowers;

##################################################################################
#						  		 Creating Tables 							 	 #
##################################################################################
CREATE TABLE Customer (
    Customer_id TINYINT(3) PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    C_Phone BIGINT(10) NOT NULL,
    C_Email VARCHAR(255) NOT NULL
);

CREATE TABLE Flowers (
    Flower_ID TINYINT(3) PRIMARY KEY AUTO_INCREMENT,
    Flower_name VARCHAR(255) NOT NULL UNIQUE,
    Price_per_bunch FLOAT(4 , 2 ) NOT NULL,
    Color SET('Red', 'Pink', 'White', 'Purple', 'Blue') NOT NULL
);

CREATE TABLE Baked_goods (
    Baked_good_ID TINYINT(3) PRIMARY KEY AUTO_INCREMENT,
    Item_name VARCHAR(255) NOT NULL UNIQUE,
    Recipe VARCHAR(255) NOT NULL,
    Price FLOAT(4 , 2 ) NOT NULL,
    Best_before_date DATE NOT NULL
);

CREATE TABLE Orders (
    Order_ID TINYINT(3) PRIMARY KEY AUTO_INCREMENT,
    Flower_order_ID TINYINT(3),
    Baked_good_order_ID TINYINT(3),
    Date DATE NOT NULL,
    Customer_id TINYINT(3) NOT NULL,
    FOREIGN KEY (Flower_order_ID)
        REFERENCES Flowers (Flower_ID),
	FOREIGN KEY (Baked_good_order_ID)
        REFERENCES Baked_goods (Baked_good_ID),
    FOREIGN KEY (Customer_id)
        REFERENCES Customer (Customer_id)
);

CREATE TABLE Products_offered (
    Product_ID TINYINT(3) PRIMARY KEY AUTO_INCREMENT,
    Baked_good_ID TINYINT(3),
    Flower_ID TINYINT(3),
    FOREIGN KEY (Baked_good_ID)
        REFERENCES Baked_goods (Baked_good_ID),
    FOREIGN KEY (Flower_ID)
        REFERENCES Flowers (Flower_ID)
);

CREATE TABLE Employee (
    Employee_ID TINYINT(3) PRIMARY KEY AUTO_INCREMENT,
    First_name VARCHAR(255) NOT NULL,
    Last_name VARCHAR(255) NOT NULL,
    E_Email VARCHAR(255) NOT NULL,
    E_Phone BIGINT(10) NOT NULL,
    Manager_ID INT(5),
    Salary INT(6) NOT NULL,
    Job_Type SET('Manager', 'Baker', 'Packager', 'Customer Service', 'Owner') NOT NULL
);

CREATE TABLE Supplies (
    Supply_ID TINYINT(3) PRIMARY KEY AUTO_INCREMENT,
    Supply_name VARCHAR(255) NOT NULL,
    Supply_price FLOAT(4 , 2 ) NOT NULL,
    Supply_type SET('Baking', 'Flower', 'Packaging') NOT NULL
);

CREATE TABLE Supplier (
    Supplier_ID TINYINT(3) PRIMARY KEY AUTO_INCREMENT,
    Supplier_name VARCHAR(255) NOT NULL,
    S_Phone BIGINT(10) NOT NULL,
    S_Email VARCHAR(255) NOT NULL,
    Supply_ID TINYINT(3) NOT NULL,
    Store_Rep TINYINT(3) NOT NULL,
	FOREIGN KEY (Supply_ID)
        REFERENCES Supplies (Supply_ID),
	FOREIGN KEY (Store_Rep)
		REFERENCES Employee (Employee_ID)
);

CREATE TABLE Storage_Inventory (
    Inventory_item_ID TINYINT(3) PRIMARY KEY AUTO_INCREMENT,
    Supply_ID TINYINT(3) NOT NULL,
    Supply_Name VARCHAR(255) NOT NULL,
    Supply_Type SET('Baking', 'Flower', 'Packaging') NOT NULL,
    Units_available INT NOT NULL,
    FOREIGN KEY (Supply_ID)
        REFERENCES Supplies (Supply_ID)
);

##################################################################################
#						    Inserting Dummy Data							 	 #
##################################################################################

INSERT INTO Customer (Customer_id, Name, C_Phone, C_Email) VALUES
(1, 'Palak', 1234567890, 'palak@gmail.com'),
(2, 'Varsha', 1234567890, 'varsha@gmail.com'),
(3, 'Sandra', 1234567890, 'sandra@gmail.com'),
(4, 'Anchal', 1234567890, 'anchal@gmail.com'),
(5, 'Leslie', 1234567890, 'leslie@pawneeparks.gov'),
(6, 'Ann', 1234567890, 'ann@stjosephhospital.com'),
(7, 'April', 1234567890, 'neutralmilkhotellover78@hotmail.com'),
(8, 'Andy', 1234567890, 'burtmacklin@gmail.com'),
(9, 'Ben', 1234567890, 'benwyatt@pawneeparks.gov'),
(10, 'Chris', 1234567890, 'christraeger@umich.edu'),
(11, 'Tom', 1234567890, 'tom@tomsbistro.com'),
(12, 'Ron', 1234567890, '18237195@gmail.com'),
(13, 'Donna', 1234567890, 'treatyoself5@gmail.com'),
(14, 'Jerry', 1234567890, 'garrynotjerry@gmail.com'),
(15, 'Jess', 1234567890, 'hellogiggles@gmail.com'),
(16, 'Nick', 1234567890, 'nicholasmiller@gmail.com'),
(17, 'Schmidt', 1234567890, 'schmidt@associatedstrat.com'),
(18, 'Winston', 1234567890, 'winniethebish@gmail.com'),
(19, 'Cece', 1234567890, 'cece@cecesboys.com'),
(20, 'Aly', 1234567890, 'aly74@gmail.com');

INSERT INTO Baked_goods (Baked_good_ID, Item_name, Recipe, Price, Best_before_date) VALUES
(1, 'cupcakes', 'eggs+flour+sugar', '8.99', '2022-04-12'),
(2, 'brownies', 'eggs+flour+sugar+dark chocolate chips', '12.99', '2022-04-12'),
(3, 'cookies', 'eggs+flour+sugar+toppings(dark chocolate chips, white chocolate chips, icing, raisins, macademia nuts)', '6.99', '2022-04-12'),
(4, 'blondies', 'eggs+flour+sugar+white chocolate chips', '13.99', '2022-04-12'),
(5, 'cake pops', 'eggs+flour+sugar', '8.99', '2022-04-12'),
(6, 'muffins', 'eggs+flour+sugar+toppings(dark chocolate chips, blueberries)', '18.99', '2022-04-12'),
(7, 'pie', 'eggs+flour+sugar+filling(apple, blueberry, raspberry)', '21.99', '2022-04-12'),
(8, 'eclairs', 'eggs+flour+sugar+dark chocolate chips', '14.99', '2022-04-12'),
(9, 'mini bundt cakes', 'eggs+flour+sugar+icing', '15.99', '2022-04-12'),
(10, 'chocolate croissants', 'eggs+flour+sugar+dark chocolate chips', '15.99', '2022-04-12');

INSERT INTO Flowers (Flower_ID, Flower_name, Price_per_bunch, Color) VALUES 
(1, 'Lilies', 5.99, 'Purple'),
(2, 'Daisies', 8.99, 'White'),
(3, 'Peonies', 4.99, 'Pink'),
(4, 'Baby Breath', 6.99, 'White'),
(5, 'Hibiscus', 9.99, 'Pink'),
(6, 'Roses', 5.99, 'Red'),
(7, 'Sunflowers', 10.99, 'Blue'),
(8, 'Hydrangeas', 8.99, 'Purple'),
(9, 'Forget-Me-Nots', 3.99, 'Blue'),
(10, 'Tulips', 10.99, 'Pink');

INSERT INTO Orders (Order_ID, Flower_order_ID, Baked_good_order_ID, Date, Customer_id) VALUES
(1, 6, 1, '2022-04-20', 1),
(2, 2, 2, '2022-04-3', 2),
(3, 1, 3, '2022-04-5', 3),
(4, 3, 3, '2022-04-12', 4),
(5, 10, 7, '2022-04-4', 5),
(6, 5, 8, '2022-04-15', 5),
(7, 6, 9, '2022-04-22', 6),
(8, 1, 2, '2022-04-13', 7),
(9, 7, 3, '2022-04-25', 8),
(10, 8, 5, '2022-04-11', 9),
(11, 3, 3, '2022-04-4', 10),
(12, 3, 1, '2022-04-14', 11),
(13, 1, 1, '2022-04-18', 12),
(14, 6, 4, '2022-04-19', 12),
(15, 4, 8, '2022-04-16', 13),
(16, 1, 8, '2022-04-21', 13),
(17, 2, 3, '2022-04-23', 13),
(18, 7, 3, '2022-04-23', 14),
(19, 10, 1, '2022-04-11', 15),
(20, 6, 5, '2022-04-2', 16),
(21, 1, 1, '2022-04-7', 17),
(22, 1, 3, '2022-04-12', 18),
(23, 4, 6, '2022-04-5', 18),
(24, 10, 3, '2022-04-20', 19),
(25, 3, 10, '2022-04-16', 20),
(26, 3, 10, '2022-01-16', 20);

INSERT INTO Products_offered (Product_ID, Baked_good_ID, Flower_ID) VALUES 
(1, 2, 1),
(2, 1, 1),
(3, 2, 2),
(4, 3, 9),
(5, 4, 3),
(6, 5, 5),
(7, 6, 7),
(8, 7, 1),
(9, 1, 10),
(10, 10, 4),
(11, 9, 6),
(12, 3, 7),
(13, 4, 2),
(14, 5, 9),
(15, 6, 4),
(16, 7, 10),
(17, 8, 3),
(18, 9, 6),
(19, 8, 5),
(20, 10, 8);

INSERT INTO Employee (Employee_ID, First_name, Last_name, E_Phone, E_Email, Manager_ID, Salary, Job_type) VALUES 
(1, 'Michael', 'Scott', 1234567890, 'prisonmike@gmail.com', null, 100000, 'Owner'),
(2, 'Jim', 'Halpert', 1234567890, 'jimothy@gmail.com', null, 80000, 'Manager'),
(3, 'Pam', 'Beasley', 1234567890, 'artsypam@gmail.com', 10012, 50000, 'Customer Service'),
(4, 'Erin', 'Hannon', 1234567890, 'helloerin@gmail.com', 10012, 50000, 'Customer Service'),
(5, 'Dwight', 'Schrute', 1234567890, 'schrutefarms@gmail.com', 10001, 80000, 'Baker'),
(6, 'Andy', 'Bernard', 1234567890, 'cornellacapellaandy@gmail.com', 10001, 80000, 'Baker'),
(7, 'Angela', 'Martin', 1234567890, 'catluver222@gmail.com', 10001, 80000, 'Baker'),
(8, 'Oscar', 'Martinez', 1234567890, 'finerthings@gmail.com', 10001, 80000, 'Packager');

INSERT INTO Supplies(Supply_ID, Supply_name, Supply_price, Supply_type) VALUES
(1, 'Dark Chocolate Chips', 3.99, 'Baking'),
(2, 'Oil', 5.99, 'Baking'),
(3, 'Flour', 2.99, 'Baking'),
(4, 'Eggs', 5.99, 'Baking'),
(5, 'Sugar', 3.99, 'Baking'),
(6, 'White Chocolate Chips', 3.99, 'Baking'),
(7, 'Icing', 2.99, 'Baking'),
(8, 'Macademia Nuts', 6.99, 'Baking'),
(9, 'Raisins', 5.99, 'Baking'),
(10, 'Blueberries', 4.99, 'Baking'),
(11, 'Apple', 6.99, 'Baking'),
(12, 'Raspberry', 3.99, 'Baking'),
(13, 'Lillies', 12.99, 'Flower'),
(14, 'Daisies', 14.99, 'Flower'),
(15, 'Peonies', 13.99, 'Flower'),
(16, 'Baby Breath', 15.99, 'Flower'),
(17, 'Hibiscus', 18.99, 'Flower'),
(18, 'Roses', 9.99, 'Flower'),
(19, 'Sunflowers', 10.99, 'Flower'),
(20, 'Hydrangeas', 12.99, 'Flower'),
(21, 'Forget-Me-Nots', 8.99, 'Flower'),
(22, 'Tulips', 14.99, 'Flower'),
(23, 'Baskets', 9.99, 'Packaging'),
(24, 'Cards', 4.99, 'Packaging'),
(25, 'Confetti', 3.99, 'Packaging');

INSERT INTO Storage_Inventory (Inventory_item_ID, Supply_id, Supply_Name, Supply_Type, units_available) VALUES 
(1, 1, 'Dark Chocolate Chips', 'Baking', 25),
(2, 2, 'Oil', 'Baking', 20),
(3, 3, 'Flour', 'Baking', 20),
(4, 4, 'Eggs', 'Baking', 30),
(5, 5, 'Sugar', 'Baking', 20),
(6, 6, 'White Chocolate Chips', 'Baking', 25),
(7, 7, 'Icing', 'Baking', 40),
(8, 8, 'Macademia Nuts', 'Baking', 25),
(9, 9, 'Raisins', 'Baking', 15),
(10, 10, 'Blueberries', 'Baking', 10),
(11, 11, 'Apple', 'Baking', 20),
(12, 12, 'Raspberry', 'Baking', 25),
(13, 13, 'Lillies', 'Flower', 25),
(14, 14, 'Daisies', 'Flower', 25),
(15, 15, 'Peonies', 'Flower', 25),
(16, 16, 'Baby Breath', 'Flower', 25),
(17, 17, 'Hibiscus', 'Flower', 25),
(18, 18, 'Roses', 'Flower', 25),
(19, 19, 'Sunflowers', 'Flower', 25),
(20, 20, 'Hydrangeas', 'Flower', 25),
(21, 21, 'Forget-Me-Nots', 'Flower', 25),
(22, 22, 'Tulips', 'Flower', 25),
(23, 23, 'Baskets', 'Packaging', 30),
(24, 24, 'Cards', 'Packaging', 50),
(25, 25, 'Confetti', 'Packaging', 30);

INSERT INTO Supplier (Supplier_ID, Supplier_Name, S_Email, S_Phone, Supply_ID, Store_Rep) VALUES
(1, 'walmart', 'walmart@gmail.com', 1234567890, 1, 2),
(2,  'BobTheBuilder', 'bob@gmail.com', 1234567890, 13, 2),
(3,  'Costco', 'costco@gmail.com', 1234567890, 23, 2);
