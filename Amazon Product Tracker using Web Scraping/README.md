# 🛒 Amazon Product Tracker using Web Scraping

## 📌 Project Overview

This project is a simple **automated data pipeline** that tracks product information from an Amazon page using web scraping techniques.
--followed Alex The Analyst

The script extracts key product details such as:

* Product title
* Number of customer ratings
* Date of extraction

The collected data is stored over time in a CSV file, enabling **historical tracking and analysis**.

---

## 🚀 Key Features

* 🔍 Web scraping using **BeautifulSoup**
* 🌐 HTTP requests using **Requests**
* 📅 Automated daily data collection
* 🗂 Data storage in CSV format
* 🔄 Continuous execution using a loop (runs every 24 hours)

---

## 🧱 Tech Stack

* Python
* BeautifulSoup
* Requests
* Pandas
* CSV
* Datetime

---

## ⚙️ How It Works

1. Sends a request to the Amazon product page
2. Parses the HTML content using BeautifulSoup
3. Extracts:

   * Product title
   * Ratings count
4. Saves the data into a CSV file
5. Repeats the process every 24 hours

---

## 📂 Output Example

| Title                                                    | Ratings    | Date       |
| -------------------------------------------------------- | ---------- | ---------- |
| Funny Got Data MIS Data Systems Business Analyst T-Shirt | 19 ratings | 2024-02-09 |

---

## ▶️ How to Run

1. Install required libraries:

```bash
pip install requests beautifulsoup4 pandas
```

2. Run the script:

```bash
python amazon_scraper.py
```

3. The script will:

* Create/update `AmazonWebScrapingDataset.csv`
* Append new data daily

---

## ⚠️ Notes

* Amazon page structure may change, which can break the scraper
* Headers are required to avoid request blocking
* For production-level pipelines, consider:

  * Scheduling tools (e.g., cron jobs)
  * Databases instead of CSV
  * Error handling and logging

---

## 💡 Future Improvements

* 📉 Track price changes in addition to ratings
* 📊 Build a dashboard (Power BI / Tableau)
* 🗄 Store data in a database (PostgreSQL / MySQL)
* ☁️ Deploy as a scheduled cloud pipeline

---

## 🎯 Project Purpose

This project demonstrates:

* Data collection from external sources
* Automation of data pipelines
* Building datasets for future analysis

---

## 📬 Contact

If you have any questions or suggestions, feel free to connect with me on LinkedIn.
