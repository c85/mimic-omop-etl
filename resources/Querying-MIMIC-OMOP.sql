-- Querying MIMIC(C2M2V2)
-- How many patients
select count(distinct subject_id) as NUM_PTs
from `mimic3_demo.PATIENTS`

--How many admissions
select count(distinct hadm_id) as NUM_ADMISSIONS
from `mimic3_demo.ADMISSIONS` 

-- Counts of diagnoses by patients NO LABELS
select ICD9_CODE, count(distinct SUBJECT_ID) as CNT_DX
from `mimic3_demo.DIAGNOSES_ICD` 
group by ICD9_CODE
order by count(distinct SUBJECT_ID) desc


--Counts of diagnoses by patients WITH LABELS
select dx.ICD9_CODE, ddx.SHORT_TITLE,
       count(distinct dx.SUBJECT_ID) as CNT_DX
from `mimic3_demo.DIAGNOSES_ICD`  dx
    JOIN `mimic3_demo.D_ICD_DIAGNOSES` ddx using (ICD9_CODE)
group by dx.ICD9_CODE, ddx.SHORT_TITLE
order by count(distinct dx.SUBJECT_ID) desc

-- Number of drugs per patient per admission
select SUBJECT_ID, HADM_ID,
       count(DISTINCT DRUG) as CNT_DRUG
from `mimic3_demo.PRESCRIPTIONS` 
GROUP BY SUBJECT_ID, HADM_ID
order by count(DISTINCT DRUG) desc

-- Average number of drugs across all admissions
select avg(CNT_DRUG) as AVG_DRUG_CNT
FROM
   (select SUBJECT_ID, HADM_ID,
       count(DISTINCT DRUG) as CNT_DRUG
       from `mimic3_demo.PRESCRIPTIONS` 
       GROUP BY SUBJECT_ID, HADM_ID)






-- Querying OMOP (C2M2V4)
-- How many patients
select count(distinct person_id) as NUM_PTs
from mimic3_demo_omop_c.person

-- How many admissions
select count(distinct visit_occurrence_id) as NUM_ADMISSIONS
from mimic3_demo_omop_c.visit_occurrence

--Count of diagnoses by patients
select condition_concept_id, count(distinct person_id) as NUM_DX
from mimic3_demo_omop_c.condition_occurrence
group by condition_concept_id
order by count(distinct person_id) desc

--Count of diagnoses by patients with labels
select condition_concept_id, c1.concept_name, count(distinct person_id) as NUM_DX
from mimic3_demo_omop_c.condition_occurrence co JOIN
     mimic3_demo_omop_c.concept c1 on (co.condition_concept_id = c1.concept_id)
group by condition_concept_id, c1.concept_name
order by count(distinct person_id) desc

--Number of drugs per patient per admission
select person_id, visit_occurrence_id, count(distinct drug_concept_id) as NUM_DRUG
from mimic3_demo_omop_c.drug_exposure
group by person_id, visit_occurrence_id
order by NUM_DRUG desc

-- Average number of drugs across all admissions
select avg(NUM_DRUG) as AVG_NUM_DRUGS
from (select person_id, visit_occurrence_id, 
            count(distinct drug_concept_id) as NUM_DRUG
      from mimic3_demo_omop_c.drug_exposure
      group by person_id, visit_occurrence_id)