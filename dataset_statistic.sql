-- Number of used records
with result as (select distinct note.HADM_ID, note.ROW_ID, note.SUBJECT_ID, note.CATEGORY, note.CGID, 
note.CHARTDATE, note.CHARTTIME,note.DESCRIPTION, note.ISERROR, note.STORETIME, note.TEXT
from `physionet-data.mimiciii_clinical.diagnoses_icd` icd
join `physionet-data.mimiciii_notes.noteevents` note on note.SUBJECT_ID = icd.SUBJECT_ID 
and note.HADM_ID = icd.HADM_ID
where ICD9_CODE like '250%')
select count(*) as used_record_num from result where result.HADM_ID is not null;

-- Number of regular icd codes
with diabete_patients as (select distinct icd.HADM_ID from `physionet-data.mimiciii_clinical.diagnoses_icd` icd
join `physionet-data.mimiciii_notes.noteevents` note on note.SUBJECT_ID = icd.SUBJECT_ID and note.HADM_ID = icd.HADM_ID
where ICD9_CODE like '250%' and note.HADM_ID is not null),
regular_icd_codes as (select distinct dicd.ICD9_CODE from diabete_patients dp
join `physionet-data.mimiciii_clinical.diagnoses_icd` dicd on dp.HADM_ID = dicd.HADM_ID
order by dicd.ICD9_CODE)
select count(*) as regular_icd_codes_count from regular_icd_codes;

-- Number of rolled up icd codes
with diabete_patients as (select distinct icd.HADM_ID from `physionet-data.mimiciii_clinical.diagnoses_icd` icd
join `physionet-data.mimiciii_notes.noteevents` note on note.SUBJECT_ID = icd.SUBJECT_ID and note.HADM_ID = icd.HADM_ID
where ICD9_CODE like '250%' and note.HADM_ID is not null),
rolled_up_icd_codes as (select distinct SUBSTRING( dicd.ICD9_CODE, 1, 3 ) as ICD9_CODE from diabete_patients dp
join `physionet-data.mimiciii_clinical.diagnoses_icd` dicd on dp.HADM_ID = dicd.HADM_ID)
select count(*) as rolled_up_icd_codes_count From rolled_up_icd_codes;

-- Regular label cardinality
with diabete_patients as (select distinct icd.HADM_ID, note.ROW_ID from `physionet-data.mimiciii_clinical.diagnoses_icd` icd
join `physionet-data.mimiciii_notes.noteevents` note on note.SUBJECT_ID = icd.SUBJECT_ID and note.HADM_ID = icd.HADM_ID
where ICD9_CODE like '250%' and note.HADM_ID is not null),
report_id_regular_icd as (select distinct dp.ROW_ID, dicd.ICD9_CODE from diabete_patients dp
join `physionet-data.mimiciii_clinical.diagnoses_icd` dicd on dp.HADM_ID = dicd.HADM_ID
order by dp.ROW_ID, dicd.ICD9_CODE),
pre_calculation as (select riri.ROW_ID, count(riri.ICD9_CODE) as regular_icd_count from report_id_regular_icd riri
group by riri.ROW_ID)
select avg(regular_icd_count) from pre_calculation;

-- Rolled up label cardinality
with diabete_patients as (select distinct icd.HADM_ID, note.ROW_ID from `physionet-data.mimiciii_clinical.diagnoses_icd` icd
join `physionet-data.mimiciii_notes.noteevents` note on note.SUBJECT_ID = icd.SUBJECT_ID and note.HADM_ID = icd.HADM_ID
where ICD9_CODE like '250%' and note.HADM_ID is not null),
report_id_rolled_up_icd as (select distinct dp.ROW_ID, SUBSTRING(dicd.ICD9_CODE, 1, 3 ) as ICD9_CODE from diabete_patients dp
join `physionet-data.mimiciii_clinical.diagnoses_icd` dicd on dp.HADM_ID = dicd.HADM_ID
order by dp.ROW_ID),
pre_calculation as (select rirui.ROW_ID, count(rirui.ICD9_CODE) as rolled_up_icd_count from report_id_rolled_up_icd rirui
group by rirui.ROW_ID)
select avg(rolled_up_icd_count) from pre_calculation;

-- Regular label density
with diabete_patients as (select distinct icd.HADM_ID, note.ROW_ID from `physionet-data.mimiciii_clinical.diagnoses_icd` icd
join `physionet-data.mimiciii_notes.noteevents` note on note.SUBJECT_ID = icd.SUBJECT_ID and note.HADM_ID = icd.HADM_ID
where ICD9_CODE like '250%' and note.HADM_ID is not null),
report_id_regular_icd as (select distinct dp.ROW_ID, dicd.ICD9_CODE from diabete_patients dp
join `physionet-data.mimiciii_clinical.diagnoses_icd` dicd on dp.HADM_ID = dicd.HADM_ID
order by dp.ROW_ID, dicd.ICD9_CODE),
density_calculation as (select riri.ROW_ID, count(riri.ICD9_CODE)/4097 as regular_icd_density from report_id_regular_icd riri
group by riri.ROW_ID)
select avg(regular_icd_density) from density_calculation;

-- Rolled up label density
with diabete_patients as (select distinct icd.HADM_ID, note.ROW_ID from `physionet-data.mimiciii_clinical.diagnoses_icd` icd
join `physionet-data.mimiciii_notes.noteevents` note on note.SUBJECT_ID = icd.SUBJECT_ID and note.HADM_ID = icd.HADM_ID
where ICD9_CODE like '250%' and note.HADM_ID is not null),
report_id_rolled_up_icd as (select distinct dp.ROW_ID, SUBSTRING(dicd.ICD9_CODE, 1, 3 ) as ICD9_CODE from diabete_patients dp
join `physionet-data.mimiciii_clinical.diagnoses_icd` dicd on dp.HADM_ID = dicd.HADM_ID
order by dp.ROW_ID),
density_calculation as (select rirui.ROW_ID, count(rirui.ICD9_CODE)/780 as rolled_up_icd_density from report_id_rolled_up_icd rirui
group by rirui.ROW_ID)
select avg(rolled_up_icd_density) from density_calculation;

-- eleven most common rolled up icd codes.
with diabete_patients as (select distinct icd.HADM_ID, note.ROW_ID from `physionet-data.mimiciii_clinical.diagnoses_icd` icd
join `physionet-data.mimiciii_notes.noteevents` note on note.SUBJECT_ID = icd.SUBJECT_ID and note.HADM_ID = icd.HADM_ID
where ICD9_CODE like '250%' and note.HADM_ID is not null),
report_id_rolled_up_icd as (select distinct dp.ROW_ID, SUBSTRING(dicd.ICD9_CODE, 1, 3 ) as ICD9_CODE from diabete_patients dp
join `physionet-data.mimiciii_clinical.diagnoses_icd` dicd on dp.HADM_ID = dicd.HADM_ID
order by dp.ROW_ID)
select rirui.ICD9_CODE, count(rirui.ROW_ID)/406203 as report_percentage from report_id_rolled_up_icd rirui
group by rirui.ICD9_CODE
order by report_percentage desc
limit 11;

