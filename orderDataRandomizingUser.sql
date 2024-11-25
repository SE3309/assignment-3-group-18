CREATE TEMPORARY TABLE UserOrderMultiplier AS
SELECT 
    userID, 
    FLOOR(1 + RAND() * 3) AS orderMultiplier -- Each user makes 1 to 3 orders
FROM UsersWithShippingAndPayment;

INSERT INTO orders (orderDate, orderStatus, userID, shippingAddressID, paymentID)
SELECT 
    CURDATE() - INTERVAL FLOOR(RAND() * 365) DAY AS orderDate,
    CASE FLOOR(RAND() * 5)
        WHEN 0 THEN 'Pending'
        WHEN 1 THEN 'Shipped'
        WHEN 2 THEN 'Delivered'
        WHEN 3 THEN 'Cancelled'
        ELSE 'Returned'
    END AS orderStatus,
    u.userID,
    (SELECT sa.shippingAddressID 
     FROM shippingAddress sa 
     WHERE sa.userID = u.userID
     ORDER BY RAND() LIMIT 1) AS shippingAddressID,
    (SELECT pi.paymentID 
     FROM paymentInfo pi 
     WHERE pi.userID = u.userID
     ORDER BY RAND() LIMIT 1) AS paymentID
FROM UserOrderMultiplier u
JOIN (
    SELECT 1 AS repeater UNION ALL SELECT 2 UNION ALL SELECT 3
) rep ON rep.repeater <= u.orderMultiplier
ORDER BY RAND()
LIMIT 300;