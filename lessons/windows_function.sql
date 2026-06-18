--count rows -- aggregation only

select 
  job_id,
  count(*) over ()
  from 
  job_postings_fact;

  --partition by -find hourly salary
  select 
  job_id,
  job_title_short,
  company_id
  salary_hour_avg,
  avg(salary_hour_avg) over (partition by job_title_short,company_id)
  from 
  job_postings_fact
  where salary_hour_avg is not null
  order by random()
  limit 10;

  --order by - ranking job with the highest to lowest salary

  select 
  job_id,
  job_title_short,
  salary_hour_avg,
  rank() over (order by salary_hour_avg desc) as rank_hourly_salary
  from 
  job_postings_fact
  where salary_hour_avg is not null
  order by salary_hour_avg desc
  limit 10;

  --partition by and order by

  select 
  job_posted_date,
  job_title_short,
  salary_hour_avg,
  avg(salary_hour_avg) over (
    partition by job_title_short
    order by job_posted_date)
    as running_avg_hourly_by_title
  from 
  job_postings_fact
  where salary_hour_avg is not null
  and job_title_short = 'Data Analyst'
  order by
   job_title_short, job_posted_date
  limit 10;

--partition by and order by -ranking by job_title_short

  select 
  job_id,
  job_title_short,
  salary_hour_avg,
  rank() over (
    partition by job_title_short
    order by salary_hour_avg desc
    ) as rank_hourly_salary
  from 
  job_postings_fact
  where salary_hour_avg is not null
  order by 
  job_title_short desc,
  salary_hour_avg
  limit 10;


  --aggregate function
  
  select 
  job_posted_date,
  job_title_short,
  salary_hour_avg,
  max(salary_hour_avg) over (
    partition by job_title_short
    order by job_posted_date)
    as running_avg_hourly_by_title
  from 
  job_postings_fact
  where salary_hour_avg is not null
  and job_title_short = 'Data Engineer'
  order by
   job_title_short, job_posted_date
  limit 10;

  --row and rank functions
  select 
  job_id,
  job_title_short,
  salary_hour_avg,
  dense_rank() over (order by salary_hour_avg desc) as rank_hourly_salary
  from 
  job_postings_fact
  where salary_hour_avg is not null
  order by salary_hour_avg desc
  limit 140;

  --row_number -- providing new  job_id

  select *,
   ROW_NUMBER() over (order by job_posted_date)
   from 
  job_postings_fact
  order by job_posted_date;

  --navigation functions
--lag and lead

select
    job_id,
    company_id,
    job_title,
    job_title_short,
    job_posted_date,
    salary_year_avg,
    lead(salary_year_avg)over(
        partition by company_id
        order by job_posted_date
    ) as previous_postings_salary,
    salary_year_avg - lead(salary_year_avg)over(
        partition by company_id
        order by job_posted_date
    ) as salary_change
from
    job_postings_fact
where salary_year_avg is not null
order by company_id, job_posted_date
limit 60;