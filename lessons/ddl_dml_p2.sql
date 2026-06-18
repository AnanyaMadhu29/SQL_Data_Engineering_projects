-- .read lessons/ddl_dml_p2.sql
create or replace table staging.job_postings_flat as
select
  jpf.job_id,
  jpf.job_title_short,
  jpf.job_title,
  jpf.job_location,
  jpf.job_via,
  jpf.job_schedule_type,
  jpf.job_work_from_home,
  jpf.search_location,
  jpf.job_posted_date,
  jpf.job_no_degree_mention,
  jpf.job_health_insurance,
  jpf.job_country,
  jpf.salary_rate,
  jpf.salary_year_avg,
  jpf.salary_hour_avg,
  cd.name as company_name
from data_jobs.job_postings_fact as jpf
left join data_jobs.company_dim as cd
  on jpf.company_id = cd.company_id;


select count(*) from staging.job_postings_flat;

create or replace view staging.priority_jobs_flat_view as
select jpf.* 
from staging.job_postings_fact as jpf
join staging.priority_roles as r
on jpf.job_title_short = r.role_name
where r.priority_lvl = 1;

select 
    job_title_short,
    count(*) as job_count
from staging.priority_jobs_flat_view
group by job_title_short
order by job_count desc;

create temporary table data_engineering_jobs as
select *
from staging.priority_jobs_flat_view
where job_title_short = 'Data Engineer';

select
 job_title_short,
    count(*) as job_count
from data_engineering_jobs
group by job_title_short;

select count(*) from staging.job_postings_flat;
select count(*) from staging.priority_jobs_flat_view;
select count(*) from data_engineering_jobs;

delete from staging.job_postings_flat
where job_posted_date < '2024-01-01';

truncate table staging.job_postings_flat;

select * from staging.job_postings_flat;

insert into staging.job_postings_flat
select
  jpf.job_id,
  jpf.job_title_short,
  jpf.job_title,
  jpf.job_location,
  jpf.job_via,
  jpf.job_schedule_type,
  jpf.job_work_from_home,
  jpf.search_location,
  jpf.job_posted_date,
  jpf.job_no_degree_mention,
  jpf.job_health_insurance,
  jpf.job_country,
  jpf.salary_rate,
  jpf.salary_year_avg,
  jpf.salary_hour_avg,
  cd.name as company_name
from data_jobs.job_postings_fact as jpf
left join data_jobs.company_dim as cd
  on jpf.company_id = cd.company_id
  where jpf.job_posted_date < '2024-01-01';
