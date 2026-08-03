-- Calculate the number of sessions per user
with sessions_count_per_user as 
(
  select
     user_id, 
     count(session_id) session_count  -- total sessions for each user
  from user_sessions
  group by user_id
)

select 
   user_id, 
   session_count as total_session  -- return users that exceed the average session count
from sessions_count_per_user 
where session_count > 
(
  -- compute the overall average session count across all users
  select 
    avg(session_count)
  from sessions_count_per_user 
)





















