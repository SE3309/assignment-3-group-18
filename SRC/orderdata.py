from faker import Faker
import random
from datetime import date, timedelta

# Initialize Faker
fake = Faker()

# Order status options
order_statuses = ['Pending', 'Shipped', 'Delivered', 'Cancelled', 'Returned']

# Generate order data
orders = []

# Define the date range for orders
start_date = date(2023, 1, 1)  # Orders start from Jan 1, 2023
end_date = date.today()  # Orders can be up to today's date

for order_id in range(1, 156):  # Generate 300 orders
    order_date = fake.date_between(start_date=start_date, end_date=end_date)  # Random order date
    order_total = round(random.uniform(20.00, 5000.00), 2)  # Random order total between $20.00 and $5000.00
    order_status = random.choice(order_statuses)  # Random order status
    orders.append((order_id, order_date, order_total, order_status))

# Generate SQL INSERT query
sql = "INSERT INTO orders (orderDate, orderTotal, orderStatus) VALUES\n"
sql += ",\n".join([
    f"""('{order_date}', {order_total}, '{order_status}')"""
    for _, order_date, order_total, order_status in orders
]) + ";"

# Save SQL script to a file
with open("ordersdata.sql", "w") as file:
    file.write(sql)
