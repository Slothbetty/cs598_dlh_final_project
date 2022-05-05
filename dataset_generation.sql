--Queries to extract data:
--Note events with rolled up and regular ICD9_CM code:
with diabete_patients as (select distinct note.HADM_ID, note.ROW_ID, note.SUBJECT_ID, note.CATEGORY, note.TEXT
from `physionet-data.mimiciii_clinical.diagnoses_icd` icd
join `physionet-data.mimiciii_notes.noteevents` note on note.SUBJECT_ID = icd.SUBJECT_ID and note.HADM_ID = icd.HADM_ID
where ICD9_CODE like '250%' and note.HADM_ID is not null 
and note.ISERROR is null and note.CHARTDATE is not null
and note.SUBJECT_ID is not null and note.TEXT is not null
and note.CATEGORY is not null and note.CGID is not null),
admission_icd as (select distinct dp.HADM_ID, dicd.ICD9_CODE as reg_icd_code, SUBSTRING( dicd.ICD9_CODE, 1, 3 ) as rolled_up_icd_code from diabete_patients dp
join `physionet-data.mimiciii_clinical.diagnoses_icd` dicd on dp.HADM_ID = dicd.HADM_ID
order by dp.HADM_ID, dicd.ICD9_CODE),
admission_icd_agg as (select distinct ai.HADM_ID, string_agg(distinct ai.rolled_up_icd_code, ',') As rolled_up_icd_codes, 
string_agg(ai.reg_icd_code, ',') as reg_icd_codes From admission_icd ai 
group by ai.HADM_ID)
select distinct dp.*,  aia.rolled_up_icd_codes, aia.reg_icd_codes
from diabete_patients dp
join admission_icd_agg aia on aia.HADM_ID = dp.HADM_ID
order by dp.HADM_ID;