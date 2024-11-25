CREATE VIEW CustomerOrderSummary AS
SELECT 
    u.userID,
    u.name,
    u.email,
    COUNT(DISTINCT o.orderID) as total_orders,
    SUM(oi.quantity * oi.pricePerUnit) as total_spent,
    AVG(r.rating) as avg_product_rating
FROM User u
LEFT JOIN Orders o ON u.userID = o.userID
LEFT JOIN OrderItem oi ON o.orderID = oi.orderID
LEFT JOIN Review r ON u.userID = r.customerID
GROUP BY u.userID, u.name, u.email;

SELECT name, total_orders, total_spent, avg_product_rating
FROM CustomerOrderSummary
WHERE total_orders > 0
ORDER BY total_spent DESC
LIMIT 5;

CREATE VIEW ProductInventoryStatus AS
SELECT 
    p.productID,
    p.name as product_name,
    p.category,
    p.price,
    i.quantity as current_stock,
    i.restockThreshold,
    i.quantity <= i.restockThreshold as needs_restock,
    AVG(r.rating) as avg_rating,
    COUNT(r.reviewID) as review_count
FROM Product p
LEFT JOIN Inventory i ON p.productID = i.productID
LEFT JOIN Review r ON p.productID = r.productID
GROUP BY p.productID, p.name, p.category, p.price, i.quantity, i.restockThreshold;

SELECT 
    product_name, 
    current_stock, 
    restockThreshold,
    needs_restock,
    avg_rating
FROM ProductInventoryStatus
WHERE needs_restock = true
ORDER BY current_stock;
























