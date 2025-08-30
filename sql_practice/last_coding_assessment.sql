import pandas as pd
import numpy as np

# Load all sheets
excel_file = 'interview_festival_data.xlsx'
artists = pd.read_excel(excel_file, sheet_name='artists')
stages = pd.read_excel(excel_file, sheet_name='stages') 
performances = pd.read_excel(excel_file, sheet_name='performances')
attendees = pd.read_excel(excel_file, sheet_name='attendees')
attendance = pd.read_excel(excel_file, sheet_name='attendance')
merch_sales = pd.read_excel(excel_file, sheet_name='merch_sales')

# Convert datetime columns
performances['start_time'] = pd.to_datetime(performances['start_time'])
performances['end_time'] = pd.to_datetime(performances['end_time'])

# Revenue
# Artist
# Attendees