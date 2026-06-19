--duckdb dw_marts.duckdb -c ".read build_dw_marts.sql" 

--Step 1: DW - create star schema tables
.read 01_create_tables_dw.sql

--Step 2: DW - load data into tables  
.read 02_load_schema_dw.sql

--Step 3: DW - create flat mart table
.read 03_create_flat_mart.sql

--Step 4: DW - create skills mart
.read 04_create_skills_mart.sql