SELECT 
  sender_id, 
  COUNT(receiver_id) message_count
FROM 
  messages
WHERE 
  EXTRACT(YEAR FROM sent_date) = 2022 AND EXTRACT(MONTH FROM sent_date) = 8
GROUP BY  
  sender_id
ORDER BY message_count DESC
LIMIT 2;


