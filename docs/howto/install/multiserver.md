# Deploy DRAPI to multiple servers

The Domino REST API is designed to be able to share configuration between multiple servers.
To do this succesfully, you need to plan carefully and follow the steps outlined here.
Sharing configuration works not only for tightly coupled systems, but also for servers that ate just on the same org
or even across Domain boundaries (as long as trust and replication are setup correctly and working).

!!! warning "Not everything is shared"

    Settings in `KeepConfig.nsf`, mostly scopes and oauth applications replicate.
    Configurstion settings in `keepconfig.d` and `keepweb.d` are per server.
    When you want to share those, you need to manually copy them over.

!!! info ""

    We are working on improving the config sharing

## Planning

You need to know the following to plan properly:

- How are the participating servers replicating? You need to balance timelyness (to avoid replication conflicts) with resource consumption. Revisit [these considerations](https://www.wissel.net/blog/2009/06/picking-your-routing-and-replication-architecture.html).
- What will be the source of identity: DRAPI's login/Identity Provider or some external one like [Keycloak](https://www.keycloak.org/), [Microsoft Entra](https://www.microsoft.com/en-us/security/business/microsoft-entra) (the artist formerly known as "Azure Active Directory"), [Okta](https://www.okta.com/) or some other [OIDC](https://openid.net/developers/how-connect-works/) compliant identity service?
- Do you have or plan DRAPI extensions?
- What [SPA](https://developer.mozilla.org/en-US/docs/Glossary/SPA) are you planning to deploy to `keepweb.d`?

## Installation

- Follow the [steps outlined here](../../tutorial/installconfig/index.md) to install DRAPI on your main server. We shall refer to it as hub henceforth.
- Start DRAPI on the hub using the DOmino console command `load restapi`. This will create the database `KeepConfig.nsf`. When you upgrade DRAPI, you need to refresh the design of `KeepConfig.nsf` from `KeepConfig.ntf`
- Use the Domino admin to create replicas of `KeepConfig.nsf` on all participaing servers. You must retain the name and location.
- if one of the participating servers already has a `KeepConfig.nsf` with a divergent repllicaId, you must remove it. If is has no configuration entries, just delete it. When there are or you are not sure, rename it and deal with it later on.
- Create and/or verify scheduled (or cluster) replication between the participating servers (hencforth refered to as spoke(s)) and the hub.
- Now install DRAPI on the spokes.

## Configuration

There are three areas you need to configure:

- Shared JWT Keys to login to DRAPI.
- TLS to secure web traffic.
- OIDC/OAuth.

All of those will write their configuation entries into `keepconfig.d`. For now you need to manually copy them between servers (We are working on a more convenient solution). Be careful to only copy the settings you want to share.

### Shared JWT Keys to login to DRAPI

Use the Management Console to [generate the Keys for JWT](../../references/security/encryption.html#using-the-management-console-for-encryption-operations). As of 2025 you should prefer [EC](https://en.wikipedia.org/wiki/Elliptic-curve_cryptography) certificates. Follow [the example](./../references/security/encryption.html#ample-of-how-to-create-and-set-up-domino-rest-api-on-multiple-domino-servers-to-use-the-same-jwt-keys) and copy the 4 files across servers.

### TLS to secure web traffic

The **strongly** recommended way ise to use the [Domino Certificat Manager](../production/dominohttps.md). It's the most secure option and the least work. Create a file `keepconfig.d\DominoCertMgr.json` with the following content:

```json
{
  "TLSCertStore": true
}
```

Copy the file to all participaing servers.

You have [other options](../production/httpsprod.md), but they are more work.

### OIDC/OAuth

- To activate DRAPI's OAuth support, [follow these steps](../IdP/configuredrapiIdP.md). You might want to split the JSON file into two and take out the only server specific entry `url` - unless all participating servers sit behind a proxy serving the same URL.
- Follow [these steps](../IdP/configuringIdentityProvider.md) for a generic IdP, [these steps](../IdP/configuringAD.md) for Microsoft Entra ID (a.k.a Microsoft AD).

## Limit admin access

You don't need access to the adminUI on your spoke servers, it only increases the possibility of replication conflics by an absent minded admin. The capability walkthrough [Lab 11](../../tutorial/walkthrough/lab-11.md#disable-admin-endpoints-and-ui) outlines the steps to take to disable both the admin UI and the admin endpoints. You create a file `keepconfig.d/disableadmin.json` and copy it to all spokes, but not the hub.

```json
{
  "versions": {
    "setup": {
      "active": false
    },
    "admin": {
      "active": false
    },
    "admin-server": {
      "active": false
    }
  },
  "verticles": {
    "Design": {
      "active": false
    },
    "KeepAdmin": {
      "active": false
    },
    "AdminAccess": {
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

!!! warn "Swagger UI"

    This also disables the Swagger UI. So use a tool like [Bruno](https://www.usebruno.com/) instead

## Let's connect

--8<-- "feedback.md"
