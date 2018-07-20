view: crm_segment_level_summary {
  derived_table: {
    sql:
      select      product,
            to_date(senddatetime) as send_date,
            campaigncode,
            mailing_name,
            mailing_id,
            lifestage,
            product||to_date(senddatetime)||campaigncode||coalesce(mailing_name,' ')||coalesce(mailing_id,0)||lifestage as segment_level_id,
            product||to_date(senddatetime)||campaigncode||coalesce(mailing_name,' ')||coalesce(mailing_id,0) as mailing_level_id,
            has_control_flag,

            sum(case when iscontrol = 'no' then uniques else 0 end) as unique_subscribers_treatment_segment_level,
            sum(case when iscontrol = 'yes' and emailengagementstatus in ('D', 'R') then uniques else 0 end) as unique_subscribers_control_segment_level,

            sum(case when iscontrol = 'no' then actives else 0 end) as actives_treatment_segment_level,
            sum(case when iscontrol = 'yes' and emailengagementstatus in ('D', 'R') then actives else 0 end) as actives_control_segment_level,

            sum(case when iscontrol = 'no' then bet_days else 0 end) as bet_days_treatment_segment_level,
            sum(case when iscontrol = 'yes' and emailengagementstatus in ('D', 'R') then bet_days else 0 end) as bet_days_control_segment_level,

            sum(case when iscontrol = 'no' then stakes else 0 end) as stakes_treatment_segment_level,
            sum(case when iscontrol = 'yes' and emailengagementstatus in ('D', 'R') then stakes else 0 end) as stakes_control_segment_level,

            sum(case when iscontrol = 'no' then stakes_normalised else 0 end) as stakes_normalised_treatment_segment_level,
            sum(case when iscontrol = 'yes' and emailengagementstatus in ('D', 'R') then stakes_normalised else 0 end) as stakes_normalised_control_segment_level,

            sum(case when iscontrol = 'no' then margin else 0 end) as margin_treatment_segment_level,
            sum(case when iscontrol = 'yes' and emailengagementstatus in ('D', 'R') then margin else 0 end) as margin_control_segment_level,

            sum(case when iscontrol = 'no' then margin_normalised else 0 end) as margin_normalised_treatment_segment_level,
            sum(case when iscontrol = 'yes' and emailengagementstatus in ('D', 'R') then margin_normalised else 0 end) as margin_normalised_control_segment_level,

          -1.0*sum(case when iscontrol = 'no' then free_bets_normalised else 0 end) as free_bets_normalised_treatment_segment_level,
          -1.0*sum(case when iscontrol = 'yes' and emailengagementstatus in ('D', 'R') then free_bets_normalised else 0 end) as free_bets_normalised_control_segment_level,

          -1.0*sum(case when iscontrol = 'no' then free_bets else 0 end) as free_bets_treatment_segment_level,
          -1.0*sum(case when iscontrol = 'yes' and emailengagementstatus in ('D', 'R') then free_bets else 0 end) as free_bets_control_segment_level,

          1.0*(coalesce(actives_treatment_segment_level,0)/nullif(unique_subscribers_treatment_segment_level,0)) as perc_of_unique_subscribers_active_treatment_segment_level,
          1.0*(coalesce(actives_control_segment_level,0)/nullif(unique_subscribers_control_segment_level,0)) as perc_of_unique_subscribers_active_control_segment_level,


          1.0*(coalesce(bet_days_treatment_segment_level,0)/nullif(actives_treatment_segment_level,0)) as average_bet_days_treatment_segment_level,
          1.0*(coalesce(bet_days_control_segment_level,0)/nullif(actives_control_segment_level,0)) as average_bet_days_control_segment_level,

          1.0*(coalesce(stakes_normalised_treatment_segment_level,0)/nullif(bet_days_treatment_segment_level,0)) as stake_per_bet_day_treatment_segment_level,
          1.0*(coalesce(stakes_normalised_control_segment_level,0)/nullif(bet_days_control_segment_level,0)) as stake_per_bet_day_control_segment_level,

          1.0*(coalesce(margin_normalised_treatment_segment_level,0)/nullif(stakes_normalised_treatment_segment_level,0)) as margin_per_stake_treatment_segment_level,
          1.0*(coalesce(margin_normalised_control_segment_level,0)/nullif(stakes_normalised_control_segment_level,0)) as margin_per_stake_control_segment_level,

          1.0*(coalesce(free_bets_normalised_treatment_segment_level,0)/nullif(unique_subscribers_treatment_segment_level,0)) as free_bet_per_unique_subscribers_treatment_segment_level,
          1.0*(coalesce(free_bets_normalised_control_segment_level,0)/nullif(unique_subscribers_control_segment_level,0)) as free_bet_per_unique_subscribers_control_segment_level,

          1.0*(unique_subscribers_treatment_segment_level*(perc_of_unique_subscribers_active_control_segment_level*average_bet_days_control_segment_level*stake_per_bet_day_control_segment_level
                *margin_per_stake_control_segment_level+free_bet_per_unique_subscribers_control_segment_level)) as control_net_profit_margin_normalised_segment_level,

          1.0*(coalesce(unique_subscribers_treatment_segment_level,0)*(coalesce(perc_of_unique_subscribers_active_treatment_segment_level,0)*coalesce(average_bet_days_control_segment_level,0)
                *coalesce(stake_per_bet_day_control_segment_level,0)*coalesce(margin_per_stake_control_segment_level,0)+coalesce(free_bet_per_unique_subscribers_control_segment_level,0))
                -coalesce(control_net_profit_margin_normalised_segment_level,0)) as actives_contribution_segment_level,

          1.0*(coalesce(unique_subscribers_treatment_segment_level,0)*(coalesce(perc_of_unique_subscribers_active_treatment_segment_level,0)*coalesce(average_bet_days_treatment_segment_level,0)
                *coalesce(stake_per_bet_day_control_segment_level,0)*coalesce(margin_per_stake_control_segment_level,0)+coalesce(free_bet_per_unique_subscribers_control_segment_level,0))
                -coalesce(control_net_profit_margin_normalised_segment_level,0)-coalesce(actives_contribution_segment_level,0)) as bet_days_contribution_segment_level,

          1.0*(coalesce(unique_subscribers_treatment_segment_level,0)*(coalesce(perc_of_unique_subscribers_active_treatment_segment_level,0)*coalesce(average_bet_days_treatment_segment_level,0)
                *coalesce(stake_per_bet_day_treatment_segment_level,0)*coalesce(margin_per_stake_control_segment_level,0)+coalesce(free_bet_per_unique_subscribers_control_segment_level,0))
                -coalesce(control_net_profit_margin_normalised_segment_level,0)-coalesce(actives_contribution_segment_level,0)-coalesce(bet_days_contribution_segment_level,0)) as stakes_normalised_contribution_segment_level,

          1.0*(coalesce(unique_subscribers_treatment_segment_level,0)*(coalesce(perc_of_unique_subscribers_active_treatment_segment_level,0)*coalesce(average_bet_days_treatment_segment_level,0)
                *coalesce(stake_per_bet_day_treatment_segment_level,0)*coalesce(margin_per_stake_treatment_segment_level,0)+coalesce(free_bet_per_unique_subscribers_control_segment_level,0))
                -coalesce(control_net_profit_margin_normalised_segment_level,0)-coalesce(actives_contribution_segment_level,0)-coalesce(bet_days_contribution_segment_level,0)-coalesce(stakes_normalised_contribution_segment_level,0)) as margin_normalised_contribution_segment_level,

          1.0*(coalesce(unique_subscribers_treatment_segment_level,0)*(coalesce(perc_of_unique_subscribers_active_treatment_segment_level,0)*coalesce(average_bet_days_treatment_segment_level,0)
                *coalesce(stake_per_bet_day_treatment_segment_level,0)*coalesce(margin_per_stake_treatment_segment_level,0)+coalesce(free_bet_per_unique_subscribers_treatment_segment_level,0))
                -coalesce(control_net_profit_margin_normalised_segment_level,0)-coalesce(actives_contribution_segment_level,0)-coalesce(bet_days_contribution_segment_level,0)
                -coalesce(stakes_normalised_contribution_segment_level,0)-coalesce(margin_normalised_contribution_segment_level,0)) as free_bets_normalised_contribution_segment_level,

          coalesce(margin_normalised_treatment_segment_level,0)+coalesce(free_bets_normalised_treatment_segment_level,0) as total_net_profit_margin_normalised_segment_level,

          1.0*(actives_treatment_segment_level/nullif(unique_subscribers_treatment_segment_level,0) - actives_control_segment_level/nullif(unique_subscribers_control_segment_level,0)) * unique_subscribers_treatment_segment_level as incremental_actives_segment_level,

          1.0*(bet_days_treatment_segment_level/nullif(unique_subscribers_treatment_segment_level,0) - bet_days_control_segment_level/nullif(unique_subscribers_control_segment_level,0)) * unique_subscribers_treatment_segment_level as incremental_bet_days_segment_level,

          1.0*(stakes_treatment_segment_level/nullif(unique_subscribers_treatment_segment_level,0) - stakes_control_segment_level/nullif(unique_subscribers_control_segment_level,0)) * unique_subscribers_treatment_segment_level as incremental_stakes_segment_level,

          1.0*(stakes_normalised_treatment_segment_level/nullif(unique_subscribers_treatment_segment_level,0) - stakes_normalised_control_segment_level/nullif(unique_subscribers_control_segment_level,0)) * unique_subscribers_treatment_segment_level as incremental_stakes_normalised_segment_level,

          1.0*(margin_treatment_segment_level/nullif(unique_subscribers_treatment_segment_level,0) - margin_control_segment_level/nullif(unique_subscribers_control_segment_level,0)) * unique_subscribers_treatment_segment_level as incremental_margin_segment_level,

          1.0*(margin_normalised_treatment_segment_level/nullif(unique_subscribers_treatment_segment_level,0) - margin_normalised_control_segment_level/nullif(unique_subscribers_control_segment_level,0)) * unique_subscribers_treatment_segment_level as incremental_margin_normalised_segment_level,

          1.0*(free_bets_treatment_segment_level/nullif(unique_subscribers_treatment_segment_level,0) - free_bets_control_segment_level/nullif(unique_subscribers_control_segment_level,0)) * unique_subscribers_treatment_segment_level as incremental_free_bets_segment_level,

          1.0*(free_bets_normalised_treatment_segment_level/nullif(unique_subscribers_treatment_segment_level,0) - free_bets_normalised_control_segment_level/nullif(unique_subscribers_control_segment_level,0)) * unique_subscribers_treatment_segment_level as incremental_free_bets_normalised_segment_level


          from
              (
              select t1.*,
                  max(case when emailengagementstatus in ('D', 'R') then 1 else 0 end) over (partition by product,to_date(senddatetime),campaigncode,mailing_name,mailing_id) as has_control_flag
              from PRESENTATION.CRM_DEMO t1

              where emailengagementstatus in ('A','B','D', 'R')
              )
          group by 1,2,3,4,5,6,7,8,9


       ;;
#    datagroup_trigger: crm_sandbox_default_datagroup
    }

    dimension: segment_level_id {
      view_label: "(4) Segment Level Fields"
      description: "Unique key for the each mailing, and for each segment combination (favourite brand, weeks since active and life stage)"
      type: string
      primary_key: yes
      hidden:  yes
      sql: ${TABLE}.SEGMENT_LEVEL_ID;;
    }

    dimension: mailing_level_id {
      view_label: "(2) Mailing and Segment Level"
      description: "Unique key for the each mailing"
      type: string
      hidden:  yes
      sql: ${TABLE}.MAILING_LEVEL_ID;;
    }

    dimension: product {
      view_label: "(2) Mailing and Segment Level"
      type: string
      sql: ${TABLE}.PRODUCT ;;
    }

    dimension_group: send {
      view_label: "(2) Mailing and Segment Level"
      description: "The date when the communication was sent, grouped into different dimensions"
      type: time
      timeframes: [
        raw,
        date,
        month,
        year
      ]
      sql: ${TABLE}.SEND_DATE ;;
    }

    dimension: send_week {
      view_label: "(2) Mailing and Segment Level"
      description: "The date when the communication was sent, grouped into different dimensions"
      label: "Week"
      group_label: "Send Date"
      sql: TO_CHAR(TO_DATE(DATEADD('day', (0 - MOD(EXTRACT(DOW FROM ${TABLE}.senddatetime )::integer - 5 + 7, 7)), ${TABLE}.senddatetime )), 'YYYY-MM-DD') ;;
      link: {label: "Campaigns breakdown"
        url:"https://redkitedemo.eu.looker.com/dashboards/11?Product={{ _filters['product'] | url_encode }}&Mailing%20Send%20Date={{ value }}+for+7+days&Communication%20Type={{ _filters['crm_extract.communication_type'] | url_encode }}&Filter%20for%20Campaigns%20with%20Selection%20Issues={{ _filters['crm_extract.selection_issue'] | url_encode }}"
      }
#     required_fields: [cpr_segment_level_summary.product]
    }

    dimension: send_date_filter {
      view_label: "(2) Mailing and Segment Level"
      description: "Field to be used for filtering as it autopopulated suggestions for dates"
      type: string
      sql: to_varchar(${TABLE}.SENDDATETIME,'DD-MON-YYYY') ;;
      order_by_field: send_raw
      full_suggestions: yes
    }

    dimension: mailing_name {
      view_label: "(2) Mailing and Segment Level"
      description: "Linked to the mailing ID, each mailing sent has a unique name. It is not unique at communication level, as the same mailing can go out multiple times"
      type: string
      sql: ${TABLE}.MAILING_NAME ;;
      link: {label: "Details about this mailing"
        url:"https://redkitedemo.eu.looker.com/dashboards/12?Mailing%20Name={{ ['mailing_name'] | url_encode }}&Send%20Date={{ ['send_date'] | url_encode }}"}
    }

    dimension: mailing_name_with_date {
      view_label: "(2) Mailing and Segment Level"
      description: "Field created as a concatenation between the send date and the name of a campaign"
      type: string
      sql: ${send_date}||' '|| ${TABLE}.MAILING_NAME ;;
      # The link below creates a drill through to the Campaign Drilldown dashboard; it passes through a filter on mailing name
      link: {label: "Details about this mailing"
        url:"https://redkitedemo.eu.looker.com/dashboards/12?Mailing%20Name={{ ['mailing_name'] | url_encode }}&Send%20Date={{ ['send_date'] | url_encode }}"}
      #&Product={{ _filters['cpr_extract.product'] | url_encode }}
      full_suggestions: yes
    }

    dimension: mailing_id {
      view_label: "(2) Mailing and Segment Level"
      description: "Distinct numerical code for each individual mailing. It is not unique at communication level, as the same mailing can go out multiple times"
      type: string
      hidden: yes
      sql: ${TABLE}.MAILING_ID;;
    }

    measure: unique_subscribers_treatment {
      view_label: "(2) Mailing and Segment Level"
      group_label: "Treatment Metrics"
      description: "Total distinct treatment subscribers"
      value_format: "[>=1000000]#.0,,\"M\";[>=1000]#.0,\"K\";0"
      type: sum
      #hidden: yes
      sql:${TABLE}.UNIQUE_SUBSCRIBERS_TREATMENT_SEGMENT_LEVEL ;;
    }

    measure: unique_subscribers_control {
      view_label: "(2) Mailing and Segment Level"
      group_label: "Control Metrics"
      description: "Total distinct control subscribers"
      type: sum
      #hidden: yes
      sql: ${TABLE}.UNIQUE_SUBSCRIBERS_CONTROL_SEGMENT_LEVEL;;
    }

    measure: perc_control_size {
      view_label: "(2) Mailing and Segment Level"
      description: "Total control subscribers divided by total control and treatment subscribers"
      type: number
      value_format: "0.00%"
      sql: ${unique_subscribers_control}/nullif(${unique_subscribers_control}+${unique_subscribers_treatment},0) ;;
    }

    measure: visitors_treatment {
      view_label: "(2) Mailing and Segment Level"
      group_label: "Treatment Metrics"
      description: "Total distinct treatment subscribers who have placed a bet within the outcome window"
      type: sum
      #hidden: yes
      sql: ${TABLE}.ACTIVES_TREATMENT_SEGMENT_LEVEL;;
    }

    measure: visitors_control {
      view_label: "(2) Mailing and Segment Level"
      group_label: "Control Metrics"
      description: "Total distinct control subscribers who have placed a bet within the outcome window"
      type: sum
      #hidden: yes
      sql: ${TABLE}.ACTIVES_CONTROL_SEGMENT_LEVEL;;
    }

    measure: incremental_visitors_segment_level {
      description: "Number of active subscribers attributed to the mailing itself, calculated at segment level. To be used when doing analysis at customer segment level (not campaign level)"
      group_label: "Incrementals"
      view_label: "(4) Segment Level Fields"
      type: sum
      #hidden:yes
      value_format: "#,##0"
      sql: ${TABLE}.incremental_actives_segment_level ;;
    }

    measure: incremental_visitors_segment_level_w_format {
      description: "Number of active subscribers attributed to the mailing itself, calculated at segment level. To be used when doing analysis at customer segment level (not campaign level)"
      label:"Incremental Actives Segment Level"
      view_label: "(4) Segment Level Fields"
      group_label: "Incrementals"
      type: sum
      hidden: yes
      value_format: "#,##0"
      sql: ${TABLE}.incremental_actives_segment_level ;;
      drill_fields: [send_date, mailing_name, incremental_visitors_segment_level, incremental_visits_segment_level, incremental_total_spend_normalised_segment_level, incremental_margin_normalised_segment_level, incremental_returns_normalised_segment_level, incremental_net_profit_margin_normalised_segment_level]
      html:
          <a href="#drillmenu" target="_self">
          {% if value >= 0 %}
            <font color="black">{{ rendered_value }}</font>
          {% elsif value < 0 %}
            <font color="red">{{ rendered_value }}</font>
          {% endif %}
              </a>;;
    }

    measure: visits_treatment {
      view_label: "(2) Mailing and Segment Level"
      description: "Total number of days with at least one bet within the outcome window for the treatment subscribers"
      type: sum
      hidden: yes
      sql: ${TABLE}.BET_DAYS_TREATMENT_SEGMENT_LEVEL;;
    }

    measure: visits_control {
      view_label: "(2) Mailing and Segment Level"
      description: "Total number of days with at least one bet within the outcome window for the control subscribers"
      type: sum
      hidden: yes
      sql: ${TABLE}.BET_DAYS_CONTROL_SEGMENT_LEVEL;;
    }

    measure: incremental_visits_segment_level {
      view_label: "(4) Segment Level Fields"
      group_label: "Incrementals"
      description: "Number of bet days attributed to the mailing itself, calculated at segment level. To be used when doing analysis at customer segment level (not campaign level)"
      type: sum
      #hidden: yes
      value_format: "#,##0"
      sql: ${TABLE}.incremental_bet_days_segment_level ;;
    }

    measure: total_spend_normalised_treatment {
      view_label: "(2) Mailing and Segment Level"
      description: "Total stakes placed by the treatment subscribers within the outcome window, after outliers have been normalised"
      type: sum
      hidden: yes
      sql: ${TABLE}.STAKES_NORMALISED_TREATMENT_SEGMENT_LEVEL  ;;
    }

    measure: total_spend_normalised_control {
      view_label: "(2) Mailing and Segment Level"
      description: "Total stakes placed by the control subscribers within the outcome window, after outliers have been normalised"
      type: sum
      hidden: yes
      sql: ${TABLE}.STAKES_NORMALISED_CONTROL_SEGMENT_LEVEL  ;;
    }

    measure: incremental_total_spend_normalised_segment_level {
      view_label: "(4) Segment Level Fields"
      group_label: "Incrementals"
      description: "Total normalised stakes attributed to the mailing itself, calculated at segment level. To be used when doing analysis at customer segment level (not campaign level)"
      type: sum
      #hidden: yes
      value_format: "\"£\"#,###"
      sql: ${TABLE}.incremental_stakes_normalised_segment_level ;;
    }

    measure: total_spend_treatment {
      view_label: "(2) Mailing and Segment Level"
      description: "Total stakes placed by the treatment subscribers within the outcome window"
      type: sum
      hidden: yes
      sql: ${TABLE}.STAKES_TREATMENT ;;
    }

    measure: total_spend_control {
      view_label: "(2) Mailing and Segment Level"
      description: "Total stakes placed by the control subscribers within the outcome window"
      type: sum
      hidden: yes
      sql: ${TABLE}.STAKES_CONTROL_SEGMENT_LEVEL;;
    }

    measure: incremental_total_spend_segment_level {
      view_label: "(4) Segment Level Fields"
      description: "Total stakes attributed to the mailing itself, calculated at segment level. To be used when doing analysis at customer segment level (not campaign level)"
      group_label: "Incrementals"
      type: sum
      hidden: yes
      value_format: "\"£\"#,###"
      sql: ${TABLE}.incremental_stakes_segment_level ;;
    }

    measure: margin_normalised_treatment {
      view_label: "(2) Mailing and Segment Level"
      description: "Total margin within the outcome window for the treatment subscribers, after outliers have been normalised"
      type: sum
      hidden: yes
      sql: ${TABLE}.MARGIN_NORMALISED_TREATMENT_SEGMENT_LEVEL;;
    }

    measure: margin_normalised_control {
      view_label: "(2) Mailing and Segment Level"
      description: "Total margin within the outcome window for the control subscribers, after outliers have been normalised"
      type: sum
      hidden: yes
      sql: ${TABLE}.MARGIN_NORMALISED_CONTROL_SEGMENT_LEVEL;;
    }

    measure: incremental_margin_normalised_segment_level {
      view_label: "(4) Segment Level Fields"
      group_label: "Incrementals"
      description: "Total normalised margin attributed to the mailing itself. To be used when doing analysis at customer segment level (not campaign level)"
      type: sum
      #hidden: yes
      value_format: "\"£\"#,###"
      sql: ${TABLE}.incremental_margin_normalised_segment_level ;;
    }

    measure: margin_treatment {
      view_label: "(2) Mailing and Segment Level"
      description: "Total marginwithin the outcome window for the treatment subscribers"
      type: sum
      hidden: yes
      sql: ${TABLE}.MARGIN_TREATMENT_SEGMENT_LEVEL;;
    }

    measure: margin_control {
      view_label: "(2) Mailing and Segment Level"
      description: "Total margin within the outcome window for the control subscribers"
      type: sum
      hidden: yes
      sql: ${TABLE}.MARGIN_CONTROL_SEGMENT_LEVEL;;
    }

    measure: incremental_margin_segment_level {
      view_label: "(4) Segment Level Fields"
      group_label: "Incrementals"
      description: "Total margin attributed to the mailing itself, calculated at segment level. To be used when doing analysis at customer segment level (not campaign level)"
      type: sum
      hidden: yes
      value_format: "\"£\"#,###"
      sql: ${TABLE}.incremental_margin_segment_level ;;
    }

    measure: returns_normalised_treatment {
      view_label: "(2) Mailing and Segment Level"
      description: "Total free bets redeemed by the treatment subscribers within the outcome window, after outliers have been normalised"
      type: sum
      hidden: yes
      sql: ${TABLE}.FREE_BETS_NORMALISED_TREATMENT_SEGMENT_LEVEL;;
    }

    measure: returns_normalised_control {
      view_label: "(2) Mailing and Segment Level"
      description: "Total free bets redeemed by the control subscribers within the outcome window, after outliers have been normalised"
      type: sum
      hidden: yes
      sql: ${TABLE}.FREE_BETS_NORMALISED_CONTROL_SEGMENT_LEVEL;;
    }

    measure: incremental_returns_normalised_segment_level {
      view_label: "(4) Segment Level Fields"
      group_label: "Incrementals"
      description: "Total normalised free bets attributed to the mailing itself, calculated at segment level. To be used when doing analysis at customer segment level (not campaign level)"
      type: sum
      value_format: "\"£\"#,###"
      sql: -1.0*${TABLE}.incremental_free_bets_normalised_segment_level ;;
    }

    measure: returns_treatment {
      view_label: "(2) Mailing and Segment Level"
      description: "Total free bets redeemed by the treatment subscribers within the outcome window"
      type: sum
      hidden: yes
      sql: ${TABLE}.FREE_BETS_TREATMENT_SEGMENT_LEVEL;;
    }

    measure: returns_control {
      view_label: "(2) Mailing and Segment Level"
      description: "Total free bets redeemed by the control subscribers within the outcome window"
      type: sum
      hidden: yes
      sql: ${TABLE}.FREE_BETS_CONTROL_SEGMENT_LEVEL;;
    }

    measure: incremental_returns_segment_level {
      view_label: "(4) Segment Level Fields"
      group_label: "Incrementals"
      description: "Total free bets attributed to the mailing itself, calculated at segment level. To be used when doing analysis at customer segment level (not campaign level)"
      type: sum
      hidden: yes
      value_format: "\"£\"#,###"
      sql: -1.0*${TABLE}.incremental_free_bets_segment_level ;;
    }

    measure: negative_metric_segment_level {
      view_label: "(4) Segment Level Fields"
      description: "Populated for Fields with negative incrementals - Only works if the filter 'Select Metric' is on"
      group_label: "Segment Level Incrementals"
      label: "Negative incremental"
      type: number
      hidden:yes
      sql: case when {% parameter crm_mailing_level_summary.select_metric  %} = 'visitors' and ${incremental_visitors_segment_level} < 0 then ${incremental_visitors_segment_level}
                  when {% parameter crm_mailing_level_summary.select_metric  %}  = 'visits' and ${incremental_visits_segment_level} < 0 then ${incremental_visits_segment_level}
                  when {% parameter crm_mailing_level_summary.select_metric  %}  = 'total_spend_normalised' and ${incremental_total_spend_normalised_segment_level} < 0 then ${incremental_total_spend_normalised_segment_level}
                  when {% parameter crm_mailing_level_summary.select_metric  %}  = 'margin_normalised' and ${incremental_margin_normalised_segment_level} < 0 then ${incremental_margin_normalised_segment_level}
                  when {% parameter crm_mailing_level_summary.select_metric  %}  = 'returns_normalised' and ${incremental_returns_normalised_segment_level} < 0 then ${incremental_returns_normalised_segment_level}
        end;;

        value_format_name: decimal_0
        # html:
        # {% assign var=_filters['select_metric']  %}
        # {% if "actives" == var %}
        # {{ value }}
        # {% elsif "bet^_days" == var %}
        # {{ value }}
        # {% elsif "stakes^_normalised" == var %}
        # £{{ value }}
        # {% elsif "margin^_normalised" == var %}
        # £{{ value }}
        # {% elsif "free^_bets^_normalised" == var %}
        # £{{ value }}
        # {% endif %} ;;
      }

      measure: positive_metric_segment_level {
        view_label: "(4) Segment Level Fields"
        description: "Populated for Fields with positive incrementals - Only works if the filter 'Select Metric' is on"
        group_label: "Segment Level Incrementals"
        label: "Positive incremental"
        type: number
        hidden:yes
        sql: case when {% parameter crm_mailing_level_summary.select_metric %} = 'visitors' and ${incremental_visitors_segment_level} >= 0 then ${incremental_visitors_segment_level}
                  when {% parameter crm_mailing_level_summary.select_metric %}  = 'visits' and ${incremental_visits_segment_level} >= 0 then ${incremental_visits_segment_level}
                  when {% parameter crm_mailing_level_summary.select_metric %}  = 'total_spend_normalised' and ${incremental_total_spend_normalised_segment_level} >= 0 then ${incremental_total_spend_normalised_segment_level}
                  when {% parameter crm_mailing_level_summary.select_metric %}  = 'margin_normalised' and ${incremental_margin_normalised_segment_level} >= 0 then ${incremental_margin_normalised_segment_level}
                  when {% parameter crm_mailing_level_summary.select_metric %}  = 'returns_normalised' and ${incremental_returns_normalised_segment_level} >= 0 then ${incremental_returns_normalised_segment_level}
        end;;

          value_format_name: decimal_0
        }

        measure: perc_of_unique_subscribers_active_treatment_segment_level {
          view_label: "(4) Segment Level Fields"
          description: "Average treatment active rate, calculated at segment level. Total distinct active treatment subscribers by total distinct treatment subscribers selected for each segment"
          type: average
          #hidden: yes
          value_format: "0.00%"
          sql:  ${TABLE}.perc_of_unique_subscribers_active_treatment_segment_level;;
        }

        measure: perc_of_unique_subscribers_active_control_segment_level {
          view_label: "(4) Segment Level Fields"
          description: "Average control active rate, calculated at segment level. Total distinct active control subscribers by total distinct control subscribers selected for each segment"
          type: average
          #hidden: yes
          value_format: "0.00%"
          sql:  ${TABLE}.perc_of_unique_subscribers_active_control_segment_level;;
        }

        measure: average_visits_treatment_segment_level {
          view_label: "(4) Segment Level Fields"
          description: "Average number of days an active treatment subscriber placed at least one bet, calculated at segment level"
          group_label: "Ratios Treatment"
          type: average
          hidden:yes
          value_format: "0.000"
          sql: ${TABLE}.average_bet_days_treatment_segment_level;;
        }

        measure: incremental_margin_per_total_spend {
          view_label: "(2) Mailing and Segment Level"
          description: "The difference between the treatment assumed margin to stake ratio and the control assumed margin to stake ratio, calculated at segment level"
          type: number
          hidden: yes
          sql:  ${margin_normalised_treatment}/nullif(${total_spend_normalised_treatment},0) - ${margin_normalised_control}/nullif(${total_spend_normalised_control},0) ;;
          value_format: "0.00%"
        }

        measure: incremental_perc_of_unique_subscribers_active {
          view_label: "(2) Mailing and Segment Level"
          description: "The difference between the average active rate for treatment subscribers and the average active rate for the control subscribers, calculated at segment level"
          type: number
          hidden: yes
          sql:  ${perc_of_unique_subscribers_active_treatment_segment_level} - ${perc_of_unique_subscribers_active_control_segment_level};;
          value_format: "0.00%"
        }

        measure: control_net_profit_margin_normalised_segment_level {
          view_label: "(4) Segment Level Fields"
          description: "Scaled net assumed margin normalised which would have been expected if the mailing had not been sent, calculated at segment level"
          type: sum
          hidden: yes
          value_format: "\"£\"#,###"
          sql: case when ${TABLE}.has_control_flag = 0  then 0 else ${TABLE}.CONTROL_NET_PROFIT_MARGIN_NORMALISED_SEGMENT_LEVEL end ;;
        }

        measure: visitors_contribution_segment_level {
          view_label: "(4) Segment Level Fields"
          description: "Net margin value attributed to incremental active subscribers, calculated at segment level"
          group_label: "Margin Attribution"
          type: sum
          value_format: "\"£\"#,###"
          sql:case when ${TABLE}.has_control_flag  = 0  then 0 else ${TABLE}.ACTIVES_CONTRIBUTION_SEGMENT_LEVEL END;;
        }

        measure: visits_contribution_segment_level {
          view_label: "(4) Segment Level Fields"
          description: "Net margin value attributed to incremental bet days, calculated at segment level"
          group_label: "Margin Attribution"
          type: sum
          value_format:  "\"£\"#,##0.0,\" k\""
          sql: Case when ${TABLE}.has_control_flag  = 0  then 0 else ${TABLE}.BET_DAYS_CONTRIBUTION_SEGMENT_LEVEL end;;
        }

        measure: total_spend_normalised_contribution_segment_level {
          view_label: "(4) Segment Level Fields"
          description: "Net margin value attributed to incremental normalised stakes, calculated at segment level"
          group_label: "Margin Attribution"
          type: sum
          value_format:  "\"£\"#,##0.0,\" k\""
          sql: Case when ${TABLE}.has_control_flag = 0  then 0 else ${TABLE}.STAKES_NORMALISED_CONTRIBUTION_SEGMENT_LEVEL  end;;
        }

        measure: margin_normalised_contribution_segment_level {
          view_label: "(4) Segment Level Fields"
          description: "Net margin value attributed to incremental normalised margin, calculated at segment level"
          group_label: "Margin Attribution"
          type: sum
          value_format:  "\"£\"#,##0.0,\" k\""
          sql: Case when ${TABLE}.has_control_flag = 0  then 0 else ${TABLE}.MARGIN_NORMALISED_CONTRIBUTION_SEGMENT_LEVEL end;;
        }

        measure: returns_normalised_contribution_segment_level {
          view_label: "(4) Segment Level Fields"
          description: "Incremental normalised value of free bets in the treatment group, calculated at segment level"
          group_label: "Margin Attribution"
          type: sum
          value_format:  "\"£\"#,##0.0,\" k\""
          sql: Case when ${TABLE}.has_control_flag = 0  then 0 else ${TABLE}.FREE_BETS_NORMALISED_CONTRIBUTION_SEGMENT_LEVEL end;;
        }

        measure: total_net_profit_margin_normalised_segment_level {
          view_label: "(2) Mailing and Segment Level"
          description: "Total assumed net profit, calculated at segment level"
          type: sum
          value_format:  "\"£\"#,##0.0,\" k\""
          sql: case when ${TABLE}.has_control_flag  = 0  then 0 else ${TABLE}.TOTAL_NET_PROFIT_MARGIN_NORMALISED_SEGMENT_LEVEL end;;
        }

        measure: incremental_net_profit_margin_normalised_segment_level {
          view_label: "(4) Segment Level Fields"
          description: "The difference between total margin normalised and total free bets normalised, calculated at segment level"
          type: number
          #hidden: yes
          value_format: "\"£\"#,###"
          sql:  ${total_net_profit_margin_normalised_segment_level}-coalesce(${control_net_profit_margin_normalised_segment_level},0);;
        }

        measure: incremental_net_profit_margin_normalised_segment_level_w_format {
          label: "Incremental Net Profit Margin Normalised Segment Level"
          view_label: "(4) Segment Level Fields"
          description: "The difference between total margin normalised and total free bets normalised"
          type: number
          hidden: yes
          value_format: "\"£\"#,###"
          sql: case when ${unique_subscribers_control} = 0  then 0 else
            ${total_net_profit_margin_normalised_segment_level}-${control_net_profit_margin_normalised_segment_level} end;;
          drill_fields: [send_date, mailing_name, incremental_net_profit_margin_normalised_segment_level_w_format, incremental_visitors_segment_level, incremental_visits_segment_level, incremental_total_spend_normalised_segment_level, incremental_margin_normalised_segment_level, incremental_returns_normalised_segment_level]
          html:
              <a href="#drillmenu" target="_self">
              {% if value >= 0 %}
              <font color="black">{{ rendered_value }}</font>
              {% elsif value < 0 %}
              <font color="red">{{ rendered_value }}</font>
              {% endif %}
              </a>;;
        }

        measure: contribution_source {
          view_label: "(2) Mailing and Segment Level"
          description: "Displays margin attribution for the selected metric - Only works if the filter 'Select Metric' is on"
          type: number
          hidden:yes
          label_from_parameter: crm_mailing_level_summary.select_metric
          value_format:  "\"£\"#,##0.0,\" k\""
          sql:  case
                     when {% parameter crm_mailing_level_summary.select_metric %} = 'visitors' then ${visitors_contribution_segment_level}
                     when {% parameter crm_mailing_level_summary.select_metric %} = 'visits' then ${visits_contribution_segment_level}
                     when {% parameter crm_mailing_level_summary.select_metric %} = 'total_spend_normalised' then ${total_spend_normalised_contribution_segment_level}
                     when {% parameter crm_mailing_level_summary.select_metric %} = 'margin_normalised' then ${margin_normalised_contribution_segment_level}
                     when {% parameter crm_mailing_level_summary.select_metric %} = 'returns_normalised' then ${returns_normalised_contribution_segment_level}
                end ;;
        }

        dimension: life_stage {
          view_label: "(2) Mailing and Segment Level"
          description: "Customer segmentation into Activation, Grow, Nurture and Reactivation"
          type: string
          sql: ${TABLE}.LIFESTAGE;;
        }




      }
