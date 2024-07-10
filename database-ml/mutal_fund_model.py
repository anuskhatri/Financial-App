import pandas as pd

# Assuming you have your dataset in a CSV file
file_path = 'C:\\Users\\Mr.Hetal Hakani\\Downloads\\comprehensive_mutual_funds_data.csv'

# Load the dataset
df = pd.read_csv(file_path)

# Replace blank values and '-' with 0
df.replace(['–'], '-', inplace=True)

# Optionally, you can save the cleaned dataset to a new CSV file
cleaned_file_path = 'C:\\Users\\Mr.Hetal Hakani\\Desktop\\comprehensive_mutual_funds_data.csv'
df.to_csv(cleaned_file_path, index=False)

print("Dataset cleaned and saved to:", cleaned_file_path)