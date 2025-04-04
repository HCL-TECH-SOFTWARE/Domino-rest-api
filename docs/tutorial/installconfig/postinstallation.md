# Post installation task overview

After installation the Domino REST API will run on port 8880 with http and a transient JWT token for single server use. This is nice to try things out, but not production ready. Familiarize yourself with the tasks listed here to finalize a **production worthy** Domino REST API deployment.

--8<-- "iskeeprunning.md"

The headlines link to details for each task. Feedback is welcome.

## [Check connectivity](./connectivity.md)

First order after your installation is to ensure connectivity works. There are a few moving parts, check it carefully

## [Securing ports](../installconfig/configuringPorts.md)

A production environment must encrypt the communication between any client and the Domino REST API Server. We use multiple ports, learn how to secure them.

## [Enable a database](../../howto/database/enablingadb.md)

To make a database available on the Domino REST API, create a Domino REST API `schema` and link it to a publicly visible `scope`. The schema defines what documents, based on the value of their `form` item, views, folders, and agents are available for a call via HTTP.

## [Configure JWT](../../references/security/authentication.md)

Domino REST API uses JSON Web Token (JWT) for Authorization. To allow using Domino REST API without the deployment of an external Identity Provider (IdP), Domino REST API can be configured to provide a JWT after authentication with Domino credentials.

## [Sharing JWT between servers](../../references/security/encryption.md)

JWT token can be shared between servers, effectively enabling SSO (Single Sign On) for Domino REST API. It's LTPA for grownups.

## [Configure OAuth access for apps](../../tutorial/adminui.md)

The Admin UI allows to configure database schemas, server scopes and OAuth applications (Domino functioning as IdP).

## [Setup functional Accounts](../installconfig/setupfunctionalaccount.md)

There are a series of endpoints that aren't associated with regular user ids:

- Management console (Port 8889)
- Metrics endpoint (Port 8890)
- Health check (Port 8886)

To enable access to those, you need [functional accounts](../../references/functionalUsers.md).
