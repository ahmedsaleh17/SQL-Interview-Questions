# SQL Learning Materials - Complete Course Guide

A structured, progressive SQL learning curriculum covering everything from basics to advanced techniques. This folder contains 14 comprehensive modules designed to build your SQL skills from the ground up.

## 📚 Course Overview

This course is organized as a step-by-step progression through SQL concepts:

| # | Module | Topics | Difficulty |
|---|--------|--------|-----------|
| 01 | [SQL Basics](#01-sql-basics) | SELECT, WHERE, ORDER BY, DISTINCT, LIMIT | Beginner |
| 02 | [SQL Intermediate](#02-sql-intermediate) | JOINs, GROUP BY, HAVING, Aggregations | Beginner-Intermediate |
| 03 | [String Functions](#03-sql-string-functions) | SUBSTRING, CONCAT, UPPER, LOWER, TRIM, REPLACE | Intermediate |
| 04 | [DateTime Functions](#04-sql-datetime-functions) | DATEADD, DATEDIFF, CONVERT, GETDATE, Date Formatting | Intermediate |
| 05 | [NULL Functions](#05-sql-null-functions) | ISNULL, COALESCE, NULLIF, Handling Missing Data | Intermediate |
| 06 | [Window Aggregate Functions](#06-sql-window-aggregate-functions) | SUM(), AVG(), COUNT(), MIN(), MAX() OVER() | Intermediate-Advanced |
| 07 | [Window Ranking Functions](#07-sql-window-ranking-functions) | ROW_NUMBER(), RANK(), DENSE_RANK(), NTILE() | Intermediate-Advanced |
| 08 | [Window Value Functions](#08-sql-window-value-functions) | LAG(), LEAD(), FIRST_VALUE(), LAST_VALUE() | Advanced |
| 09 | [Subqueries](#09-sql-subquery) | Nested SELECTs, Correlated Subqueries, EXISTS | Advanced |
| 10 | [CTEs (Common Table Expressions)](#10-sql-cte) | WITH Clause, Recursive CTEs, Multiple CTEs | Advanced |
| 11 | [Views](#11-sql-views) | Creating Views, Updating Views, View Permissions | Advanced |
| 12 | [CTAS (Create Table As Select)](#12-sql-ctas) | Creating Tables from Queries, Data Copy | Advanced |
| 13 | [Temporary Tables](#13-sql-temptables) | Local Temp Tables, Global Temp Tables, Scope | Advanced |
| 14 | [Indexes](#14-sql-indexes) | Index Types, Query Optimization, Index Strategies | Advanced |

## 🗂️ Database Schema

The learning materials use the following database schema with 4 primary tables:

### Schema Diagram
![SalesDB Data Model](../Resources/00_SalesDB_DataModel.png)

### Table Descriptions

#### **Customers**
- `CustomerID` (PK): Unique identifier for each customer
- `FirstName`, `LastName`: Customer names
- `Country`: Customer location
- `Score`: Customer loyalty/satisfaction score

#### **Products**
- `ProductID` (PK): Unique identifier for each product
- `Product`: Product name
- `Category`: Product classification
- `Price`: Product price

#### **Orders**
- `OrderID` (PK): Unique identifier for each order
- `ProductID` (FK): References Products table
- `CustomerID` (FK): References Customers table
- `SalesPersonID` (FK): References Employees table
- `OrderDate`: Date the order was placed
- `ShipDate`: Date the order was shipped
- `OrderStatus`: Current status of the order
- `ShipAddress`, `BillAddress`: Delivery and billing addresses
- `Quantity`: Number of items ordered
- `Sales`: Sale amount
- `CreationTime`: Timestamp of order creation

#### **Employees**
- `EmployeeID` (PK): Unique identifier for each employee
- `FirstName`, `LastName`: Employee names
- `Department`: Department assignment
- `BirthDate`: Employee birth date
- `Gender`: Employee gender
- `Salary`: Employee salary
- `ManagerID` (FK): References parent Employee (self-referencing for hierarchy)

## 📖 Module Details

### 01. SQL Basics
**File:** `01_sql_basics.sql`

Learn the fundamental SQL operations:
- SELECT statements and column selection
- WHERE clause for filtering
- ORDER BY for sorting results
- DISTINCT to remove duplicates
- LIMIT to restrict result sets
- Comparison operators (=, <>, <, >, <=, >=)
- Logical operators (AND, OR, NOT)

**Use Cases:** Data retrieval, filtering, and basic exploration

---

### 02. SQL Intermediate
**File:** `02_sql_intermediate.sql`

Master data aggregation and combining data:
- INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL OUTER JOIN
- GROUP BY for data aggregation
- HAVING clause for filtering grouped data
- Aggregate functions: COUNT(), SUM(), AVG(), MIN(), MAX()
- JOIN conditions and multiple table relationships

**Use Cases:** Analyzing multiple tables, summarizing data

---

### 03. SQL String Functions
**File:** `03_sql_string_functions.sql`

Manipulate and analyze text data:
- SUBSTRING() / SUBSTR() - extract portions of text
- CONCAT() - combine strings
- UPPER() / LOWER() - case conversion
- TRIM() / LTRIM() / RTRIM() - remove whitespace
- REPLACE() - substitute text
- LEN() / LENGTH() - string length
- CHARINDEX() / INSTR() - find text position
- CAST() / CONVERT() - string conversion

**Use Cases:** Data cleaning, formatting, text analysis

---

### 04. SQL DateTime Functions
**File:** `04_sql_datetime_functions.sql`

Work with dates and times:
- GETDATE() / NOW() - current date/time
- DATEADD() - add intervals to dates
- DATEDIFF() - calculate differences between dates
- CONVERT() - format dates
- DAY(), MONTH(), YEAR() - extract date parts
- DATEFROMPARTS() - construct dates
- EOMONTH() - end of month calculations
- Date arithmetic and comparisons

**Use Cases:** Time-based analysis, date calculations, reporting

---

### 05. SQL NULL Functions
**File:** `05_sql_Null_functions.sql`

Handle missing and unknown data:
- ISNULL() - replace NULL values
- COALESCE() - return first non-NULL value
- NULLIF() - convert specific values to NULL
- IS NULL / IS NOT NULL - test for nullness
- NULL in aggregations
- NULL handling in JOINs

**Use Cases:** Data quality, handling missing values

---

### 06. SQL Window Aggregate Functions
**File:** `06_sql_window_aggregate_functions.sql`

Advanced aggregations over defined windows:
- SUM() OVER() - running/cumulative totals
- AVG() OVER() - moving averages
- COUNT() OVER() - running counts
- MIN() OVER(), MAX() OVER() - running extremes
- PARTITION BY clause
- ORDER BY within window functions
- ROWS/RANGE specification

**Use Cases:** Trend analysis, comparative aggregations, analytics

---

### 07. SQL Window Ranking Functions
**File:** `07_sql_window_ranking_functions.sql`

Rank and number rows within partitions:
- ROW_NUMBER() - unique sequential numbering
- RANK() - ranking with gaps
- DENSE_RANK() - ranking without gaps
- NTILE() - distribute rows into buckets
- PARTITION BY for group-based ranking
- Finding top N records per group

**Use Cases:** Top/bottom analysis, percentile calculations, deduplication

---

### 08. SQL Window Value Functions
**File:** `08_sql_window_value_functions.sql`

Access values from other rows in window:
- LAG() - access previous row values
- LEAD() - access next row values
- FIRST_VALUE() - get first value in window
- LAST_VALUE() - get last value in window
- Year-over-year comparisons
- Change detection between rows

**Use Cases:** Sequential analysis, change tracking, comparisons

---

### 09. SQL Subqueries
**File:** `09_sql_subquery.sql`

Nested SELECT statements for complex logic:
- Scalar subqueries (return single value)
- Inline views (subqueries in FROM clause)
- Correlated subqueries (reference outer query)
- EXISTS / NOT EXISTS
- IN / NOT IN with subqueries
- Subqueries in WHERE, SELECT, FROM clauses
- Performance considerations

**Use Cases:** Complex filtering, existence checks, complex calculations

---

### 10. SQL CTEs (Common Table Expressions)
**File:** `10_sql_CTE.sql`

Write readable, maintainable complex queries:
- WITH clause syntax
- Single CTEs
- Multiple CTEs
- Recursive CTEs
- CTE advantages over subqueries
- Naming conventions
- CTE readability patterns

**Use Cases:** Complex queries, hierarchical data, step-by-step logic

---

### 11. SQL Views
**File:** `11_sql_views.sql`

Create reusable query abstractions:
- CREATE VIEW syntax
- Simple views
- Complex views with joins and aggregations
- Altering and dropping views
- Indexed views
- View permissions and security
- View limitations

**Use Cases:** Query reusability, security, simplified interfaces

---

### 12. SQL CTAS (Create Table As Select)
**File:** `12_sql_CTAS.sql`

Create tables from query results:
- CREATE TABLE AS SELECT syntax
- Copying data between tables
- Selective column/row copying
- Data type handling in CTAS
- Performance considerations
- Backup and snapshot creation

**Use Cases:** Data copies, backups, staging tables

---

### 13. SQL Temporary Tables
**File:** `13_sql_TempTables.sql`

Use temporary storage for intermediate results:
- Local temporary tables (#TableName)
- Global temporary tables (##TableName)
- Scope and lifetime
- Creating temp tables
- Inserting into temp tables
- Dropping temp tables
- Performance vs permanent tables

**Use Cases:** Intermediate calculations, performance optimization

---

### 14. SQL Indexes
**File:** `14_sql_indexes.sql`

Optimize query performance:
- Clustered indexes
- Non-clustered indexes
- Composite indexes
- Index creation syntax
- Execution plans
- Index maintenance
- When to use indexes
- Index performance impact

**Use Cases:** Query optimization, performance tuning

---

## 🚀 Learning Path Recommendations

### Beginner (1-2 weeks)
1. Start with **01_sql_basics.sql** - Get comfortable with SELECT and WHERE
2. Move to **02_sql_intermediate.sql** - Learn JOINs and GROUP BY
3. Practice with **03_sql_string_functions.sql** - Apply functions to real data

### Intermediate (2-3 weeks)
4. Study **04_sql_datetime_functions.sql** - Handle time-based data
5. Master **05_sql_Null_functions.sql** - Deal with missing data
6. Explore **06_sql_window_aggregate_functions.sql** - Advanced analytics

### Advanced (3-4 weeks)
7. Learn **07_sql_window_ranking_functions.sql** - Ranking techniques
8. Understand **08_sql_window_value_functions.sql** - Sequential analysis
9. Practice **09_sql_subquery.sql** - Complex nested queries
10. Master **10_sql_CTE.sql** - Readable complex queries
11. Study **11_sql_views.sql** - Query organization
12. Learn **12_sql_CTAS.sql** - Data management
13. Implement **13_sql_TempTables.sql** - Performance techniques
14. Optimize with **14_sql_indexes.sql** - Query performance

## 💡 Best Practices

- **Start Simple:** Run simple queries first to understand the schema
- **Modify Examples:** Change filters and columns to experiment
- **Test Locally:** Run against the provided schema tables
- **Review Patterns:** Study the SQL patterns used in each example
- **Performance:** Use execution plans to understand query performance
- **Documentation:** Comment your queries to explain the logic

## 🔗 Related Resources

- [Learn-SQL Folder](./): All learning materials
- [Solutions Folder](../Solutions/): Real-world problem solutions from DataLemur
- [Root README](../README.md): Interview question tracker

## 📝 Notes

- Examples use T-SQL (SQL Server) syntax unless otherwise specified
- Syntax may vary slightly across different SQL databases (PostgreSQL, MySQL, etc.)
- Always test queries on development data before production use
- Comment your code for maintainability and knowledge sharing

---

**Happy Learning! 🎓**

Feel free to refer to specific modules as you prepare for SQL interviews or deepen your database knowledge.
