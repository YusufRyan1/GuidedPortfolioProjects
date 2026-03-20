# 📊 Automated Cryptocurrency Data Pipeline using API

## 📌 Project Overview

This project focuses on building an **automated data pipeline** that extracts real-time cryptocurrency data from the CoinMarketCap API, transforms it into a structured format, and stores it for analysis.

The project was inspired by and developed while following **Alex The Analyst**.

---

## 🚀 Key Features

* 🌐 Data extraction using a **REST API (CoinMarketCap)**
* 🔄 Automated data collection at regular intervals
* 🧹 Data transformation using **Pandas (JSON → Tabular format)**
* 🗂 Incremental data storage in CSV format
* ⏱ Timestamp tracking for historical analysis

---

## 🧱 Tech Stack

* Python
* Requests (Session handling)
* Pandas
* JSON
* OS & Time modules

---

## ⚙️ How It Works

1. Connects to the CoinMarketCap API using an API key
2. Retrieves the latest cryptocurrency listings (top 15 coins)
3. Converts nested JSON data into a structured DataFrame using `pd.json_normalize()`
4. Adds a timestamp column for tracking data over time
5. Stores the data in a CSV file:

   * Creates the file if it doesn't exist
   * Appends new data if it already exists
6. Runs automatically in intervals (e.g., every 60 seconds)

---

## 📂 Data Pipeline Flow

API Request → JSON Response → Data Transformation → CSV Storage → Repeat (Loop)

---

## 📊 Sample Data Columns

* Cryptocurrency Name (Bitcoin, Ethereum, etc.)
* Symbol (BTC, ETH, etc.)
* Price (USD)
* Market Cap
* Volume (24h)
* Percentage Changes (1h, 24h, 7d, etc.)
* Timestamp

---

## ▶️ How to Run

1. Install dependencies:

```bash
pip install pandas requests
```

2. Add your API key:

```python
headers = {
  'Accepts': 'application/json',
  'X-CMC_PRO_API_KEY': 'YOUR_API_KEY',
}
```

3. Run the script or notebook:

```bash
python api_data_pipeline.py
```

4. The script will:

* Fetch data from the API
* Transform and store it
* Repeat automatically based on the defined interval

---

## ⚠️ Notes

* Do NOT expose your API key publicly (replace it with an environment variable)
* API rate limits may apply depending on your plan
* The loop can be adjusted for different time intervals

---

## 💡 Future Improvements

* 🗄 Store data in a database (PostgreSQL / MySQL) instead of CSV
* 📊 Build a dashboard (Power BI / Tableau) for crypto trends
* ⚙️ Use scheduling tools (Airflow / cron jobs) instead of manual loops
* 🧱 Refactor into modular pipeline (Extract → Transform → Load)
* ☁️ Deploy to cloud (AWS / GCP)

---

## 🎯 Project Purpose

This project demonstrates:

* Working with real-world APIs
* Data transformation and normalization
* Building automated data collection pipelines
* Creating datasets for time-series analysis

---

## 🙌 Acknowledgment

This project was developed while following tutorials by **Alex The Analyst**, with additional modifications and improvements for learning and practice purposes.
