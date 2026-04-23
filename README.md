# SQL-Interview-Questions & Learning Materials

A comprehensive SQL learning and interview preparation repository combining foundational learning materials with real-world problem-solving solutions. Perfect for building SQL skills from basics to advanced techniques and preparing for data interviews on [DataLemur](https://datalemur.com/).

## 📁 Repository Structure

```
SQL-problemsolving/
├── Learn-SQL/                          # 📚 Foundational Learning Materials (14 Modules)
│   ├── 01_sql_basics.sql               # SELECT, WHERE, ORDER BY, DISTINCT, LIMIT
│   ├── 02_sql_intermediate.sql         # JOINs, GROUP BY, HAVING, Aggregations
│   ├── 03_sql_string_functions.sql     # Text manipulation functions
│   ├── 04_sql_datetime_functions.sql   # Date and time handling
│   ├── 05_sql_Null_functions.sql       # NULL handling strategies
│   ├── 06_sql_window_aggregate_functions.sql   # Window functions for analytics
│   ├── 07_sql_window_ranking_functions.sql     # Ranking and numbering
│   ├── 08_sql_window_value_functions.sql       # LAG, LEAD, FIRST_VALUE, LAST_VALUE
│   ├── 09_sql_subquery.sql             # Nested queries and correlated subqueries
│   ├── 10_sql_CTE.sql                  # Common Table Expressions (WITH clause)
│   ├── 11_sql_views.sql                # Creating and using views
│   ├── 12_sql_CTAS.sql                 # Create Table As Select
│   ├── 13_sql_TempTables.sql           # Temporary table management
│   ├── 14_sql_indexes.sql              # Query optimization with indexes
│   └── README.md                       # Complete learning guide
│
├── Solutions/                          # 🎯 DataLemur Interview Question Solutions (20+ Problems)
│   └── [Various .sql solution files]
│
├── Resources/                          # 📖 Additional reference materials
│
└── README.md                          # This file
```

## Purpose

✅ **Structured Learning** - 14 progressive modules from beginner to advanced SQL  
✅ **Interview Preparation** - 20+ real interview questions with solutions  
✅ **Skill Development** - Master SQL from basics to optimization techniques  
✅ **Reference Material** - Quick access to SQL patterns and best practices  
✅ **Hands-On Practice** - Learn concepts then apply them to interview problems  

## How to Use This Repository

### 🎓 For Learning SQL Fundamentals
1. Start with [Learn-SQL folder](./Learn-SQL/) - Contains 14 structured modules
2. Follow the progressive difficulty path from basics to advanced
3. Work through examples in each module file
4. Understand the schema relationships (see [Schema Diagram](./Learn-SQL/README.md#-database-schema))
5. Refer to [Learn-SQL README](./Learn-SQL/README.md) for complete module descriptions

### 🎯 For Interview Preparation
1. Browse the [Questions Table](#questions--solutions) below
2. Check the DataLemur challenge link to understand the problem
3. Review the solution provided in the [Solutions](./Solutions/) folder
4. Compare your approach with the provided solution
5. Study the SQL patterns and techniques used

### 🔄 Integrated Learning Path
1. **Phase 1 - Fundamentals** (Week 1-2): Complete modules 1-5 from [Learn-SQL](./Learn-SQL/)
2. **Phase 2 - Advanced Techniques** (Week 3-4): Complete modules 6-14 from [Learn-SQL](./Learn-SQL/)
3. **Phase 3 - Problem Solving** (Week 5+): Practice interview questions from [Solutions](./Solutions/)
4. **Phase 4 - Mastery** (Ongoing): Revisit challenging modules and optimize solution approaches

## Database Schema

All learning materials and solutions use a consistent schema with 4 interconnected tables:
- **Customers**: Customer information with loyalty scores
- **Products**: Product catalog with pricing
- **Orders**: Transaction records with relationships to customers and products
- **Employees**: Employee directory with hierarchical management structure

See the [Learn-SQL README](./Learn-SQL/README.md#-database-schema) for the complete schema diagram and detailed descriptions.

## Technologies & Tools

- **SQL Dialects**: T-SQL (SQL Server), with notes for PostgreSQL and MySQL variations
- **Learning Platform**: Designed for practice on local databases
- **Interview Platform**: [DataLemur](https://datalemur.com/)
- **File Format**: `.sql` files with detailed comments and explanations

## Questions & Solutions

| ID | DataLemur Question Link | Difficulty | My Solution |
|:--:|:-----------------------:|:---------: |:-----------:|
| 01 | [Histogram of Tweets](https://datalemur.com/questions/sql-histogram-tweets)| Easy | [Solution](./Solutions/Histogram-of-tweets.sql) |
| 02 | [Data Science Skills](https://datalemur.com/questions/matching-skills)| Easy | [Solution](./Solutions/DataScience-skill.sql) |
| 03 | [Page With No Likes](https://datalemur.com/questions/sql-page-with-no-likes)| Easy | [Solution](./Solutions/page-with-no-likes.sql) |
| 04 | [Unfinished Parts](https://datalemur.com/questions/tesla-unfinished-parts)| Easy | [Solution](./Solutions/unfinished-parts.sql) |
| 05 | [Laptop vs. Mobile Viewership](https://datalemur.com/questions/laptop-mobile-viewership)| Easy | [Solution](./Solutions/laptop-mobile-viewership.sql) |
| 06 | [Average Post Hiatus (Part 1)](https://datalemur.com/questions/sql-average-post-hiatus-1)| Easy | [Solution](./Solutions/avg-post.sql) |
| 07 | [Teams Power Users](https://datalemur.com/questions/teams-power-users)| Easy | [Solution](./Solutions/teams-power-users.sql) |
| 08 | [Duplicate Job Listings](https://datalemur.com/questions/duplicate-job-listings)| Easy | [Solution](./Solutions/duplicate-job-listings.sql) |
| 09 | [Cities With Completed Trades](https://datalemur.com/questions/completed-trades)| Easy | [Solution](./Solutions/cities-with-completed-trades.sql) |
| 10 | [Average Review Ratings](https://datalemur.com/questions/sql-avg-review-ratings)| Easy | [Solution](./Solutions/average-review-ratings.sql) |
| 11 | [Well Paid Employees](https://datalemur.com/questions/sql-well-paid-employees)| Easy | [Solution](./Solutions/well-paid-employees.sql) |
| 12 | [Final Account Balance](https://datalemur.com/questions/final-account-balance)| Easy | [Solution](./Solutions/final-account-balance.sql) |
| 13 | [App Click-through Rate (CTR)](https://datalemur.com/questions/click-through-rate)| Easy | [Solution](./Solutions/click-through-rate.sql) |
| 14 | [IBM db2 Product Analytics](https://datalemur.com/questions/sql-ibm-db2-product-analytics)| Easy | [Solution](./Solutions/ibm-db2-product-analysis.sql) |
| 15 | [Cards Issued Difference](https://datalemur.com/questions/cards-issued-difference)| Easy | [Solution](./Solutions/cards_issued_difference.sql) |
| 16 | [Compressed Mean](https://datalemur.com/questions/alibaba-compressed-mean)| Easy | [Solution](./Solutions/compressed_mean.sql) |
| 17 | [Pharmacy Analytics (Part 1)](https://datalemur.com/questions/top-profitable-drugs)| Easy | [Solution](./Solutions/Pharmacy-analytics-top-profitable-drugs.sql) |
| 18 | [Pharmacy Analytics (Part 2)](https://datalemur.com/questions/non-profitable-drugs)| Easy | [Solution](./Solutions/Pharmacy-analytics-non-profitable-drugs.sql) |
| 19 | [Pharmacy Analytics (Part 3)](https://datalemur.com/questions/total-drugs-sales)| Easy | [Solution](./Solutions/Pharmacy-analytics-total-drugs-sales.sql) |
| 20 | [Patient Support Analysis (Part 1)](https://datalemur.com/questions/frequent-callers)| Easy | [Solution](./Solutions/frequent-callers.sql) |
| 21 | [User's Third Transaction](https://datalemur.com/questions/sql-third-transaction)| Medium | [Solution](./Solutions/third-transaction.sql) |
| 22 | [Second Highest Salary](https://datalemur.com/questions/sql-second-highest-salary)| Medium | [Solution](./Solutions/second-highest-salary.sql) |
| 32 | [Sending vs. Opening Snaps](https://datalemur.com/questions/time-spent-snaps)| Medium | [Solution](./Solutions/sending_vs_opening_snaps.sql)


## Progress

Keep track of completed questions above in the table.

## 📚 Related Resources

### Learn-SQL Folder
- **[Complete Learning Guide](./Learn-SQL/README.md)** - Detailed descriptions of all 14 modules
- **[Module 01: SQL Basics](./Learn-SQL/01_sql_basics.sql)** - Foundation concepts
- **[Module 02: SQL Intermediate](./Learn-SQL/02_sql_intermediate.sql)** - JOINs and aggregations
- **[Modules 03-05: Functions](./Learn-SQL/)** - String, DateTime, and NULL functions
- **[Modules 06-08: Window Functions](./Learn-SQL/)** - Advanced analytics
- **[Modules 09-14: Advanced Topics](./Learn-SQL/)** - Subqueries, CTEs, Views, Optimization

### Solutions Folder
- **[20+ DataLemur Solutions](./Solutions/)** - Interview problem solutions with explanations

## 🎯 Learning Recommendations

### Beginner Path (1-3 weeks)
- Focus on [Learn-SQL](./Learn-SQL/) modules 1-5
- Understand basic SELECT, JOINs, GROUP BY, and functions
- Practice with simple queries before moving to solutions

### Intermediate Path (2-4 weeks)
- Complete modules 6-8: Window functions and aggregations
- Study real solutions from [Solutions](./Solutions/) folder
- Apply window functions to interview problems

### Advanced Path (3-5 weeks)
- Master modules 9-14: Subqueries, CTEs, Views, and Optimization
- Solve complex interview questions
- Optimize queries using indexes and execution plans

### Interview Prep Sprint (1-2 weeks)
- Review modules relevant to each [interview question](./Solutions/)
- Practice similar problems to build confidence
- Focus on explaining your approach, not just writing code

## 💡 Best Practices

1. **Start with Fundamentals** - Complete the [Learn-SQL](./Learn-SQL/) modules in order
2. **Understand the Schema** - Familiarize yourself with all 4 tables and their relationships
3. **Run Locally** - Execute queries against the schema to see results
4. **Comment Code** - Add explanations to your queries for future reference
5. **Compare Solutions** - After solving, compare your approach with provided solutions
6. **Review Patterns** - Identify recurring SQL patterns and techniques
7. **Optimize Gradually** - First get correct results, then optimize for performance

## 🔗 Quick Links

- **Learn SQL Fundamentals**: [Learn-SQL Folder](./Learn-SQL/)
- **Practice Interview Questions**: [Solutions Folder](./Solutions/)
- **View Database Schema**: [Schema Diagram](./Learn-SQL/README.md#-database-schema)
- **DataLemur Platform**: [https://datalemur.com/](https://datalemur.com/)

---

**Happy Learning! 🚀**

Whether you're building SQL skills from scratch or preparing for interviews, this repository provides everything you need to master SQL and succeed.
