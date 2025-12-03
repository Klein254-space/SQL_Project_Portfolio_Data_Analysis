/*
Question: What are the most optimal skills to learn(aka skills that are in high demand and also top paying) for Data Analyst roles?
-- Identify skills in high demand and associated with average salary for Data Analyst positions.
-- Concentrate in remote positions with specified salary.
-- Why? Target jobs that offer job security (high demand) and financial reward (top paying) offering strategic insights for career development in Data Analysis.
*/

WITH skills_demand AS (
    SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT (skills_job_dim.job_id) AS demand_count
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'  
     AND salary_year_avg IS NOT NULL
GROUP BY 
    skills_dim.skills, skills_dim.skill_id
), average_salary AS (
    SELECT 
    skills_job_dim.skill_id,
    skills,
    ROUND(AVG (salary_year_avg), 0) AS average_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'  
    AND salary_year_avg IS NOT NULL
GROUP BY 
    skills_dim.skills, skills_job_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    average_salary
FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    average_salary DESC,
    demand_count DESC
LIMIT 25;

--- Rewriting it in a more concise way

SELECT
    skills_dim.skill_id,
    skills_dim.skills,
     COUNT (skills_job_dim.job_id) AS demand_count,
    ROUND(AVG (salary_year_avg), 0) AS average_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'  
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id,
    skills_dim.skills
HAVING
    COUNT (skills_job_dim.job_id) > 10
ORDER BY
    average_salary DESC,
    demand_count DESC
LIMIT 25;