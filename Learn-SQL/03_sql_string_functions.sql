-- SQL FUNCTIONS 
--------------------
/* String Fuctions 
-- Manipulation 
   - CONCAT
   - UPPER
   - LOWER
   - TRIM 
   - REPLACE 

-- Calculation 
  - LEN 

-- String Extraction 
  - LEFT
  - RIGHT
  - SUBSTRING
*/


/* Concate first name and country into one column */


SELECT CONCAT(first_name,' ',country) name_country
FROM customers




/* Upper & Lower */
-- Convert first name to lower 
SELECT LOWER(first_name) low_name
FROM customers

-- convert the first name to upper
SELECT UPPER(first_name) up_name
FROM customers


-- Trim function 
-- remove leading and trailing spacing 

-- Find Customers whose first name contains leading or trailing spaces

SELECT first_name
FROM customers
WHERE first_name != TRIM(first_name)

-- another complicated solution 

SELECT 
    first_name,
    LEN(first_name) Len_name, 
    LEN(TRIM(first_name)) len_trim_name,
    LEN(first_name) - LEN(TRIM(first_name)) Flag
FROM customers
where LEN(first_name) - LEN(TRIM(first_name)) !=0;



---

-- Replace Function (Replaces specific character with a new character)

-- remove dashes (-) from a phone number
SELECT 
'123-88-99' phone,
REPLACE('123-88-99','-','') clean_phone


-- Replace file extence form txt to csv
SELECT
'Report.txt' old_filename,
REPLACE('Report.txt', '.txt', '.csv')  new_filename



-- LEN FUNCTION (Counts How many Characters / digits)
SELECT 
LEN('Ahmed'),
LEN('Mariam')


-- Calculate teh length of each customer's first name 
SELECT 
    first_name,
    LEN(first_name) len_firstname
from customers



-- String Extraction Functions 

-- LEFT FUNCTION  & RIGHT FUNCTION 
SELECT
    first_name, 
    LEFT(TRIM(first_name),2 ) as first_two,
    RIGHT(TRIM(first_name),2) as last_two
 
FROM customers


-- SUBSTRING FUNCTION  (Extracts a part of string at a specific position)


-- Retrieve a list of customers's first names after removing the first character
SELECT
    first_name,
    SUBSTRING(TRIM(first_name), 2, LEN(first_name)) Sub_name
FROM customers