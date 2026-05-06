# 📘 Learning Along with GPT — SQL Module 1.4 (DML & Query Design)

## 🧱 DDL vs DML

### DDL (Data Definition Language)
- Defines database structure  
- Commands: CREATE, ALTER, DROP, TRUNCATE  

### DML (Data Manipulation Language)
- Operates on data  
- Commands: SELECT, INSERT, UPDATE, DELETE  

> DDL = structure, DML = data

---

## ⚡ Indexing (Conceptual)

Purpose: Improve query performance

### Pros
- Faster reads  
- Efficient joins  
- Optimized sorting  

### Cons
- Slower writes  
- Storage overhead  

> Indexes trade write performance for read efficiency

---

## 🧾 Table vs View

| Table | View |
|------|------|
| Stores data | Virtual (query-based) |
| Faster reads | More flexible |
| Uses storage | No storage |

> Table = performance, View = abstraction

---

## 🧩 Understanding Table Schema (DESCRIBE)

| Attribute | Meaning |
|----------|--------|
| Null | Can column store NULL? |
| Key | Index type (e.g. Primary Key) |
| Default | Value if none provided |
| Extra | Auto-behaviour (e.g. auto_increment) |

> Primary Key ⇒ always NOT NULL

---

## 🔍 Case Sensitivity in Queries

Problem: Inconsistent data (ACTIVE / Active / active)

### Solutions
- LOWER(column) → quick fix (not efficient)
- ILIKE → case-insensitive match
- Normalize input → better
- Clean data → best

> Fix the data, not just the query

---

## 🧼 Data Cleaning Workflow

1. Profile data  
   SELECT DISTINCT column FROM table;

2. Clean data  
   UPDATE table SET column = UPPER(column);

3. Standardize  
4. Document  
5. Enforce  
   CHECK (column = UPPER(column))

---

## 🧮 Derived Columns & Execution Order

SQL Execution Order:
1. FROM  
2. WHERE  
3. SELECT  
4. ORDER BY  

Aliases in SELECT cannot be used in WHERE (standard SQL)

---

## 🧱 CTE (Common Table Expression)

WITH base AS (
    SELECT ..., calculated_column
)
SELECT *
FROM base
WHERE condition;

> CTE = named subquery

---

## ⚠️ DuckDB Behavior

- Allows alias in WHERE (non-standard)
- Convenient but not portable

---

## 📊 GROUP BY Usage

Use GROUP BY only when multiple groups exist

Example:

SELECT town, SUM(price)
FROM table
GROUP BY town;

Redundant case:

WHERE town = 'TAMPINES'
GROUP BY town;

---

## 📅 Date Functions Across SQL Dialects

| MySQL | PostgreSQL / DuckDB |
|------|----------------------|
| YEAR(date) | EXTRACT(YEAR FROM date) |
| YEAR(date) | date_part('year', date) |

---

## 🔗 EXISTS vs IN

### IN
SELECT *
FROM orders
WHERE customer_id IN (
    SELECT id FROM customers
);

- Compares values (list membership)
- Simpler syntax
- Can have issues with NULLs

---

### EXISTS
SELECT *
FROM orders o
WHERE EXISTS (
    SELECT 1
    FROM customers c
    WHERE c.id = o.customer_id
);

- Checks if matching row exists
- Stops at first match (efficient)
- Safer with NULLs

---

### Key Differences

| IN | EXISTS |
|----|--------|
| Value comparison | Row existence check |
| May scan full list | Short-circuits |
| NULL-sensitive | NULL-safe |

---

### Best Practice

- Use IN for small, simple lists  
- Use EXISTS for large datasets and relationships  
- Prefer NOT EXISTS over NOT IN when NULLs may exist  

---

## 🧠 Key Takeaways

- Understand execution order, not just syntax  
- Clean data > complex queries  
- Prefer standard SQL for portability  
- Use CTEs for clarity  
- Avoid redundant operations  
- EXISTS is generally safer than IN for subqueries  

---

## 🚀 Notes

- DuckDB is flexible but not always standard-compliant  
- Consider portability for reusable SQL  
- Document assumptions when working with unknown datasets  
