# Post installation

After installation, Domino REST API will run on port 8880 with HTTP and a transient JWT token for single server use. It's nice to try things out, but not production-ready. The following configuration tasks are needed to finalize a **production-worthy** Domino REST API deployment and to ensure complete functionality and a secure interface to your Domino applications.

!!! caution "Important"

    - You should familiarize yourself with all [configuration parameters](../../../references/configuration/parameters.md) and [security](../../../references/security/index.md) settings before you deploy into a production environment.
    - Domino REST API honors all Domino access control mechanisms and doesn't allow anonymous access. For more information, see [Access Control](../../../references/accesscontrol.md).

## [Check connectivity](connectivity.md)

After the installation, make sure connectivity works.

## [Secure ports](secureport.md)

A production environment must have an encrypted communication between any client and the Domino REST API Server. Domino REST API uses multiple ports, learn how to secure them.

## [Setup functional accounts](setupfunctionalaccount.md)

There are a series of endpoints that aren't associated with regular user IDs:

- Management console (Port 8889)
- Metrics endpoint (Port 8890)
- Health check (Port 8886)

To enable access to these port, you need functional accounts.

## [Configure JWT](jwtconfig.md)

Domino REST API uses JSON Web Token (JWT) for authorization. To allow using Domino REST API without the deployment of an external Identity Provider (IdP), Domino REST API can be configured to provide a JWT after authentication with Domino credentials.

The JWT token can also be shared between servers to enable SSO (Single Sign On) for Domino REST API.

## [Manage databases](admingroup.md)

There are databases created on the Domino server as part of the Domino REST API installation. These databases must be secured and managed like other production databases.

## [Expose databases to REST API access](exposedb.md)

To make a database available on the Domino REST API, create a Domino REST API schema and link it to a publicly visible scope. The schema defines what documents, based on the value of their form item, views, folders, and agents are available for a call via HTTP.

<!--

## [Enable a database](../../howto/database/enablingadb.md)

To make a database available on the Domino REST API, create a Domino REST API `schema` and link it to a publicly visible `scope`. The schema defines what documents, based on the value of their `form` item, views, folders, and agents are available for a call via HTTP.

## [Configure JWT](../../references/security/authentication.md)

Domino REST API uses JSON Web Token (JWT) for Authorization. To allow using Domino REST API without the deployment of an external Identity Provider (IdP), Domino REST API can be configured to provide a JWT after authentication with Domino credentials.

## [Sharing JWT between servers](../../references/security/encryption.md)

JWT token can be shared between servers, effectively enabling SSO (Single Sign On) for Domino REST API. It's LTPA for grownups.

## [Configure OAuth access for apps](../../tutorial/adminui.md)

The Admin UI allows to configure database schemas, server scopes and OAuth applications (Domino functioning as IdP).
-->

<!--# Configuration

This section describes how to configure your Domino REST API after installation
-->