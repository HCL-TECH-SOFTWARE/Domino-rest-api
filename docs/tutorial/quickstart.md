# Quickstart

This guide is designed to help users with working experience in HCL Notes and HCL Domino to quickly install, configure, and start using Domino REST API. By following this guide, you'll get the Domino REST API up and running, understand the core concepts, and successfully perform your first API requests using tools like Swagger UI, Postman, or curl.

## Step 1: Download the Domino REST API

Log in to [My HCLSoftware Portal](https://my.hcltechsw.com/) and download the latest Domino REST API installer or container (Docker) image. For more information, see [Download Domino REST API](installconfig/install/downloaddrapi.md).

## Step 2: Install and run the Domino REST API

Follow the [installation and configuration guide](https://opensource.hcltechsw.com/Domino-rest-api/tutorial/installconfig/index.html) to install and start the REST API on a Domino server or Notes client.

After installation, complete the [post-installation steps](https://opensource.hcltechsw.com/Domino-rest-api/tutorial/installconfig/configuration/index.html) to ensure proper operation.

## Step 3: Learn to use the Domino REST API tools

- Explore the [Admin UI tutorial](https://opensource.hcltechsw.com/Domino-rest-api/tutorial/adminui.html) for web-based API management.

- Understand core concepts such as [schemas and scopes](https://opensource.hcltechsw.com/Domino-rest-api/topicguides/understanding.html).

- Familiarize yourself with API testing tools like [Postman and curl](https://opensource.hcltechsw.com/Domino-rest-api/tutorial/postmancurl.html), which are invaluable for working with REST APIs.

## Step 4: Get started with your first database

- Pick a database to work with. You can use the sample [demo.nsf](https://opensource.hcltechsw.com/Domino-rest-api/references/downloads.html).

- Create a **schema** that defines the data structure and what fields/forms you want to expose via REST. This is done using Domino Designer with appropriate developer access.

- Select views you want to expose through REST.

- Optionally, configure agents to be REST accessible.

- Create a **scope** (an externally visible alias for your database/API exposure) via the Domino REST API admin tools by a Domino administrator.

    !!! note

        Scopes should be lowercase and are part of your API URLs (`?dataSource=[scopename]`).

## Step 5: Try it out

- Use one or more of the following methods to test your API:

  - The built-in [Swagger UI](https://opensource.hcltechsw.com/Domino-rest-api/tutorial/swagger.html) for exploring available endpoints interactively.

  - Send API requests via [Postman](https://opensource.hcltechsw.com/Domino-rest-api/tutorial/postmancurl.html).

  - Use [curl](https://opensource.hcltechsw.com/Domino-rest-api/tutorial/postmancurl.html) commands or the provided [Domino REST API shell script](https://opensource.hcltechsw.com/Domino-rest-api/references/downloads.html) for command-line testing.

## Additional information

### Understanding Key Roles

- **Domino Developer:** Creates the API schemas defining accessible data in NSF databases.

- **Domino Administrator:** Creates and activates scopes and configures OAuth-compatible applications with client IDs and secrets.

- **Volt MX Administrator:** Configures middleware integration with Volt Foundry.

- **Application Developer:** Builds applications consuming Domino REST API endpoints via tools like Volt Iris, VS Code, or other frameworks.

Learn more about [Domino REST API roles](https://opensource.hcltechsw.com/Domino-rest-api/references/usingdominorestapi/roles.html).

### Essential endpoints

Ensure your endpoints are secure. Bring up a browser and verify that you can hit these endpoints:

| Endpoints | Ports | Details |
| ---- | ---- | ---- |
| [Domino REST API Home Page](http://localhost:8880/) | 8880 | Start page |
| [Live Domino REST API](http://localhost:8880/openapi/index.html?url=/api/v1/schema/openapi.core.json) | 8880 | Interact live with the API |
| [Admin UI](http://localhost:8880/admin/ui/) | 8880 | Login with an admin user. `LocalDomainAdmin` member |
| [Management API](http://localhost:8889/) | 8889 | Access to the log and runtime info |
| [Prometheus Metrics](http://localhost:8890/) | 8890 | Performance info in Prometheus format. Protected with basic authentication (metrics/metrics) |
| [Health check endpoint](http://localhost:8886/) | 8886 | Server healthcheck endpoint as used by Kubernetes or OpenShift |
| [Auth](http://localhost:8880/api/v1/auth) | 8880  | The endpoint, `[POST] http/s://${HOST}:8880/api/v1/auth`, is the default end point to exchange Domino web credentials for a JWT access token. For example, use the token in Postman request headers as a Bearer authentication header. You also can use your [own IdP](../howto/IdP/configuringIdentityProvider.md) to gain access tokens |

## What's Next?

Depending on your goals, explore these further resources:

- Dive deeper into [installation and configuration](https://opensource.hcltechsw.com/Domino-rest-api/tutorial/installconfig/index.html)

- Learn more about [using Domino REST API](https://opensource.hcltechsw.com/Domino-rest-api/references/usingdominorestapi/index.html)

- Explore [internal workings](https://opensource.hcltechsw.com/Domino-rest-api/references/extensibility/howkeepworks.html) and the security layer [Barbican](https://opensource.hcltechsw.com/Domino-rest-api/references/extensibility/barbican.html)

## Join the community and give feedback

Your feedback is valuable. Join the conversation and get help via:

- [HCLSoftware Digital Solutions Community Forum](https://developer.ds.hcl-software.com/)

- [OpenNTF Discord channel](https://discord.com/invite/jmRHpDRnH4)

- Customer support information: [Contact Support](https://opensource.hcltechsw.com/Domino-rest-api/references/support.html)
