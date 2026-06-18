--subquery

select *
from (
    select * from staging.job_postings_fact
    where salary_year_avg is not null
    or salary_hour_avg is not null
) as valid_salaries
limit 10;

--cte

with valid_salaries as (
    select *
    from staging.job_postings_fact
    where salary_year_avg is not null
    or salary_hour_avg is not null
)

select *
from valid_salaries
limit 10;

--scenario 2: Subquery in from
-- stage only jobs that are remote before aggregating to determine the remote median salaries per job
select job_title_short,
median(salary_year_avg),
(
select median(salary_year_avg) as median_salary
from staging.job_postings_fact
where job_work_from_home = True
) as market_remote_median_salary
from 
(
  select 
  job_title_short,
    salary_year_avg
    from staging.job_postings_fact
    where job_work_from_home = True
  ) as clean_jobs
group by job_title_short
limit 10;

--scenario 3: Subquery in Having 
--Keep only those job titles where the median salary is above overall median:

select job_title_short,
median(salary_year_avg),
(
select median(salary_year_avg) as median_salary
from staging.job_postings_fact
where job_work_from_home = True
) as market_remote_median_salary
from 
(
  select 
  job_title_short,
    salary_year_avg
    from staging.job_postings_fact
    where job_work_from_home = True
  ) as clean_jobs
group by job_title_short
having median(salary_year_avg) > (
select median(salary_year_avg) as median_salary
from staging.job_postings_fact
where job_work_from_home = True
)
limit 10;

--CTE Example
--compare how much more remote jobs pay compared to onsite for each job title
--use a cte to calculate the median salary by title and work arrangement, then compare those medians.
with title_medians as (
    select 
    job_title_short,
    job_work_from_home,
    median(salary_year_avg):: int as market_median_salary
    from staging.job_postings_fact
    where job_country = 'India'
    group by job_title_short, job_work_from_home
)

select 
    r.job_title_short,
    r.market_median_salary as remote_median_salary,
    o.market_median_salary as onsite_median_salary,
    (r.market_median_salary - o.market_median_salary) as remote_premium
from title_medians as r
inner join title_medians as o
on r.job_title_short = o.job_title_short
where r.job_work_from_home = True
and o.job_work_from_home = False
order by remote_premium desc;



select 
* 
from range(3) as src(key);

select * 
from range(3) as tgt(key);

select *  from range(3) as src(key)
where not exists(
    select 1
    from range(2) as tgt(key)
    where src.key = tgt.key
);

select * from job_postings_fact as tgt
where not exists(
    select 1
    from skills_job_dim as src
    where tgt.job_id = src.job_id
)
order by job_id;