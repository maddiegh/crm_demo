view: crm_mailing_level_summary {
  label: "CRM Mailing Level Summary"
  derived_table: {
    sql:  select
          product,
          to_date(senddatetime) as send_date,
          campaigncode,
          mailing_name,
          mailing_id,
          product||to_date(senddatetime)||campaigncode||coalesce(mailing_name,' ')||coalesce(mailing_id,0) as mailing_level_id,

          sum(case when iscontrol = 'no' then uniques else 0 end) as unique_subscribers_treatment_campaign_level,
          sum(case when iscontrol = 'yes' and emailengagementstatus in ('D', 'R') then uniques else 0 end) as unique_subscribers_control_campaign_level,

          sum(case when iscontrol = 'no' then actives else 0 end) as actives_treatment_campaign_level,
          sum(case when iscontrol = 'yes' and emailengagementstatus in ('D', 'R') then actives else 0 end) as actives_control_campaign_level,

          sum(case when iscontrol = 'no' then bet_days else 0 end) as bet_days_treatment_campaign_level,
          sum(case when iscontrol = 'yes' and emailengagementstatus in ('D', 'R') then bet_days else 0 end) as bet_days_control_campaign_level,

          sum(case when iscontrol = 'no' then stakes else 0 end) as stakes_treatment_campaign_level,
          sum(case when iscontrol = 'yes' and emailengagementstatus in ('D', 'R') then stakes else 0 end) as stakes_control_campaign_level,

          sum(case when iscontrol = 'no' then stakes_normalised else 0 end) as stakes_normalised_treatment_campaign_level,
          sum(case when iscontrol = 'yes' and emailengagementstatus in ('D', 'R') then stakes_normalised else 0 end) as stakes_normalised_control_campaign_level,

          sum(case when iscontrol = 'no' then margin else 0 end) as margin_treatment_campaign_level,
          sum(case when iscontrol = 'yes' and emailengagementstatus in ('D', 'R') then margin else 0 end) as margin_control_campaign_level,

          sum(case when iscontrol = 'no' then margin_normalised else 0 end) as margin_normalised_treatment_campaign_level,
          sum(case when iscontrol = 'yes' and emailengagementstatus in ('D', 'R') then margin_normalised else 0 end) as margin_normalised_control_campaign_level,

          -1.0*sum(case when iscontrol = 'no' then free_bets_normalised else 0 end) as free_bets_normalised_treatment_campaign_level,
          -1.0*sum(case when iscontrol = 'yes' and emailengagementstatus in ('D', 'R') then free_bets_normalised else 0 end) as free_bets_normalised_control_campaign_level,

          -1.0*sum(case when iscontrol = 'no' then free_bets else 0 end) as free_bets_treatment_campaign_level,
          -1.0*sum(case when iscontrol = 'yes' and emailengagementstatus in ('D', 'R') then free_bets else 0 end) as free_bets_control_campaign_level,

          1.0*(coalesce(actives_treatment_campaign_level,0)/nullif(unique_subscribers_treatment_campaign_level,0)) as perc_of_unique_subscribers_active_treatment_campaign_level,
          1.0*(coalesce(actives_control_campaign_level,0)/nullif(unique_subscribers_control_campaign_level,0)) as perc_of_unique_subscribers_active_control_campaign_level,


          1.0*(coalesce(bet_days_treatment_campaign_level,0)/nullif(actives_treatment_campaign_level,0)) as average_bet_days_treatment_campaign_level,
          1.0*(coalesce(bet_days_control_campaign_level,0)/nullif(actives_control_campaign_level,0)) as average_bet_days_control_campaign_level,

          1.0*(coalesce(stakes_normalised_treatment_campaign_level,0)/nullif(bet_days_treatment_campaign_level,0)) as stake_per_bet_day_treatment_campaign_level,
          1.0*(coalesce(stakes_normalised_control_campaign_level,0)/nullif(bet_days_control_campaign_level,0)) as stake_per_bet_day_control_campaign_level,

          1.0*(coalesce(margin_normalised_treatment_campaign_level,0)/nullif(stakes_normalised_treatment_campaign_level,0)) as margin_per_stake_treatment_campaign_level,
          1.0*(coalesce(margin_normalised_control_campaign_level,0)/nullif(stakes_normalised_control_campaign_level,0)) as margin_per_stake_control_campaign_level,

          1.0*(coalesce(free_bets_normalised_treatment_campaign_level,0)/nullif(unique_subscribers_treatment_campaign_level,0)) as free_bet_per_unique_subscribers_treatment_campaign_level,
          1.0*(coalesce(free_bets_normalised_control_campaign_level,0)/nullif(unique_subscribers_control_campaign_level,0)) as free_bet_per_unique_subscribers_control_campaign_level,

          1.0*(unique_subscribers_treatment_campaign_level*(perc_of_unique_subscribers_active_control_campaign_level*average_bet_days_control_campaign_level*stake_per_bet_day_control_campaign_level
                *margin_per_stake_control_campaign_level+free_bet_per_unique_subscribers_control_campaign_level)) as control_net_profit_margin_normalised_campaign_level,

          1.0*(coalesce(unique_subscribers_treatment_campaign_level,0)*(coalesce(perc_of_unique_subscribers_active_treatment_campaign_level,0)*coalesce(average_bet_days_control_campaign_level,0)
                *coalesce(stake_per_bet_day_control_campaign_level,0)*coalesce(margin_per_stake_control_campaign_level,0)+coalesce(free_bet_per_unique_subscribers_control_campaign_level,0))
                -coalesce(control_net_profit_margin_normalised_campaign_level,0)) as actives_contribution_campaign_level,

          1.0*(coalesce(unique_subscribers_treatment_campaign_level,0)*(coalesce(perc_of_unique_subscribers_active_treatment_campaign_level,0)*coalesce(average_bet_days_treatment_campaign_level,0)
                *coalesce(stake_per_bet_day_control_campaign_level,0)*coalesce(margin_per_stake_control_campaign_level,0)+coalesce(free_bet_per_unique_subscribers_control_campaign_level,0))
                -coalesce(control_net_profit_margin_normalised_campaign_level,0)-coalesce(actives_contribution_campaign_level,0)) as bet_days_contribution_campaign_level,

          1.0*(coalesce(unique_subscribers_treatment_campaign_level,0)*(coalesce(perc_of_unique_subscribers_active_treatment_campaign_level,0)*coalesce(average_bet_days_treatment_campaign_level,0)
                *coalesce(stake_per_bet_day_treatment_campaign_level,0)*coalesce(margin_per_stake_control_campaign_level,0)+coalesce(free_bet_per_unique_subscribers_control_campaign_level,0))
                -coalesce(control_net_profit_margin_normalised_campaign_level,0)-coalesce(actives_contribution_campaign_level,0)-coalesce(bet_days_contribution_campaign_level,0)) as stakes_normalised_contribution_campaign_level,

          1.0*(coalesce(unique_subscribers_treatment_campaign_level,0)*(coalesce(perc_of_unique_subscribers_active_treatment_campaign_level,0)*coalesce(average_bet_days_treatment_campaign_level,0)
                *coalesce(stake_per_bet_day_treatment_campaign_level,0)*coalesce(margin_per_stake_treatment_campaign_level,0)+coalesce(free_bet_per_unique_subscribers_control_campaign_level,0))
                -coalesce(control_net_profit_margin_normalised_campaign_level,0)-coalesce(actives_contribution_campaign_level,0)-coalesce(bet_days_contribution_campaign_level,0)-coalesce(stakes_normalised_contribution_campaign_level,0)) as margin_normalised_contribution_campaign_level,

          1.0*(coalesce(unique_subscribers_treatment_campaign_level,0)*(coalesce(perc_of_unique_subscribers_active_treatment_campaign_level,0)*coalesce(average_bet_days_treatment_campaign_level,0)
                *coalesce(stake_per_bet_day_treatment_campaign_level,0)*coalesce(margin_per_stake_treatment_campaign_level,0)+coalesce(free_bet_per_unique_subscribers_treatment_campaign_level,0))
                -coalesce(control_net_profit_margin_normalised_campaign_level,0)-coalesce(actives_contribution_campaign_level,0)-coalesce(bet_days_contribution_campaign_level,0)
                -coalesce(stakes_normalised_contribution_campaign_level,0)-coalesce(margin_normalised_contribution_campaign_level,0)) as free_bets_normalised_contribution_campaign_level,

          coalesce(margin_normalised_treatment_campaign_level,0)+coalesce(free_bets_normalised_treatment_campaign_level,0) as total_net_profit_margin_normalised_campaign_level,

          1.0*(actives_treatment_campaign_level/nullif(unique_subscribers_treatment_campaign_level,0) - actives_control_campaign_level/nullif(unique_subscribers_control_campaign_level,0)) * unique_subscribers_treatment_campaign_level as incremental_actives_campaign_level,

          1.0*(bet_days_treatment_campaign_level/nullif(unique_subscribers_treatment_campaign_level,0) - bet_days_control_campaign_level/nullif(unique_subscribers_control_campaign_level,0)) * unique_subscribers_treatment_campaign_level as incremental_bet_days_campaign_level,

          1.0*(stakes_treatment_campaign_level/nullif(unique_subscribers_treatment_campaign_level,0) - stakes_control_campaign_level/nullif(unique_subscribers_control_campaign_level,0)) * unique_subscribers_treatment_campaign_level as incremental_stakes_campaign_level,

          1.0*(stakes_normalised_treatment_campaign_level/nullif(unique_subscribers_treatment_campaign_level,0) - stakes_normalised_control_campaign_level/nullif(unique_subscribers_control_campaign_level,0)) * unique_subscribers_treatment_campaign_level as incremental_stakes_normalised_campaign_level,

          1.0*(margin_treatment_campaign_level/nullif(unique_subscribers_treatment_campaign_level,0) - margin_control_campaign_level/nullif(unique_subscribers_control_campaign_level,0)) * unique_subscribers_treatment_campaign_level as incremental_margin_campaign_level,

          1.0*(margin_normalised_treatment_campaign_level/nullif(unique_subscribers_treatment_campaign_level,0) - margin_normalised_control_campaign_level/nullif(unique_subscribers_control_campaign_level,0)) * unique_subscribers_treatment_campaign_level as incremental_margin_normalised_campaign_level,

          1.0*(free_bets_treatment_campaign_level/nullif(unique_subscribers_treatment_campaign_level,0) - free_bets_control_campaign_level/nullif(unique_subscribers_control_campaign_level,0)) * unique_subscribers_treatment_campaign_level as incremental_free_bets_campaign_level,

          1.0*(free_bets_normalised_treatment_campaign_level/nullif(unique_subscribers_treatment_campaign_level,0) - free_bets_normalised_control_campaign_level/nullif(unique_subscribers_control_campaign_level,0)) * unique_subscribers_treatment_campaign_level as incremental_free_bets_normalised_campaign_level



          from PRESENTATION.CRM_DEMO

          where emailengagementstatus in ('A','B','D', 'R')

          group by 1,2,3,4,5,6
        ;;
    datagroup_trigger: crm_sandbox_default_datagroup

  }

  dimension: mailing_level_id {
    description: "Unique key for the each mailing"
    primary_key: yes
    type: string
    hidden: yes
    sql: ${TABLE}.MAILING_LEVEL_ID;;
  }

  dimension: mailing_name {
    description: "Linked to the mailing ID, each mailing sent has a unique name. It is not unique at communication level, as the same mailing can go out multiple times"
    type: string
    hidden: yes
    sql: ${TABLE}.MAILING_NAME ;;
    link: {label: "Details about this mailing"
      url:"https://redkite.eu.looker.com/dashboards/46?Mailing%20Name={{ ['mailing_name'] | url_encode }}&Send%20Date={{ ['send_date'] | url_encode }}"}
  }

  dimension: mailing_name_with_date {
    description: "Field created as a concatenation between the send date and the name of a campaign"
    type: string
    hidden:yes
    sql: ${send_date}||' '|| ${TABLE}.MAILING_NAME ;;
    # The link below creates a drill through to the Campaign Drilldown dashboard; it passes through a filter on mailing name
    link: {label: "Details about this mailing"
      url:"https://redkite.eu.looker.com/dashboards/46?Mailing%20Name={{ ['mailing_name'] | url_encode }}&Send%20Date={{ ['send_date'] | url_encode }}"}
    #&Product={{ _filters['cpr_extract.product'] | url_encode }}
    full_suggestions: yes
  }

  dimension_group: send {
    type: time
    timeframes: [raw, date, week, month, year]
    hidden: yes
    sql: ${TABLE}.SEND_DATE ;;
  }

  measure: perc_of_unique_subscribers_active_treatment_campaign_level  {
    description: "Average treatment active rate, calculated at mailing level. Total distinct active treatment subscribers by total distinct treatment subscribers selected for each mailing"
    type: average
    #hidden: yes
    value_format: "0.00%"
    sql:  ${TABLE}.PERC_OF_UNIQUE_SUBSCRIBERS_ACTIVE_TREATMENT_CAMPAIGN_LEVEL;;
  }

  measure: perc_of_unique_subscribers_active_control_campaign_level {
    description: "Average control active rate, calculated at mailing level. Total distinct active control subscribers by total distinct control subscribers selected for each mailing"
    type: average
    #hidden: yes
    value_format: "0.00%"
    sql:  ${TABLE}.PERC_OF_UNIQUE_SUBSCRIBERS_ACTIVE_CONTROL_CAMPAIGN_LEVEL;;
  }

  measure: average_bet_days_treatment_campaign_level {
    description: "Average number of days an active treatment subscriber placed at least one bet, calculated at mailing level"
    type: average
    hidden: yes
    sql: ${TABLE}.AVERAGE_BET_DAYS_TREATMENT_CAMPAIGN_LEVEL ;;
  }

  measure: average_bet_days_control_campaign_level {
    description: "Average number of days an active control subscriber placed at least one bet, calculated at mailing level"
    type: average
    hidden: yes
    sql: ${TABLE}.AVERAGE_BET_DAYS_CONTROL_CAMPAIGN_LEVEL ;;
  }

  measure: stake_per_bet_day_treatment_campaign_level {
    description: "Average stake per day for treatment subscribers, calculated at mailing level"
    type: average
    hidden: yes
    sql: ${TABLE}.STAKE_PER_BET_DAY_TREATMENT_CAMPAIGN_LEVEL ;;
  }

  measure: stake_per_bet_day_control_campaign_level {
    description: "Average stake per day for control subscribers, calculated at mailing level"
    type: average
    hidden: yes
    sql: ${TABLE}.STAKE_PER_BET_DAY_CONTROL_CAMPAIGN_LEVEL ;;
  }

  measure: margin_per_stake_treatment_campaign_level {
    description: "Average assumed margin to stake ratio for the treatment subscribers, calculated at mailing level"
    type: average
    hidden: yes
    sql: ${TABLE}.MARGIN_PER_STAKE_TREATMENT_CAMPAIGN_LEVEL ;;
  }

  measure: margin_per_stake_control_campaign_level {
    description: "Average assumed margin to stake ratio for the control subscribers, calculated at mailing level"
    type: average
    hidden: yes
    sql: ${TABLE}.MARGIN_PER_STAKE_CONTROL_CAMPAIGN_LEVEL ;;
  }

  measure: free_bet_per_unique_subscribers_treatment_campaign_level {
    description: "Average free bet redeemed by the treatment subscribers, calculated at mailing level"
    type: average
    hidden: yes
    sql: ${TABLE}.FREE_BET_PER_UNIQUE_SUBSCRIBERS_TREATMENT_CAMPAIGN_LEVEL ;;
  }

  measure: free_bet_per_unique_subscribers_control_campaign_level {
    description: "Average free bet redeemed by the control subscribers, calculated at mailing level"
    type: average
    hidden: yes
    sql: ${TABLE}.FREE_BET_PER_UNIQUE_SUBSCRIBERS_CONTROL_CAMPAIGN_LEVEL ;;
  }

  measure:: control_net_profit_margin_normalised_campaign_level {
    description: "Scaled net assumed margin normalised which would have been expected if the mailing had not been sent, calculated at mailing level"
    type: sum
    value_format: "\"£\"#,###.00"
    hidden: yes
    sql: case when ${TABLE}.unique_subscribers_control_campaign_level = 0 then 0 else ${TABLE}.CONTROL_NET_PROFIT_MARGIN_NORMALISED_CAMPAIGN_LEVEL end;;
  }

  measure: actives_contribution_campaign_level {
    description: "Net margin value attributed to incremental active subscribers, calculated at mailing level"
    group_label: "Margin Attribution"
    type: sum
    value_format:  "\"£\"#,##0.0,\" k\""
    sql: case when ${TABLE}.unique_subscribers_control_campaign_level = 0 then 0 else ${TABLE}.ACTIVES_CONTRIBUTION_CAMPAIGN_LEVEL end ;;
  }

  measure: bet_days_contribution_campaign_level {
    description: "Net margin value attributed to incremental bet days, calculated at mailing level"
    group_label: "Margin Attribution"
    type: sum
    value_format:  "\"£\"#,##0.0,\" k\""
    sql: case when ${TABLE}.unique_subscribers_control_campaign_level = 0 then 0 else ${TABLE}.BET_DAYS_CONTRIBUTION_CAMPAIGN_LEVEL end;;
  }

  measure: stakes_normalised_contribution_campaign_level {
    description: "Net margin value attributed to incremental normalised stakes, calculated at mailing level"
    group_label: "Margin Attribution"
    type: sum
    value_format:  "\"£\"#,##0.0,\" k\""
    sql: case when ${TABLE}.unique_subscribers_control_campaign_level = 0 then 0 else ${TABLE}.STAKES_NORMALISED_CONTRIBUTION_CAMPAIGN_LEVEL end;;
  }

  measure: margin_normalised_contribution_campaign_level {
    description: "Net margin value attributed to incremental normalised margin, calculated at mailing level"
    group_label: "Margin Attribution"
    type: sum
    value_format:  "\"£\"#,##0.0,\" k\""
    sql: case when ${TABLE}.unique_subscribers_control_campaign_level = 0 then 0 else ${TABLE}.MARGIN_NORMALISED_CONTRIBUTION_CAMPAIGN_LEVEL end;;
  }

  measure: free_bets_normalised_contribution_campaign_level {
    description: "Incremental normalised value of free bets in the treatment group, calculated at mailing level"
    group_label: "Margin Attribution"
    type: sum
    value_format:  "\"£\"#,##0.0,\" k\""
    sql: case when ${TABLE}.unique_subscribers_control_campaign_level = 0 then 0 else ${TABLE}.FREE_BETS_NORMALISED_CONTRIBUTION_CAMPAIGN_LEVEL end;;
  }

  measure: total_net_profit_margin_normalised_campaign_level {
    description: "Total assumed net profit, calculated at mailing level"
    group_label: "Margin Attribution"
    type: sum
    value_format:  "\"£\"#,##0.0,\" k\""
    sql:  case when ${TABLE}.unique_subscribers_control_campaign_level = 0 then 0 else ${TABLE}.TOTAL_NET_PROFIT_MARGIN_NORMALISED_CAMPAIGN_LEVEL end;;
  }

  measure: incremental_actives_campaign_level {
    description: "Number of active subscribers attributed to the mailing itself, calculated at mailing level. To be used when doing analysis at campaign level (not customer segment level)"
    group_label: "Incrementals"
    type: sum
    value_format: "#,##0"
    sql: ${TABLE}.incremental_actives_campaign_level ;;
    drill_fields: [send_date, mailing_name, incremental_actives_campaign_level, incremental_bet_days_campaign_level, incremental_stakes_normalised_campaign_level, incremental_margin_normalised_campaign_level, incremental_free_bets_normalised_campaign_level, incremental_net_profit_margin_normalised_campaign_level]
  }

  measure: incremental_actives_campaign_level_w_format {
    description: "Number of active subscribers attributed to the mailing itself, calculated at mailing level. To be used when doing analysis at campaign level (not customer segment level)"
    label:"Incremental Actives Campaign Level"
    group_label: "Incrementals"
    type: sum
    hidden: yes
    value_format: "#,##0"
    sql: ${TABLE}.incremental_actives_campaign_level ;;
    drill_fields: [send_date, mailing_name, incremental_actives_campaign_level, incremental_bet_days_campaign_level, incremental_stakes_normalised_campaign_level, incremental_margin_normalised_campaign_level, incremental_free_bets_normalised_campaign_level, incremental_net_profit_margin_normalised_campaign_level]
    html:
    <a href="#drillmenu" target="_self">
    {% if value >= 0 %}
      <font color="black">{{ rendered_value }}</font>
    {% elsif value < 0 %}
      <font color="red">{{ rendered_value }}</font>
    {% endif %}
        </a>;;
  }

  measure: incremental_bet_days_campaign_level {
    description: "Number of bet days attributed to the mailing itself, calculated at mailing level. To be used when doing analysis at campaign level (not customer segment level)"
    group_label: "Incrementals"
    type: sum
    value_format: "#,##0"
    sql: ${TABLE}.incremental_bet_days_campaign_level ;;
  }

  measure: incremental_bet_days_campaign_level_w_format {
    description: "Number of bet days attributed to the mailing itself, calculated at mailing level. To be used when doing analysis at campaign level (not customer segment level)"
    label:"Incremental Bet Days Campaign Level"
    group_label: "Incrementals"
    type: sum
    hidden: yes
    value_format: "#,##0"
    sql: ${TABLE}.incremental_bet_days_campaign_level ;;
    html:
    <a href="#drillmenu" target="_self">
    {% if value >= 0 %}
    <font color="black">{{ rendered_value }}</font>
    {% elsif value < 0 %}
    <font color="red">{{ rendered_value }}</font>
    {% endif %}
    </a>;;
  }

  measure: incremental_stakes_campaign_level {
    description: "Total stakes attributed to the mailing itself, calculated at mailing level. To be used when doing analysis at campaign level (not customer segment level)"
    group_label: "Incrementals"
    type: sum
    value_format: "\"£\"#,###"
    hidden: yes
    sql: ${TABLE}.incremental_stakes_campaign_level ;;
  }

  measure: incremental_stakes_normalised_campaign_level {
    description: "Total normalised stakes attributed to the mailing itself, calculated at mailing level. To be used when doing analysis at campaign level (not customer segment level)"
    group_label: "Incrementals"
    type: sum
    value_format: "\"£\"#,###"
    sql: ${TABLE}.incremental_stakes_normalised_campaign_level ;;
  }

  measure: incremental_stakes_normalised_campaign_level_w_format {
    description: "Total normalised stakes attributed to the mailing itself, calculated at mailing level. To be used when doing analysis at campaign level (not customer segment level)"
    label:"Incremental Stakes Normalised Campaign Level"
    group_label: "Incrementals"
    type: sum
    hidden: yes
    value_format: "\"£\"#,###"
    sql: ${TABLE}.incremental_stakes_normalised_campaign_level ;;
    html:
    <a href="#drillmenu" target="_self">
    {% if value >= 0 %}
    <font color="black">{{ rendered_value }}</font>
    {% elsif value < 0 %}
    <font color="red">{{ rendered_value }}</font>
    {% endif %}
    </a>;;
  }

  measure: incremental_margin_campaign_level {
    description: "Total margin attributed to the mailing itself, calculated at mailing level. To be used when doing analysis at campaign level (not customer segment level)"
    group_label: "Incrementals"
    type: sum
    value_format: "\"£\"#,###"
    hidden: yes
    sql: ${TABLE}.incremental_margin_campaign_level ;;
  }

  measure: incremental_margin_normalised_campaign_level {
    description: "Total normalised margin attributed to the mailing itself, calculated at mailing level. To be used when doing analysis at campaign level (not customer segment level)"
    group_label: "Incrementals"
    type: sum
    value_format: "\"£\"#,###"
    sql: ${TABLE}.incremental_margin_normalised_campaign_level ;;
  }

  measure: incremental_margin_normalised_campaign_level_w_format {
    description: "Total normalised margin attributed to the mailing itself, calculated at mailing level. To be used when doing analysis at campaign level (not customer segment level)"
    label:"Incremental Margin Normalised Campaign Level"
    group_label: "Incrementals"
    type: sum
    hidden: yes
    value_format: "\"£\"#,###"
    sql: ${TABLE}.incremental_margin_normalised_campaign_level ;;
    html:
    <a href="#drillmenu" target="_self">
    {% if value >= 0 %}
    <font color="black">{{ rendered_value }}</font>
    {% elsif value < 0 %}
    <font color="red">{{ rendered_value }}</font>
    {% endif %}
    </a>;;
  }

  measure: incremental_free_bets_campaign_level {
    description: "Total free bets attributed to the mailing itself, calculated at mailing level. To be used when doing analysis at campaign level (not customer segment level)"
    group_label: "Incrementals"
    type: sum
    value_format: "\"£\"#,###"
    hidden: yes
    sql: ${TABLE}.incremental_free_bets_campaign_level ;;
  }

  measure: incremental_free_bets_normalised_campaign_level {
    description: "Total normalised free bets attributed to the mailing itself, calculated at mailing level. To be used when doing analysis at campaign level (not customer segment level)"
    group_label: "Incrementals"
    type: sum
    value_format: "\"£\"#,###"
    sql: ${TABLE}.incremental_free_bets_normalised_campaign_level ;;
  }

  measure: incremental_free_bets_normalised_campaign_level_w_format {
    description: "Total normalised free bets attributed to the mailing itself, calculated at mailing level. To be used when doing analysis at campaign level (not customer segment level)"
    label:"Incremental Free Bets Normalised Campaign Level"
    group_label: "Incrementals"
    type: sum
    hidden: yes
    value_format: "\"£\"#,###"
    sql: ${TABLE}.incremental_free_bets_normalised_campaign_level ;;
    html:
    <a href="#drillmenu" target="_self">
    {% if value >= 0 %}
    <font color="black">{{ rendered_value }}</font>
    {% elsif value < 0 %}
    <font color="red">{{ rendered_value }}</font>
    {% endif %}
    </a>;;
  }

  measure: unique_subscribers_treatment_campaign_level {
    description: "Total distinct control subscribers"
    type: sum
    hidden: yes
    sql: ${TABLE}.unique_subscribers_treatment_campaign_level ;;
  }

  measure: unique_subscribers_control_campaign_level {
    description: "Total distinct control subscribers"
    type: sum
    hidden: yes
    sql: ${TABLE}.unique_subscribers_control_campaign_level ;;
  }

  measure: incremental_net_profit_margin_normalised_campaign_level {
    description: "The difference between total margin normalised and total free bets normalised, calculated at mailing level"
    type: number
    #hidden: yes
    value_format: "\"£\"#,###"
    sql: case when ${unique_subscribers_control_campaign_level} = 0 then 0 else
      ${total_net_profit_margin_normalised_campaign_level}-coalesce(${control_net_profit_margin_normalised_campaign_level},0) end;;
    drill_fields: [send_date, mailing_name, incremental_net_profit_margin_normalised_campaign_level, incremental_actives_campaign_level, incremental_bet_days_campaign_level, incremental_stakes_normalised_campaign_level, incremental_margin_normalised_campaign_level, incremental_free_bets_normalised_campaign_level]
  }

  measure: incremental_net_profit_margin_normalised_campaign_level_w_format {
    description: "The difference between total margin normalised and total free bets normalised, calculated at mailing level"
    label: "Incremental Net Profit Margin Normalised Campaign Level"
    group_label: "Incrementals"
    type: number
    hidden: yes
    value_format: "\"£\"#,###"
    sql: case when ${unique_subscribers_control_campaign_level} = 0  then 0 else
      ${total_net_profit_margin_normalised_campaign_level}-${control_net_profit_margin_normalised_campaign_level} end;;
    drill_fields: [send_date, mailing_name, incremental_net_profit_margin_normalised_campaign_level, incremental_actives_campaign_level, incremental_bet_days_campaign_level, incremental_stakes_normalised_campaign_level, incremental_margin_normalised_campaign_level, incremental_free_bets_normalised_campaign_level]
    html:
    <a href="#drillmenu" target="_self">
    {% if value >= 0 %}
    <font color="black">{{ rendered_value }}</font>
    {% elsif value < 0 %}
    <font color="red">{{ rendered_value }}</font>
    {% endif %}
    </a>;;
  }

  parameter: select_metric {
    description: "Field created to allow a breakdown of various metrics such as incremental activity and incremental margin attribution for actives, bet days, stakes, margin and free bets. To be used when doing analysis at campaign level (not customer segment level)"
    type: string
    hidden:yes
    allowed_value: {
      label: "Actives"
      value: "actives"
    }

    allowed_value: {
      label: "Bet Days"
      value: "bet_days"
    }

    allowed_value: {
      label: "Stakes (Normalised)"
      value: "stakes_normalised"
    }

    allowed_value: {
      label: "Margin (Normalised)"
      value: "margin_normalised"
    }

    allowed_value: {
      label: "Free bets (Normalised)"
      value: "free_bets_normalised"
    }
  }

  measure: negative_metric {
    description: "Populated for metrics with negative incrementals - Only works if the filter 'Select Metric' is on"
    type: number
    hidden:yes
    sql: case when {% parameter select_metric %} = 'actives' and ${incremental_actives_campaign_level} < 0 then ${incremental_actives_campaign_level}
                  when {% parameter select_metric %}  = 'bet_days' and ${incremental_bet_days_campaign_level} < 0 then ${incremental_bet_days_campaign_level}
                  when {% parameter select_metric %}  = 'stakes_normalised' and ${incremental_stakes_normalised_campaign_level} < 0 then ${incremental_stakes_normalised_campaign_level}
                  when {% parameter select_metric %}  = 'margin_normalised' and ${incremental_margin_normalised_campaign_level} < 0 then ${incremental_margin_normalised_campaign_level}
                  when {% parameter select_metric %}  = 'free_bets_normalised' and ${incremental_free_bets_normalised_campaign_level} < 0 then ${incremental_free_bets_normalised_campaign_level}
        end;;

      value_format_name: decimal_0

    }

    measure: positive_metric {
      description: "Populated for metrics with positive incrementals - Only works if the filter 'Select Metric' is on"
      type: number
      hidden:yes
      sql: case when {% parameter select_metric %} = 'actives' and ${incremental_actives_campaign_level} >= 0 then ${incremental_actives_campaign_level}
                  when {% parameter select_metric %}  = 'bet_days' and ${incremental_bet_days_campaign_level} >= 0 then ${incremental_bet_days_campaign_level}
                  when {% parameter select_metric %}  = 'stakes_normalised' and ${incremental_stakes_normalised_campaign_level} >= 0 then ${incremental_stakes_normalised_campaign_level}
                  when {% parameter select_metric %}  = 'margin_normalised' and ${incremental_margin_normalised_campaign_level} >= 0 then ${incremental_margin_normalised_campaign_level}
                  when {% parameter select_metric %}  = 'free_bets_normalised' and ${incremental_free_bets_normalised_campaign_level} >= 0 then ${incremental_free_bets_normalised_campaign_level}
        end;;

        value_format_name: decimal_0
      }

      parameter: incremental_actives_or_net_profit {
        description: "Field which allows switching between incremental actives, incremental net profit margin and incremental net profit margin normalised. To be used when doing analysis at campaign level (not customer segment level)"
        type: string
        hidden:yes
        allowed_value: {
          label: "Incremental Actives"
          value: "actives_campaign_level"
        }

        allowed_value: {
          label: "Incremental Net Profit Margin Normalised"
          value: "incremental_net_profit_margin_normalised_campaign_level"
        }

      }

      measure: incremental_metric {
        label_from_parameter: incremental_actives_or_net_profit
        description: "This is a value which dynamically changes based on the field called incremental_active_or_net_profit"
        drill_fields: [send_date, mailing_name, incremental_net_profit_margin_normalised_campaign_level, incremental_actives_campaign_level, incremental_bet_days_campaign_level, incremental_stakes_normalised_campaign_level, incremental_margin_normalised_campaign_level, incremental_free_bets_normalised_campaign_level]
        type: number
        hidden:yes
        sql: case when {% parameter incremental_actives_or_net_profit %} = 'actives_campaign_level' then ${incremental_actives_campaign_level}
                  when {% parameter incremental_actives_or_net_profit %}  = 'incremental_net_profit_margin_normalised_campaign_level' then ${incremental_net_profit_margin_normalised_campaign_level}
        end;;

          value_format_name: decimal_0
          html:
              <a href="#drillmenu" target="_self">
              {% assign var=_filters['incremental_actives_or_net_profit']  %}
              {% if "incremental^_net^_profit^_margin^_normalised^_campaign^_level" == var %}
                  <font color="black">£{{ rendered_value }}</font>
              {% elsif "actives^_campaign^_level" == var %}
                  <font color="black">{{ rendered_value }}</font>
              {% endif %}
              </a>;;

          }

          filter: dynamic_logo_filter {
            suggestable: yes
            hidden: yes
            suggestions: ["Electricals","Sport & Leisure","Furniture","Beauty","Home & Garden"]
          }

          dimension: dynamic_logo {
            description: "Only works if the filter 'Dynamic Logo Filter' is on"
            hidden:yes
            sql:
                  case when
                    case when {% condition dynamic_logo_filter %} 'Electricals' {% endcondition %} then 1 else 0 end +
                    case when {% condition dynamic_logo_filter %} 'Sport & Leisure' {% endcondition %} then 1 else 0 end +
                    case when {% condition dynamic_logo_filter %} 'Furniture' {% endcondition %} then 1 else 0 end +
                    case when {% condition dynamic_logo_filter %} 'Beauty' {% endcondition %} then 1 else 0 end +
                    case when {% condition dynamic_logo_filter %} 'Home & Garden' {% endcondition %} then 1 else 0 end <> 1
                    then 'https://static1.squarespace.com/static/5a27fde0d74cff1ed0580900/t/5b102ed070a6adf99f2618fb/1527787220709/fakelogo2.jpeg'
                  when {% condition dynamic_logo_filter %} 'Electricals' {% endcondition %} then 'https://static1.squarespace.com/static/5a27fde0d74cff1ed0580900/t/5b100d03352f53b071710ab3/1527778567044'
                  when {% condition dynamic_logo_filter %} 'Sport & Leisure' {% endcondition %} then 'https://static1.squarespace.com/static/5a27fde0d74cff1ed0580900/t/5b100c790e2e7296bcc5a6a4/1527778433219/sport.jpeg'
                  when {% condition dynamic_logo_filter %} 'Furniture' {% endcondition %} then 'https://static1.squarespace.com/static/5a27fde0d74cff1ed0580900/t/5b100ce4352f53b0717104c4/1527778535695'
                  when {% condition dynamic_logo_filter %} 'Beauty' {% endcondition %} then 'https://static1.squarespace.com/static/5a27fde0d74cff1ed0580900/t/5b100c980e2e7296bcc5ac25/1527778463387/beauty.jpeg'
                  when {% condition dynamic_logo_filter %} 'Home & Garden' {% endcondition %} then 'https://static1.squarespace.com/static/5a27fde0d74cff1ed0580900/t/5b100cc6aa4a998d558e35e6/1527778521830/homeandgarden.jpeg'
                  else 'https://static1.squarespace.com/static/5a27fde0d74cff1ed0580900/t/5b102ed070a6adf99f2618fb/1527787220709/fakelogo2.jpeg'
                  end;;
            html: <img src="{{ value }}" width="200" height="200" /> ;;

          }


        }
