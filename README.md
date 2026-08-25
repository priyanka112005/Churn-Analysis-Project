 # 📊 Customer Churn Analysis

## 📌 Project Overview

This project analyzes **Telecom Customer Churn data** to understand customer behavior, identify factors associated with churn, and provide actionable insights for customer retention.

The project focuses primarily on **Data Analytics and Business Intelligence**, using SQL and Power BI, with Python-based churn prediction as an additional component.

---

## 🎯 Objectives

* Clean and prepare customer churn data.
* Analyze customer behavior and churn patterns using SQL.
* Identify high-risk customer segments and major churn reasons.
* Build an interactive Power BI dashboard.
* Create KPIs and analytical measures using DAX.
* Predict potential churners using Python and Random Forest.
* Provide data-driven business recommendations.

---

## 🛠️ Tools & Technologies

| Tool                | Purpose                                      |
| ------------------- | -------------------------------------------- |
| **MySQL**           | Data cleaning, exploration, analysis & views |
| **Power Query**     | Data transformation                          |
| **Power BI**        | Dashboard & visualization                    |
| **DAX**             | KPIs and analytical measures                 |
| **Python**          | Data preparation & prediction                |
| **Scikit-learn**    | Random Forest model                          |
| **GitHub**          | Project documentation                        |

---

## 🔄 Project Workflow

```text
Raw Dataset
     ↓
MySQL Data Cleaning & Exploration
     ↓
SQL Analysis & Views
     ↓
Power Query Transformations
     ↓
Power BI Dashboard + DAX
     ↓
Python Churn Prediction
     ↓
Insights & Business Recommendations
```

---

# 🗄️ SQL Analysis

The raw dataset was imported into MySQL and cleaned to create the `prod_Churn` table.

SQL was used for:

* Data exploration
* Distinct value analysis
* Duplicate and NULL checks
* Customer segmentation
* Churn analysis
* Contract, payment and revenue analysis
* Creating analytical views


# 🔄 Power Query Transformations

Power Query was used to prepare the data for Power BI.

Key transformations included:

* Created **Churn Status** as a numerical field.
* Created **Monthly Charge Range** groups.
* Created **Age Group** and sorting fields.
* Created **Tenure Group** and sorting fields.
* Created a `prod_Services` table by unpivoting service columns.

These transformations made the data easier to analyze and visualize.

---

# 📊 Power BI Dashboard

The Power BI dashboard contains **three pages**:

### 1. Summary

Provides an overall view of the customer base and churn performance using KPIs and customer segmentation.

### 2. Churn Reason

Analyzes the major reasons behind customer churn and helps identify areas requiring attention.

### 3. Churn Prediction

Displays predicted churners generated using the Python prediction model.

---

# 📐 DAX Measures

DAX was used to create important KPIs, including:

```DAX
Total Customers =
COUNT(prod_Churn[Customer_ID])
```

```DAX
New Joiners =
CALCULATE(
    COUNT(prod_Churn[Customer_ID]),
    prod_Churn[Customer_Status] = "Joined"
)
```

```DAX
Total Churn =
SUM(prod_Churn[Churn Status])
```

```DAX
Churn Rate =
[Total Churn] / [Total Customers]
```

Additional measures were created for displaying the number of predicted churners on the prediction page.

---

# 🤖 Churn Prediction

Python was used as an additional predictive component of the project.

A **Random Forest Classifier** was used to predict whether customers are likely to churn.

### Evaluation Metrics

The model was evaluated using:

* Precision
* Recall
* F1-Score
* Confusion Matrix

The prediction results were then incorporated into the **Churn Prediction** page in Power BI.

---

# 📈 Key Insights

The analysis explores churn patterns across:

* Customer demographics
* Contract type
* Tenure
* Monthly charges
* Payment methods
* Services
* Churn reasons

These insights help identify customer segments that may require additional retention efforts.

---

# 💡 Business Recommendations

* Target high-risk customer segments with personalized retention campaigns.
* Pay particular attention to customers in their early tenure.
* Address the major reasons contributing to customer churn.
* Review pricing and service-value concerns for high-charge customers.
* Use predicted churners to proactively engage customers at risk of leaving.


---

# 🏆 Skills Demonstrated

**SQL:** Data Cleaning, Data Exploration, Analysis, Views, Data Quality Checks

**Power BI:** Power Query, Data Transformation, Dashboarding, Visualization, DAX

**Python:** Pandas, Data Preparation, Random Forest, Model Evaluation

**Analytics:** Customer Segmentation, Churn Analysis, Business Insights, Data-Driven Recommendations

---


**Tools:** MySQL • Power BI • Power Query • DAX • Python • Pandas • Scikit-learn

