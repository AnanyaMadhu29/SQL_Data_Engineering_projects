select 
    job_id,
    job_title_short,
    cd.company_id
from 
    job_postings_fact as jpf
left join company_dim as cd
on jpf.company_id = cd.company_id
limit 10;
