import random

# Predefined locations for inventory
locations = ['New York', 'Los Angeles', 'Chicago', 'Houston', 'Toronto', 'Vancouver', 'London', 'Paris', 'Berlin', 'Tokyo']

# Generate inventory data for 206 products
inventories = []

for product_id in range(1, 207):  # Loop from productID 1 to 206
    num_locations = random.randint(1, 3)  # Each product can have 1 to 3 locations
    for _ in range(num_locations):
        location = random.choice(locations)  # Randomly select a location
        quantity = random.randint(0, 1000)  # Random quantity between 0 and 1000
        restock_threshold = random.randint(50, 200)  # Random restock threshold between 50 and 200
        inventories.append((product_id, location, quantity, restock_threshold))

# Generate SQL INSERT query
sql = "INSERT INTO inventory (productID, location, quantity, restockThreshold) VALUES\n"
sql += ",\n".join([
    f"({product_id}, '{location}', {quantity}, {restock_threshold})"
    for product_id, location, quantity, restock_threshold in inventories
]) + ";"

# Save SQL script to a file
with open("inventorydata.sql", "w") as file:
    file.write(sql)

