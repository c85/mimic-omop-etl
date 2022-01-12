# Create an ETL Process to Transform a MIMIC-III Table to OMOP

## Description:
This is a short exercise mapping MIMIC.DIAGNOSES_ICD table to the OMOP.CONDITION_OCCURRENCE table. The final submission includes:

1. A Google Presentation slide deck.
2. A file with SQL code used to transform the source data table into the target table.

The final grade is based on:

1. Whether one or more MIMIC source table/s are used to map person_id, visit_occurrence_id, and condition_source_value to the OMOP CONDITION_OCCURRENCE target table.
2. Data profiling results for the MIMIC source table/s specifically addressing the profiling results for the MIMIC SUBJECT_ID frequency.
3. Mappings and explanations between the MIMIC source table/s and person_id, visit_occurrence_id, and condition_source_value in the OMOP CONDITION_OCCURRENCE target table.
4. SQL source code to perform the mappings identified in Step 3.
5. Assessment and explanation for at least one data quality measure/s of the created CONDITION_OCCURRENCE table.