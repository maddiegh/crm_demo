connection: "snowlooker"

week_start_day: friday

case_sensitive: no


include: "CRM*.view"

datagroup: crm_sandbox_default_datagroup {
  sql_trigger: SELECT MAX(senddatetime) FROM PRESENTATION_CRM.CPR_XLS_EXTRACT_20180323;;
  max_cache_age: "12 hour"
}

persist_with: crm_sandbox_default_datagroup

explore: cpr_extract {

  label: "✉️ CPR Report"
  view_label: "(1) CPR Raw Data"
  description: "Replacement for the excel CPR report, using the same source data"
  view_name: cpr_extract
  join: cpr_mailing_level_summary {
    view_label: "(3) Mailing Level Fields"
    type: left_outer
    sql_on: ${cpr_extract.mailing_level_id} = ${cpr_mailing_level_summary.mailing_level_id} ;;
    relationship: many_to_one
  }
  join: cpr_segment_level_summary {
    type: left_outer
    sql_on: ${cpr_extract.segment_level_id} = ${cpr_segment_level_summary.segment_level_id} ;;
    relationship: many_to_one
  }

  join: crm_waterfall_view {
    type: left_outer
    sql_on: ${cpr_extract.mailing_level_id} = ${crm_waterfall_view.mailing_level_id} ;;
    relationship: many_to_one
  }
}
