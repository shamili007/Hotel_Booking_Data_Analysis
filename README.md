# Hotel Booking Data Analysis Project
![Banner Image](https://github.com/shamili007/Hotel_Booking_Data_Analysis/blob/main/booking-com-design-exercise-blue-banner.jpeg)

Welcome to the Hotel Booking Data Analysis project! In this project, we explore and analyze a
dataset containing hotel booking information to derive insights and patterns that can be useful
for understanding booking trends, customer behavior, and other factors affecting the hospitality
industry.
## Introduction
This project focuses on analyzing a dataset obtained from hotel booking records, including
information such as booking dates, hotel details, guest demographics, and reservation statuses.
By leveraging SQL queries and data analysis techniques, we aim to answer various questions
and uncover valuable insights from the dataset.
## Dataset Overview
The dataset used in this project consists of [136110] rows of data, representing hotel
bookings. Before analysis, the dataset underwent a data cleaning process to handle missing
values (NULLs) and ensure data quality.
## Analysis Questions
To guide our analysis, we formulated several key questions to explore and address using the
dataset:
1. Find the customers who have made more than 5 orders and the total number of orders they have made.
2. Identify the number of unique hotels present in the dataset.
3. List all the distinct market segments represented in the bookings.
4. Count the number of bookings with NULL values for both the 'children' and 'meal' columns
5. Create a new column 'booking_period' categorizing bookings as 'Weekend' if stays_in_weekend_nights > 0, otherwise 'Weekday'.
6. Classify the bookings as 'High Price' if the price is greater than the average price, otherwise 'Low Price'
7. Create INDEX on COUNTRY column and Do Explain and Analyze
8. Determine the average number of adults per booking for each hotel.
9. Identify the countries with an average booking price exceeding $200.
10. Rank the bookings based on the 'booking_date' in ascending order.
11. Calculate the dense rank of bookings based on the 'country' column.
12. Find all email addresses containing 'gmail.com'.
13. Identify bookings with names starting with 'A'.
14. Calculate the total price generated from bookings.
15. Determine the minimum and maximum number of required car parking spaces across all bookings
16. Find the average price of bookings for each combination of 'hotel' and 'meal'.
17. Count the number of bookings where the number of adults is greater than the average number of adults across all bookings.
18. What is the overall cancellation rate for hotel bookings?
19. Which countries are the top contributors to hotel bookings?
20. What are the main market segments booking the hotels, such as leisure or corporate?
21. What percentage of bookings require car parking spaces?
## Getting Started
To replicate the analysis or explore the dataset further, follow these steps:
1. Clone the repository to your local machine.
2. Ensure you have a SQL environment set up to execute queries.
3. Load the provided dataset into your SQL database.
4. Execute the SQL queries provided in the repository to analyze the data and derive insights.
5. Customize the analysis or queries as needed for your specific objectives.
## Conclusion
Through this project, we aim to provide valuable insights into hotel booking trends, customer
preferences, and other factors influencing the hospitality industry. By analyzing the dataset and
addressing the key questions, we hope to assist stakeholders in making informed decisions and
optimizing their operations.
Feel free to explore the repository and contribute to further analysis or enhancements!
