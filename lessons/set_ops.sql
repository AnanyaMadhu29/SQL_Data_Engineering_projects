select UNNEST([1,1,1,2])
except all
select UNNEST([1,1,3]);

create or replace temp table jobs_2023 as
select * exclude (job_id,job_posted_date)
from job_postings_fact
where extract(year from job_posted_date) = 2023;

select * from jobs_2023;

create or replace temp table jobs_2024 as
select * exclude (job_id,job_posted_date)
from job_postings_fact
where extract(year from job_posted_date) = 2024;

select * from jobs_2024;

-- which job postings appeared across both years, without counting duplicates

select 
 'jobs_2023' as table_name,
count(*) as row_count from jobs_2023
union 
select 
'jobs_2024' as table_name,
count(*) as row_count from jobs_2024;

-- which job postings appeared across both years, counting duplicates
select * from jobs_2023
union all
select * from jobs_2024;

--which job postings appeared in 2023 but not in 2024
select * from jobs_2023
except 
select * from jobs_2024;

--which job postings from 2023 remain after subracting matching 2024 postings, one-for-one?
select * from jobs_2023
except all
select * from jobs_2024;

--which job postings appeared in both 2023 and 2024?
select * from jobs_2023
intersect
select * from jobs_2024;

--which job postings appeared in both 2023 and 2024 preserving duplicates?
select * from jobs_2023
intersect all
select * from jobs_2024;