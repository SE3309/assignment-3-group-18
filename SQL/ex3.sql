INSERT INTO Product (name, category, brand, price, description, averageRating, numberOfReviews) 
VALUES ('Laptop', 'Electronics', 'BrandX', 999.99, 'A high-performance laptop.', 4.5, 10);

INSERT INTO Product
SET name = 'Smartwatch', 
    category = 'Electronics', 
    brand = 'BrandW', 
    price = 299.99, 
    description = 'A stylish and feature-packed smartwatch.', 
    averageRating = 4.7, 
    numberOfReviews = 30;

-- created a temp table for this insert statement
INSERT INTO Product
SET name = 'Tablet',
    category = 'Electronics',
    brand = 'BrandV',
    price = (SELECT price FROM temp_table),
    description = 'A portable tablet for everyday use.',
    averageRating = 4.3,
    numberOfReviews = 20;
