import random

# Number of orders and products
num_orders = 810
num_products = 206

# Initialize order items
order_items = []

# Generate at least one order item for each order
for order_id in range(1, num_orders + 1):
    # Generate at least one item per order
    num_items = random.randint(1, 5)  # Each order can have 1 to 5 items
    for _ in range(num_items):
        product_id = random.randint(1, num_products)  # Random productID between 1 and 206
        quantity = random.randint(1, 10)  # Random quantity between 1 and 10
        price_per_unit = round(random.uniform(5.00, 500.00), 2)  # Random price per unit between $5.00 and $500.00
        order_items.append((order_id, product_id, quantity, price_per_unit))

# Generate SQL INSERT query
sql = "INSERT INTO orderItem (orderID, productID, quantity, pricePerUnit) VALUES\n"
sql += ",\n".join([
    f"({order_id}, {product_id}, {quantity}, {price_per_unit})"
    for order_id, product_id, quantity, price_per_unit in order_items
]) + ";"

# Save SQL script to a file
with open("orderitemdata.sql", "w") as file:
    file.write(sql)
