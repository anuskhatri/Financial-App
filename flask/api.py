import os
import google.generativeai as genai

# Set your API key directly (not recommended for production)
api_key = ""  # Replace with your actual API key
genai.configure(api_key="")

# Replace this with your tuned model's name
tuned_model_name = "tunedModels/investmentquerytuner-axtq661rgg8t"

# Create an instance of the GenerativeModel
model = genai.GenerativeModel(model_name=tuned_model_name)

# Define a user query
user_query = "give me retirement plan"

# Generate content using the tuned model
response = model.generate_content(user_query)

# Print the generated response
print(response.text)  # This should give you the model's output based on the input query
