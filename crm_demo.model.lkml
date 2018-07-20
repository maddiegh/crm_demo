connection: "redkite_demo_snowflake"

week_start_day: friday

case_sensitive: no

#include: "*.dashboard" # include all the dashboards

include: "CRM*.view"

datagroup: crm_sandbox_default_datagroup {
  sql_trigger: SELECT MAX(senddatetime) FROM PRESENTATION_CRM.CPR_XLS_EXTRACT_20180323;;
  max_cache_age: "12 hour"
}

persist_with: crm_sandbox_default_datagroup

explore: crm_explore {

  label: "✉️ CRM Explore"
  view_label: "(1) CRM Raw Data"
  view_name: crm_extract
  join: crm_mailing_level_summary {
    view_label: "(3) Mailing Level Fields"
    type: left_outer
    sql_on: ${crm_extract.mailing_level_id} = ${crm_mailing_level_summary.mailing_level_id} ;;
    relationship: many_to_one
  }
  join: crm_segment_level_summary {
    type: left_outer
    sql_on: ${crm_extract.segment_level_id} = ${crm_segment_level_summary.segment_level_id} ;;
    relationship: many_to_one
  }

  join: crm_waterfall_view {
    type: left_outer
    sql_on: ${crm_extract.mailing_level_id} = ${crm_waterfall_view.mailing_level_id} ;;
    relationship: many_to_one
  }
}
