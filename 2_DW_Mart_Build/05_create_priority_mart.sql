--Step 5: Mart - Create priority mart

DROP SCHEMA IF EXISTS priority_mart CASCADE;

CREATE SCHEMA priority_mart;

SELECT '=== Loading Roles for Priority Mart ===' AS info;

CREATE TABLE priority_mart.priority_roles (
    role_id INTEGER PRIMARY KEY,
    role_name VARCHAR,
    priority_lvl INTEGER
);

INSERT INTO priority_mart.priority_roles(
    role_id,
    role_name,
    priority_lvl
)
VALUES
    (1, 'Data Engineer', 2),
    (2, 'Senior Data Engineer', 1),
    (3, 'Software Engineer', 3);

SELECT * FROM priority_mart.priority_roles;

SELECT '=== Loading Snapshots for Priority Mart ===' AS info;

create or replace table priority_mart.priority_jobs_snapshot (
    job_id integer primary key,
    job_title_short varchar,
    company_name varchar,
    job_posted_date timestamp,
    salary_year_avg double,
    priority_lvl integer,
    updated_at timestamp
);

insert into priority_mart.priority_jobs_snapshot(
    job_id,
    job_title_short,
    company_name,
    job_posted_date,
    salary_year_avg,
    priority_lvl,
    updated_at
)
select 
    jpf.job_id,
    jpf.job_title_short,
    cd.name as company_name,
    jpf.job_posted_date,
    jpf.salary_year_avg,
    r.priority_lvl,
    current_timestamp as updated_at
from job_postings_fact as jpf
left join company_dim as cd
on jpf.company_id = cd.company_id
join priority_mart.priority_roles as r
on jpf.job_title_short = r.role_name;

select job_title_short, count(*) as job_count,
min(priority_lvl) as priority_lvl,
min(updated_at) as updated_at
from priority_mart.priority_jobs_snapshot
group by job_title_short
order by job_count desc;

