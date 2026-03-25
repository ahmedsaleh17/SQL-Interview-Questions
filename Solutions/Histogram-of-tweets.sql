WITH tweets_num_per_users AS 
(
  -- Count the number of tweets for each user in 2022
  SELECT 
    user_id,                          -- Unique user identifier
    COUNT(tweet_id) tweets_num        -- Total tweets by this user
  FROM tweets
  WHERE YEAR(tweet_date) = 2022       -- Filter only 2022 tweets
  GROUP BY user_id                    
)

-- Step 2: Create the histogram by grouping users by their tweet counts
SELECT 
  tweets_num tweet_bucket,            -- Number of tweets (the bucket/bin)
  COUNT(*) users_num                  -- How many users have this bucket
FROM tweets_num_per_users
GROUP BY tweets_num                   -- Group by tweet count to get frequency



