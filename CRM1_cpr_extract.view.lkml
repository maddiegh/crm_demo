include: "CRM0_data_cleansing.view.lkml"

view: cpr_extract{
  sql_table_name: ${cpr_data_cleansing.SQL_TABLE_NAME} ;;

  dimension: id {
    description: "Unique primary key for each entry in the CPR extract"
    primary_key: yes
    type: string
    # string here could cause speed issues - need to fix key at source, not this hack
    hidden:  yes
    # There have been some issues identified with some of the campaigns in the CPR report raw data; this is a workaround for the cases where a campaign appears multiple times
    sql: ${TABLE}.ID;;
  }

  dimension: selection_issue {
    description: "This is used to filter out the campaigns which have duplicates on the same send day"
    type: string
    sql: ${TABLE}.SELECTION_ISSUE ;;
  }

  dimension: campaign_type {
    description: "Flag to identify reactivation campaigns"
    type: string
    sql: case when lower(${TABLE}.mailing_name) like '%reactivation%' or lower(${TABLE}.mailing_name) like '%winback%' or lower(${TABLE}.mailing_name) like '%lapsed%' then 'Reactivation'
      when lower(${TABLE}.mailing_name) like '%activation%' then 'Activation'
      else 'Other' end;;
  }

  dimension: mailing_level_id {
    description: "Unique key for the each mailing"
    type: string
    hidden:  yes
    sql: ${TABLE}.MAILING_LEVEL_ID;;
  }

  dimension: segment_level_id {
    description: "Unique key for the each segment (concatenate together mailing_level_id, favourite brand, weeks since active and lifestage"
    type: string
    hidden:  yes
    sql: ${TABLE}.SEGMENT_LEVEL_ID;;
  }

  measure: communications_count  {
    description: "Number of distinct mailings, count of distinct combinations of product, send date, campaign code, mailing name and mailing ID"
    group_label: "Comms Volumes"
    type: count_distinct
    sql: ${TABLE}.PRODUCT||TO_DATE(${TABLE}.SENDDATETIME)||${TABLE}.CAMPAIGNCODE||coalesce(${TABLE}.MAILING_NAME,' ')||coalesce(${TABLE}.MAILING_ID,0) ;;
  }

  measure: flowchart_name_count  {
    description: "Number of distinct flowchart names"
    group_label: "Comms Volumes"
    type: count_distinct
    sql: ${TABLE}.FLOWCHARTNAME ;;
  }

  measure: mailing_name_count  {
    description: "Number of distinct mailing names"
    group_label: "Comms Volumes"
    type: count_distinct
    sql: ${TABLE}.MAILING_NAME ;;
  }

  measure: campaign_code_count  {
    description: "Number of distinct campaign codes"
    group_label: "Comms Volumes"
    type: count_distinct
    sql:${TABLE}.CAMPAIGNCODE ;;
  }


  dimension_group: selection {
    description: "The date when the campaign selection was made, grouped into different dimensions"
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      day_of_week,
      year
    ]
    hidden: yes
    sql: ${TABLE}.SELECTION_DATE ;;
  }

  dimension: treatment_code {
    description: "Treatment code used to track performance of a campaign, it links subscriber selection with the mailing response data"
    type: number
    hidden:  yes
    sql: ${TABLE}.TREATMENTCODE ;;
  }

  dimension: campaign_code {
    description: "Identifier for a high level campaign (e.g. Cheltenham). Each campaign can have multiple communications. No decode available for now"
    type: string
    hidden:  yes
    sql: ${TABLE}.CAMPAIGNCODE ;;
  }

  dimension: flowchart_name {
    description: "Identifier for the communication type within the higher level campaign (e.g. Cheltenham - Launch Email)"
    type: string
    sql: ${TABLE}.FLOWCHARTNAME ;;
  }

  dimension: treatment_group {
    description: "Splits the treatment subscribers into A/B treatments; the control subscribers show as D"
    type: string
    sql: ${TABLE}.EMAILENGAGEMENTSTATUS ;;
  }

  dimension: product {
    type: string
    sql: ${TABLE}.PRODUCT ;;
# The link below creates a drill through to the Campaign Level dashboard; it passes through a filter on product
    link: {label: "Drill down into this product"
      url:"https://redkite.eu.looker.com/dashboards/45?Product={{ value | url_encode }}"}
  }

