from faker import Faker
import random

# Initialize Faker
fake = Faker()

# unique product reviews
product_reviews = set()

while len(product_reviews) < 1000:
    product_id = random.randint(1, 206)  # Random productID between 1 and 406
    customer_id = random.randint(1, 1000)  # Random customerID between 1 and 1000
    rating = round(random.uniform(1.0, 5.0), 1)  # Ratings between 1.0 and 5.0, rounded to 1 decimal place
    review_description = fake.text(max_nb_chars=200)  # Random review description (max 200 chars)
    date_posted = fake.date_between(start_date='-2y', end_date='today')  # Dates in the last 2 years

    # Ensure uniqueness of the (productID, customerID) pair
    product_reviews.add((product_id, customer_id, rating, review_description, date_posted))

# Generate SQL INSERT query
sql = "INSERT INTO productReview (productID, customerID, rating, reviewDescription, datePosted) VALUES\n"
sql += ",\n".join([
    f"""({product_id}, {customer_id}, {rating}, '{review_description.replace("'", "''")}', '{date_posted}')"""
    for product_id, customer_id, rating, review_description, date_posted in product_reviews
]) + ";"

# Save SQL script to a file
with open("reviewdata.sql", "w") as file:
    file.write(sql)
