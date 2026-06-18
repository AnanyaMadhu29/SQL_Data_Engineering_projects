select job_posted_date,
  job_posted_date :: date as date,
  job_posted_date :: time as time,
  job_posted_date :: timestamp as timestamp,
  job_posted_date :: timestamptz as timestamptz
from job_postings_fact
limit 10;

--extract
select 
  date_trunc('month', job_posted_date):: date as job_posted_month,
  count(job_id) as job_count
  from job_postings_fact
  where job_title_short = 'Data Engineer'
  and extract(year from job_posted_date) = 2024
  group by
  date_trunc('month', job_posted_date)
order by job_posted_month desc;

--date trunc date_trunc('precision', date_time )

select 
job_posted_date,
date_trunc('year', job_posted_date)::date as job_posted_year,
date_trunc('quarter', job_posted_date)::date as job_posted_quarter,
date_trunc('month', job_posted_date) ::date as job_posted_month,
date_trunc('week', job_posted_date) :: date as job_posted_week,
date_trunc('day', job_posted_date):: date as job_posted_day,
date_trunc('hour', job_posted_date):: time as job_posted_hour
from job_postings_fact
order by random()
limit 10;


--timezone
select 
'2026-01-01 00:00:00'::timestamptz at time zone 'EST';

select
job_title_short,
job_location,
job_posted_date at time zone 'UTC' at time zone 'IST'
from job_postings_fact
where
 job_location like 'New York, NY'
limit 10;


select 
 extract(hour from job_posted_date at time zone 'UTC' at time zone 'IST') as job_posted_hour,
 count(job_id) as job_count
from job_postings_fact
where job_location like 'New York, NY'
group by
  extract(hour from job_posted_date at time zone 'UTC' at time zone 'IST')
order by job_posted_hour;