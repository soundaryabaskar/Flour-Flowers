USE flour_and_flowers; 
#----------------------------------------------------------------------------------------------------------#
#Query1: Counts the total number of customers that have purchased from the business
#----------------------------------------------------------------------------------------------------------#

#Counts the total number of customers that have purchased from the business
SELECT COUNT(*) AS Num_Customers
FROM Customer;

#----------------------------------------------------------------------------------------------------------#
#Query2: 
#----------------------------------------------------------------------------------------------------------#

#Lists the premade pairs of produts sold at the shop with the product ID, the baked item and the flowers
SELECT PO.Product_ID, BG.Item_name, F.Flower_name
FROM Baked_goods BG
JOIN Products_offered PO ON PO.Baked_good_ID = BG.Baked_good_ID
JOIN Flowers F ON PO.Flower_ID = F.Flower_ID
ORDER BY Product_ID;

#Lists all the baked goods that the shop offers
SELECT Item_name
FROM Baked_goods; 

#lists all the employees that work at this shop and their job type
SELECT First_name, Last_name, Job_type
FROM Employee;

#----------------------------------------------------------------------------------------------------------#
#Query3: Counts the number of orders made by each customer
#----------------------------------------------------------------------------------------------------------#

#Counts the number of orders made by each customer
SELECT C.Name, COUNT(*) AS Num_orders
FROM Orders O
INNER JOIN Customer C ON O.Customer_ID = C.Customer_ID
GROUP BY C.Name
ORDER BY Num_orders DESC, C.Name;

#----------------------------------------------------------------------------------------------------------#
#Query4: Shows the total earnings from all baked goods and flowers individually and also combined total
#----------------------------------------------------------------------------------------------------------#

#Shows the total earnings from all baked goods and flowers individually and also combined total
SELECT SUM(F.price_per_bunch) AS Flower_earnings, SUM(BG.price) AS BG_earnings, 
	   (SUM(F.price_per_bunch)) + (SUM(BG.price)) AS Total_earnings
FROM Orders O
JOIN Flowers F ON O.Flower_order_ID = F.Flower_ID
JOIN Baked_goods BG ON O.Baked_good_order_ID = BG.Baked_good_ID
WHERE O.date >='2022-04-10' AND  O.date <='2022-04-16';

#----------------------------------------------------------------------------------------------------------#
#Query5: Shows all the Orders made by customers during a specific week
#----------------------------------------------------------------------------------------------------------#
    
#Shows all the Orders made by customers during a specific week
SELECT O.Order_ID, O.Date, C.Name
FROM Orders O
JOIN Customer C ON O.Customer_id = C.Customer_id
WHERE O.Date >='2022-04-10' AND O.Date <= '2022-04-16';

##############################################################################

#Stored procedure to delete orders that were made __ months before the current date. 
#Helps with maintaining the size of the table

DROP PROCEDURE IF EXISTS delete_history;

DELIMITER $$
CREATE PROCEDURE delete_history(IN num_months TINYINT) 
BEGIN
	SET SQL_SAFE_UPDATES = 0;
	DELETE FROM Orders 
	WHERE Date < DATE_ADD(CURDATE(), INTERVAL -num_months MONTH);
	SET SQL_SAFE_UPDATES = 1;
		
END $$

DELIMITER ;

CALL delete_history(2);

SELECT * FROM Orders;

##############################################################################

#Stored procedure that updates the storage inventory when items are purchased
DROP PROCEDURE IF EXISTS buy_supplies;

DELIMITER $$
CREATE PROCEDURE buy_supplies(IN supply_bought TINYINT, amount_bought TINYINT) 
BEGIN
	UPDATE Storage_Inventory
	SET  units_available = (units_available + amount_bought)
	WHERE Inventory_item_ID = supply_bought;
END $$

DELIMITER ;

CALL buy_supplies(1, 10);

SELECT * FROM Storage_Inventory;

##############################################################################
/*SELECT * FROM Customer;
SELECT * FROM Baked_goods;
SELECT * FROM Flowers;
SELECT * FROM Orders;
SELECT * FROM Products_offered;
SELECT * FROM Employee;
SELECT * FROM Storage_Inventory;
SELECT * FROM Supplier;
SELECT * FROM Supplies;*/
##############################################################################
