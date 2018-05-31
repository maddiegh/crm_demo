# CRM Homepage ✉️

## Dashboards

The Dashboards in CRM have been designed to go from a high level overview down to actionable, campaign level insight.

[1. CRM Overview](https://redkitedemo.eu.looker.com/dashboards/10) 👉 [2. CRM Campaign Level](https://redkitedemo.eu.looker.com/dashboards/11) 👉 [3. CRM Campaign Drilldown](https://redkitedemo.eu.looker.com/dashboards/12)

**1. CRM Overview Dashboard**
This dashboard is built around Incremental Net Margin and guides a Looker user into understanding why it changed over a period (defaulted to week on week).
It is designed to be used sequentially.

At the simplest level, Incremental Net Margin changes because either there were more active users or there was more margin coming from those users.
The first two heat map tables help to highlight if there was a standout day or weekend that impacted either of the two metrics.
Clicking on a week label will link through to a filtered version of the Campaign Level report - which will highlight if a campaign drove change.

If *Active Users* were driving the change in margin, then the 'Drill down into net incremental actives' section highlight what part of the CRM team's work impacted this.
The charts follow a funnel path:
what volume of emails reached subscribers 👉 did they open the email 👉 did they click on a link in the email

These metrics are then broken out by product line i.e. if open rate increased, was it due to one product or all products?
If a product line stands out, then the whole report can be filtered to investigate it further.

If *Incremental Margin Per Active* was driving the change in margin, then the 'Drill Down by Incremental Margin' section highlights what product line impacted this.

**2. CRM Campaign Level**

Notes on usage:
- The dashboard is designed to be filtered (either by clicking from the CRM Overview Dashboard or by changing the filters at the top).
- The large mailing stats and financials performance tables can be sorted by clicking on any column name.
- The report can be filtered with free text searches - eg if you want to search for campaigns where the subject line contains 'free spins', change the 'Mailing Name' filter to 'Contains' and type in the text you want to search.
- Clicking on a mailing name takes you to the 'CRM Campaign Drilldown' dashboard.

**3. CRM Campaign Drilldown**
This dashboard displays the most granular level of CRM data currently available.
It gives a full overview of the performance of a single campaign.

Notes on usage:
- This dashboard is designed to display only one campaign at a time.
- The active rate and margin comparisons benchmark to the last 28days of a product line average figure.

## Data Glossary 📖
A definition of all key fields can be found when hovering over the ℹ️ symbol next to a field.
A summary can also be [found and downloaded here](https://redkitedemo.eu.looker.com/)

## Who to speak to

For help with Looker, technical issues or bugs please contact Henry and Madalina:
Henry Crawford <henry@redkiteintelligence.com>
Madalina Ghita <madalina.ghita@redkiteintelligence.com>

<font color="grey" size="2">Document last updated: 01/06/2018</font>
