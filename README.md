# Interaction Model

## Summary

The Interaction Model project addresses a business use case for companies seeking to reduce duplicate leads and contacts generated from on online form by managing form submits as individual interactions. In a scenario where website visitors who may be existing customers, previously vetted leads, or new to the brand can submit their contact information and product preferences through an online contact form, this project automates the process of creating new leads and opportunities by translating visitor interactions within a Salesforce environment.

## Key Features

- **Data Integration**: On user submission, the Interaction Model project sends the collected information through a Salesforce org webservice class.

- **Interaction Record Creation**: The project automatically generates a new `Interaction__c` record in Salesforce, capturing crucial visitor data.

- **Contact & Lead Matching**: A Flow is triggered on creation to check for duplicate contacts or leads given the visitor's information using custom invocable Apex actions.

- **Opportunity Creation**: If a matching contact is found, the system associates the interaction with the existing contact and creates a new opportunity based on the selected product of interest.

- **Lead Creation**: If no match is found, the project initiates the creation of a new lead.

- **Email Notifications**: Whenever a new lead or opportunity is created, an email notification is sent to the responsible owner, ensuring prompt follow-up.

- **User-Friendly Interface**: The Interaction Model offers a Lightning Web Component embedded within an Experience Cloud site, allowing sales representatives to conveniently view interactions related to the contacts or leads they manage.

- **Data Cleanup**: To maintain database efficiency, the project includes a scheduled batch process that deletes interactions older than 3 days.