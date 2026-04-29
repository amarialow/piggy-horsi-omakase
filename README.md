![Piggy Horse: Unstable Omakase](images/photo.jpg)

# 🍣 NYC Omakase Market Analysis
## Piggy Horsi: Unstable Omakase — SQL Portfolio Project

---

## 📌 Executive Summary

This project explores the feasibility of opening a new omakase restaurant, **Piggy Horsi: Unstable Omakase**, in New York City using SQL-driven analysis. By examining restaurant data (pricing, ratings, locations, and customer demand), the goal is to identify underserved neighborhoods, optimal pricing strategies, and competitive positioning opportunities.

---
## 📖 Project Description

New York City has seen a surge in high-end omakase experiences, but the market remains unevenly distributed. This project analyzes:

- Market saturation across neighborhoods
- Pricing trends and their relationship to ratings
- Customer demand using review data
- Strategic gaps for potential new entrants

**Key Objective:** Identify the best location and pricing strategy for launching a successful omakase restaurant.

---

## 🛠️ Tech Stack

| Tool | Purpose |
|---|---|
| PostgreSQL | SQL Analysis |
| DBeaver | Database Management |
| Tableau / Power BI | Data Visualization |
| The Sushi Legend, Yelp, Google Maps | Data Sources |

---

## 📊 Dashboard

![Dashboard](images/PiggyHorsiDashboard.jpg)

---

## ER Diagram

![ER Diagram](images/omakase_er_diagram.jpg)

---

## 📂 Data Collection & Preparation

### Data Sources
- [The Sushi Legend](https://thesushilegend.com/nyc-omakase-list-2026/)
- [Yelp Open Dataset](https://business.yelp.com/data/resources/open-dataset/)
- Google Maps

### Data Preparation

**1. The Sushi Legend**
- Downloaded the NYC omakase list PDF from [thesushilegend.com](https://thesushilegend.com/nyc-omakase-list-2026/)
- Extracted structured data from the PDF using AI-assisted tools and converted it into a `.csv` format
- Imported the CSV data into PostgreSQL for analysis

**2. Yelp Open Dataset**
- Downloaded the [Yelp Open Dataset](https://business.yelp.com/data/resources/open-dataset/)
- Used Pandas to convert `business.json` and `review.json` to `.csv` files

```python
import pandas as pd
import json

data = []
with open('yelp_academic_dataset_review.json', 'r', encoding='utf-8') as f:
    for line in f:
        data.append(json.loads(line))

df = pd.DataFrame(data)
df.to_csv('review.csv', index=False)
```

- Imported the CSV data into PostgreSQL

### Data Cleaning Steps
- Removed duplicates
- Made "name" column unique
- Handled missing/null values

---

## ❓ Key Business Questions & SQL Analysis

### 1. Market Landscape

**Which neighborhoods are most saturated?**

```sql
SELECT 
    neighborhood,
    COUNT(*) AS total
FROM public.nyc_omakase
GROUP BY neighborhood
ORDER BY total DESC;
```

### 2. Pricing Strategy

**Top 10 most expensive and cheapest omakase by neighborhood**

```sql
(SELECT 'Most Expensive' AS category, name, neighborhood, price_max AS price
FROM public.nyc_omakase
WHERE price_max IS NOT NULL
ORDER BY price_max DESC
LIMIT 10)
UNION ALL
(SELECT 'Cheapest' AS category, name, neighborhood, price_min AS price
FROM public.nyc_omakase
WHERE price_min IS NOT NULL
ORDER BY price_min ASC
LIMIT 10);
```

**What is the average omakase price?**

```sql
SELECT 
    ROUND(AVG((price_min + price_max) / 2.0), 2) AS avg_price
FROM public.nyc_omakase
WHERE price_min IS NOT NULL
  AND price_max IS NOT NULL;
```

**Does higher price correlate with higher ratings?**

```sql
SELECT 
    price_per_person, 
    AVG(rating) AS avg_rating
FROM restaurants
GROUP BY price_per_person
ORDER BY price_per_person;
```

### 3. Customer Demand

**Which restaurants perform best?**

```sql
SELECT name, rating, review_count
FROM restaurants
ORDER BY rating DESC, review_count DESC
LIMIT 10;
```

### 4. Location Opportunity

**Where is demand high but competition low?**

```sql
SELECT 
    neighborhood,
    COUNT(*) AS restaurant_count,
    AVG(review_count) AS avg_demand
FROM restaurants
WHERE cuisine = 'Omakase'
GROUP BY neighborhood
ORDER BY avg_demand DESC, restaurant_count ASC;
```

---

## 📊 Visualizations

### Tools
- Tableau / Power BI / Python (matplotlib, seaborn)

### Key Visuals

| Visual | Description |
|---|---|
| 🗺️ NYC Map | Restaurant density by neighborhood |
| 📊 Bar Chart | Top neighborhoods by omakase count |
| 📈 Scatter Plot | Price vs Rating |
| 🔥 Heatmap | Demand vs Competition |

### Insights
- High-density areas (e.g., Manhattan) show strong competition
- Emerging neighborhoods may offer better entry opportunities
- Price and rating show diminishing returns beyond a threshold

---

## 💡 Key Insights & Recommendations

- **Best Locations:** Neighborhoods with high review counts but fewer competitors
- **Optimal Pricing:** Mid-to-high tier pricing performs best
- **Market Gap:** Opportunity for premium experiences outside saturated areas

---

## 🗂️ Project Structure

```
/data
/sql
  ├── create_nyc_omakase_table.sql
  └── analysis.sql
/visualizations
/notebooks
README.md
```

---

## ⚠️ Limitations

- Review data may be biased or incomplete
- Pricing may not reflect current market conditions
- Some neighborhood mappings required manual cleaning

---

## 🚀 Future Improvements

- Time-series analysis of omakase market growth
- Sentiment analysis on customer reviews
- Integration with demographic and income data
- Predictive modeling for restaurant success

---

## ▶️ How to Run

1. Clone the repository
2. Set up PostgreSQL and create the database
3. Run `sql/create_nyc_omakase_table.sql` to create the schema
4. Import the CSV data files
5. Run `sql/analysis.sql` for the analysis queries
6. Connect to Tableau / Power BI for visualizations

---

## 👤 Author

**Amanda Low**
- **LinkedIn:** 
