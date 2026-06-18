select char_length('hello');

select lower('Ananya');

select upper('OLivia');

select left('SQL',2);

select right('SQL',2);

select substring('Ananya',3,3);

select concat ('Ananya','-','Madhu');

select 'Ananya' || '-' || 'Madhu';

--trimming functions

select ' SQL ';

select trim(' SQL ');

select ltrim('   Ananya');

select rtrim('Ananya    ');

--replacement fns

select replace('Ananya','a','A');

select regexp_replace('ananya.madhu@gmail.com','^.*(@)','\1');

--NULL Functions

--1. NULLIF --returns null if values are equal

select nullif(10,10); --null
select nullif(30,10); --30 

select 
nullif(salary_year_avg,0),
nullif(salary_hour_avg,0)
salary_hour_avg
from 
job_postings_fact
where salary_hour_avg is not null or salary_year_avg is not null
limit 10;


--coalesce --returns first non-null value

select 
salary_year_avg,
salary_hour_avg,
coalesce (salary_year_avg,salary_hour_avg *2080)
from job_postings_fact;


    select
        job_title_short,
        salary_hour_avg,
        salary_year_avg,
        coalesce (salary_year_avg,salary_hour_avg *2080) as standardized_salary,
    case
when coalesce (salary_year_avg,salary_hour_avg *2080) is null then 'Missing'
when coalesce (salary_year_avg,salary_hour_avg *2080) < 75000 then 'Low'
when coalesce (salary_year_avg,salary_hour_avg *2080) < 150000 then 'Medium'
else 'High'
end as salary_bucket
from job_postings_fact
order by standardized_salary desc
limit 10;