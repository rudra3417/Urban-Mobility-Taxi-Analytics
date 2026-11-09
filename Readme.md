# Urban Mobility Analytics
### SQL Server | Power BI | Data Analytics

## Project Overview
Urban Mobility Analytics is a data analytics project using NYC Yellow Taxi trip records to examine trip demand, pickup locations, payment methods, trip distances and recorded fare amounts.

The objective was to use SQL Server to clean and analyse real-world taxi trip data, identify meaningful patterns, and present the results through an interactive Power BI dashboard.

## Business Objectives
- Analyse taxi trip demand across different pickup hours.
- Identify pickup zones with the highest trip volumes.
- Understand the distribution of payment methods.
- Examine how average fare varies across trip-distance categories.
- Understand the distribution of trips across distance categories.

## Tools & Technologies
- **SQL Server:** Data cleaning, transformation, aggregation and business analysis.
- **Power BI:** Interactive dashboard development and visualisation.
- **DAX:** Calculated columns and measures.

## Data Source
NYC Taxi & Limousine Commission (TLC) Yellow Taxi Trip Records.

The project uses a sample of publicly available trip records. The analysed data is heavily concentrated on January 1, 2023, so findings should be interpreted within the scope of this sample.

## Data Preparation
Data preparation was performed using SQL Server.

Key activities included:
- Creating a separate working table for analysis.
- Checking and handling missing values in selected columns.
- Investigating duplicate records and invalid trip details.
- Reviewing unusual fare, distance and duration values.
- Applying documented cleaning rules before analysis.
- Creating a payment method classification.

Final cleaned dataset: **38,826 records**.

## SQL Analysis
The project addressed eight business questions:

1. At what hours is taxi demand highest?
2. Which pickup locations receive the most trips?
3. Which pickup locations have the highest average fare?
4. How does trip distance relate to recorded fare?
5. Which payment methods are most commonly used?
6. Which hours have the highest recorded fare amounts?
7. How does trip duration vary across distance categories?
8. Which trips have unusually high recorded fares?

## Power BI Dashboard
The interactive dashboard contains four KPI cards and five charts.

**KPIs**
- Total Trips
- Average Fare
- Average Duration
- Total Fare

**Visualisations**
1. Hourly Trip Demand
2. Payment Method Distribution
3. Top 5 Pickup Locations
4. Average Fare by Distance
5. Trip Distribution by Distance Group

**Interactive filters**
- Payment Method
- Pickup Location ID

## Key Findings

- **Trip demand:** Recorded trip activity was concentrated in the late-night and early-morning hours, with a considerable decline later in the day.
- **Payment methods:** Credit card payments represented approximately 75.4% of analysed trips, followed by cash payments.
- **Pickup locations:** Trip demand was unevenly distributed across pickup zones, with certain zones recording substantially more trips.
- **Distance and fare:** Average fare increased across distance categories, from $12.65 for trips up to 5 miles to $86.99 for trips above 20 miles.
- **Trip distribution:** Short-distance trips dominated the dataset, accounting for approximately 77.2% of analysed trips.

## Business Recommendations

- Review service coverage during periods with higher recorded trip activity.
- Monitor high-demand pickup zones when evaluating operational coverage.
- Monitor disputed transactions to identify payment-related issues.
- Consider both trip frequency and average fare when evaluating different journey categories.

## Limitations
- The dataset is heavily concentrated on January 1, 2023, and does not represent year-round taxi demand.
- Recorded fare amounts do not represent driver profit or net revenue.
- Pickup location analysis is based on location IDs and their corresponding taxi zones.
- Findings are limited to the available sample and should not be generalised to all NYC taxi operations.

## Conclusion
This project demonstrates the use of SQL Server for real-world data preparation and business analysis, followed by Power BI dashboard development to communicate findings effectively.

It provided practical experience in data cleaning, SQL querying, analytical thinking, KPI development and business interpretation.