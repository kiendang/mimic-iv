# This file makes ${STORAGE}s for the concepts in this subfolder.
# Be sure to run postgres-functions.sql first, as the concepts rely on those function definitions.
# Note that this may take a large amount of time and hard drive space.

# string replacements are necessary for some queries
export REGEX_DATETIME_DIFF="s/DATETIME_DIFF\((.+?),\s?(.+?),\s?(DAY|MINUTE|SECOND|HOUR|YEAR)\)/DATETIME_DIFF(\1, \2, '\3')/g"
export REGEX_SCHEMA='s/`physionet-data.(mimic_derived|mimic_core|mimic_hosp|mimic_icu).(.+?)`/\2/g'
export CONNSTR='mimiciv mimic'
export STORAGE='TABLE'

# this is set as the search_path variable for psql
# a search path of "public,mimiciii" will search both public and mimiciii
# schemas for data, but will create ${STORAGE}s on the public schema
export PSQL_PREAMBLE='SET search_path TO mimic_derived,mimic_core,mimic_hosp,mimic_icu'

echo ''
echo '==='
echo "Beginning to create ${STORAGE}s for MIMIC database."
echo 'Any notices of the form "NOTICE: MATERIALIZED VIEW "XXXXXX" does not exist" can be ignored.'
echo 'The scripts drop views before creating them, and these notices indicate nothing existed prior to creating the view.'
echo '==='
echo ''

echo 'Directory 1 of 9: demographics'
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS icustay_times; CREATE ${STORAGE} icustay_times AS "; cat demographics/icustay_times.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS icustay_hourly; CREATE ${STORAGE} icustay_hourly AS "; cat demographics/icustay_hourly_pg.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS weight_durations; CREATE ${STORAGE} weight_durations AS "; cat demographics/weight_durations.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS age; CREATE ${STORAGE} age AS "; cat demographics/age.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}

echo 'Directory 2 of 9: measurement'
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS bg; CREATE ${STORAGE} bg AS "; cat measurement/bg.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS blood_differential; CREATE ${STORAGE} blood_differential AS "; cat measurement/blood_differential.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS cardiac_marker; CREATE ${STORAGE} cardiac_marker AS "; cat measurement/cardiac_marker.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS chemistry; CREATE ${STORAGE} chemistry AS "; cat measurement/chemistry.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS coagulation; CREATE ${STORAGE} coagulation AS "; cat measurement/coagulation.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS complete_blood_count; CREATE ${STORAGE} complete_blood_count AS "; cat measurement/complete_blood_count.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS creatinine_baseline; CREATE ${STORAGE} creatinine_baseline AS "; cat measurement/creatinine_baseline.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS enzyme; CREATE ${STORAGE} enzyme AS "; cat measurement/enzyme.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS gcs; CREATE ${STORAGE} gcs AS "; cat measurement/gcs.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS height; CREATE ${STORAGE} height AS "; cat measurement/height.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS icp; CREATE ${STORAGE} icp AS "; cat measurement/icp.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS inflammation; CREATE ${STORAGE} inflammation AS "; cat measurement/inflammation.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS oxygen_delivery; CREATE ${STORAGE} oxygen_delivery AS "; cat measurement/oxygen_delivery.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS rhythm; CREATE ${STORAGE} rhythm AS "; cat measurement/rhythm.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS urine_output; CREATE ${STORAGE} urine_output AS "; cat measurement/urine_output.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS urine_output_rate; CREATE ${STORAGE} urine_output_rate AS "; cat measurement/urine_output_rate.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS ventilator_setting; CREATE ${STORAGE} ventilator_setting AS "; cat measurement/ventilator_setting.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS vitalsign; CREATE ${STORAGE} vitalsign AS "; cat measurement/vitalsign.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}

