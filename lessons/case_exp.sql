--bucketing data into groups using case expressions
select
job_title_short,
salary_hour_avg,
case 
when salary_hour_avg < 25 then 'Low'
when salary_hour_avg <50 then 'Medium'
else 'High'
end as salary_category
from job_postings_fact
where salary_hour_avg is not null
limit 10;

--filter null salary values

select
job_title_short,
salary_hour_avg,
case 
when salary_hour_avg is null then 'Missing'
when salary_hour_avg < 25 then 'Low'
when salary_hour_avg <50 then 'Medium'
else 'High'
end as salary_category
from job_postings_fact
limit 10;


--categorizing categorical values
with title_lower as (
    select
        job_title,
        lower(trim(job_title)) as job_title_clean
    from job_postings_fact
)
select 
    job_title,
    case
    when job_title_clean like '%data%' and job_title_clean like '%analyst%' then 'Data Analyst'
    when job_title_clean like '%data%' and job_title_clean like '%engineer%' then 'Data Engineer'
    when job_title_clean like '%data%' and job_title_clean like '%scientist%' then 'Data Scientist'
    else 'Other'
end as job_title_category,
from title_lower
order by random()
limit 30;

--calculate median salaries for different buckets

select
  job_title_short,
  count(*) as total_postings,
  median(
    case
      when salary_year_avg < 100000 then salary_year_avg
    end
  ) as median_low_salary,
  median(
    case
      when salary_year_avg >= 100000 then salary_year_avg
    end
  ) as median_high_salary
from job_postings_fact
where salary_year_avg is not null
group by job_title_short;

--conditional calculations
--categorizing salaries into tiers


with salaries as(
    select
        job_title_short,
        salary_hour_avg,
        salary_year_avg,
        case
            when salary_year_avg is not null then salary_hour_avg
            when salary_hour_avg is not null then salary_year_avg * 2080
        end as standardized_salary
    from job_postings_fact
)

select *,
case 
when standardized_salary is null then 'Missing'
when standardized_salary < 75000 then 'Low'
when standardized_salary < 150000 then 'Medium'
else 'High'
end as salary_bucket
from salaries
order by standardized_salary 
limit 10;