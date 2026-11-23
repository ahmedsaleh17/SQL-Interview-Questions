SELECT 
    TRIM(LOWER(author)), 
    COUNT(message) commit_count, 
    COUNT(DISTINCT(repo_name)) repo_count
FROM repo_commits 
GROUP BY TRIM(LOWER(author))
HAVING COUNT(message) >=24





