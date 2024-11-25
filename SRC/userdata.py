from faker import Faker
import re

# Initialize Faker
fake = Faker()
used_names = set()  # To track unique names
data = set()  # To store unique (name, email, password) combinations

# Function to sanitize names
def sanitize_name(name):
    # Remove titles (Mr.)
    name = re.sub(r'\b(Mr|Mrs|Dr|Ms|Prof)\.?\b', '', name)
    name = re.sub(r"[^\w\s]", '', name)  # Remove special characters
    return name.strip()  # Trim leading/trailing spaces

# Generate unique data
while len(data) < 1000:
    full_name = sanitize_name(fake.name())
    if full_name in used_names:
        continue  # Skip if set has the names
    
    email = f"{full_name.replace(' ', '.').lower()}@example.com"
    password = fake.password(length=10)
    
    if email in [entry[1] for entry in data]:
        continue  # Skip if email has already been used
    
    # Add sanitized data to data set
    data.add((full_name, email, password))
    used_names.add(full_name)  # Mark the name as used

# Create SQL query
sql = "INSERT INTO computerstore.user (name, email, password) VALUES\n"
sql += ",\n".join([f"('{name}', '{email}', '{password}')" for name, email, password in data]) + ";"

# Save to file
with open("userdata.sql", "w") as file:
    file.write(sql)