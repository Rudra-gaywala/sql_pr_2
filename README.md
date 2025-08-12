# 📦 MySQL Customer Orders Management System

## 📌 Overview
This project demonstrates a **Customer Orders Management System** implemented in MySQL.  
It includes:
- Table creation with **Primary Keys** & **Foreign Keys**
- Data insertion
- **Joins** (INNER, LEFT, RIGHT, FULL via UNION)
- Aggregate functions (`SUM`, `AVG`, `RANK`, etc.)
- Date & string manipulation functions
- Conditional queries using `CASE`
- Window functions for running totals & rankings

---

## 📥 Sample Data

### **Customers**
| first_name | last_name | email                | registration_date |
|------------|-----------|----------------------|-------------------|
| John       | Doe       | john.doe@gmail.com   | 2025-07-21        |
| Jane       | Smith     | jane.smith@gmail.com | 2025-07-12        |

### **Orders**
| customer_id | order_date | total_amount |
|-------------|-----------|--------------|
| 1           | 2023-07-01| 150          |
| 2           | 2023-07-03| 200          |

### **Employees**
| first_name | last_name | department | hire_date  | salary |
|------------|-----------|------------|------------|--------|
| Mark       | Johnson   | Sales      | 2020-01-15 | 50000  |
| Susan      | Lee       | HR         | 2021-03-20 | 5000   |

---

## 📊 Queries Implemented

### **Joins**
- `INNER JOIN` → Orders with customer details  
- `LEFT JOIN` → All customers with their orders  
- `RIGHT JOIN` → All orders with customer info  
- `FULL OUTER JOIN` (simulated via `UNION`)

### **Aggregate Functions**
- `AVG()` → Customers with above-average orders  
- `SUM() OVER()` → Running total of order amounts  
- `RANK()` → Rank orders by amount  

### **Date Functions**
- `YEAR()`, `MONTH()` → Extract date parts  
- `DATEDIFF()` → Days between dates  
- `DATE_FORMAT()` → Custom date display  

### **String Functions**
- `CONCAT()` → Combine first & last name  
- `REPLACE()`, `UPPER()`, `LOWER()`, `TRIM()` → String formatting  

### **CASE Statements**
- Conditional **discounts** based on order amount  
- Salary category as **High**, **Medium**, **Low**  

---

## 📌 Example Queries

### 1️⃣ Get all orders with customer names
```sql
SELECT o.order_id, o.order_date, o.total_amount, c.first_name, c.last_name
FROM orders o
INNER JOIN customers c 
    ON o.customer_id = c.customer_id;
```

### 2️⃣ Find customers with above-average order total
```sql
SELECT DISTINCT c.*
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.total_amount > (SELECT AVG(total_amount) FROM orders);
```

### 3️⃣ Running total of orders
```sql
SELECT order_id, order_date, total_amount, 
       SUM(total_amount) OVER (ORDER BY order_date) AS RunningTotal
FROM orders;
```

---

## 🚀 How to Use
1. **Create the database** in MySQL.
2. **Run table creation scripts** to set up schema.
3. **Insert sample data** provided above.
4. **Execute queries** to explore:
   - Joins
   - Aggregates
   - String & Date functions
   - Window functions
