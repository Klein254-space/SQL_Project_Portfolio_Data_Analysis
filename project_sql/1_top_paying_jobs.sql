/*
Question: What are the top paying Data Analyst jobs?
- Identify the top 10 highest-paying jobs for the role of Data Analyst job available remotely.
- Focuses on job postings with specified salary (remove nulls).
- Why? highlight the top paying opportunities for Data Analysts, offering insights into lucrative career options in this field.
*/

SELECT 
    job_id,
    job_title,
    job_location,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN
    company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;