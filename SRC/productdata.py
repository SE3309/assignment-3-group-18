from faker import Faker
import random

# Initialize Faker
fake = Faker()

# Categories and brands for variety
categories = ['Electronics', 'Furniture', 'Clothing', 'Books', 'Toys', 'Kitchen', 'Sports', 'Beauty']
brands = ['BrandA', 'BrandB', 'BrandC', 'BrandD', 'BrandE', 'BrandF', 'BrandG']

# Unique products
products = set()

# Generate unique product data
while len(products) < 200:
    name = fake.unique.catch_phrase()  # Ensure unique product names
    category = random.choice(categories)
    brand = random.choice(brands)
    price = round(random.uniform(10.00, 999.99), 2)  # Price between $10.00 and $999.99
    description = fake.text(max_nb_chars=200)  # Random product description

    products.add((name, category, brand, price, description))

# Generate SQL INSERT query
sql = "INSERT INTO product (name, category, brand, price, description) VALUES\n"
sql += ",\n".join([
    f"""('{name.replace("'", "''")}', '{category}', '{brand}', {price}, '{description.replace("'", "''")}')"""
    for name, category, brand, price, description in products
]) + ";"

# Save SQL script to a file
with open("productdata.sql", "w") as file:
    file.write(sql)
