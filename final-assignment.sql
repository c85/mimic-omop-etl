/* RETRIEVE THE 3 FIELDS FROM MIMIC DIAGNOSES_ICD table to build the OMOP CONDITION_OCCURRENCE table */
WITH 
diagnosis1 as (
     select distinct
          m3.subject_id as person_id
     from mimic3_demo.DIAGNOSES_ICD m3
),
CONDITION_OCCURRENCE as (
     select
          d1.person_id,
          m3.HADM_DI as visit_occurrence_id,
          m3.ICD9_CODE as condition_source_value
     from diagnosis1 d1
     join mimic3_demo.DIAGNOSES_ICD m3
     on d1.person_id = m3.subject_id 
)

select * from CONDITION_OCCURRENCE
