view: crm_waterfall_view {
  derived_table: {
    sql:
        select t1.*, aux_column
        from
        (
        select
          product,
          to_date(senddatetime) as send_date,
          campaigncode,
          mailing_name,
          mailing_id,

          sum(case when iscontrol = 'no' then uniques else 0 end) as unique_subscribers_treatment_campaign_level,
          sum(case when iscontrol = 'yes' and emailengagementstatus in ('D', 'R') then uniques else 0 end) as unique_subscribers_control_campaign_level,

          sum(case when iscontrol = 'no' then actives else 0 end) as actives_treatment_campaign_level,
          sum(case when iscontrol = 'yes' and emailengagementstatus in ('D', 'R') then actives else 0 end) as actives_control_campaign_level,

          sum(case when iscontrol = 'no' then bet_days else 0 end) as bet_days_treatment_campaign_level,
          sum(case when iscontrol = 'yes' and emailengagementstatus in ('D', 'R') then bet_days else 0 end) as bet_days_control_campaign_level,

          sum(case when iscontrol = 'no' then stakes_normalised else 0 end) as stakes_normalised_treatment_campaign_level,
          sum(case when iscontrol = 'yes' and emailengagementstatus in ('D', 'R') then stakes_normalised else 0 end) as stakes_normalised_control_campaign_level,

          sum(case when iscontrol = 'no' then margin_normalised else 0 end) as margin_normalised_treatment_campaign_level,
          sum(case when iscontrol = 'yes' and emailengagementstatus in ('D', 'R') then margin_normalised else 0 end) as margin_normalised_control_campaign_level,

          -sum(case when iscontrol = 'no' then free_bets_normalised else 0 end) as free_bets_normalised_treatment_campaign_level,
          -sum(case when iscontrol = 'yes' and emailengagementstatus in ('D', 'R') then free_bets_normalised else 0 end) as free_bets_normalised_control_campaign_level,

          1.0*coalesce(actives_treatment_campaign_level,0)/nullif(unique_subscribers_treatment_campaign_level,0) as perc_of_unique_subscribers_active_treatment,
          1.0*coalesce(actives_control_campaign_level,0)/nullif(unique_subscribers_control_campaign_level,0) as perc_of_unique_subscribers_active_control,

          1.0*coalesce(bet_days_treatment_campaign_level,0)/nullif(actives_treatment_campaign_level,0) as average_bet_days_treatment,
          1.0*coalesce(bet_days_control_campaign_level,0)/nullif(actives_control_campaign_level,0) as average_bet_days_control,

          1.0*coalesce(stakes_normalised_treatment_campaign_level,0)/nullif(bet_days_treatment_campaign_level,0) as stake_per_bet_day_treatment,
          1.0*coalesce(stakes_normalised_control_campaign_level,0)/nullif(bet_days_control_campaign_level,0) as stake_per_bet_day_control,

          1.0*coalesce(margin_normalised_treatment_campaign_level,0)/nullif(stakes_normalised_treatment_campaign_level,0) as margin_per_stake_treatment,
          1.0*coalesce(margin_normalised_control_campaign_level,0)/nullif(stakes_normalised_control_campaign_level,0) as margin_per_stake_control,

          1.0*coalesce(free_bets_normalised_treatment_campaign_level,0)/nullif(unique_subscribers_treatment_campaign_level,0) as free_bet_per_unique_subscribers_treatment,
          1.0*coalesce(free_bets_normalised_control_campaign_level,0)/nullif(unique_subscribers_control_campaign_level,0) as free_bet_per_unique_subscribers_control,

          1.0*coalesce(unique_subscribers_treatment_campaign_level,0)*(coalesce(perc_of_unique_subscribers_active_control,0)*coalesce(average_bet_days_control,0)*coalesce(stake_per_bet_day_control,0)
          *coalesce(margin_per_stake_control,0)+coalesce(free_bet_per_unique_subscribers_control,0)) as control_net_profit_margin_normalised,

          1.0*coalesce(unique_subscribers_treatment_campaign_level,0)*(coalesce(perc_of_unique_subscribers_active_treatment,0)*coalesce(average_bet_days_control,0)*coalesce(stake_per_bet_day_control,0)
          *coalesce(margin_per_stake_control,0)+coalesce(free_bet_per_unique_subscribers_control,0)) - coalesce(control_net_profit_margin_normalised,0) as actives_contribution,

          1.0*coalesce(unique_subscribers_treatment_campaign_level,0)*(coalesce(perc_of_unique_subscribers_active_treatment,0)*coalesce(average_bet_days_treatment,0)*coalesce(stake_per_bet_day_control,0)
          *coalesce(margin_per_stake_control,0)+coalesce(free_bet_per_unique_subscribers_control,0)) - coalesce(control_net_profit_margin_normalised,0) - coalesce(actives_contribution,0) as bet_days_contribution,

          1.0*coalesce(unique_subscribers_treatment_campaign_level,0)*(coalesce(perc_of_unique_subscribers_active_treatment,0)*coalesce(average_bet_days_treatment,0)*coalesce(stake_per_bet_day_treatment,0)
          *coalesce(margin_per_stake_control,0)+coalesce(free_bet_per_unique_subscribers_control,0)) - coalesce(control_net_profit_margin_normalised,0) - coalesce(actives_contribution,0)
          -coalesce(bet_days_contribution,0) as stakes_normalised_contribution,

          1.0*coalesce(unique_subscribers_treatment_campaign_level,0)*(coalesce(perc_of_unique_subscribers_active_treatment,0)*coalesce(average_bet_days_treatment,0)*coalesce(stake_per_bet_day_treatment,0)
          *coalesce(margin_per_stake_treatment,0)+coalesce(free_bet_per_unique_subscribers_control,0)) - coalesce(control_net_profit_margin_normalised,0)
          -coalesce(actives_contribution,0)-coalesce(bet_days_contribution,0)-coalesce(stakes_normalised_contribution,0) as margin_normalised_contribution,

          1.0*(coalesce(unique_subscribers_treatment_campaign_level,0)*(coalesce(perc_of_unique_subscribers_active_treatment,0)*coalesce(average_bet_days_treatment,0)*coalesce(stake_per_bet_day_treatment,0)
          *coalesce(margin_per_stake_treatment,0)+coalesce(free_bet_per_unique_subscribers_treatment,0)) - coalesce(control_net_profit_margin_normalised,0) - coalesce(actives_contribution,0)
          -coalesce(bet_days_contribution,0) - coalesce(stakes_normalised_contribution,0) - coalesce(margin_normalised_contribution,0)) as free_bets_normalised_contribution,

          1.0*coalesce(control_net_profit_margin_normalised,0)+coalesce(actives_contribution,0)+coalesce(bet_days_contribution,0)+coalesce(stakes_normalised_contribution,0)
           +coalesce(margin_normalised_contribution,0)+coalesce(free_bets_normalised_contribution,0) as total_net_profit_margin_normalised

          from PRESENTATION.CRM_DEMO

          where emailengagementstatus in ('A','B','D', 'R')
          group by 1,2,3,4,5

          having sum(case when iscontrol = 'yes' and emailengagementstatus in ('D', 'R') then uniques else 0 end) > 0
          ) t1
        cross join
          (
          select 1 as aux_column union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7
          ) t2
    ;;
    datagroup_trigger: crm_sandbox_default_datagroup
#     indexes: ["product", "send_date", "campaigncode", "mailing_name", "mailing_id"]


  }

  dimension: mailing_level_id {
    description: "Unique key for the each mailing"
    primary_key: yes
    type: string
    hidden: yes
    sql: ${TABLE}.PRODUCT||${TABLE}.SEND_DATE||${TABLE}.CAMPAIGNCODE||coalesce(${TABLE}.MAILING_NAME,' ')||coalesce(${TABLE}.MAILING_ID,0);;
  }

  dimension: product {
    type: string
    hidden: yes
    sql: ${TABLE}.PRODUCT ;;
  }

  dimension_group: send {
    type: time
    hidden: yes
    timeframes: [raw, date, week, month, year]
    sql: ${TABLE}.SEND_DATE ;;
  }

  dimension: campaigncode {
    type: string
    hidden: yes
    sql: ${TABLE}.CAMPAIGNCODE ;;
  }

  dimension: mailing_name {
    type: string
    hidden: yes
    sql: ${TABLE}.MAILING_NAME ;;
  }

  dimension: mailing_id {
    type: number
    hidden: yes
    sql: ${TABLE}.MAILING_ID ;;
  }

  measure: actives_contribution {
    type: sum
    value_format: "\"£\"#,###.00"
    hidden: yes
    sql: ${TABLE}.ACTIVES_CONTRIBUTION ;;
  }

  measure: bet_days_contribution {
    type: sum
    value_format: "\"£\"#,###.00"
    hidden: yes
    sql: ${TABLE}.BET_DAYS_CONTRIBUTION ;;
  }

  measure: stakes_normalised_contribution {
    type: sum
    value_format: "\"£\"#,###.00"
    hidden: yes
    sql: ${TABLE}.STAKES_NORMALISED_CONTRIBUTION ;;
  }

  measure: margin_normalised_contribution {
    type: sum
    value_format: "\"£\"#,###.00"
    hidden: yes
    sql: ${TABLE}.MARGIN_NORMALISED_CONTRIBUTION ;;
  }

  measure: free_bets_normalised_contribution {
    type: sum
    value_format: "\"£\"#,###.00"
    hidden: yes
    sql: ${TABLE}.FREE_BETS_NORMALISED_CONTRIBUTION ;;
  }

  measure: total_net_profit_margin_normalised {
    type: sum
    value_format: "\"£\"#,###.00"
    hidden: yes
    sql: ${TABLE}.TOTAL_NET_PROFIT_MARGIN_NORMALISED ;;
  }

  measure: control_net_profit_margin_normalised {
    type: sum
    value_format: "\"£\"#,###.00"
    hidden: yes
    sql: ${TABLE}.CONTROL_NET_PROFIT_MARGIN_NORMALISED ;;
  }

  dimension: aux_column {
    type: number
    hidden: yes
    sql: ${TABLE}.AUX_COLUMN ;;
  }

}
