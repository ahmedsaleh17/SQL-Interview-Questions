-- Calculate the percentage of international calls (calls between different countries)
SELECT 
  -- Count calls where caller and receiver are from different countries, multiply by 100 to get percentage
  -- Divide by total number of calls and round to 1 decimal place
  ROUND(SUM(CASE WHEN callers.country_id <> receivers.country_id THEN 1 ELSE NULL END) * 100.0 / COUNT(*),1) AS international_calls_pct
FROM phone_calls calls 
-- Join to get caller's country information
LEFT JOIN phone_info callers 
ON calls.caller_id = callers.caller_id 
-- Join to get receiver's country information
LEFT JOIN phone_info receivers 
ON calls.receiver_id = receivers.caller_id
