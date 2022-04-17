--Queries to extract data:
--Admission id and ICD9_CM code relationship with regular code
with diabete_patients as (select distinct icd.HADM_ID from `physionet-data.mimiciii_clinical.diagnoses_icd` icd
join `physionet-data.mimiciii_notes.noteevents` note on note.SUBJECT_ID = icd.SUBJECT_ID and note.HADM_ID = icd.HADM_ID
where ICD9_CODE like '250%' and note.HADM_ID is not null),
admission_icd as (select distinct dp.HADM_ID, dicd.ICD9_CODE from diabete_patients dp
join `physionet-data.mimiciii_clinical.diagnoses_icd` dicd on dp.HADM_ID = dicd.HADM_ID
order by dp.HADM_ID, dicd.ICD9_CODE)
select aicd.HADM_ID, string_agg(aicd.ICD9_CODE, ',') As icd_codes From admission_icd aicd
group by aicd.HADM_ID;

--Admission id and ICD9_CM code relationship with rolled up code
with diabete_patients as (select distinct icd.HADM_ID from `physionet-data.mimiciii_clinical.diagnoses_icd` icd
join `physionet-data.mimiciii_notes.noteevents` note on note.SUBJECT_ID = icd.SUBJECT_ID and note.HADM_ID = icd.HADM_ID
where ICD9_CODE like '250%' and note.HADM_ID is not null),
admission_icd as (select distinct dp.HADM_ID, SUBSTRING( dicd.ICD9_CODE, 1, 3 ) as ICD9_CODE from diabete_patients dp
join `physionet-data.mimiciii_clinical.diagnoses_icd` dicd on dp.HADM_ID = dicd.HADM_ID
order by dp.HADM_ID)
select aicd.HADM_ID, string_agg(aicd.ICD9_CODE, ',') As icd_codes From admission_icd aicd
group by aicd.HADM_ID;

--Note events training data:
select distinct note.HADM_ID, note.ROW_ID, note.SUBJECT_ID, note.CATEGORY, note.CGID, 
note.CHARTDATE, note.CHARTTIME,note.DESCRIPTION, note.ISERROR, note.STORETIME, note.TEXT
from `physionet-data.mimiciii_clinical.diagnoses_icd` icd
join `physionet-data.mimiciii_notes.noteevents` note on note.SUBJECT_ID = icd.SUBJECT_ID 
and note.HADM_ID = icd.HADM_ID
where ICD9_CODE like '250%' and note.HADM_ID is not null;

-- Note events category ordering:
with result as (select distinct note.HADM_ID, note.ROW_ID, note.SUBJECT_ID, note.CATEGORY, note.CGID, 
note.CHARTDATE, note.CHARTTIME,note.DESCRIPTION, note.ISERROR, note.STORETIME, note.TEXT
from `physionet-data.mimiciii_clinical.diagnoses_icd` icd
join `physionet-data.mimiciii_notes.noteevents` note on note.SUBJECT_ID = icd.SUBJECT_ID 
and note.HADM_ID = icd.HADM_ID
where ICD9_CODE like '250%' and note.HADM_ID is not null),
category_count as (select result.CATEGORY, count(*) as count
from result
group by result.CATEGORY)
select * from category_count
order by count desc; 