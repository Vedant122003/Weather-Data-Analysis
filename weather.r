# Load libraries
library(ggplot2)
library(dplyr)
library(lubridate)

# Set the working directory
setwd("C:/Users/vedan/Desktop/Main/Weather_data_analysis")

# Read the CSV file
weather_data <- read.csv("weather_data.csv", stringsAsFactors = FALSE)

# Convert the date column to a Date type
weather_data$date <- as.Date(weather_data$date, "%Y-%m-%dT%H:%M:%S")

# Analyze and visualize the data
# Filtering to only include precipitation data
precip_data <- weather_data %>%
  filter(datatype == "PRCP") %>%
  mutate(value_mm = value / 10)  # Convert tenths of mm to mm

# Summary statistics for precipitation
summary_stats <- precip_data %>%
  summarise(
    total_precip = sum(value_mm, na.rm = TRUE),
    avg_daily_precip = mean(value_mm, na.rm = TRUE),
    max_precip = max(value_mm, na.rm = TRUE),
    min_precip = min(value_mm, na.rm = TRUE)
  )

print(summary_stats)

# Plot precipitation over time
ggplot(data = precip_data, aes(x = date, y = value_mm)) +
  geom_line() +
  labs(title = "Daily Precipitation Over Time",
       x = "Date",
       y = "Precipitation (mm)") +
  theme_minimal()