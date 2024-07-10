
import mysql.connector
import csv
import datetime

# Open the CSV file
cs = open("C:\\Users\\Mr.Hetal Hakani\\Desktop\\comprehensive_mutual_funds_data.csv")
reader = csv.reader(cs)

# Establish a connection to the MySQL database
con = mysql.connector.connect(
    host="localhost",
    user="root",
    passwd="",
    database="bob_test"
)

# Create a cursor object
my_cursor = con.cursor()

# Iterate over the rows in the CSV file
for i in reader:
    # Insert the row into the database
    my_cursor.execute("INSERT INTO mutual_funds (scheme_name, min_sip, min_lumpsum, expense_ratio, fund_size_cr, fund_age_yr, fund_manager, sortino, alpha, sd, beta, sharpe, risk_level, amc_name, rating, category, sub_category, returns_1yr, returns_3yr, returns_5yr) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)", tuple(i))

# Commit the changes
con.commit()

# Print the current date and the number of records inserted
dt = datetime.datetime.now()
print(dt.date())
print(my_cursor.rowcount, "records inserted.")

# Close the cursor and connection
my_cursor.close()
con.close()
