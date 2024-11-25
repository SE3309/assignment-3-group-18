SET SQL_SAFE_UPDATES = 0;

-- 6.1: Updates the orderStatus of all orders that are older than 6 months and still in Pending status. 
UPDATE orders
SET orderStatus = 'Cancelled'
WHERE orderID IS NOT NULL 
    AND userID IS NOT NULL
    AND orderStatus = 'Pending'
    AND orderDate < CURDATE() - INTERVAL 6 MONTH;

-- 6.2: This command assumes that a shipment for all items was recieved for a particular brand at a particular location, 
-- and appropriately updates the quantity in the inventory relation.
UPDATE inventory i
JOIN product p 
ON i.productID = p.productID
SET i.quantity = i.quantity + 50
WHERE p.brand = 'BrandG'
AND i.location = 'Tokyo';

-- 6.3: This command reduces the price of products by 20% for brands whose total sales exceed $10,000.
UPDATE product p
JOIN (
    SELECT p.brand
    FROM product p
    JOIN orderItem oi ON p.productID = oi.productID
    JOIN orders o ON oi.orderID = o.orderID
    GROUP BY p.brand
    HAVING SUM(oi.quantity * oi.pricePerUnit) > 10000
) AS eligible_brands ON p.brand = eligible_brands.brand
SET p.price = p.price * 0.80;