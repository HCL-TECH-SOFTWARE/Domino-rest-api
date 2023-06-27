# Lab 11 - KEEP Configuration

The Domino REST API provides extensive configuration capabilities to cater to different usage scenarios

## Duration 20 min

## What you will learn

- FineTune KEEP configuration
- Switch on/off API endpoints

![KEEP configuration](img/ActualConfiguration.svg)

## Prerequisites

- Domino running

## Steps

All configuration settings are kept in JSON files you place in `keepcofig.d` Files are loaded in alphabetical order. When you have conflicting entries, the last one wins. After a change the REST API needs to be reloaded.

### Update CORS settings

```json
{
  "CORS": {
    "localhost": true,
    ".local": false,
    "yourDomain.com": true
  }
}
```

![CORS Settings](img/CORS.png)

### Disable PIM access

```json
{
  "versions": {
    "pim": {
      "active": true
    }
  },
  "verticles": {
    "PIM": {
      "active": false
    },
    "Firehose": {
      "active": false
    }
  }
}
```

![PIM disabled](img/DisablePIM.png)

### Disable Admin Endpoints and UI

```json
{
  "versions": {
    "setup": {
      "active": false
    }
  },
  "verticles": {
    "Design": {
      "active": false
    },
    "KeepAdmin": {
      "active": false
    }
  },
  "webapps": {
    "webjars": {
      "active": false
    }
  }
}
```

![Disable Setup](img/DisableSetup.png)

### Enable OAuth

```json
{
  "oauth": {
    "active": true,
    "database": "oauth.nsf",
    "authCodeExpiresIn": 120,
    "accessTokenExpiresIn": 3600,
    "refreshTokenExpiresIn": 525600,
    "url": "http://localhost:8880"
  }
}
```

![Enable OAuth](img/EnableOAuth.png)

## How to check

- check with swagger
- check with curl

## Things to explore

- [Official Domino REST API documentation](https://opensource.hcltechsw.com/Domino-rest-api/index.html)
- [Discord discussion](https://discord.com/invite/jmRHpDRnH4)
- mess with other parameters:
  - disable Domino login
  - enable Preview features
  - update NsfExclusions
