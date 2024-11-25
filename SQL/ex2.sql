CREATE TABLE User (
    userID INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    PRIMARY KEY (userID)
);


CREATE TABLE ShippingAddress (
    shippingAddressID INT NOT NULL AUTO_INCREMENT,
    userID INT NOT NULL,
    addressLine1 VARCHAR(255) NOT NULL,
    addressLine2 VARCHAR(255),
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    postalCode CHAR(10) NOT NULL,
    country VARCHAR(50) NOT NULL,
    PRIMARY KEY (shippingAddressID),
    FOREIGN KEY (userID) REFERENCES User(userID)
);


CREATE TABLE Product (
    productID INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    brand VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    description TEXT,
    PRIMARY KEY (productID)
);


CREATE TABLE Inventory (
    inventoryID INT NOT NULL auto_increment,
    productID INT NOT NULL,
    location varchar(50) NOT NULL,
    quantity INT NOT NULL,
    restockThreshold INT NOT NULL, 
    PRIMARY KEY (inventoryID), 
    FOREIGN KEY (productID) REFERENCES Product(productID)
);

CREATE TABLE Orders (
    orderID INT NOT NULL AUTO_INCREMENT,    
    orderDate DATE NOT NULL,
    orderStatus VARCHAR(50) NOT NULL,
    userID INT NOT NULL,
    shippingAddressID INT NOT NULL,
    paymentID INT,
    PRIMARY KEY (orderID),
    FOREIGN KEY (userID) REFERENCES User(userID) ON DELETE CASCADE,
    FOREIGN KEY (shippingAddressID) REFERENCES ShippingAddress(shippingAddressID),
    FOREIGN KEY (paymentID) REFERENCES PaymentInfo(PaymentID)
);


CREATE TABLE OrderItem ( 
orderItemID INT NOT NULL auto_increment, 
    orderID INT NOT NULL,  
    productID INT NOT NULL,  
    quantity INT NOT NULL,  
    pricePerUnit DECIMAL(10, 2) NOT NULL,  
    PRIMARY KEY (orderItemID),  
    FOREIGN KEY (orderID) REFERENCES Orders(orderID), 
    FOREIGN KEY (productID) REFERENCES Product(productID) 
);

CREATE TABLE Review (
    productID INT NOT NULL,
    customerID INT NOT NULL,
    rating DECIMAL(2, 1) NOT NULL CHECK (rating BETWEEN 1 AND 5),
    reviewDescription TEXT,
    datePosted DATE NOT NULL,
    PRIMARY KEY (productID, customerID),
    FOREIGN KEY (productID) REFERENCES Product(productID),
    FOREIGN KEY (customerID) REFERENCES User(userID)
);

CREATE TABLE PaymentInfo (
    paymentID INT NOT NULL AUTO_INCREMENT,
    userID INT NOT NULL,
    paymentMethod VARCHAR(50) NOT NULL,
    accountNumber VARCHAR(50) NOT NULL,
    cardNumber VARCHAR(50) NOT NULL,
    expirationDate date NOT NULL,
    CVV VARCHAR(3) NOT NULL,
    PRIMARY KEY (paymentID),
    FOREIGN KEY (userID) REFERENCES User(userID)
);