#   dimension: product_logo {
#     description: "Logo for each brand"
#     #hidden:  yes
#     sql:case when ${TABLE}.PRODUCT = 'skyBet' then 'Sky_Bet_Logo_-_CMYK_-2017.png'
#           when ${TABLE}.PRODUCT = 'skyBINGO' then 'Sky-Bingo-Logo---RGB---2018.png'
#           when ${TABLE}.PRODUCT = 'skyCASINO' then 'Sky-Casino-Logo---RGB---2018.png'
#           when ${TABLE}.PRODUCT = 'skyPOKER' then 'Sky-Poker-Logo---RGB---2018.png'
#           when ${TABLE}.PRODUCT = 'skyVEGAS' then 'Sky-Vegas-Logo---RGB---2018.png'
#     end;;
#     html: <img src="http://skybetcareers.com/uploads/brand-logos/{{ value }}" width="320" height="80" /> ;;
#   }

  dimension: treatment_or_control {
    description: "Field used to identify treatment and control subscribers"
    sql: case when UPPER(${TABLE}.ISCONTROL) = 'TRUE' then 'Control'
              when UPPER(${TABLE}.ISCONTROL) = 'FALSE' then 'Treatment'
    end;;
  }

  dimension: os_channel {
    description: "Contact channel"
    type: string
    sql: ${TABLE}.OS_CHANNEL ;;
  }

  dimension: mailing_id {
    description: "Distinct numerical code for each individual mailing. It is not unique at communication level, as the same mailing can go out multiple times"
    #REVIEW
    type: number
    hidden:  yes
    sql: ${TABLE}.MAILING_ID ;;
  }

  dimension: mailing_name {
    description: "Linked to the mailing ID, each mailing sent has a unique name. It is not unique at communication level, as the same mailing can go out multiple times"
    type: string
    sql: ${TABLE}.MAILING_NAME ;;
# The link below creates a drill through to the Campaign Drilldown dashboard; it passes through a filter on mailing name
    link: {label: "Details about this mailing"
      url:"https://redkite.eu.looker.com/dashboards/46?Mailing%20Name={{ value | url_encode }}&Send%20Date={{ ['send_date'] | url_encode }}"}
    #&Product={{ _filters['cpr_extract.product'] | url_encode }}
    full_suggestions: yes
  }

  dimension: mailing_name_with_date {
    description: "Field created as a concatenation between the send date and the name of a campaign"
    type: string
    sql: ${send_date}||' '|| ${TABLE}.MAILING_NAME ;;
# The link below creates a drill through to the Campaign Drilldown dashboard; it passes through a filter on mailing name
    link: {label: "Details about this mailing"
      url:"https://redkite.eu.looker.com/dashboards/46?Mailing%20Name={{ ['mailing_name'] | url_encode }}&Send%20Date={{ ['send_date'] | url_encode }}"}
    #&Product={{ _filters['cpr_extract.product'] | url_encode }}
    full_suggestions: yes
  }

  dimension_group: send {
    description: "The date when the communication was sent, grouped into different dimensions"
    type: time
    timeframes: [
      raw,
      date,
      month,
      quarter,
      day_of_week,
      year,
      time
    ]
    convert_tz: no
    sql: ${TABLE}.SENDDATETIME ;;
    drill_fields: [send_date, mailing_name]

  }

  dimension: send_week {
    description: "The date when the communication was sent, grouped into different dimensions"
    label: "Week"
    group_label: "Send Date"
    sql: TO_CHAR(TO_DATE(DATEADD('day', (0 - MOD(EXTRACT(DOW FROM ${TABLE}.SENDDATETIME)::integer - 5 + 7, 7)), ${TABLE}.SENDDATETIME)), 'YYYY-MM-DD') ;;
# The link below creates a drill through to the Campaign Level dashoard; it passes through filters on product and the selection date (extracts week commencing = 'given date')
    link: {label: "Campaigns breakdown"
      url:"https://redkite.eu.looker.com/dashboards/45?Product={{ _filters['product'] | url_encode }}&Mailing%20Send%20Date={{ value }}+for+7+days&Communication%20Type={{ _filters['cpr_extract.communication_type'] | url_encode }}&Filter%20for%20Campaigns%20with%20Selection%20Issues={{ _filters['cpr_extract.selection_issue'] | url_encode }}"}
  }

  dimension: sent_date_filter {
    description: "Field to be used for filtering as it autopopulated suggestions for dates"
    type: string
    hidden: yes
    sql: to_varchar(${TABLE}.SENDDATETIME,'DD-MON-YYYY') ;;
    order_by_field: send_raw
    full_suggestions: yes
  }

  dimension: subject {
    description: "The headline of the communication as the subscribers receives it"
    type: string
    sql: ${TABLE}.SUBJECT ;;
  }

  measure: latest_record_date {
    description: "This field is only used in order to display the date of the latest record, so that the user of the dashboards knows how up-to-date the information is"
    type: date
    hidden: yes
    sql: max(${send_date}) ;;
  }

  measure: unique_subscribers {
    description: "Total distinct subscribers selected for each mailing"
    group_label: "Mailing Performance Volumes"
    type: sum
    sql: ${TABLE}.UNIQUES ;;
  }

  measure: sends {
    description: "Total distinct subscribers who were sent each mailing"
    group_label: "Mailing Performance Volumes"
    type: sum
    sql: ${TABLE}.SENDS ;;
  }

  measure: perc_of_unique_subscribers_sent {
    description: "Send rate. Total distinct subscribers who were sent each mailing divided by the total distinct subscribers selected for the mailing"
    type: number
    value_format: "0.0\%"
    sql: ${sends}/nullif(${unique_subscribers},0)*100 ;;
  }

  measure: unique_bounces {
    description: "Total distinct subscribers within each mailing for whom the communication bounced"
    group_label: "Mailing Performance Volumes"
    type: sum
    sql: ${TABLE}.UNIQUE_BOUNCES ;;
  }

  measure: perc_of_sends_bounced {
    description: "Bounce rate. Total distinct subscribers within each mailing for whom the communication bounced divided by total distinct subscribers who were sent the mailing"
    group_label: "Mailing Performance Ratios"
    type: number
    value_format: "0.00\%"
    sql: ${unique_bounces}/nullif(${sends},0)*100 ;;
    drill_fields: [mailing_name, send_date, perc_of_sends_bounced, unique_bounces, sends]
  }

  measure: unique_unsubscribes {
    description: "Total distinct subscribers within each mailing who unsubscribed after they received the mailing"
    group_label: "Mailing Performance Volumes"
    type: sum
    sql: ${TABLE}.UNIQUE_UNSUBSCRIBES ;;
  }

  measure: perc_of_sends_unsubscribed {
    description: "Unsubscribe rate. Total distinct subscribers within each mailing who unsubscribed divided by the total distinct subscribers who were sent the mailing"
    group_label: "Mailing Performance Ratios"
    type: number
    value_format: "0.00\%"
    sql: ${unique_unsubscribes}/nullif(${sends},0)*100;;
    drill_fields: [mailing_name, send_date, perc_of_sends_unsubscribed, unique_unsubscribes, sends]
  }

  measure: unique_opens {
    description: "Total distinct subscribers within each mailing who opened the communication"
    group_label: "Mailing Performance Volumes"
    type: sum
    sql: ${TABLE}.UNIQUE_OPENS ;;
  }

  measure: opens {
    description: "Total number of times all the subscribers within each mailing opened the communication. Same subscriber can open the communication multiple times"
    type: sum
    hidden: yes
    sql: ${TABLE}.OPENS ;;
  }

  measure: perc_of_sends_opened {
    description: "Open rate. Total distinct subscribers within each mailing who opened the communication divided by the total distinct subscribers who were sent the mailing"
    group_label: "Mailing Performance Ratios"
    type: number
    value_format: "0.0\%"
    sql: ${unique_opens}/nullif(${sends},0)*100;;
    drill_fields: [mailing_name, send_date, perc_of_sends_opened, unique_opens, sends]
  }

  measure: unique_clicks {
    description: "Total distinct subscribers within each mailing who clicked on the link in the communication"
    group_label: "Mailing Performance Volumes"
    type: sum
    sql: ${TABLE}.UNIQUE_CLICKS ;;
  }

  measure: clicks {
    description: "Total number of times all the subscribers within each mailing clicked on the link in the communication. Same subscriber could click multiple times"
    type: sum
    hidden: yes
    sql: ${TABLE}.CLICKS ;;
  }

  measure: perc_of_opens_clicked {
    description: "Click through rate. Total distinct subscribers within each mailing who clicked on the link in the communication divided by the total distinct subscribers within a mailing who opened the communication"
    group_label: "Mailing Performance Ratios"
    type: number
    value_format: "0.0\%"
    sql: ${unique_clicks}/nullif(${unique_opens},0)*100;;
    drill_fields: [mailing_name, send_date, perc_of_opens_clicked, unique_clicks, opens]
  }

  measure: actives {
    description: "Total distinct subscribers who placed a bet within the outcome window"
    type: sum
    sql: ${TABLE}.ACTIVES ;;
  }

  measure: perc_of_unique_subscribers_active {
    description: "Active rate. Total distinct active subscribers divided by the total distinct subscribers selected for each mailing"
    type: number
    value_format: "0.0\%"
    sql: ${actives}/nullif(${unique_subscribers},0)*100;;
    drill_fields: [mailing_name, send_date, perc_of_unique_subscribers_active, actives, unique_subscribers]
  }

  measure: bet_days {
    description: "Total number of days with at least one bet within the outcome window"
    type: sum
    sql: ${TABLE}.BET_DAYS ;;
  }

  measure: stakes {
    description: "Total stakes placed within the outcome window"
    hidden: yes
    type: sum
    value_format: "\"£\"#,##0.0,\" k\""
    sql: ${TABLE}.STAKES ;;
  }

  measure: margin {
    description: "Total assumed margin within the outcome window. It is calculated differently within each brand"
    hidden: yes
    type: sum
    value_format: "\"£\"#,##0.0,\" k\""
    sql: ${TABLE}.MARGIN ;;
  }

  measure: free_bets {
    description: "Total value of free bets redeemed by the subscribers within the outcome window"
    hidden: yes
    type: sum
    value_format: "\"£\"#,##0.0,\" k\""
    sql: ${TABLE}.FREE_BETS ;;
  }

  measure: stakes_normalised {
    description: "Total stakes placed within the outcome window, after outliers have been normalised"
    group_label: "Normalised Metrics"
    type: sum
    value_format: "\"£\"#,##0.0,\" k\""
    sql: ${TABLE}.STAKES_NORMALISED ;;
  }

  measure: margin_normalised {
    description: "Total assumed margin within the outcome window, after outliers have been normalised. It is calculated differently within each brand"
    group_label: "Normalised Metrics"
    type: sum
    value_format: "\"£\"#,##0.0,\" k\""
    sql: ${TABLE}.MARGIN_NORMALISED ;;
  }

  measure: free_bets_normalised {
    description: "Total value of free bets redeemed by the subscribers within the outcome window, after outliers have been normalised"
    group_label: "Normalised Metrics"
    type: sum
    value_format: "\"£\"#,##0.0,\" k\""
    sql: ${TABLE}.FREE_BETS_NORMALISED ;;
  }

  dimension: lights_out_filter_match {
    description: "Filter used to separate campaigns which are 'Lights Out' (automated, regular campaigns which are not dependant on any CRM involvement) from targeted campaigns. 'Lights Out' = only Lights Out comms, 'Manual' = all campaigns where selection is manual, excludes Lights Out "
    type: string
    hidden: yes
    sql: case when coalesce(${TABLE}.MAILING_NAME, ${TABLE}.FLOWCHARTNAME) like '%Activation%'
                    or coalesce(${TABLE}.MAILING_NAME, ${TABLE}.FLOWCHARTNAME)  like '% LO%'
                    or upper(coalesce(${TABLE}.MAILING_NAME, ${TABLE}.FLOWCHARTNAME)) like '%L/O%'
                    or upper(coalesce(${TABLE}.MAILING_NAME, ${TABLE}.FLOWCHARTNAME)) like '%LIGHTS%OUT%'
                    or upper(coalesce(${TABLE}.MAILING_NAME, ${TABLE}.FLOWCHARTNAME)) like '%_AUT_%'
            then 'Only' else 'Exclude' end;;
  }

  dimension: communication_type {
    description: "Filter used to separate campaigns which are 'Lights Out' (automated, regular campaigns which are not dependant on any CRM involvement) from targeted campaigns. 'Lights Out' = only Lights Out comms, 'Manual' = all campaigns where selection is manual, excludes Lights Out "
    type: string
    sql: case when coalesce(${TABLE}.MAILING_NAME, ${TABLE}.FLOWCHARTNAME) like '%Activation%'
                    or coalesce(${TABLE}.MAILING_NAME, ${TABLE}.FLOWCHARTNAME)  like '% LO%'
                    or upper(coalesce(${TABLE}.MAILING_NAME, ${TABLE}.FLOWCHARTNAME)) like '%L/O%'
                    or upper(coalesce(${TABLE}.MAILING_NAME, ${TABLE}.FLOWCHARTNAME)) like '%LIGHTS%OUT%'
                    or upper(coalesce(${TABLE}.MAILING_NAME, ${TABLE}.FLOWCHARTNAME)) like '%_AUT_%'
            then 'Lights Out'
            else 'Manual'
    end;;
  }

  dimension: fav_brand {
    description: "Define"
    type: string
    hidden: yes
    sql:upper(${TABLE}.FAV_BRAND);;
  }

  dimension: weeks_since_active {
    description: "Define"
    type: string
    hidden: yes
    sql: ${TABLE}.WEEKS_SINCE_ACTIVE;;
  }

  dimension: life_stage {
    description: "Customer segmentation into Activation, Grow, Nurture and Reactivation"
    type: string
    sql: ${TABLE}.LIFESTAGE;;
  }

  set: detail {
    fields: [
      flowchart_name,
      product,
      os_channel,
      mailing_id,
      mailing_name,
      subject,
      unique_subscribers,
      sends,
      unique_opens,
      opens,
      unique_clicks,
      clicks,
      unique_bounces,
      unique_unsubscribes,
      actives,
      bet_days,
      stakes,
      margin,
      free_bets,
      stakes_normalised,
      margin_normalised,
      free_bets_normalised,
      lights_out_filter_match
    ]
  }
}
