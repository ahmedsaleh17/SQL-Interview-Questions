-- ===================================================================
-- SQL QUERY: FANNG Stock Min/Max Analysis
-- PURPOSE: Find the month with highest and lowest opening prices for each stock ticker
-- USES: Window functions (ROW_NUMBER), CTEs, and date formatting
-- ===================================================================

-- CTE 1: Identify the highest opening price for each ticker
WITH highest_open AS
(
  -- Inner query with window function
  SELECT 
    *
  FROM 
  (
    -- Extract month-year, partition by ticker, rank by open price descending
    SELECT 
    TO_CHAR(date, 'Mon-yyyy') AS highest_mth, 
    ticker, 
    open, 
    -- ROW_NUMBER assigns rank 1 to the highest opening price per ticker
    ROW_NUMBER() OVER(PARTITION BY ticker ORDER BY open DESC) RN
    FROM stock_prices 
  )T 
  -- Keep only the row with rank 1 (highest open price)
  WHERE RN = 1
), 
-- CTE 2: Identify the lowest opening price for each ticker
  Lowest_open AS
(
  SELECT 
    *
  FROM 
  (
    -- Extract month-year, partition by ticker, rank by open price ascending
    SELECT 
    TO_CHAR(date, 'Mon-yyyy') AS lowest_mth, 
    ticker, 
    open, 
    -- ROW_NUMBER assigns rank 1 to the lowest opening price per ticker
    ROW_NUMBER() OVER(PARTITION BY ticker ORDER BY open ASC) RN
    FROM stock_prices 
  )T 
  -- Keep only the row with rank 1 (lowest open price)
  WHERE RN = 1
)


-- FINAL RESULT: Join highest and lowest CTEs to display side-by-side comparison
SELECT 
  highest_open.ticker, 
  -- Month when highest opening price occurred
  highest_open.highest_mth,
  -- The highest opening price value
  highest_open.open as highest_open, 
  -- Month when lowest opening price occurred
  lowest_open.lowest_mth, 
  -- The lowest opening price value
  lowest_open.open as lowest_open
-- Inner join ensures we only match tickers that exist in both CTEs
FROM highest_open 
JOIN lowest_open 
ON highest_open.ticker = lowest_open.ticker



  
  