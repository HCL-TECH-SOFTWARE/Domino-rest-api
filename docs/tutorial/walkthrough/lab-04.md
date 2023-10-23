# Lab 04 - Additional scope & schema

Rationale: An external training provider shall get access to Name and Course, but neither cost nor approval flows.

## Duration 10 min

## What you will learn:

A database can expose different sets of information based on different schema.

## Prerequisites

- Lab 03 completed
- Domino running
- Postman available

## Steps for schema and scope exploration

### Create schema

1. In the Admin UI, select "Database Management - REST API"
2. Click **Schemas** from the navigation pane.
2. On the **Schema Management**, click **Add Schema**".
3. Select `ApprovalCentral.nsf` from the **Available Databases**.
4. Fill in Schema Name: `training`

    ![Add Schema](img/AddSchema.png)

5. Switch to the "NSF View"

    ![NSF View](img/nsfView.png)

    ![TrainingSchema](img/TrainingSchema.png)

6. Edit the `Training` schema.
7. Configure only form `Training`.

    | Field    |  Type  |   Access   |
    | -------- | :----: | :--------: |
    | Form     | string | read-write |
    | from     | names  | read-write |
    | Training | string | read-write |

    Set formula for write access to `@false`

8. Configure view `(TrainingApprovals)`.

  !!! danger 
  "Don't forget to save".

### Create scope

1. Click **Add Scope**, on the **Scope Management**
2. Select the schema `Training` from the `ApprovalCentral.nsf` from  the **Available Schema**
3. Fill in Scope Name as `trainingcorp`. Fill the Description.
  
   Server and  Maximum Level Access, leave it as it is. 

4. Click **Add**.

    ![Added scope](img/AddScope.png)

alternative `POST` to `/api/setup-v1/admin/scope`

```json
{
  "apiName": "trainingcorp",
  "createSchema": false,
  "description": "Subset Training for XY Training Inc",
  "iconName": "handshake",
  "isActive": true,
  "nsfPath": "ApprovalCentral.nsf",
  "schemaName": "training",
  "server": "*"
}
```

## How to check

- Retrieve list of schemas for `ApprovalCentral.nsf`.
- Retrieve list of scopes.
- Check admin UI.
- Login with limit to scope `trainingcorp` and look at data in POSTMAN

## Things to explore

- [Official Domino REST API documentation](https://opensource.hcltechsw.com/Domino-rest-api/index.html)
- [Discord discussion](https://discord.com/invite/jmRHpDRnH4)
- Login with a limited scope and try to access the other scope's data.
