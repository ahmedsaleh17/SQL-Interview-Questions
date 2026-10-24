# SQL-Interview-Questions & Learning Materials

A comprehensive SQL learning and interview preparation repository combining foundational learning materials with real-world problem-solving solutions. Perfect for building SQL skills from basics to advanced techniques and preparing for data interviews on [DataLemur](https://datalemur.com/) and [DataDriven](https://datadriven.io/)

## 📁 Repository Structure

```
SQL-problemsolving/
├── Learn-SQL/                          # 📚 Foundational Learning Materials (20 Modules)
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
│   ├── 15_sql_index_maintenance.sql    # Index maintenance strategies
│   ├── 16_sql_data_partitioning.sql    # Data partitioning concepts and techniques
│   ├── 17_sql_query_optimization_techniques.sql # Query optimization techniques
│   ├── 18_sql_stored_procedure.sql     # Stored procedures and reusable database logic
│   ├── 19_sql_triggers.sql             # Triggers for auditing and automated actions
│   ├── 20_transactions.sql            # Transactions, ACID compliance, and rollback safety
│   └── README.md                       # Complete learning guide
│
├── Solutions/                          # 🎯 Interview Question Solutions (48 Problems)
│   └── [Various .sql solution files]
│
├── Resources/                          # 📖 Additional reference materials
│
└── README.md                          # This file
```

## Purpose

✅ **Structured Learning** - 20 progressive modules from beginner to advanced SQL  
✅ **Interview Preparation** - 49 real interview questions with solutions  
✅ **Skill Development** - Master SQL from basics to optimization techniques  
✅ **Reference Material** - Quick access to SQL patterns and best practices  
✅ **Hands-On Practice** - Learn concepts then apply them to interview problems  

## How to Use This Repository

### 🎓 For Learning SQL Fundamentals
1. Start with [Learn-SQL folder](./Learn-SQL/) - Contains 20 structured modules
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
2. **Phase 2 - Advanced Techniques** (Week 3-4): Complete modules 6-19 from [Learn-SQL](./Learn-SQL/)
3. **Phase 3 - Transactions & Safety** (Week 5): Review module 20 for transaction integrity and rollback patterns
4. **Phase 4 - Problem Solving** (Week 6+): Practice interview questions from [Solutions](./Solutions/)
5. **Phase 5 - Mastery** (Ongoing): Revisit challenging modules and optimize solution approaches

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

## Questions & Solutions - time to practice :)

| ID | DataLemur Question Link | Difficulty | My Solution |
|:--:|:-----------------------:|:---------: |:-----------:|
| 01 | [Histogram of Tweets](https://datalemur.com/questions/sql-histogram-tweets)| Easy | [Solution](./Solutions/Histogram-of-tweets.sql) |
| 02 | [Where Users Linger](https://datadriven.io/problems/where_users_linger)| Easy | [Solution](./Solutions/users_linger.sql) |
| 03 | [Data Science Skills](https://datalemur.com/questions/matching-skills)| Easy | [Solution](./Solutions/DataScience-skill.sql) |
| 04 | [Page With No Likes](https://datalemur.com/questions/sql-page-with-no-likes)| Easy | [Solution](./Solutions/page-with-no-likes.sql) |
| 05 | [Unfinished Parts](https://datalemur.com/questions/tesla-unfinished-parts)| Easy | [Solution](./Solutions/unfinished-parts.sql) |
| 06 | [Laptop vs. Mobile Viewership](https://datalemur.com/questions/laptop-mobile-viewership)| Easy | [Solution](./Solutions/laptop-mobile-viewership.sql) |
| 07 | [Average Post Hiatus (Part 1)](https://datalemur.com/questions/sql-average-post-hiatus-1)| Easy | [Solution](./Solutions/avg-post.sql) |
| 08 | [Teams Power Users](https://datalemur.com/questions/teams-power-users)| Easy | [Solution](./Solutions/teams-power-users.sql) |
| 09 | [Duplicate Job Listings](https://datalemur.com/questions/duplicate-job-listings)| Easy | [Solution](./Solutions/duplicate-job-listings.sql) |
| 10 | [Cities With Completed Trades](https://datalemur.com/questions/completed-trades)| Easy | [Solution](./Solutions/cities-with-completed-trades.sql) |
| 11 | [Average Review Ratings](https://datalemur.com/questions/sql-avg-review-ratings)| Easy | [Solution](./Solutions/average-review-ratings.sql) |
| 12 | [Well Paid Employees](https://datalemur.com/questions/sql-well-paid-employees)| Easy | [Solution](./Solutions/well-paid-employees.sql) |
| 13 | [Final Account Balance](https://datalemur.com/questions/final-account-balance)| Easy | [Solution](./Solutions/final-account-balance.sql) |
| 14 | [App Click-through Rate (CTR)](https://datalemur.com/questions/click-through-rate)| Easy | [Solution](./Solutions/click-through-rate.sql) |
| 15 | [IBM db2 Product Analytics](https://datalemur.com/questions/sql-ibm-db2-product-analytics)| Easy | [Solution](./Solutions/ibm-db2-product-analysis.sql) |
| 16 | [Cards Issued Difference](https://datalemur.com/questions/cards-issued-difference)| Easy | [Solution](./Solutions/cards_issued_difference.sql) |
| 17 | [Compressed Mean](https://datalemur.com/questions/alibaba-compressed-mean)| Easy | [Solution](./Solutions/compressed_mean.sql) |
| 18 | [Pharmacy Analytics (Part 1)](https://datalemur.com/questions/top-profitable-drugs)| Easy | [Solution](./Solutions/Pharmacy-analytics-top-profitable-drugs.sql) |
| 19 | [Pharmacy Analytics (Part 2)](https://datalemur.com/questions/non-profitable-drugs)| Easy | [Solution](./Solutions/Pharmacy-analytics-non-profitable-drugs.sql) |
| 20 | [Pharmacy Analytics (Part 3)](https://datalemur.com/questions/total-drugs-sales)| Easy | [Solution](./Solutions/Pharmacy-analytics-total-drugs-sales.sql) |
| 21 | [Active Token Owners in 2026](https://datadriven.io/problems/active_token_owners_in_year)| Easy | [Solution](./Solutions/active_token_owners.sql) |
| 22 | [Patient Support Analysis (Part 1)](https://datalemur.com/questions/frequent-callers)| Easy | [Solution](./Solutions/frequent-callers.sql) |
| 23 | [30-Day Page View Counts](https://datadriven.io/problems/30_day_page_view_counts)| Easy | [Solution](./Solutions/30-days-views.sql) |
| 24 | [User's Third Transaction](https://datalemur.com/questions/sql-third-transaction)| Medium | [Solution](./Solutions/third-transaction.sql) |
| 25 | [Second Highest Salary](https://datalemur.com/questions/sql-second-highest-salary)| Medium | [Solution](./Solutions/second-highest-salary.sql) |
| 26 | [Sending vs. Opening Snaps](https://datalemur.com/questions/time-spent-snaps)| Medium | [Solution](./Solutions/sending_vs_opening_snaps.sql) |
| 27 | [Tweets' Rolling Averages](https://datalemur.com/questions/rolling-average-tweets)| Medium | [Solution](./Solutions/tweets_moving_avg.sql) |
| 28 | [Highest-Grossing Items](https://datalemur.com/questions/sql-highest-grossing)| Medium | [Solution](./Solutions/highest_grossing_items.sql) |
| 29 | [Top Three Salaries](https://datalemur.com/questions/sql-top-three-salaries)| Medium | [Solution](./Solutions/top_three_salaries.sql) |
| 30 | [Signup Activation Rate](https://datalemur.com/questions/signup-confirmation-rate)| Medium | [Solution](./Solutions/signup_activation_rate.sql) |
| 31 | [Spotify Streaming History](https://datalemur.com/questions/spotify-streaming-history)| Medium | [Solution](./Solutions/spotify_streaming_hist.sql) |
| 32 | [Supercloud Customer](https://datalemur.com/questions/supercloud-customer)| Medium | [Solution](./Solutions/supercloud_customers.sql) |
| 33 | [Odd and Even Measurements](https://datalemur.com/questions/odd-even-measurements)| Medium | [Solution](./Solutions/odd_even_measurements.sql) |
| 34 | [FAANG Stock Min-Max (Part 1)](https://datalemur.com/questions/sql-bloomberg-stock-min-max-1)| Medium | [Solution](./Solutions/fanng_stock_min_max.sql) |
| 35 | [Swapped Food Delivery](https://datalemur.com/questions/sql-swapped-food-delivery)| Medium | [Solution](./Solutions/swapped_food_delivery.sql) |
| 36 | [Best-Selling Product](https://datalemur.com/questions/best-selling-products)| Medium | [Solution](./Solutions/best-selling-product.sql) |
| 37 | [User Shopping Sprees](https://datalemur.com/questions/amazon-shopping-spree)| Medium | [Solution](./Solutions/user-shopping-sprees.sql) |
| 38 | [Histogram of Users and Purchases](https://datalemur.com/questions/histogram-users-purchases)| Medium | [Solution](./Solutions/histogram-users-purchases.sql) |
| 39 | [Compressed Mode](https://datalemur.com/questions/alibaba-compressed-mode)| Medium | [Solution](./Solutions/compressed-mode.sql) |
| 40 | [Card Launch Success](https://datalemur.com/questions/card-launch-success)| Medium | [Solution](./Solutions/card-launch-sucess.sql) |
| 41 | [International Call Percentage](https://datalemur.com/questions/international-call-percentage)| Medium | [Solution](./Solutions/international_call_percentage.sql) |
| 42 | [Patient Support Analysis (Part 2)](https://datalemur.com/questions/uncategorized-calls-percentage)| Medium | [Solution](./Solutions/patient-support-analysis.sql) |
| 43 | [Cloud Costs Analysis](https://datadriven.io/problems/above_average_cloud_spend)| Medium | [Solution](./Solutions/cloud_costs_analysis.sql) |
| 44 | [Suspected Bot Sessions](https://datadriven.io/problems/suspected_bot_sessions)| Medium | [Solution](./Solutions/suspected-bot-sessions.sql) |
| 45 | [Where the Fleet Lives](https://datadriven.io/problems/nodes_in_key_regions)| Medium | [Solution](./Solutions/nodes_in_keys_regions.sql) |
| 46 | [Above Average Product Prices](https://datadriven.io/problems/above_average_product_prices)| Medium | [Solution](./Solutions/above_average_prices.sql) |
| 47 | [What's in a Name](https://datadriven.io/problems/what_s_in_a_name)| Medium | [Solution](./Solutions/what_is_in_a_name.sql) |
| 48 | [Active Campaigns](https://datadriven.io/problems/active_campaigns)| Medium | [Solution](./Solutions/active_campaigns.sql) |
| 49 | [The Days That Line Up](https://datadriven.io/problems/the_days_that_line_up)| Medium | [Solution](./Solutions/data_pipes_success.sql) |
| 50 | [Above the Fold](https://datadriven.io/problems/above_the_fold)| Medium | [Solution](./Solutions/above_the_fold.sql) |
| 51 | [Above Average Interactions](https://datadriven.io/problems/above_average_interactions)| Hard | [Solution](./Solutions/above_avg_interactions.sql) |
| 52 | [Campaign Bookend Engagement](https://datadriven.io/problems/campaign_bookend_engagement)| Hard | [Solution](./Solutions/campaign_engagement.sql) |
| 53 | [Bargains and Budget-Busters](https://datadriven.io/problems/bargains_and_budget_busters)| Hard | [Solution](./Solutions/campaign_engagement.sql) |
| 54 | [Content Sorted by Duration](https://datadriven.io/problems/content_sorted_by_duration)| Hard | [Solution](./Solutions/content_sorted_by_duration.sql) |


## Progress

Keep track of completed questions above in the table.

## 📚 Related Resources

### Learn-SQL Folder
- **[Complete Learning Guide](./Learn-SQL/README.md)** - Detailed descriptions of all 20 modules
- **[Module 01: SQL Basics](./Learn-SQL/01_sql_basics.sql)** - Foundation concepts
- **[Module 02: SQL Intermediate](./Learn-SQL/02_sql_intermediate.sql)** - JOINs and aggregations
- **[Modules 03-05: Functions](./Learn-SQL/)** - String, DateTime, and NULL functions
- **[Modules 06-08: Window Functions](./Learn-SQL/)** - Advanced analytics
- **[Modules 09-20: Advanced Topics](./Learn-SQL/)** - Subqueries, CTEs, Views, Temp Tables, Indexes, Maintenance, Partitioning, Query Optimization, Stored Procedures, Triggers, and Transactions

### Solutions Folder
- **[48 SQL Solutions](./Solutions/)** - Interview problem solutions with explanations

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
- Master modules 9-20: Subqueries, CTEs, Views, Temp Tables, Indexes, Maintenance, Partitioning, Query Optimization, Stored Procedures, Triggers, and Transactions
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
- **DataDriven Platform**: [https://datadriven.io/](https://datadriven.io/)

---

**Happy Learning! 🚀**

Whether you're building SQL skills from scratch or preparing for interviews, this repository provides everything you need to master SQL and succeed.
