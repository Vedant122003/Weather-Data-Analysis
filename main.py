import requests
import pandas as pd

def fetch_weather_data(api_key, station_id, start_date, end_date):
    url = "https://www.ncdc.noaa.gov/cdo-web/api/v2/data"
    params = {
        'datasetid': 'GHCND',
        'stationid': station_id,
        'startdate': start_date,
        'enddate': end_date,
        'limit': 1000,
        'units': 'metric',
    }
    headers = {'token': api_key}

    response = requests.get(url, headers=headers, params=params)
    data = response.json()
    return data.get('results', [])

def save_to_csv(data, filename):
    df = pd.DataFrame(data)
    if not df.empty:
        df.to_csv(filename, index=False)
        print("Data saved to file.")
    else:
        print("No data available to save.")

# Replace 'Your_API_Key' with your actual API key
api_key = "Your_API_Key"
station_id = 'GHCND:IN023011900'  # Example Station ID for Agra, India
start_date = '1960-01-01'
end_date = '1960-12-31'
filename = 'weather_data.csv'

# Fetch data
weather_data = fetch_weather_data(api_key, station_id, start_date, end_date)

# Save data to CSV
save_to_csv(weather_data, filename)
