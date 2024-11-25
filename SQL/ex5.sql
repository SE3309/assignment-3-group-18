-- Simple Select to get all Products from BRANDG
SELECT *
FROM product
WHERE brand = 'BrandG';

-- Users who ordered in the month of January 2024
SELECT u.name, o.orderDate
FROM user u
JOIN Orders o ON u.userID = o.userID
WHERE o.orderDate BETWEEN '2024-01-01' AND '2024-01-31';

-- Total Number of orders placed by each user
SELECT u.name AS UserName, COUNT(*) AS TotalOrders
FROM User u
JOIN Orders o ON u.userID = o.userID
GROUP BY u.name;

-- Products with their ratings and number of reviews where number of reviews >= 10
SELECT p.productID, p.name, p.category, p.brand, AVG(r.rating) AS AverageRating, COUNT(r.rating) AS NumberOfReviews
FROM Product p
LEFT JOIN Review r ON p.productID = r.productID
GROUP BY p.productID, p.name, p.category, p.brand
HAVING COUNT(r.rating) >= 10;

-- USERS who left atleast 5 review
SELECT u.name, u.email, u.userID
FROM User u
WHERE EXISTS (SELECT 1 FROM Review r WHERE r.customerID = u.userID GROUP BY r.customerID HAVING COUNT(r.reviewID) >= 5);

-- Products that have been ordered >= 5 different times
SELECT p.name, p.brand, COUNT(DISTINCT oi.orderID) AS NumberOfOrders
FROM Product p
JOIN OrderItem oi ON p.productID = oi.productID
GROUP BY p.name, p.brand
HAVING COUNT(DISTINCT oi.orderID) >= 5;


-- Categorizing products based on their stock from a particular location
SELECT p.name AS ProductName, i.location, i.quantity, i.restockThreshold,
	CASE 
		WHEN i.quantity < i.restockThreshold THEN 'Low Stock'
		WHEN i.quantity >= i.restockThreshold THEN 'In Stock'
	END AS Status
FROM Inventory i
JOIN Product p ON i.productID = p.productID
WHERE i.location = 'Tokyo';








