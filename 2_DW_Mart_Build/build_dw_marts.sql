--duckdb dw_marts.duckdb -c ".read build_dw_marts.sql" 

--Step 1: DW - create star schema tables
.read 01_create_tables_dw.sql

--Step 2: DW - load data into tables  
.read 02_load_schema_dw.sql

--Step 3: DW - create flat mart table
.read 03_create_flat_mart.sql

--Step 4: DW - create skills mart
.read 04_create_skills_mart.sql

--Step 5: DW - create priority mart
.read 05_create_priority_mart.sql

--Step 6: DW - update priority mart
.read 06_update_priority_mart.sql

-- Step 7: Mart - Create company prospecting mart
.read 07_create_company_mart.sql

-- Final verification
SELECT '=== Pipeline Build Complete ===' AS status;
SELECT 'All warehouse tables and marts created successfully' AS message;