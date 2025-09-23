# Lab 02 - Quick config

## What you will learn

- How to navigate the **Admin UI**.
- How to configure the "Approval Central" database using the **Admin UI**.
- Understand the difference between a *Schema* and a *Scope*.

## Before you begin

- You have completed [Lab 01 - Log in to the REST API](lab-01.md).
- Your Domino server must be running.
- You have deployed the database `ApprovalCentral.nsf` on your Domino server.

## Procedure

The procedure guides you in creating a schema and a scope using **Quick Config** in the Admin UI. 

1. Log in to **Admin UI**.
2. Expand the side panel and click **Quick Config**.

    ![Quick config](img/AdminUIExpanded.png){: style="height:70%;width:70%"}

3. Select `ApprovalCentral.nsf` from **Available Databases**, and fill in the form.

    - **Schema Name**: default
    - **Scope Name**: approvals
    - **Description & Schema Icon**: at your discretion

    ![Quick config](img/QuickConfig.png){: style="height:70%;width:70%"}

4. Click **Add**.

## Alternative procedure

The procedure guides you in creating a schema and a scope using curl, Postman, or KEEP CLI.

- Use the request in Postman's Lab 01 **Create QuickConfig for ApprovalCentral**.
- Use curl, Postman or the KEEP cli to post this JSON:

  ```json
  {
    "scopeName": "approvals",
    "nsfPath": "ApprovalCentral.nsf",
    "schemaName": "default",
    "create": true
  }
  ```

## How to verify

In the **Admin UI**, you will find one entry each for schema and scope as shown:

![Schema available](img/schemaAvailable.png){: style="height:70%;width:70%"}

![Scope available](img/scopeAvailable.png){: style="height:70%;width:70%"}

You can also check the following URLs:

- {{HOST}}/api/setup-v1/schemas?nsfPath=ApprovalCentral.nsf
- {{HOST}}/api/setup-v1/schema?nsfPath=ApprovalCentral.nsf&configName=default
- {{HOST}}/api/v1/scopes

## Things to explore

- [Domino REST API documentation](https://opensource.hcltechsw.com/Domino-rest-api/index.html)

- [Discord discussion](https://discord.com/invite/jmRHpDRnH4)

- Check the Swagger UI to see the newly created entries.
- Use Postman to create a second quick config using `recipe.nsf`.
- Open Domino Designer to check resources.

    ![Schema in Designer](img/schemaInDesigner.png){: style="height:70%;width:70%"}

    ![Schema in Designer](img/schemaInDesigner2.png){: style="height:70%;width:70%"}

## Next step

Proceed to [Lab 03 - Schema exploration](lab-03.md).
<!--
## Duration 10 min

## What you will learn:

- Navigate the Admin UI
- Configure the "Approval Central" database using the Admin UI
- Difference between **Schema** and **Scope**

## Prerequisites

- Lab 01 completed
- Your Domino server running

- Database [ApprovalCentral.nsf](../downloads/ApprovalCentral.zip) deployed to your server.

## Steps in creating a schema and scope in Quick Config

1. Log in to Admin UI.
2. Click on **Quick Config**.

    ![Quick config](img/AdminUIExpanded.png){: style="height:70%;width:70%"}

3. Fill in the form.

    - **Schema Name**: default
    - **Scope Name**: approvals
    - **Description & Schema Icon**: at your discretion

    ![Quick config](img/QuickConfig.png){: style="height:70%;width:70%"}

4. Click **Add**.

### Alternative steps

- Use request in Postman's Lab 01 **Create QuickConfig for ApprovalCentral**
- Use curl, Postman or the KEEP cli to post this JSON:

```json
{
  "scopeName": "approvals",
  "nsfPath": "ApprovalCentral.nsf",
  "schemaName": "default",
  "create": true
}
```

## How to check

In the Admin UI, you will find one entry each for schema and scope:

![Scope available](img/scopeAvailable.png){: style="height:70%;width:70%"}

![Schema available](img/schemaAvailable.png){: style="height:70%;width:70%"}

### URLs to check

- {{HOST}}/api/setup-v1/schemas?nsfPath=ApprovalCentral.nsf
- {{HOST}}/api/setup-v1/schema?nsfPath=ApprovalCentral.nsf&configName=default
- {{HOST}}/api/v1/scopes

## Things to explore

- [Domino REST API documentation](https://opensource.hcltechsw.com/Domino-rest-api/index.html)

- [Discord discussion](https://discord.com/invite/jmRHpDRnH4)

- Check the Swagger UI for the new entry.
- Use POSTMAN to create a second quick config using recipe.nsf.
- Open Domino Designer to check resources.

  ![Schema in Designer](img/schemaInDesigner.png){: style="height:70%;width:70%"}

  ![Schema in Designer](img/schemaInDesigner2.png){: style="height:70%;width:70%"}
-->