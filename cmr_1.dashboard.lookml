- dashboard: proof_of_concept_1__crm_overview
  title: Proof of Concept 1 - CRM Overview
  layout: newspaper
  elements:
  - name: Product Performance Metrics
    type: text
    title_text: Product Performance Metrics
    body_text: ''
    row: 47
    col: 0
    width: 24
    height: 2
  - name: Drill down into Drivers of Net Incrementals
    type: text
    title_text: Drill down into Drivers of Net Incrementals
    body_text: |-
      Assuming incremental active customers & margin are driven by a CRM event - this drilldown focuses on topline CRM impacted behaviour

      Click on the numbers to obtain a breakdown by individual campaign.
    row: 21
    col: 0
    width: 24
    height: 4
  - name:
    type: text
    body_text: |-
      A guide to using this report can be found on the [CRM homepage ✉️]( /stories/crm_demo/crm_intro.md)

      <font color="white" size="1"></font>

      The <img src="https://tippco-web.s3-eu-west-1.amazonaws.com/filter.png" width="5%"/> above control the results in the report below.
    row: 0
    col: 0
    width: 12
    height: 3
  - title: Incremental Net Profit, Last Full Week
    name: Incremental Net Profit, Last Full Week
    model: crm_demo
    explore: crm_extract
    type: single_value
    fields:
    - crm_extract.send_week
    - crm_mailing_level_summary.incremental_net_profit_margin_normalised_campaign_level_w_format
    filters:
      crm_extract.send_date: 2 weeks ago for 2 weeks
    sorts:
    - crm_extract.send_week desc
    limit: 500
    dynamic_fields:
    - table_calculation: week_on_week_change
      label: Week on Week Change
      expression: "${crm_mailing_level_summary.incremental_net_profit_margin_normalised_campaign_level_w_format}/offset(${crm_mailing_level_summary.incremental_net_profit_margin_normalised_campaign_level_w_format},\
        \  1) -1"
      value_format:
      value_format_name: percent_2
      _kind_hint: measure
      _type_hint: number
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    comparison_label: ''
    hidden_fields: []
    single_value_title: ''
    listen:
      Product: crm_extract.product
      Filter for Campaigns with Selection Issues: crm_extract.selection_issue
      Communication Type: crm_extract.communication_type
      Channel: crm_extract.os_channel
    row: 7
    col: 0
    width: 6
    height: 4
  - title: CRM - Last full day of data
    name: CRM - Last full day of data
    model: crm_demo
    explore: crm_extract
    type: single_value
    fields:
    - crm_extract.latest_record_date
    sorts:
    - crm_extract.latest_record_date desc
    limit: 500
    query_timezone: GB
    custom_color_enabled: true
    custom_color: "#8b2251"
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    series_types: {}
    single_value_title: Last Full Day of Data
    row: 0
    col: 12
    width: 6
    height: 3
  - title: Incremental Actives, Last Full Week
    name: Incremental Actives, Last Full Week
    model: crm_demo
    explore: crm_extract
    type: single_value
    fields:
    - crm_extract.send_week
    - crm_mailing_level_summary.incremental_actives_campaign_level_w_format
    filters:
      crm_extract.send_date: 2 weeks ago for 2 weeks
    sorts:
    - crm_extract.send_week desc
    limit: 500
    dynamic_fields:
    - table_calculation: week_on_week_change
      label: Week on Week Change
      expression: "${crm_mailing_level_summary.incremental_actives_campaign_level_w_format}/offset(${crm_mailing_level_summary.incremental_actives_campaign_level_w_format},\
        \  1) -1"
      value_format:
      value_format_name: percent_1
      _kind_hint: measure
      _type_hint: number
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: true
    comparison_type: change
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    comparison_label: ''
    listen:
      Product: crm_extract.product
      Filter for Campaigns with Selection Issues: crm_extract.selection_issue
      Communication Type: crm_extract.communication_type
      Channel: crm_extract.os_channel
    row: 7
    col: 6
    width: 6
    height: 4
  - title: Incremental Actives by Day of Week
    name: Incremental Actives by Day of Week
    model: crm_demo
    explore: crm_extract
    type: table
    fields:
    - crm_extract.send_day_of_week
    - crm_extract.send_week
    - crm_mailing_level_summary.incremental_actives_campaign_level
    pivots:
    - crm_extract.send_day_of_week
    fill_fields:
    - crm_extract.send_day_of_week
    sorts:
    - crm_extract.send_day_of_week 0
    - crm_extract.send_week
    limit: 500
    row_total: right
    query_timezone: GB
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: true
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    conditional_formatting:
    - type: low to high
      value:
      background_color:
      font_color:
      palette:
        name: Custom
        colors:
        - "#f89456"
        - "#16cf2c"
        - "#087945"
      bold: false
      italic: false
      strikethrough: false
      fields:
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: ''
    series_labels: {}
    listen:
      Date Range: crm_segment_level_summary.send_date
      Product: crm_extract.product
      Filter for Campaigns with Selection Issues: crm_extract.selection_issue
      Communication Type: crm_extract.communication_type
      Channel: crm_extract.os_channel
    row: 25
    col: 0
    width: 12
    height: 8
  - title: Email Overview - Emails Sent, Open and Click Rates
    name: Email Overview - Emails Sent, Open and Click Rates
    model: crm_demo
    explore: crm_extract
    type: looker_line
    fields:
    - crm_extract.send_week
    - crm_extract.perc_of_opens_clicked
    - crm_extract.perc_of_sends_opened
    - crm_segment_level_summary.unique_subscribers_treatment
    filters:
      crm_extract.selection_date: 12 weeks
    sorts:
    - crm_extract.send_week desc
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types:
      wow_change: scatter
      total_targeted: column
      crm_mailing_level_summary.unique_subscribers_treatment: column
      crm_segment_level_summary.unique_subscribers_treatment: column
    hidden_series: []
    colors:
    - 'palette: Santa Cruz'
    series_colors:
      crm_extract.perc_of_unique_subscribers_sent: "#ed6168"
      total_targeted: "#5e4ce7"
      crm_mailing_level_summary.unique_subscribers_treatment: "#5e4ce7"
      crm_extract.perc_of_opens_clicked: "#1ea8df"
      crm_segment_level_summary.unique_subscribers_treatment: "#5e4ce7"
    show_null_labels: false
    x_axis_reversed: true
    trend_lines: []
    focus_on_hover: true
    hide_legend: false
    x_axis_datetime_label: "%b %d"
    y_axes:
    - label:
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: crm_extract.perc_of_opens_clicked
        name: Perc of Opens Clicked
        axisId: crm_extract.perc_of_opens_clicked
      - id: crm_extract.perc_of_sends_opened
        name: Perc of Sends Opened
        axisId: crm_extract.perc_of_sends_opened
    - label:
      maxValue:
      minValue:
      orientation: right
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: crm_segment_level_summary.unique_subscribers_treatment
        name: Unique Subscribers Treatment
        axisId: crm_segment_level_summary.unique_subscribers_treatment
    hidden_fields:
    - crm_mailing_level_summary.targeted_test
    - crm_mailing_level_summary.targeted_control
    label_rotation: 0
    listen:
      Date Range: crm_segment_level_summary.send_date
      Product: crm_extract.product
      Filter for Campaigns with Selection Issues: crm_extract.selection_issue
      Communication Type: crm_extract.communication_type
      Channel: crm_extract.os_channel
    row: 33
    col: 0
    width: 12
    height: 7
  - title: Total Incremental Actives and Incremental Net Profit
    name: Total Incremental Actives and Incremental Net Profit
    model: crm_demo
    explore: crm_extract
    type: looker_line
    fields:
    - crm_extract.send_week
    - crm_mailing_level_summary.incremental_net_profit_margin_normalised_campaign_level
    - crm_mailing_level_summary.incremental_actives_campaign_level
    sorts:
    - crm_extract.send_week desc
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types:
      wow_change: scatter
      total_targeted: column
      crm_extract.unique_clicks: column
      incremental_margin_per_incremental_active: column
      crm_mailing_level_summary.incremental_actives_campaign_level: column
    hidden_series:
    - crm_mailing_level_summary.incremental_normalised_stake
    colors:
    - 'palette: Santa Cruz'
    series_colors:
      wow_change: "#9c9a9a"
      total_targeted: "#61d4ed"
      crm_extract.unique_clicks: "#5245ed"
      crm_extract.perc_of_opened_clicked: "#ed6168"
      crm_extract.perc_of_opens_clicked: "#ed6168"
    show_null_labels: false
    x_axis_reversed: true
    trend_lines: []
    focus_on_hover: true
    hide_legend: false
    x_axis_datetime_label: "%b %d"
    y_axes:
    - label: ''
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 18
      type: linear
      unpinAxis: true
      valueFormat:
      series:
      - id: crm_mailing_level_summary.incremental_actives_campaign_level
        name: Incremental Actives Campaign Level
        axisId: crm_mailing_level_summary.incremental_actives_campaign_level
    - label:
      maxValue:
      minValue:
      orientation: right
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom:
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: crm_mailing_level_summary.incremental_net_profit_margin_normalised_campaign_level
        name: Incremental Net Profit Margin Normalised Campaign Level
        axisId: crm_mailing_level_summary.incremental_net_profit_margin_normalised_campaign_level
    hidden_fields:
    - crm_mailing_level_summary.incremental_actives
    label_rotation: 0
    listen:
      Date Range: crm_segment_level_summary.send_date
      Product: crm_extract.product
      Filter for Campaigns with Selection Issues: crm_extract.selection_issue
      Communication Type: crm_extract.communication_type
      Channel: crm_extract.os_channel
    row: 33
    col: 12
    width: 12
    height: 7
  - title: Hygiene Metrics - Send, Unsubscribe & Bounce Rates
    name: Hygiene Metrics - Send, Unsubscribe & Bounce Rates
    model: crm_demo
    explore: crm_extract
    type: looker_line
    fields:
    - crm_extract.send_week
    - crm_extract.perc_of_sends_unsubscribed
    - crm_extract.perc_of_sends_bounced
    - crm_extract.perc_of_unique_subscribers_sent
    sorts:
    - crm_extract.send_week desc
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_series: []
    colors:
    - 'palette: Santa Cruz'
    series_colors:
      skyBet - crm_extract.perc_of_targeted_sent: "#2015b0"
      skyBINGO - crm_extract.perc_of_targeted_sent: "#8e61ed"
      skyCASINO - crm_extract.perc_of_targeted_sent: "#078f86"
      skyPOKER - crm_extract.perc_of_targeted_sent: "#4b98f2"
      skyVEGAS - crm_extract.perc_of_targeted_sent: "#cc0404"
    show_null_labels: false
    x_axis_reversed: true
    trend_lines: []
    focus_on_hover: true
    hide_legend: false
    x_axis_datetime_label: "%b %d"
    y_axes:
    - label:
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: crm_extract.perc_of_unique_subscribers_sent
        name: Perc of Unique Subscribers Sent
        axisId: crm_extract.perc_of_unique_subscribers_sent
    - label:
      maxValue:
      minValue:
      orientation: right
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: crm_extract.perc_of_sends_bounced
        name: Perc of Sends Bounced
        axisId: crm_extract.perc_of_sends_bounced
      - id: crm_extract.perc_of_sends_unsubscribed
        name: Perc of Sends Unsubscribed
        axisId: crm_extract.perc_of_sends_unsubscribed
    listen:
      Date Range: crm_segment_level_summary.send_date
      Product: crm_extract.product
      Filter for Campaigns with Selection Issues: crm_extract.selection_issue
      Communication Type: crm_extract.communication_type
      Channel: crm_extract.os_channel
    row: 40
    col: 0
    width: 12
    height: 7
  - title: Open Rate by Product Line
    name: Open Rate by Product Line
    model: crm_demo
    explore: crm_extract
    type: looker_line
    fields:
    - crm_extract.product
    - crm_extract.perc_of_sends_opened
    - crm_extract.send_week
    pivots:
    - crm_extract.product
    filters:
      crm_extract.selection_date: 12 weeks ago for 12 weeks
    sorts:
    - crm_extract.product 0
    - crm_extract.send_week desc
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_series: []
    colors:
    - 'palette: Santa Cruz'
    series_colors:
      skyBet - crm_extract.perc_of_sends_opened: "#2015b0"
      skyBINGO - crm_extract.perc_of_sends_opened: "#8e61ed"
      skyCASINO - crm_extract.perc_of_sends_opened: "#078f86"
      skyPOKER - crm_extract.perc_of_sends_opened: "#4b98f2"
      skyVEGAS - crm_extract.perc_of_sends_opened: "#cc0404"
    show_null_labels: false
    x_axis_reversed: true
    trend_lines: []
    focus_on_hover: true
    hide_legend: false
    x_axis_datetime_label: "%b %d"
    listen:
      Date Range: crm_segment_level_summary.send_date
      Filter for Campaigns with Selection Issues: crm_extract.selection_issue
      Communication Type: crm_extract.communication_type
      Channel: crm_extract.os_channel
    row: 49
    col: 8
    width: 8
    height: 6
  - title: Send Volume Ratio by Product Line
    name: Send Volume Ratio by Product Line
    model: crm_demo
    explore: crm_extract
    type: looker_column
    fields:
    - crm_extract.product
    - crm_extract.sends
    - crm_extract.send_week
    pivots:
    - crm_extract.product
    sorts:
    - crm_extract.product 0
    - crm_extract.send_week desc
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: percent
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    point_style: none
    interpolation: linear
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_series: []
    colors:
    - 'palette: Santa Cruz'
    series_colors:
      skyVEGAS - crm_extract.sends: "#cc0404"
      skyPOKER - crm_extract.sends: "#4b98f2"
      skyCASINO - crm_extract.sends: "#078f86"
      skyBINGO - crm_extract.sends: "#8e61ed"
      skyBet - crm_extract.sends: "#2015b0"
    x_axis_reversed: true
    trend_lines: []
    focus_on_hover: true
    hide_legend: false
    x_axis_datetime_label: "%b %d"
    listen:
      Date Range: crm_segment_level_summary.send_date
      Filter for Campaigns with Selection Issues: crm_extract.selection_issue
      Communication Type: crm_extract.communication_type
      Channel: crm_extract.os_channel
    row: 49
    col: 0
    width: 8
    height: 6
  - title: Click Through Rate by Product Line
    name: Click Through Rate by Product Line
    model: crm_demo
    explore: crm_extract
    type: looker_line
    fields:
    - crm_extract.product
    - crm_extract.perc_of_opens_clicked
    - crm_extract.send_week
    pivots:
    - crm_extract.product
    sorts:
    - crm_extract.product 0
    - crm_extract.send_week desc
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_series: []
    colors:
    - 'palette: Santa Cruz'
    series_colors:
      skyBet - crm_extract.perc_of_opens_clicked: "#2015b0"
      skyBINGO - crm_extract.perc_of_opens_clicked: "#8e61ed"
      skyCASINO - crm_extract.perc_of_opens_clicked: "#078f86"
      skyPOKER - crm_extract.perc_of_opens_clicked: "#4b98f2"
      skyVEGAS - crm_extract.perc_of_opens_clicked: "#cc0404"
    show_null_labels: false
    x_axis_reversed: true
    trend_lines: []
    focus_on_hover: true
    hide_legend: false
    x_axis_datetime_label: "%b %d"
    listen:
      Date Range: crm_segment_level_summary.send_date
      Filter for Campaigns with Selection Issues: crm_extract.selection_issue
      Communication Type: crm_extract.communication_type
      Channel: crm_extract.os_channel
    row: 49
    col: 16
    width: 8
    height: 6
  - title: Incremental Net Margin by Day of Week
    name: Incremental Net Margin by Day of Week
    model: crm_demo
    explore: crm_extract
    type: table
    fields:
    - crm_extract.send_week
    - crm_extract.send_day_of_week
    - crm_mailing_level_summary.incremental_net_profit_margin_normalised_campaign_level
    pivots:
    - crm_extract.send_day_of_week
    fill_fields:
    - crm_extract.send_day_of_week
    sorts:
    - crm_extract.send_day_of_week 0
    - crm_extract.send_week
    limit: 500
    row_total: right
    query_timezone: GB
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: true
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    conditional_formatting:
    - type: low to high
      value: 100
      background_color:
      font_color:
      palette:
        name: Custom
        colors:
        - "#f89456"
        - "#16cf2c"
        - "#087945"
      bold: false
      italic: false
      strikethrough: false
      fields:
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: '0'
    series_labels: {}
    hidden_fields:
    - crm_mailing_level_summary.incremental_net_margin
    - crm_mailing_level_summary.incremental_actives
    - crm_mailing_level_summary.incremental_net_margin_campaign_level
    listen:
      Date Range: crm_segment_level_summary.send_date
      Product: crm_extract.product
      Filter for Campaigns with Selection Issues: crm_extract.selection_issue
      Communication Type: crm_extract.communication_type
      Channel: crm_extract.os_channel
    row: 25
    col: 12
    width: 12
    height: 8
  - name: User Segment Performance Metrics
    type: text
    title_text: User Segment Performance Metrics
    row: 62
    col: 0
    width: 24
    height: 2
  - title: Open Rate by Life Stage
    name: Open Rate by Life Stage
    model: crm_demo
    explore: crm_extract
    type: looker_line
    fields:
    - crm_extract.perc_of_sends_opened
    - crm_extract.send_week
    - crm_extract.life_stage
    pivots:
    - crm_extract.life_stage
    sorts:
    - crm_extract.send_week desc
    - crm_extract.life_stage
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_series: []
    colors:
    - 'palette: Santa Cruz'
    series_colors:
      skyBet - crm_extract.perc_of_sends_opened: "#2015b0"
      skyBINGO - crm_extract.perc_of_sends_opened: "#8e61ed"
      skyCASINO - crm_extract.perc_of_sends_opened: "#078f86"
      skyPOKER - crm_extract.perc_of_sends_opened: "#4b98f2"
      skyVEGAS - crm_extract.perc_of_sends_opened: "#cc0404"
      Activation - crm_extract.perc_of_sends_opened: "#1bba17"
      Grow - crm_extract.perc_of_sends_opened: "#a832e0"
      Nurture - crm_extract.perc_of_sends_opened: "#f29540"
      Reactivation - crm_extract.perc_of_sends_opened: "#3232c4"
    show_null_labels: false
    x_axis_reversed: true
    trend_lines: []
    focus_on_hover: true
    hide_legend: false
    x_axis_datetime_label: "%b %d"
    listen:
      Date Range: crm_segment_level_summary.send_date
      Product: crm_extract.product
      Filter for Campaigns with Selection Issues: crm_extract.selection_issue
      Communication Type: crm_extract.communication_type
      Channel: crm_extract.os_channel
    row: 64
    col: 8
    width: 8
    height: 6
  - title: Click Through Rate by Life Stage
    name: Click Through Rate by Life Stage
    model: crm_demo
    explore: crm_extract
    type: looker_line
    fields:
    - crm_extract.perc_of_opens_clicked
    - crm_extract.selection_week
    - crm_extract.life_stage
    pivots:
    - crm_extract.life_stage
    fill_fields:
    - crm_extract.selection_week
    sorts:
    - crm_extract.selection_week desc
    - crm_extract.life_stage
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_series: []
    colors:
    - 'palette: Santa Cruz'
    series_colors:
      skyBet - crm_extract.perc_of_opens_clicked: "#2015b0"
      skyBINGO - crm_extract.perc_of_opens_clicked: "#8e61ed"
      skyCASINO - crm_extract.perc_of_opens_clicked: "#078f86"
      skyPOKER - crm_extract.perc_of_opens_clicked: "#4b98f2"
      skyVEGAS - crm_extract.perc_of_opens_clicked: "#cc0404"
      Activation - crm_extract.perc_of_opens_clicked: "#1bba17"
      Grow - crm_extract.perc_of_opens_clicked: "#a832e0"
      Nurture - crm_extract.perc_of_opens_clicked: "#f29540"
      Reactivation - crm_extract.perc_of_opens_clicked: "#3232c4"
    show_null_labels: false
    x_axis_reversed: true
    trend_lines: []
    focus_on_hover: true
    hide_legend: false
    x_axis_datetime_label: "%b %d"
    listen:
      Date Range: crm_segment_level_summary.send_date
      Product: crm_extract.product
      Filter for Campaigns with Selection Issues: crm_extract.selection_issue
      Communication Type: crm_extract.communication_type
      Channel: crm_extract.os_channel
    row: 64
    col: 16
    width: 8
    height: 6
  - title: Top 10 Campaigns
    name: Top 10 Campaigns
    model: crm_demo
    explore: crm_extract
    type: table
    fields:
    - crm_extract.mailing_name
    - crm_segment_level_summary.send_date
    - crm_extract.product
    - crm_mailing_level_summary.incremental_metric
    sorts:
    - crm_mailing_level_summary.incremental_metric desc
    limit: 10
    column_limit: 10
    query_timezone: GB
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: true
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: true
    conditional_formatting_include_nulls: false
    conditional_formatting:
    - type: low to high
      value:
      background_color:
      font_color:
      palette:
        name: Custom
        colors:
        - "#faf472"
        - "#58fc71"
        - "#18a812"
      bold: false
      italic: false
      strikethrough: false
      fields:
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: ''
    series_labels: {}
    hidden_fields: []
    listen:
      Date Range: crm_mailing_level_summary.send_date
      Product: crm_extract.product
      Filter for Campaigns with Selection Issues: crm_extract.selection_issue
      Communication Type: crm_extract.communication_type
      Choose Metric for Top/Bottom 10 Campaigns: crm_mailing_level_summary.incremental_actives_or_net_profit
      Channel: crm_extract.os_channel
    row: 15
    col: 0
    width: 12
    height: 6
  - title: Bottom 10 Campaigns
    name: Bottom 10 Campaigns
    model: crm_demo
    explore: crm_extract
    type: table
    fields:
    - crm_extract.mailing_name
    - crm_segment_level_summary.send_date
    - crm_extract.product
    - crm_mailing_level_summary.incremental_metric
    sorts:
    - crm_mailing_level_summary.incremental_metric
    limit: 10
    column_limit: 10
    query_timezone: GB
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: true
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: true
    conditional_formatting_include_nulls: false
    conditional_formatting:
    - type: low to high
      value:
      background_color:
      font_color:
      palette:
        name: Custom
        colors:
        - "#f78a3d"
        - "#fcc358"
        - "#edca76"
      bold: false
      italic: false
      strikethrough: false
      fields:
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: ''
    series_labels: {}
    listen:
      Date Range: crm_mailing_level_summary.send_date
      Product: crm_extract.product
      Filter for Campaigns with Selection Issues: crm_extract.selection_issue
      Communication Type: crm_extract.communication_type
      Choose Metric for Top/Bottom 10 Campaigns: crm_mailing_level_summary.incremental_actives_or_net_profit
      Channel: crm_extract.os_channel
    row: 15
    col: 12
    width: 12
    height: 6
  - name: Top and Bottom Campaigns
    type: text
    title_text: Top and Bottom Campaigns
    body_text: |-
      Use the filters at the top of the dashboards to select the time frame or the brand of interest.

      The metric for Top 10 & Bottom 10 Campaigns is controlled by the filter called 'Choose Metric for Top/Bottom 10 Campaigns'.
    row: 11
    col: 0
    width: 24
    height: 4
  - title: Incremental Net Profit
    name: Incremental Net Profit
    model: crm_demo
    explore: crm_extract
    type: single_value
    fields:
    - crm_mailing_level_summary.incremental_net_profit_margin_normalised_campaign_level_w_format
    limit: 500
    column_limit: 50
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    query_timezone: America/Los_Angeles
    show_view_names: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    conditional_formatting:
    - type: low to high
      value:
      background_color:
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
        __FILE: crm_demo/crm.dashboard.lookml
        __LINE_NUM: 444
      bold: false
      italic: false
      strikethrough: false
      fields: []
      __FILE: crm_demo/crm.dashboard.lookml
      __LINE_NUM: 439
    - type: low to high
      value:
      background_color:
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
        __FILE: crm_demo/crm.dashboard.lookml
        __LINE_NUM: 462
      bold: false
      italic: false
      strikethrough: false
      fields: []
      __FILE: crm_demo/crm.dashboard.lookml
      __LINE_NUM: 457
    - type: low to high
      value:
      background_color:
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
        __FILE: crm_demo/crm.dashboard.lookml
        __LINE_NUM: 480
      bold: false
      italic: false
      strikethrough: false
      fields: []
      __FILE: crm_demo/crm.dashboard.lookml
      __LINE_NUM: 475
    - type: greater than
      value: 1
      background_color: "#fb5555"
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
        __FILE: crm_demo/crm.dashboard.lookml
        __LINE_NUM: 498
      bold: false
      italic: false
      strikethrough: false
      fields: []
      __FILE: crm_demo/crm.dashboard.lookml
      __LINE_NUM: 493
    - type: greater than
      value: 3
      background_color: "#fc5858"
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
        __FILE: crm_demo/crm.dashboard.lookml
        __LINE_NUM: 516
      bold: false
      italic: false
      strikethrough: false
      fields: []
      __FILE: crm_demo/crm.dashboard.lookml
      __LINE_NUM: 511
    hidden_fields: []
    series_types: {}
    hidden_series:
    - crm_mailing_level_summary.incremental_actives
    listen:
      Date Range: crm_mailing_level_summary.send_date
      Product: crm_extract.product
      Filter for Campaigns with Selection Issues: crm_extract.selection_issue
      Communication Type: crm_extract.communication_type
      Channel: crm_extract.os_channel
    row: 3
    col: 0
    width: 6
    height: 4
  - title: Incremental Actives
    name: Incremental Actives
    model: crm_demo
    explore: crm_extract
    type: single_value
    fields:
    - crm_mailing_level_summary.incremental_actives_campaign_level
    limit: 500
    column_limit: 50
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    query_timezone: America/Los_Angeles
    show_view_names: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: false
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    conditional_formatting:
    - type: low to high
      value:
      background_color:
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
        __FILE: crm_demo/crm.dashboard.lookml
        __LINE_NUM: 444
      bold: false
      italic: false
      strikethrough: false
      fields: []
      __FILE: crm_demo/crm.dashboard.lookml
      __LINE_NUM: 439
    - type: low to high
      value:
      background_color:
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
        __FILE: crm_demo/crm.dashboard.lookml
        __LINE_NUM: 462
      bold: false
      italic: false
      strikethrough: false
      fields: []
      __FILE: crm_demo/crm.dashboard.lookml
      __LINE_NUM: 457
    - type: low to high
      value:
      background_color:
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
        __FILE: crm_demo/crm.dashboard.lookml
        __LINE_NUM: 480
      bold: false
      italic: false
      strikethrough: false
      fields: []
      __FILE: crm_demo/crm.dashboard.lookml
      __LINE_NUM: 475
    - type: greater than
      value: 1
      background_color: "#fb5555"
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
        __FILE: crm_demo/crm.dashboard.lookml
        __LINE_NUM: 498
      bold: false
      italic: false
      strikethrough: false
      fields: []
      __FILE: crm_demo/crm.dashboard.lookml
      __LINE_NUM: 493
    - type: greater than
      value: 3
      background_color: "#fc5858"
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
        __FILE: crm_demo/crm.dashboard.lookml
        __LINE_NUM: 516
      bold: false
      italic: false
      strikethrough: false
      fields: []
      __FILE: crm_demo/crm.dashboard.lookml
      __LINE_NUM: 511
    hidden_fields: []
    series_types: {}
    hidden_series:
    - crm_mailing_level_summary.incremental_actives
    listen:
      Date Range: crm_mailing_level_summary.send_date
      Product: crm_extract.product
      Filter for Campaigns with Selection Issues: crm_extract.selection_issue
      Communication Type: crm_extract.communication_type
      Channel: crm_extract.os_channel
    row: 3
    col: 6
    width: 6
    height: 4
  - title: Contribution Source Waterfall
    name: Contribution Source Waterfall
    model: crm_demo
    explore: crm_extract
    type: looker_column
    fields:
    - crm_waterfall_view.aux_column
    - crm_waterfall_view.actives_contribution
    - crm_waterfall_view.bet_days_contribution
    - crm_waterfall_view.stakes_normalised_contribution
    - crm_waterfall_view.margin_normalised_contribution
    - crm_waterfall_view.free_bets_normalised_contribution
    - crm_waterfall_view.control_net_profit_margin_normalised
    - crm_waterfall_view.total_net_profit_margin_normalised
    filters:
      crm_waterfall_view.aux_column: NOT NULL
    sorts:
    - crm_waterfall_view.aux_column
    limit: 500
    column_limit: 50
    dynamic_fields:
    - table_calculation: calc1
      label: calc1
      expression: "\n  if(row()=2,\n  ${crm_waterfall_view.actives_contribution},\
        \ \n    if(row()=3, \n    ${crm_waterfall_view.bet_days_contribution},\n \
        \     if(row()=4, \n      ${crm_waterfall_view.stakes_normalised_contribution},\n\
        \        if(row()=5,\n        ${crm_waterfall_view.margin_normalised_contribution},\n\
        \          if(row()=6,\n        ${crm_waterfall_view.free_bets_normalised_contribution},\n\
        \           null)))))"
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      _type_hint: number
    - table_calculation: offset
      label: Offset
      expression: if(row() < 7, running_total(offset(${positive},-1)+offset(${total},-1)-${negative}),0)
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      _type_hint: number
    - table_calculation: total
      label: Total
      expression: |-
        if(row()=1,${crm_waterfall_view.control_net_profit_margin_normalised},
          if(row() = 7,
            ${crm_waterfall_view.total_net_profit_margin_normalised},0))
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      _type_hint: number
    - table_calculation: negative
      label: Negative
      expression: if(${calc1}<0,-${calc1},0)
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      _type_hint: number
    - table_calculation: positive
      label: Positive
      expression: if(${calc1}>=0,${calc1},0)
      value_format:
      value_format_name: gbp_0
      _kind_hint: measure
      _type_hint: number
    - table_calculation: calculation_6
      label: Calculation 6
      expression: "  if(row() = 1, \"Control Net Margin\",\n    if(row()=2, \"Actives\"\
        , \n      if(row()=3,  \"Bet Days\",\n        if(row()=4, \"Stakes\",\n  \
        \        if(row()=5, \"Margin\",\n            if(row()=6, \"Free Bet\",\n\
        \              if(row()=7, \"Final Value\",\n             null)))))))"
      value_format:
      value_format_name:
      _kind_hint: dimension
      _type_hint: string
    stacking: normal
    show_value_labels: true
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes:
    - label: ''
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 5
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: offset
        name: Offset
        axisId: offset
        __FILE: crm_demo/crm.dashboard.lookml
        __LINE_NUM: 112
      - id: total
        name: Total
        axisId: total
        __FILE: crm_demo/crm.dashboard.lookml
        __LINE_NUM: 117
      - id: negative
        name: Negative
        axisId: negative
        __FILE: crm_demo/crm.dashboard.lookml
        __LINE_NUM: 122
      - id: positive
        name: Positive
        axisId: positive
        __FILE: crm_demo/crm.dashboard.lookml
        __LINE_NUM: 127
      __FILE: crm_demo/crm.dashboard.lookml
      __LINE_NUM: 100
    hidden_fields:
    - crm_mailing_level_summary.control_net_margin
    - crm_mailing_level_summary.actives_contribution
    - crm_mailing_level_summary.bet_days_contribution
    - crm_mailing_level_summary.stakes_contribution
    - crm_mailing_level_summary.margin_contribution
    - crm_mailing_level_summary.free_bet_contribution
    - calc1
    - crm_mailing_level_summary.total_net_profit_margin
    - aux_table1.aux_column
    - crm_mailing_level_summary.normalised_free_bet_contribution
    - crm_mailing_level_summary.normalised_margin_contribution
    - crm_mailing_level_summary.normalised_stakes_contribution
    - crm_mailing_level_summary.free_bets_normalised_contribution
    - crm_mailing_level_summary.margin_normalised_contribution
    - crm_mailing_level_summary.stakes_normalised_contribution
    - crm_mailing_level_summary.control_net_margin_normalised
    - crm_mailing_level_summary.total_net_profit_margin_normalised
    - crm_waterfall_view.actives_contribution
    - crm_waterfall_view.bet_days_contribution
    - crm_waterfall_view.stakes_normalised_contribution
    - crm_waterfall_view.margin_normalised_contribution
    - crm_waterfall_view.free_bets_normalised_contribution
    - crm_waterfall_view.control_net_profit_margin_normalised
    - crm_waterfall_view.total_net_profit_margin_normalised
    column_spacing_ratio:
    hidden_series: []
    series_colors:
      offset: transparent
      negative: "#d81919"
      positive: "#137b13"
      total: "#588585"
    series_labels: {}
    colors:
    - "#62bad4"
    - "#a9c574"
    - "#929292"
    - "#9fdee0"
    - "#1f3e5a"
    - "#90c8ae"
    - "#92818d"
    - "#c5c6a6"
    - "#82c2ca"
    - "#cee0a0"
    - "#928fb4"
    - "#9fc190"
    - "#9fc190"
    hide_legend: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    font_size: '10'
    listen:
      Date Range: crm_mailing_level_summary.send_date
      Product: crm_extract.product
      Filter for Campaigns with Selection Issues: crm_extract.selection_issue
      Communication Type: crm_extract.communication_type
      Channel: crm_extract.os_channel
    row: 3
    col: 12
    width: 12
    height: 8
  - title: Incremental Net Profit Margin by Product
    name: Incremental Net Profit Margin by Product
    model: crm_demo
    explore: crm_extract
    type: looker_column
    fields:
    - crm_extract.send_week
    - crm_segment_level_summary.product
    - crm_mailing_level_summary.incremental_net_profit_margin_normalised_campaign_level
    pivots:
    - crm_segment_level_summary.product
    filters:
      crm_segment_level_summary.send_date: 12 weeks ago for 12 weeks
      crm_extract.product: ''
      crm_extract.selection_issue: With No Issue
      crm_extract.communication_type: Manual
    sorts:
    - crm_extract.send_week desc
    - crm_segment_level_summary.product
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#070707"
    show_null_points: true
    point_style: none
    interpolation: linear
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_series: []
    colors:
    - 'palette: Santa Cruz'
    series_colors:
      wow_change: "#9c9a9a"
      total_targeted: "#61d4ed"
      crm_extract.unique_clicks: "#5245ed"
      crm_extract.perc_of_opened_clicked: "#ed6168"
      crm_extract.perc_of_opens_clicked: "#ed6168"
      skyBet - crm_mailing_level_summary.incremental_net_profit_margin_normalised_campaign_level: "#2015b0"
      skyBINGO - crm_mailing_level_summary.incremental_net_profit_margin_normalised_campaign_level: "#8e61ed"
      skyCASINO - crm_mailing_level_summary.incremental_net_profit_margin_normalised_campaign_level: "#078f86"
      skyPOKER - crm_mailing_level_summary.incremental_net_profit_margin_normalised_campaign_level: "#4b98f2"
      skyVEGAS - crm_mailing_level_summary.incremental_net_profit_margin_normalised_campaign_level: "#cc0404"
    x_axis_reversed: true
    trend_lines: []
    focus_on_hover: true
    hide_legend: false
    x_axis_datetime_label: "%b %d"
    y_axes:
    - label: ''
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 18
      type: linear
      unpinAxis: true
      valueFormat:
      series:
      - id: crm_mailing_level_summary.incremental_actives_campaign_level
        name: Incremental Actives Campaign Level
        axisId: crm_mailing_level_summary.incremental_actives_campaign_level
    - label:
      maxValue:
      minValue:
      orientation: right
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom:
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: crm_mailing_level_summary.incremental_net_profit_margin_normalised_campaign_level
        name: Incremental Net Profit Margin Normalised Campaign Level
        axisId: crm_mailing_level_summary.incremental_net_profit_margin_normalised_campaign_level
    hidden_fields:
    - crm_mailing_level_summary.incremental_actives
    label_rotation: 0
    x_axis_label_rotation: -45
    totals_rotation: 0
    font_size: '10'
    listen:
      Date Range: crm_mailing_level_summary.send_date
      Channel: crm_extract.os_channel
    row: 55
    col: 12
    width: 12
    height: 7
  - title: Incremental Actives by Product
    name: Incremental Actives by Product
    model: crm_demo
    explore: crm_extract
    type: looker_column
    fields:
    - crm_extract.send_week
    - crm_segment_level_summary.product
    - crm_mailing_level_summary.incremental_actives_campaign_level
    pivots:
    - crm_segment_level_summary.product
    filters:
      crm_segment_level_summary.send_date: 12 weeks ago for 12 weeks
      crm_extract.product: ''
      crm_extract.selection_issue: With No Issue
      crm_extract.communication_type: Manual
    sorts:
    - crm_extract.send_week desc
    - crm_segment_level_summary.product
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#000000"
    show_null_points: true
    point_style: none
    interpolation: linear
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_series: []
    colors:
    - 'palette: Santa Cruz'
    series_colors:
      wow_change: "#9c9a9a"
      total_targeted: "#61d4ed"
      crm_extract.unique_clicks: "#5245ed"
      crm_extract.perc_of_opened_clicked: "#ed6168"
      crm_extract.perc_of_opens_clicked: "#ed6168"
      skyBet - crm_mailing_level_summary.incremental_net_profit_margin_normalised_campaign_level: "#2015b0"
      skyBINGO - crm_mailing_level_summary.incremental_net_profit_margin_normalised_campaign_level: "#8e61ed"
      skyCASINO - crm_mailing_level_summary.incremental_net_profit_margin_normalised_campaign_level: "#078f86"
      skyPOKER - crm_mailing_level_summary.incremental_net_profit_margin_normalised_campaign_level: "#4b98f2"
      skyVEGAS - crm_mailing_level_summary.incremental_net_profit_margin_normalised_campaign_level: "#cc0404"
      skyBet - crm_mailing_level_summary.incremental_actives_campaign_level: "#2015b0"
      skyBINGO - crm_mailing_level_summary.incremental_actives_campaign_level: "#8e61ed"
      skyCASINO - crm_mailing_level_summary.incremental_actives_campaign_level: "#078f86"
      skyPOKER - crm_mailing_level_summary.incremental_actives_campaign_level: "#4b98f2"
      skyVEGAS - crm_mailing_level_summary.incremental_actives_campaign_level: "#cc0404"
    x_axis_reversed: true
    trend_lines: []
    focus_on_hover: true
    hide_legend: false
    x_axis_datetime_label: "%b %d"
    y_axes:
    - label: ''
      maxValue:
      minValue:
      orientation: left
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom: 18
      type: linear
      unpinAxis: true
      valueFormat:
      series:
      - id: crm_mailing_level_summary.incremental_actives_campaign_level
        name: Incremental Actives Campaign Level
        axisId: crm_mailing_level_summary.incremental_actives_campaign_level
    - label:
      maxValue:
      minValue:
      orientation: right
      showLabels: true
      showValues: true
      tickDensity: default
      tickDensityCustom:
      type: linear
      unpinAxis: false
      valueFormat:
      series:
      - id: crm_mailing_level_summary.incremental_net_profit_margin_normalised_campaign_level
        name: Incremental Net Profit Margin Normalised Campaign Level
        axisId: crm_mailing_level_summary.incremental_net_profit_margin_normalised_campaign_level
    hidden_fields:
    - crm_mailing_level_summary.incremental_actives
    label_rotation: 0
    x_axis_label_rotation: -45
    listen:
      Date Range: crm_mailing_level_summary.send_date
      Channel: crm_extract.os_channel
    row: 55
    col: 0
    width: 12
    height: 7
  - title: Send Volume Ratio by Segment
    name: Send Volume Ratio by Segment
    model: crm_demo
    explore: crm_extract
    type: looker_column
    fields:
    - crm_extract.sends
    - crm_extract.send_week
    - crm_extract.life_stage
    pivots:
    - crm_extract.life_stage
    sorts:
    - crm_extract.send_week desc
    - crm_extract.life_stage
    limit: 500
    column_limit: 50
    query_timezone: America/Los_Angeles
    stacking: percent
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_null_points: true
    point_style: none
    interpolation: linear
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_series: []
    colors:
    - 'palette: Santa Cruz'
    series_colors:
      skyVEGAS - crm_extract.sends: "#cc0404"
      skyPOKER - crm_extract.sends: "#4b98f2"
      skyCASINO - crm_extract.sends: "#078f86"
      skyBINGO - crm_extract.sends: "#8e61ed"
      skyBet - crm_extract.sends: "#2015b0"
      Activation - crm_extract.sends: "#1bba17"
      Grow - crm_extract.sends: "#a832e0"
      Nurture - crm_extract.sends: "#f29540"
      Reactivation - crm_extract.sends: "#3232c4"
    x_axis_reversed: true
    trend_lines: []
    focus_on_hover: true
    hide_legend: false
    x_axis_datetime_label: "%b %d"
    listen:
      Date Range: crm_segment_level_summary.send_date
      Filter for Campaigns with Selection Issues: crm_extract.selection_issue
      Communication Type: crm_extract.communication_type
      Channel: crm_extract.os_channel
    row: 64
    col: 0
    width: 8
    height: 6
  - title: Active Rate by Life Stage
    name: Active Rate by Life Stage
    model: crm_demo
    explore: crm_extract
    type: looker_line
    fields:
    - crm_extract.send_week
    - crm_segment_level_summary.actives_treatment
    - crm_segment_level_summary.unique_subscribers_treatment
    - crm_extract.life_stage
    pivots:
    - crm_extract.life_stage
    sorts:
    - crm_extract.life_stage 0
    - crm_extract.send_week desc
    limit: 500
    column_limit: 50
    row_total: right
    dynamic_fields:
    - table_calculation: active_rate_treatment_subscribers
      label: Active Rate Treatment Subscribers
      expression: "${crm_segment_level_summary.actives_treatment}/${crm_segment_level_summary.unique_subscribers_treatment}"
      value_format:
      value_format_name:
      _kind_hint: measure
      _type_hint: number
    - table_calculation: total_active_rate_treatment_subscribers
      label: Total Active Rate Treatment Subscribers
      expression: "${crm_segment_level_summary.actives_treatment:row_total}/${crm_segment_level_summary.unique_subscribers_treatment:row_total}"
      value_format:
      value_format_name:
      _kind_hint: supermeasure
      _type_hint: number
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#080808"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_series: []
    colors:
    - 'palette: Santa Cruz'
    series_colors:
      skyVEGAS - crm_extract.sends: "#cc0404"
      skyPOKER - crm_extract.sends: "#4b98f2"
      skyCASINO - crm_extract.sends: "#078f86"
      skyBINGO - crm_extract.sends: "#8e61ed"
      skyBet - crm_extract.sends: "#2015b0"
      Activation - crm_mailing_level_summary.incremental_actives: "#1bba17"
      Grow - crm_mailing_level_summary.incremental_actives: "#a832e0"
      Nurture - crm_mailing_level_summary.incremental_actives: "#f29540"
      Reactivation - crm_mailing_level_summary.incremental_actives: "#3232c4"
      Activation - crm_mailing_level_summary.incremental_actives_campaign_level: "#1bba17"
      Grow - crm_mailing_level_summary.incremental_actives_campaign_level: "#a832e0"
      Nurture - crm_mailing_level_summary.incremental_actives_campaign_level: "#f29540"
      Reactivation - crm_mailing_level_summary.incremental_actives_campaign_level: "#3232c4"
      Activation - crm_segment_level_summary.incremental_actives_segment_level: "#1bba17"
      Grow - crm_segment_level_summary.incremental_actives_segment_level: "#a832e0"
      Nurture - crm_segment_level_summary.incremental_actives_segment_level: "#f29540"
      Reactivation - crm_segment_level_summary.incremental_actives_segment_level: "#3232c4"
      Activation - active_rate_treatment_subscribers: "#1bba17"
      Grow - active_rate_treatment_subscribers: "#a832e0"
      Nurture - active_rate_treatment_subscribers: "#f29540"
      Reactivation - active_rate_treatment_subscribers: "#3232c4"
      total_active_rate_treatment_subscribers: "#000000"
    x_axis_reversed: true
    trend_lines: []
    focus_on_hover: true
    hide_legend: false
    x_axis_datetime_label: "%b %d"
    hidden_fields:
    - crm_segment_level_summary.actives_treatment
    - crm_segment_level_summary.unique_subscribers_treatment
    listen:
      Date Range: crm_segment_level_summary.send_date
      Product: crm_extract.product
      Filter for Campaigns with Selection Issues: crm_extract.selection_issue
      Communication Type: crm_extract.communication_type
      Channel: crm_extract.os_channel
    row: 70
    col: 0
    width: 12
    height: 8
  - title: Average Bet Days by Life Stage
    name: Average Bet Days by Life Stage
    model: crm_demo
    explore: crm_extract
    type: looker_line
    fields:
    - crm_extract.send_week
    - crm_segment_level_summary.average_bet_days_treatment_segment_level
    - crm_extract.life_stage
    pivots:
    - crm_extract.life_stage
    sorts:
    - crm_extract.life_stage 0
    - crm_extract.send_week desc
    limit: 500
    column_limit: 50
    row_total: right
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: false
    show_x_axis_ticks: true
    x_axis_scale: ordinal
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: none
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: true
    show_silhouette: false
    totals_color: "#080808"
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    hidden_series: []
    colors:
    - 'palette: Santa Cruz'
    series_colors:
      skyVEGAS - crm_extract.sends: "#cc0404"
      skyPOKER - crm_extract.sends: "#4b98f2"
      skyCASINO - crm_extract.sends: "#078f86"
      skyBINGO - crm_extract.sends: "#8e61ed"
      skyBet - crm_extract.sends: "#2015b0"
      Activation - crm_mailing_level_summary.incremental_actives: "#1bba17"
      Grow - crm_mailing_level_summary.incremental_actives: "#a832e0"
      Nurture - crm_mailing_level_summary.incremental_actives: "#f29540"
      Reactivation - crm_mailing_level_summary.incremental_actives: "#3232c4"
      Activation - crm_mailing_level_summary.incremental_actives_campaign_level: "#1bba17"
      Grow - crm_mailing_level_summary.incremental_actives_campaign_level: "#a832e0"
      Nurture - crm_mailing_level_summary.incremental_actives_campaign_level: "#f29540"
      Reactivation - crm_mailing_level_summary.incremental_actives_campaign_level: "#3232c4"
      Activation - crm_segment_level_summary.incremental_actives_segment_level: "#1bba17"
      Grow - crm_segment_level_summary.incremental_actives_segment_level: "#a832e0"
      Nurture - crm_segment_level_summary.incremental_actives_segment_level: "#f29540"
      Reactivation - crm_segment_level_summary.incremental_actives_segment_level: "#3232c4"
      Activation - active_rate_treatment_subscribers: "#1bba17"
      Grow - active_rate_treatment_subscribers: "#a832e0"
      Nurture - active_rate_treatment_subscribers: "#f29540"
      Reactivation - active_rate_treatment_subscribers: "#3232c4"
      total_active_rate_treatment_subscribers: "#000000"
      Activation - crm_segment_level_summary.average_bet_days_treatment_segment_level: "#1bba17"
      Grow - crm_segment_level_summary.average_bet_days_treatment_segment_level: "#a832e0"
      Nurture - crm_segment_level_summary.average_bet_days_treatment_segment_level: "#f29540"
      Reactivation - crm_segment_level_summary.average_bet_days_treatment_segment_level: "#3232c4"
      Row Total - crm_segment_level_summary.average_bet_days_treatment_segment_level: "#000000"
    x_axis_reversed: true
    trend_lines: []
    focus_on_hover: true
    hide_legend: false
    x_axis_datetime_label: "%b %d"
    hidden_fields: []
    series_labels:
      Row Total - crm_segment_level_summary.average_bet_days_treatment_segment_level: Total
        Average Bet Days by Life Stage
    y_axes: []
    listen:
      Date Range: crm_segment_level_summary.send_date
      Product: crm_extract.product
      Filter for Campaigns with Selection Issues: crm_extract.selection_issue
      Communication Type: crm_extract.communication_type
      Channel: crm_extract.os_channel
    row: 70
    col: 12
    width: 12
    height: 8
  - title: "."
    name: "."
    model: crm_demo
    explore: crm_extract
    type: single_value
    fields:
    - crm_mailing_level_summary.dynamic_logo
    sorts:
    - crm_mailing_level_summary.dynamic_logo desc
    limit: 500
    column_limit: 50
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: true
    hide_totals: false
    hide_row_totals: false
    table_theme: transparent
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    barColors:
    - red
    - blue
    groupBars: true
    labelSize: 10pt
    showLegend: true
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    smoothedBars: false
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: right
    labelColorEnabled: false
    labelColor: "#FFF"
    show_value_labels: false
    font_size: 12
    value_labels: legend
    label_type: labPer
    map_plot_mode: points
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: positron
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    map: auto
    map_projection: ''
    quantize_colors: false
    stacking: ''
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    show_null_points: true
    point_style: circle
    interpolation: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    colors:
    - 'palette: Santa Cruz'
    hide_legend: false
    series_colors:
      skyVEGAS - crm_extract.sends: "#cc0404"
      skyPOKER - crm_extract.sends: "#4b98f2"
      skyCASINO - crm_extract.sends: "#078f86"
      skyBINGO - crm_extract.sends: "#8e61ed"
      skyBet - crm_extract.sends: "#2015b0"
      Activation - crm_mailing_level_summary.incremental_actives: "#1bba17"
      Grow - crm_mailing_level_summary.incremental_actives: "#a832e0"
      Nurture - crm_mailing_level_summary.incremental_actives: "#f29540"
      Reactivation - crm_mailing_level_summary.incremental_actives: "#3232c4"
      Activation - crm_mailing_level_summary.incremental_actives_campaign_level: "#1bba17"
      Grow - crm_mailing_level_summary.incremental_actives_campaign_level: "#a832e0"
      Nurture - crm_mailing_level_summary.incremental_actives_campaign_level: "#f29540"
      Reactivation - crm_mailing_level_summary.incremental_actives_campaign_level: "#3232c4"
      Activation - crm_segment_level_summary.incremental_actives_segment_level: "#1bba17"
      Grow - crm_segment_level_summary.incremental_actives_segment_level: "#a832e0"
      Nurture - crm_segment_level_summary.incremental_actives_segment_level: "#f29540"
      Reactivation - crm_segment_level_summary.incremental_actives_segment_level: "#3232c4"
    series_types: {}
    hidden_series: []
    x_axis_datetime_label: "%b %d"
    trend_lines: []
    conditional_formatting:
    - type: low to high
      value:
      background_color:
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
      bold: false
      italic: false
      strikethrough: false
      fields:
    series_labels:
      crm_mailing_level_summary.dynamic_logo: "."
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    listen:
      Product: crm_mailing_level_summary.dynamic_logo_filter
    title_hidden: true
    row: 0
    col: 18
    width: 6
    height: 3
  filters:
  - name: Date Range
    title: Date Range
    type: date_filter
    default_value: 12 weeks ago for 12 weeks
    allow_multiple_values: true
    required: false
  - name: Product
    title: Product
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    model: crm_demo
    explore: crm_extract
    listens_to_filters: []
    field: crm_extract.product
  - name: Filter for Campaigns with Selection Issues
    title: Filter for Campaigns with Selection Issues
    type: field_filter
    default_value: With No Issue
    allow_multiple_values: true
    required: false
    model: crm_demo
    explore: crm_extract
    listens_to_filters: []
    field: crm_extract.selection_issue
  - name: Communication Type
    title: Communication Type
    type: field_filter
    default_value: Manual
    allow_multiple_values: true
    required: false
    model: crm_demo
    explore: crm_extract
    listens_to_filters: []
    field: crm_extract.communication_type
  - name: Choose Metric for Top/Bottom 10 Campaigns
    title: Choose Metric for Top/Bottom 10 Campaigns
    type: field_filter
    default_value: incremental^_net^_profit^_margin^_normalised^_campaign^_level
    allow_multiple_values: true
    required: false
    model: crm_demo
    explore: crm_extract
    listens_to_filters: []
    field: crm_mailing_level_summary.incremental_actives_or_net_profit
  - name: Channel
    title: Channel
    type: field_filter
    default_value: Email
    allow_multiple_values: false
    required: false
    model: crm_demo
    explore: crm_extract
    listens_to_filters: []
    field: crm_extract.os_channel
