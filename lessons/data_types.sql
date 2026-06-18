describe
select 
table_name,
column_name,
 data_type
from information_schema.columns
where table_name = 'job_postings_fact';

select cast(123 as varchar) as string_value;

select 
cast(job_id as varchar) || '-' || cast(company_id as varchar) as job_company_id,
cast(job_work_from_home as int) as work_from_home,
cast(job_posted_date as date) as posted_date,
cast(salary_year_avg as decimal(10,0)) as salary_year_avg
from 
job_postings_fact
limit 10;

select 
job_id :: varchar || '-' || company_id :: varchar as job_company_id,
job_work_from_home :: int as work_from_home,
job_posted_date :: date as posted_date,
salary_year_avg :: decimal(10,0) as salary_year_avg
from 
job_postings_fact
where job_postings_Fact is not null
limit 10;