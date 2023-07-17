# Lab 05 - Create an application

Rationale: "Application" is the configuration you need when you want to use Domino's build in Identity Provider (IdP) functionality. IdP is part of the **OAuth** based Identity standard

## Duration 10 min

## What you will learn

Configure credentials, so an application can login _on your behalf_ with a limited set of permissions. Needed for lab 6

## Prerequisites

- Lab 04 completed
- Domino running

## Steps

### Create app in AdminUI

![Create application](img/createApp.png)

- The callback URLs need to be provided by the application developer/admin and need to match
- Add scopes as desired

!!! note "Scopes need to exist"

    You can specify one or more scopes that don't exist (yet). Just make sure they do once the application shall be used

Alternative `POST` to `/api/setup-v1/admin/application`

```json
{
  "client_name": "XYTraining",
  "description": "The external Training APP",
  "redirect_uris": ["http://localhost:3000/callback"],
  "client_uri": "https://www.spiegel.de",
  "scope": "trainingcorp",
  "logo_uri": "cathedral",
  "status": "isActive",
  "contacts": ["Doctor.Notes@projectkeep.io"]
}
```

### Create a secret -- note it down

![Create a secret](img/Secret01.png)

![See secret](img/Secret02.png)

Alternative `POST` to `/api/setup-v1/admin/application/{{CLIENT_ID}}/secret?force=true`

```json
{
  "client_id": "{{CLIENT_ID}}",
  "status": "isActive"
}
```

!!! warning "App Secrets can't be retrieved"

    Once you switch away from the App screen where you saw the "App Secret" it is gone. We store and save it salted and hashed and can't transform it back

## How to check

- App shows up in adminUI
- App shows up in landing screen

## Things to explore

- [Official Domino REST API documentation](https://opensource.hcltechsw.com/Domino-rest-api/index.html)
- [Discord discussion](https://discord.com/invite/jmRHpDRnH4)
- Explore creating / retrieving app in Postman.
- Reset the secret.
- Do the OAuth dance in Postman.