echo 'Directory 3 of 9: medication'
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS antibiotic; CREATE ${STORAGE} antibiotic AS "; cat medication/antibiotic.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS dobutamine; CREATE ${STORAGE} dobutamine AS "; cat medication/dobutamine.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS dopamine; CREATE ${STORAGE} dopamine AS "; cat medication/dopamine.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS epinephrine; CREATE ${STORAGE} epinephrine AS "; cat medication/epinephrine.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS norepinephrine; CREATE ${STORAGE} norepinephrine AS "; cat medication/norepinephrine.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS vasopressin; CREATE ${STORAGE} vasopressin AS "; cat medication/vasopressin.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS phenylephrine; CREATE ${STORAGE} phenylephrine AS "; cat medication/phenylephrine.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS neuroblock; CREATE ${STORAGE} neuroblock AS "; cat medication/neuroblock.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}

echo 'Directory 4 of 9: treatment'
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS invasive_line; CREATE ${STORAGE} crrt AS "; cat treatment/crrt.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS invasive_line; CREATE ${STORAGE} invasive_line AS "; cat treatment/invasive_line.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS rrt; CREATE ${STORAGE} rrt AS "; cat treatment/rrt.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS ventilation; CREATE ${STORAGE} ventilation AS "; cat treatment/ventilation.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}

echo 'Directory 5 of 9: firstday'
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS first_day_bg_art; CREATE ${STORAGE} first_day_bg_art AS "; cat firstday/first_day_bg_art.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS first_day_bg; CREATE ${STORAGE} first_day_bg AS "; cat firstday/first_day_bg.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS first_day_gcs; CREATE ${STORAGE} first_day_gcs AS "; cat firstday/first_day_gcs.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS first_day_height; CREATE ${STORAGE} first_day_height AS "; cat firstday/first_day_height.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS first_day_lab; CREATE ${STORAGE} first_day_lab AS "; cat firstday/first_day_lab.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS first_day_rrt; CREATE ${STORAGE} first_day_rrt AS "; cat firstday/first_day_rrt.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS first_day_urine_output; CREATE ${STORAGE} first_day_urine_output AS "; cat firstday/first_day_urine_output.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS first_day_vitalsign; CREATE ${STORAGE} first_day_vitalsign AS "; cat firstday/first_day_vitalsign.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS first_day_weight; CREATE ${STORAGE} first_day_weight AS "; cat firstday/first_day_weight.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS first_day_sofa; CREATE ${STORAGE} first_day_sofa AS "; cat firstday/first_day_sofa.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}

echo 'Directory 6 of 9: score'
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS sofa; CREATE ${STORAGE} sofa AS "; cat score/sofa.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS apsii; CREATE ${STORAGE} apsii AS "; cat score/apsii.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS lods; CREATE ${STORAGE} lods AS "; cat score/lods.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS oasis; CREATE ${STORAGE} oasis AS "; cat score/oasis.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS sapsii; CREATE ${STORAGE} sapsii AS "; cat score/sapsii.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS sirs; CREATE ${STORAGE} sirs AS "; cat score/sirs.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}

echo 'Directory 7 of 9: sepsis'
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS suspicion_of_infection; CREATE ${STORAGE} suspicion_of_infection AS "; cat sepsis/suspicion_of_infection_pg.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS sepsis3; CREATE ${STORAGE} sepsis3 AS "; cat sepsis/sepsis3.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}

echo 'Directory 8 of 9: organfailure'
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS kdigo_uo; CREATE ${STORAGE} kdigo_uo AS "; cat organfailure/kdigo_uo.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS kdigo_creatinine; CREATE ${STORAGE} kdigo_creatinine AS "; cat organfailure/kdigo_creatinine.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS kdigo_stages; CREATE ${STORAGE} kdigo_stages AS "; cat organfailure/kdigo_stages.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS meld; CREATE ${STORAGE} meld AS "; cat organfailure/meld.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}

echo 'Directory 9 of 9: comorbidity'
{ echo "${PSQL_PREAMBLE}; DROP ${STORAGE} IF EXISTS charlson; CREATE ${STORAGE} charlson AS "; cat comorbidity/charlson.sql; } | sed -r -e "${REGEX_DATETIME_DIFF}" | sed -r -e "${REGEX_SCHEMA}" | psql ${CONNSTR}

echo "Finished creating ${STORAGE}s."
