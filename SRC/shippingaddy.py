from faker import Faker
import random

# Initialize Faker
fake = Faker()

# unique shipping addresses
shipping_addresses = set()

while len(shipping_addresses) < 500:
    user_id = random.randint(1, 1000)  # Randomly select a userID between 1 and 1000
    address_line1 = fake.street_address()
    address_line2 = fake.secondary_address() if random.random() < 0.5 else ""  # 50% chance of having a secondary address
    city = fake.city()
    state = fake.state()
    postal_code = fake.postcode()
    country = fake.country()

    # Ensure uniqueness of the address combination
    shipping_addresses.add((user_id, address_line1, address_line2, city, state, postal_code, country))

# Generate SQL INSERT query
sql = "INSERT INTO shippingAddress (userID, addressLine1, addressLine2, city, state, postalCode, country) VALUES\n"
sql += ",\n".join([
    f"""({user_id}, '{address_line1.replace("'", "''")}', '{address_line2.replace("'", "''")}', '{city.replace("'", "''")}', '{state.replace("'", "''")}', '{postal_code}', '{country.replace("'", "''")}')"""
    for user_id, address_line1, address_line2, city, state, postal_code, country in shipping_addresses
]) + ";"

# Save SQL script to a file
with open("shippingaddressdata.sql", "w") as file:
    file.write(sql)
