# Lab 02 - Quick config

## Duration 10 min

## What you will learn

- Navigate the AdminUI
- Configure the "Approval Central" database using the adminUI
- Difference between **Schema** and **Scope**

## Prerequisites

- Lab 01 completed
- You Domino server running
- Database [ApprovalCentral.nsf](../downloads/ApprovalCentral.zip) deployed to your server

## Steps

- Login Admin UI
- Click on quick config

![Quick config](img/AdminUIExpanded.png)

- Fill in the form

  - Schema: default
  - Scope: approvals
  - description & icon: at your discretion

![Quick config](img/QuickConfig.png)

- Submit

### Alternative steps

- Use request in Postman's Lab 01 **Create QuickConfig for ApprovalCentral**
- use curl, postman or the KEEP cli to post this JSON:

```json
{
  "scopeName": "approvals",
  "nsfPath": "ApprovalCentral.nsf",
  "schemaName": "default",
  "create": true
}
```

## How to check

In the AdminUI you will find one entry each for schema and scope:

![Scope available](img/scopeAvailable.png)

![Schema available](img/schemaAvailable.png)

### URLs to check

- {{HOST}}/api/setup-v1/schemas?nsfPath=ApprovalCentral.nsf
- {{HOST}}/api/setup-v1/schema?nsfPath=ApprovalCentral.nsf&configName=default
- {{HOST}}/api/v1/scopes

## Things to explore

- [Official Domino REST API documentation](https://opensource.hcltechsw.com/Domino-rest-api/index.html)
- [Discord discussion](https://discord.com/invite/jmRHpDRnH4)
- Check the SwaggerUI for the new entry
- Use POSTMAN to create a second quick config using recipe.nsf
- Open Domino Designer to check resources

![Schema in Designer](img/schemaInDesigner.png)

![Schema in Designer](img/schemaInDesigner2.png)
