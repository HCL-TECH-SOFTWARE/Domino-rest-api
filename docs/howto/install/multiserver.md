# Deploy DRAPI to multiple servers

The Domino REST API is designed to be able to share configuration between multiple servers. To do this succesfully, you need to plan carefully and follow the steps outlined here.
Sharing configuration works not only for tightly coupled systems, but also for servers that ate just on the same org or even across Domain boundaries (as long as trust and replication are setup correctly and working).

!!!warning "Not everything is shared"
    Settings in `KeepConfig.nsf`, mostly scopes and oauth applications replicate. Configuration settings in `keepconfig.d` and `keepweb.d` are per server. When you want to share those, you need to manually copy them over.

!!!info "We are working on improving the config sharing."

## Planning

You need to know the following to plan properly:

- How are the participating servers replicating? You need to balance timeliness (to avoid replication conflicts) with resource consumption. Revisit [these considerations](https://www.wissel.net/blog/2009/06/picking-your-routing-and-replication-architecture.html).
- What will be the source of identity: DRAPI's login/Identity Provider or some external one like [Keycloak](https://www.keycloak.org/), [Microsoft Entra](https://www.microsoft.com/en-us/security/business/microsoft-entra) (formerly known as "Azure Active Directory"), [Okta](https://www.okta.com/) or some other [OIDC](https://openid.net/developers/how-connect-works/) compliant identity service?
- Do you have or plan DRAPI extensions?
- What [SPA](https://developer.mozilla.org/en-US/docs/Glossary/SPA) are you planning to deploy to `keepweb.d`?

## Installation

- Follow the [steps outlined here](../../tutorial/installconfig/index.md) to install DRAPI on your main server. We shall refer to it as hub henceforth.
- Start DRAPI on the hub using the Domino console command `load restapi`. This will create the database `KeepConfig.nsf`. When you upgrade DRAPI, you need to refresh the design of `KeepConfig.nsf` from `KeepConfig.ntf`.
- Use the Domino admin to create replicas of `KeepConfig.nsf` on all participating servers. You must retain the name and location.
- If one of the participating servers already has a `KeepConfig.nsf` with a divergent replicaId, you must remove it. If it has no configuration entries, just delete it. When there are, or you aren't sure, rename it and deal with it later on.
- Create and/or verify scheduled (or cluster) replication between the participating servers (henceforth referred to as spokes) and the hub.
- Now install DRAPI on the spokes.

## Configuration

There are three areas you need to configure:

- TLS to secure web traffic
- OIDC/OAuth
- Shared JWT Keys to login to DRAPI (if not using an external IdP)

All those will write their configuration entries into `keepconfig.d`. For now, manually copy them between servers until a more convenient solution is available. Be careful to only copy the settings you want to share.

### TLS to secure web traffic

The **strongly** recommended way is to use the [Domino Certificate Manager](../production/dominohttps.md). It's the most secure option and the least work. Create a file `keepconfig.d\DominoCertMgr.json` with the following content:

```json
{
  "TLSCertStore": true
}
```

Copy the file to all participating servers. This will cause each server to attempt to find a certificate matching its fully qualified domain name as configured in its server document.

You have [other options](../production/httpsprod.md), but they require more work.

### OIDC/OAuth

- To activate DRAPI's OAuth support, [follow these steps](../IdP/configuredrapiIdP.md). You might want to split the JSON file into two and take out the only server specific entry `url` - unless all participating servers sit behind a proxy serving the same URL.
- Follow [these steps](../IdP/configuringIdentityProvider.md) for a generic IdP, [these steps](../IdP/configuringAD.md) for Microsoft Entra ID, formerly Azure Active Directory.

### Shared JWT Keys to login to DRAPI

When using DRAPI as your JWT provider, as opposed to an external identity provider like Keycloak, it can be useful to share the JWT issuing certificates across servers. The best way to do that is to store them in the Domino Certificate Manager. To do that, create a file `keepconfig.d\DominoCertMgr.json` with the following content:

```json
{
  "JWTCertStore": true
}
```

If you already have a certificate chain in certstore.nsf, set the `KeepCertStoreNameJWT` notes.ini parameter on each server to the subject host name of the certificate.

Alternatively, to generate the certificate chain using DRAPI, use the Management Console to [generate the Keys for JWT](../../references/security/encryption.md#using-the-management-console-for-encryption-operations). As of 2025, you should prefer [EC](https://en.wikipedia.org/wiki/Elliptic-curve_cryptography) certificates. This will create certificates in the certificate store using the common name of the Domino server and configure the local server to use it.

To enable access to this certificate for other servers, open the [certificate store database](https://help.hcl-software.com/domino/14.0.0/admin/secu_le_using_certificate_manager.html) and find the newly created certificate document. In that document, modify the **Servers with access**** field to include the other Domino servers that will access it, and click **Submit Request**. This causes the Certificate Manager to encrypt the certificate in a way compatible with each named server.

Then, set the `KeepCertStoreNameJWT` notes.ini parameter on each server to the common name of the first server, for example `MyServer`.

Alternately, to share certificates without the certificate store, follow [the example](../../references/security/encryption.md#example-of-how-to-create-and-set-up-domino-rest-api-on-multiple-domino-servers-to-use-the-same-jwt-keys) and copy the 4 files across servers.

## Limit admin access

You don't need access to the AdminUI on your spoke servers, it only increases the possibility of replication conflicts by an absent-minded admin. The capability walkthrough [Lab 11](../../tutorial/walkthrough/lab-11.md#disable-admin-endpoints-and-ui) outlines the steps to take to disable both the Admin UI and the Admin endpoints. Create a file `keepconfig.d/disableadmin.json` and copy it to all spokes, but not the hub.

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

!!!warning "Swagger UI"
    This also disables the Swagger UI. So use a tool like [Bruno](https://www.usebruno.com/) instead.

## Let's connect

--8<-- "feedback.md"
