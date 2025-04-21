import pandas as pd
import numpy as np

# Step 1: Create a raw dataset
appointment_data = {
    'Patient ID': ['P001', 'P002', 'P003', 'P001', None],
    'Gender': ['F', 'm', 'F', 'F', 'M'],
    'Scheduled Day': ['2023-04-01', '01/04/2023', 'April 1, 2023', '2023-04-01', '2023-04-02'],
    'Appointment Day': ['2023-04-03', '2023-04-03', '2023-04-03', '2023-04-03', None],
    'Age': ['25', 'thirty', '30', '25', '40'],
    'No-show': ['No', 'Yes', 'No', 'No', 'Yes']
}

df_appointments = pd.DataFrame(appointment_data)

# Step 2: Clean and preprocess

# Remove rows with missing values
df_appointments_cleaned = df_appointments.dropna()

# Remove duplicates
df_appointments_cleaned = df_appointments_cleaned.drop_duplicates()

# Standardize text values
df_appointments_cleaned['gender'] = df_appointments_cleaned['Gender'].str.upper().str.strip()
df_appointments_cleaned['no_show'] = df_appointments_cleaned['No-show'].str.capitalize().str.strip()

# Convert date formats
df_appointments_cleaned['Scheduled Day'] = pd.to_datetime(df_appointments_cleaned['Scheduled Day'], errors='coerce')
df_appointments_cleaned['Appointment Day'] = pd.to_datetime(df_appointments_cleaned['Appointment Day'], errors='coerce')

# Rename columns to be clean and uniform
df_appointments_cleaned.columns = [col.strip().lower().replace(" ", "_") for col in df_appointments_cleaned.columns]

# Fix data types
df_appointments_cleaned['age'] = pd.to_numeric(df_appointments_cleaned['age'], errors='coerce')
df_appointments_cleaned = df_appointments_cleaned.dropna(subset=['age'])
df_appointments_cleaned['age'] = df_appointments_cleaned['age'].astype(int)

# Reset index
df_appointments_cleaned.reset_index(drop=True, inplace=True)

# Display the cleaned dataset
print(df_appointments_cleaned)

