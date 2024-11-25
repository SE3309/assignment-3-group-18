from faker import Faker
import random
from datetime import date

# Initialize Faker
fake = Faker()

# Payment method options
payment_methods = ['Credit Card', 'Debit Card', 'PayPal', 'Bank Transfer']

# Generate paymentInfo data
payment_info = set()

# Define start and end dates as datetime.date objects
start_date = date(2024, 1, 1)
end_date = date(2030, 12, 31)

while len(payment_info) < 500:  # Generate 500 unique rows
    user_id = random.randint(1, 1000)  # Random userID between 1 and 1000
    payment_method = random.choice(payment_methods)  # Random payment method
    account_number = fake.bban() if payment_method in ['Bank Transfer', 'PayPal'] else ''  # Account number for certain methods
    card_number = fake.credit_card_number() if payment_method in ['Credit Card', 'Debit Card'] else ''  # Card number for certain methods
    expiration_date = fake.date_between(start_date=start_date, end_date=end_date) if card_number else None  # Expiration date if card exists
    cvv = fake.random_number(digits=3, fix_len=True) if card_number else None  # CVV if card exists

    # Add unique record to the set
    payment_info.add((user_id, payment_method, account_number, card_number, expiration_date, cvv))

# Generate SQL INSERT query
sql = "INSERT INTO paymentInfo (userID, paymentMethod, accountNumber, cardNumber, expirationDate, CVV) VALUES\n"
sql += ",\n".join([
    f"""({user_id}, '{payment_method}', '{account_number}', '{card_number}', {'NULL' if expiration_date is None else f"'{expiration_date}'"}, {'NULL' if cvv is None else f"'{cvv}'"})"""
    for user_id, payment_method, account_number, card_number, expiration_date, cvv in payment_info
]) + ";"

# Save SQL script to a file
with open("paymentinfodata.sql", "w") as file:
    file.write(sql)
