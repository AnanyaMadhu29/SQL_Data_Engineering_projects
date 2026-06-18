--.read lessons/ddl_dml.sql

create database if not exists jobs_mart;

show databases;

--drop database jobs_mart;

select *
from information_schema.schemata;

use jobs_mart;

create schema if not exists staging;

--drop schema staging;

create table if not exists staging.preferred_roles (
    role_id integer PRIMARY KEY,
    role_name varchar
);

--drop table if exists staging.preferred_roles;

select table_name
from information_schema.tables
where table_catalog = 'jobs_mart';


insert into staging.preferred_roles (role_id, role_name)values
    (1, 'Data Engineer'),
    (2, 'Data Scientist'),
    (3, 'Data Analyst'),
    (4, 'Business Analyst'),
    (5, 'Machine Learning Engineer'),
    (6, 'AI Engineer'),
    (7, 'Big Data Engineer'),
    (8, 'Data Architect'),
    (9, 'Database Administrator'),
    (10, 'Data Visualization Specialist');

select *
from staging.preferred_roles;

alter table staging.preferred_roles
add column preferred_role BOOLEAN;

update staging.preferred_roles
set preferred_role = True
where role_id = 1 or role_id=2;

update staging.preferred_roles
set preferred_role = false
where role_id = 3 or role_id=4;

alter table staging.preferred_roles
rename to priority_roles;

select *
from staging.priority_roles;

alter table staging.priority_roles
rename column preferred_role to priority_lvl;

alter table staging.priority_roles
alter column priority_lvl type integer;

update staging.priority_roles
set priority_lvl = 3
where role_id=5;