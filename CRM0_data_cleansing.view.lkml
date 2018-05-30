view: crm_data_cleansing {
  derived_table: {
    sql: select
              t1.*,
              t1.product||to_date(t1.senddatetime)||t1.campaigncode||coalesce(t1.mailing_name,' ')||coalesce(t1.mailing_id,0)||t1.lifestage as segment_level_id,
              t1.product||to_date(t1.senddatetime)||t1.campaigncode||coalesce(t1.mailing_name,' ')||coalesce(t1.mailing_id,0) as mailing_level_id,
              case when t3.id is not null then  t1.product||to_date(t1.senddatetime)||t1.campaigncode||coalesce(t1.mailing_name,' ')||coalesce(t1.mailing_id,0)||t1.emailengagementstatus||t1.fav_brand||t1.weeks_since_active||t1.lifestage||t1.treatmentcode
                else  t1.product||to_date(t1.senddatetime)||t1.campaigncode||coalesce(t1.mailing_name,' ')||coalesce(t1.mailing_id,0)||t1.emailengagementstatus||t1.fav_brand||t1.weeks_since_active||t1.lifestage end as id,

              case when t3.id is not null then 'With Mailing Selection Issue' else 'With No Issue' end as selection_issue /*flag campaigns with multiple rows per combination of treatment group and customer segment*/

        from PRESENTATION.CRM_DEMO t1
        left join
              (
              select distinct product||to_date(senddatetime)||campaigncode||coalesce(mailing_name,' ')||coalesce(mailing_id,0) as id
              from PRESENTATION.CRM_DEMO
              where emailengagementstatus in ('D', 'R')     /*campaigns with control*/
              union
              select distinct product||to_date(senddatetime)||campaigncode||coalesce(mailing_name,' ')||coalesce(mailing_id,0) as id
              from PPRESENTATION.CRM_DEMO
              where
                            (
                            coalesce(mailing_name, flowchartname) like '%Activation%'   --definition for lights out
                            or coalesce(mailing_name, flowchartname) like '% LO%'
                            or upper(coalesce(mailing_name, flowchartname)) like '%L/O%'
                            or upper(coalesce(mailing_name, flowchartname)) like '%LIGHTS%OUT%'
                            or upper(coalesce(mailing_name, flowchartname)) like '%_AUT_%'
                            )         /*append lights out campaigns*/
              ) t2

        on t1.product||to_date(t1.senddatetime)||t1.campaigncode||coalesce(t1.mailing_name,' ')||coalesce(t1.mailing_id,0) = t2.id

        left join
              (
              select distinct product||to_date(senddatetime)||campaigncode||coalesce(mailing_name,' ')||coalesce(mailing_id,0) as id
              from PRESENTATION.CRM_DEMO
              where not
                            (
                            coalesce(mailing_name, flowchartname) like '%Activation%'   --definition for lights out
                            or coalesce(mailing_name, flowchartname) like '% LO%'
                            or upper(coalesce(mailing_name, flowchartname)) like '%L/O%'
                            or upper(coalesce(mailing_name, flowchartname)) like '%LIGHTS%OUT%'
                            or upper(coalesce(mailing_name, flowchartname)) like '%_AUT_%'
                            )         /*append lights out campaigns*/

              group by product, to_date(senddatetime), campaigncode, mailing_name, mailing_id, fav_brand, weeks_since_active, lifestage, emailengagementstatus
              having count(*) > 1     /*not lights out, but appears multiple times*/
              ) t3

        on t1.product||to_date(t1.senddatetime)||t1.campaigncode||coalesce(t1.mailing_name,' ')||coalesce(t1.mailing_id,0) = t3.id

        where t2.id is not null   /*remove the cases which don't have a control group and are not lights out either*/
         ;;
    datagroup_trigger: crm_sandbox_default_datagroup

  }


  dimension: lookup {
    type: string
    sql: ${TABLE}.LOOKUP ;;
  }

  dimension: selection_date {
    type: date
    sql: ${TABLE}.SELECTION_DATE ;;
  }

  dimension: treatmentcode {
    type: number
    sql: ${TABLE}.TREATMENTCODE ;;
  }

  dimension: campaigncode {
    type: string
    sql: ${TABLE}.CAMPAIGNCODE ;;
  }

  dimension: flowchartname {
    type: string
    sql: ${TABLE}.FLOWCHARTNAME ;;
  }

  dimension: emailengagementstatus {
    type: string
    sql: ${TABLE}.EMAILENGAGEMENTSTATUS ;;
  }

  dimension: product {
    type: string
    sql: ${TABLE}.PRODUCT ;;
  }

  dimension: iscontrol {
    type: string
    sql: ${TABLE}.ISCONTROL ;;
  }

  dimension: os_channel {
    type: string
    sql: ${TABLE}.OS_CHANNEL ;;
  }

  dimension: mailing_id {
    type: number
    sql: ${TABLE}.MAILING_ID ;;
  }

  dimension: mailing_name {
    type: string
    sql: ${TABLE}.MAILING_NAME ;;
  }

  dimension: senddatetime {
    type: string
    sql: ${TABLE}.SENDDATETIME ;;
  }

  dimension: subject {
    type: string
    sql: ${TABLE}.SUBJECT ;;
  }

  dimension: uniques {
    type: number
    sql: ${TABLE}.UNIQUES ;;
  }

  dimension: sends {
    type: number
    sql: ${TABLE}.SENDS ;;
  }

  dimension: unique_opens {
    type: number
    sql: ${TABLE}.UNIQUE_OPENS ;;
  }

  dimension: opens {
    type: number
    sql: ${TABLE}.OPENS ;;
  }

  dimension: unique_clicks {
    type: number
    sql: ${TABLE}.UNIQUE_CLICKS ;;
  }

  dimension: clicks {
    type: number
    sql: ${TABLE}.CLICKS ;;
  }

  dimension: unique_bounces {
    type: number
    sql: ${TABLE}.UNIQUE_BOUNCES ;;
  }

  dimension: bounces {
    type: number
    sql: ${TABLE}.BOUNCES ;;
  }

  dimension: unique_unsubscribes {
    type: number
    sql: ${TABLE}.UNIQUE_UNSUBSCRIBES ;;
  }

  dimension: unsubscribes {
    type: number
    sql: ${TABLE}.UNSUBSCRIBES ;;
  }

  dimension: actives {
    type: number
    sql: ${TABLE}.ACTIVES ;;
  }

  dimension: bet_days {
    type: number
    sql: ${TABLE}.BET_DAYS ;;
  }

  dimension: stakes {
    type: number
    sql: ${TABLE}.STAKES ;;
  }

  dimension: margin {
    type: number
    sql: ${TABLE}.MARGIN ;;
  }

  dimension: free_bets {
    type: number
    sql: ${TABLE}.FREE_BETS ;;
  }

  dimension: stakes_normalised {
    type: number
    sql: ${TABLE}.STAKES_NORMALISED ;;
  }

  dimension: margin_normalised {
    type: number
    sql: ${TABLE}.MARGIN_NORMALISED ;;
  }

  dimension: free_bets_normalised {
    type: number
    sql: ${TABLE}.FREE_BETS_NORMALISED ;;
  }

  dimension: bet_days_stdev {
    type: number
    sql: ${TABLE}.BET_DAYS_STDEV ;;
  }

  dimension: stakes_stdev {
    type: number
    sql: ${TABLE}.STAKES_STDEV ;;
  }

  dimension: margin_stdev {
    type: number
    sql: ${TABLE}.MARGIN_STDEV ;;
  }

  dimension: free_bets_stdev {
    type: number
    sql: ${TABLE}.FREE_BETS_STDEV ;;
  }

  dimension: product_match {
    type: string
    sql: ${TABLE}.PRODUCT_MATCH ;;
  }

  dimension: channel_match {
    type: string
    sql: ${TABLE}.CHANNEL_MATCH ;;
  }

  dimension: greater_than_from_date {
    type: string
    sql: ${TABLE}.GREATER_THAN_FROM_DATE ;;
  }

  dimension: less_than_to_date {
    type: string
    sql: ${TABLE}.LESS_THAN_TO_DATE ;;
  }

  dimension: lights_out_filter_match {
    type: string
    sql: ${TABLE}.LIGHTS_OUT_FILTER_MATCH ;;
  }

  dimension: name_match {
    type: string
    sql: ${TABLE}.NAME_MATCH ;;
  }

  dimension: mailing_name_by_day_match {
    type: string
    sql: ${TABLE}.MAILING_NAME_BY_DAY_MATCH ;;
  }

  dimension: bet_days_pooled_statistic {
    type: number
    sql: ${TABLE}.BET_DAYS_POOLED_STATISTIC ;;
  }

  dimension: stakes_pooled_statistic {
    type: number
    sql: ${TABLE}.STAKES_POOLED_STATISTIC ;;
  }

  dimension: margin_pooled_statistic {
    type: number
    sql: ${TABLE}.MARGIN_POOLED_STATISTIC ;;
  }

  dimension: free_bets_pooled_statistic {
    type: number
    sql: ${TABLE}.FREE_BETS_POOLED_STATISTIC ;;
  }

  dimension: fav_brand {
    type: string
    sql: ${TABLE}.FAV_BRAND ;;
  }

  dimension: weeks_since_active {
    type: string
    sql: ${TABLE}.WEEKS_SINCE_ACTIVE ;;
  }

  dimension: lifestage {
    type: string
    sql: ${TABLE}.LIFESTAGE ;;
  }

  dimension: segment_level_id {
    type: string
    sql: ${TABLE}.SEGMENT_LEVEL_ID ;;
  }

  dimension: mailing_level_id {
    type: string
    sql: ${TABLE}.MAILING_LEVEL_ID ;;
  }

  dimension: id {
    type: string
    sql: ${TABLE}.ID ;;
  }

  dimension: selection_issue {
    type: string
    sql: ${TABLE}.SELECTION_ISSUE ;;
  }

}
