# Configuration parameters

The configuration is assembled from JSON files and a few selected environment parameters. We use those environment parameters because they're a commonly used way to configure instances in virtual environments such as Docker, IBM Cloud, and Kubernetes.

The Domino REST API ships with default settings in internal files `config.json` and `security.json`. **These are internal files and not subject to user modifications**.

!!! warning "CaSe SeNsItIvE"

    Parameters are **case sensitive**

To alter a parameter, either set an environment parameter, if one exists (there aren't that many) or create a JSON file in `keepconfig.d` by following the the steps in [Modify configuration of Domino REST API](../howto/install/modifyconfig.md).

## Environment

--8<-- "environmentparam.md"

## Parameters in JSON files

A configuration can have the following top-level properties. These properties are case-sensitive.

|Property|Type|Description|
|:---|:---|:---|
| HOST | String | Hostname or IP address to bind to, default is not set |
| MANAGEMENTPORT | int (0 to 65353) | (default 8889) Commands regarding the runtime, for example config and shutdown, should only be exposed to an admin network workstation. |
| METRICSPORT | int (0 to 65353) | (default 8890) Port for Prometheus metrics. |
| FIREHOSEPORT | int (0 to 65353) | (default 42424) Port for Firehose to successfully deliver data to custom HTTP endpoints. |
| PORT | int (0 to 65353) | (default 8880) Port for regular API access.|
|HEALTHCHECK |int (0 to 65353)| (default 8886) Port for health check, which is the standard approach for Docker and Kubernetes environments to allow any automated tooling that manages your containers to periodically check and automatically take action if Domino REST API is no longer working.|

| prometheusMetrics        | [prometheusParameters](#prometheus-parameters)    | Parameters to hand over to the Prometheus task from vert.x.                                                                                                                                                                                |
| versions                 | [versionParameters](#version-parameters)          | List of the OpenAPI definition files to load.                                                                                                                                                                                              |
| verticles                | [verticlesParameters](#restapi-verticle)          | The verticles to load.                                                                                                                                                                                                                     |
| vertx                    | [vertxParameters](#vertx-parameters)              | Parameters to hand to the start of vert.x, see [the vert.x documentation](https://vertx.io/docs/apidocs/io/vertx/core/VertxOptions.html) for details.                                                                                      |
| ServerDirectDBAccess     | Boolean                                           | Set to `true` to allow Direct Database access for server.                                                                                                                                                                                  |
| createKeepDBfromTemplate | Boolean                                           | Set to `true` to allow create Domino REST API Database from template.                                                                                                                                                                      |
| useJnxDesigns            | Boolean                                           | Set to `false` to stop the use of Jnx Designs.                                                                                                                                                                                             |
| AllowJwtMail             | Boolean                                           | Set to `true` to allow email to be sent via a JWT token.                                                                                                                                                                                   |
| AllowLocalMailFile       | Boolean                                           | Set to `true` to allow local mail file                                                                                                                                                                                                     |
| ⁠showDeprecatedEndpoints | Boolean                                           | True to allow access to deprecated endpoints / APIs                                                                                                                                                                                        |
| ⁠showPreviewFeatures     | Boolean                                           | True to allow preview access to new features, endpoints, or APIs                                                                                                                                                                           |
| bodyHandler              | [bodyHandler parameters](#bodyhandler-parameters) | Handles HTTP file uploads and used to limit body sizes                                                                                                                                                                                     |
| webAuthnActive           | Boolean                                           | Set to `true` to enable WebAuthn to be active.                                                                                                                                                                                             |
| jwt                      | [JWT parameters](#jwt-parameters)                 | Parameters for enabling Domino REST API to accept JWT tokens from external providers     |
| LandingPageRedirect  | String                | Alternative landing page for those who prefer a different layout than the tiled landing page. Ensure the URL provided is valid and complete.|
| TokenCookie | Boolean | (default `false`) Set to `true` to allow Domino REST API to send back JWT as cookie named `KeepToken`. The cookie expiry is the same as the JWT expiry. It immediately expires when logout is called. |
| AdminUIKeepLogin | Boolean | (default `true`) If set to `true`, displays the username and password login in the Admin UI login page. If this and `AdminUIOIDCLogin` are set to `false`, the Admin UI login page behaves as if this is set to `true`. |
| AdminUIOIDCLogin | Boolean | (default `true`) If set to `true`, displays the IdP logins in the Admin UI login page. |
| WopiSessionSeconds | int | Duration of WOPI session in seconds. Default is `36000` (10 hours). |
| WebdavSessionSeconds | int | Duration of Webdav session in seconds. Default is `300` (5 minutes). |
| WopiLockSeconds | int | Duration of WOPI lock in seconds. Should be less than or the same as `WopiSessionSeconds`. Default is `1800` (15 minutes). |
| WebdavLockSeconds | int | Duration of Webdav lock in seconds. Should be less than or the same as `WebdavSessionSeconds`. Default is `300` (5 minutes). |

## Backpressure handling parameters

These parameters control the flow of requests to Domino, to shape acceptable load

| Property                  | Type | Description                                                               |
| :------------------------ | :--- | :------------------------------------------------------------------------ |
| concurrentRequestMaxCount | int  | How many requests can concurrently be opened to Domino core `-1` = unlimited |
| concurrentRequestDelay    | int  | Number of milli seconds to retry an operation (default = `42`)            |
| concurrentRequestRetries  | int  | number of retries before rejecting a request (default = `100`)           |

## Prometheus parameters

| Property         | Type    | Description                        |
| :--------------- | :------ | :--------------------------------- |
| Endpoint         | String  | Route path to metrics.             |
| enabled          | Boolean | true to enable metrics collection. |
| publishQuantiles | Boolean | true to publish Quantiles.         |

## Version parameters

Versions has a named list of entries with two parameters:

| Property | Type    | Description                                                                                                                                                                       |
| :------- | :------ | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| path     | String  | Path used by [`getResourceAsStream`](https://docs.oracle.com/javase/8/docs/api/java/lang/Class.html#getResourceAsStream-java.lang.String-) to load an OpenAPI specification file. |
| active   | Boolean | Whether the spec is loaded.|
|disabledOperationIds|Array|Receives the `operationID` of an endpoint or endpoints in an API schema as value to make those endpoints unavailable |

The name of the entries must match the name used in versions of the [RestAPI verticle](#restapi-verticle).

## Vert.x parameters

| Property | Type                                     | Description                   |
| :------- | :--------------------------------------- | :---------------------------- |
| metric   | [metricsParameters](#metrics-parameters) | Parameter for vert.x metrics. |

### Metrics parameters

Here is a JSON representation of the resource:

```json
{
  "enabled": true,
  "jvmMetricsEnabled": true,
  "metricuser": "metrics"
}
```

| Property                  | Type             | Description                                                                                                                                                                                 |
| :------------------------ | :--------------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| disabledMetricsCategories | Array of Strings | Specified in the [MetricsDomain Java class](https://github.com/vert-x3/vertx-micrometer-metrics/blob/master/src/main/java/io/vertx/micrometer/MetricsDomain.java), for example `vertx.http.server` |
| enabled                   | Boolean          | Whether metrics are enabled on the Vert.x instance.                                                                                                                                         |
| jvmMetricsEnabled         | Boolean          | Whether JVM metrics are collected.                                                                                                                                                          |
| labels                    | Array of Strings | List of labels to enable / disable.                                                                                                                                                         |
| labelMatches              | Array of Match   | List of rules for label matching.                                                                                                                                                           |
| registryName              | String           | Name for the metrics registry, so that a new registry is created and associated with this name. Leave blank for default.                                                                    |

## Verticle parameters

Verticles defines a separate unit of work for particular tags. For the Rest API verticle, see [below](#restapi-verticle). The rest have a standard set of parameters:

| Property       | Type    | Description                                                                                                                                                                                                                                                                                                                       |
| :------------- | :------ | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| active         | Boolean | Whether to load this verticle. This can be used to limit available operations. For example, on an external facing server set all but the [`basis`](https://redocly.github.io/redoc/?url=https://opensource.hcltechsw.com/Domino-rest-api/assets/downloads/openapi.basis.json) API to false                                                |
| className      | String  | Class to use for the verticle. Typically this is `com.hcl.domino.keep.verticles.DominoDefaultVerticle`, unless you need to extend that class.                                                                                                                                                                                     |
| tags           | Object  | Tags from OpenAPI specs to allocate to this verticle and the package in which to find the NSFHandlers.                                                                                                                                                                                                                            |
| instances      | int     | Relevant only for RestAPI verticle, loads multiple instances that each use a thread pool. You will need to be aware of the number of cores available and scalability, see the [Vert.x documentation](https://vertx.io/docs/vertx-core/java/#_specifying_number_of_verticle_instances).                                            |
| threadPoolName | String  | When a verticle should use a dedicated pool for the `executeBlocking` operations (a.k.a all calls into the Domino C API), the name for thread pool. By default, it's assigned 10 threads, but this can be overwritten with `threadPoolSize`. Don't use the same `threadPoolName` by multiple verticles, sharing isn't supported. |
| threads        | int     | Only used for worker threads with a specific `threadPoolName`. The default is 10, but this can be overwritten.                                                                                                                                                                                                       |
| worker         | Boolean | To make this a [worker verticle](https://medium.com/@levon_t/java-vert-x-starter-guide-part-2-worker-verticles-c49866df44ab). Worker verticles run on their own event loop thread, pulled from a preconfigured pool of 20 threads. Use for heavy-duty verticles.                                                                  |
| threadTimeout  | long    | defaults to 2. Number of minutes for an [`executeBlocking`](https://vertx.io/docs/vertx-core/java/#blocking_code) to time out. Only in effect when a `threadPoolName` is specified.                                                                                                                                                |

The following are types of verticles with additional parameters:

### AsyncAgentScheduler verticle

This is the verticle for running async agents - calls to `/run/agent` with `async` set to `true` in the payload. In the Notes client you can look at `KeepAgents.nsf` for the asynchronous agents that are running or have run. This properties for this verticle include the [above](#verticle-parameters), plus these:

| Property                       | Type | Description                                                                                                        |
| :----------------------------- | :--- | :----------------------------------------------------------------------------------------------------------------- |
| agentDefaultMaxDurationSeconds | int  | Timeout for asynchronous agents, in seconds. A value of -1 allows all agents to run to completion without timeout. |
| logFrequencyMs                 | int  | Frequency to log messages of running async agents to the console.                                                  |

### RestAPI verticle

This is the verticle for managing WebHandlers. `worker`, `threadPoolName`, `threadPoolSize`, `className` and `active` parameters are as for the other verticles. This verticle also has a `versions` parameter. This maps to the top-level `versions` parameter and has the following properties:

| Property        | Type   | Description                                                                                                                                                                                                                                                                        |
| :-------------- | :----- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| defaultClass    | String | Class to use for the WebHandler if no class is defined. `com.hcl.domino.keep.handlers.v1.DefaultJsonHandler` handles any authenticated endpoint that receives either no body or a body with ContentType as `application/json` and responds with ContentType as `application/json`. |
| defaultDatabase | String | Domino REST API Database to use if there is no query parameter for "db" passed.                                                                                                                                                                                                    |
| package         | String | Package in which to find the WebHandlers for this version.                                                                                                                                                                                                                         |
| route           | String | URL path for all OpenAPI endpoints for this spec.                                                                                                                                                                                                                                  |

<!--
| filesBodyLimit  | int    | Maximum size of the body if including files. |
| jsonBodyLimit   | int    | Maximum size of the request body as JSON.|
-->

## BodyHandler parameters

| Property         | Type   | Description                                                                    |
| :--------------- | :----- | :----------------------------------------------------------------------------- |
| uploadsDirectory | String | Sets the uploads directory to use. Default value is `keep-file-uploads.d`      |
| bodyLimit        | int    | Sets the maximum body size in bytes. Setting the value to `-1` means no limit. |

## JWT parameters

| Property        | Type    | Description                                                                                                                                                                     |
| :-------------- | :------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| active          | Boolean | Set to `true` to load the JWT                                                                                                                                                   |
| providerURL     | String  | Base or full URI to the endpoint of the external JWT provider                                                                                                                   |
| algorithm / alg | String  | Signing algorithm being used                                                                                                                                                    |
| kid             | String  | Stands for _key ID_ and is a hint indicating which key was used to secure the JWS.                                                                                              |
| keyFile         | String  | Path to the JWT public key                                                                                                                                                      |
| iss             | String  | Identifies the principal that issued the JWT. The value is a case-sensitive string containing a string or URI value.                                                            |
| aud             | String  | Identifies the recipient that the JWT is intended for. When configuring Microsoft Entra ID, formerly Azure Active Directory, as an IdP, the value of this parameter is the Application ID URI you configured. |
| adminui | [JWT Admin UI parameters](#jwt-admin-ui-parameters) | Parameters for enabling this external IdP to use for Admin UI login. |
| ofba | [JWT OFBA parameters](#jwt-ofba-parameters) | Parameters for enabling this external IdP to use for OFBA. |

## JWT Admin UI parameters

| Property           | Type             | Description                                                                    |
|--------------------|------------------|--------------------------------------------------------------------------------|
| active             | Boolean          | Set to `true` to enable the use of external IdP in Admin UI login.             |
| client_id          | String           | External IdP client ID to use for Admin UI login.                              |
| application_id_uri | String           | An optional property. Required when external IdP is **Microsoft Entra ID, formerly Azure Active Directory**. End with a `/`. |

## JWT OFBA parameters

| Property           | Type             | Description                                                                    |
|--------------------|------------------|--------------------------------------------------------------------------------|
| active             | Boolean          | Set to `true` to enable the use of external IdP in OFBA.                       |
| client_id          | String           | External IdP client ID to use for OFBA.                                        |
| application_id_uri | String           | An optional property. Required when external IdP is **Microsoft Entra ID, formerly Azure Active Directory**. End with a `/`. |

## Remarks

### Named elements vs. arrays

All configuration entries are **named** entries and not arrays, since named entries can be merged in the configuration while arrays can only be overwritten.

### Deactivation of entries

The `config.json` in the Jar has the entry for the `setup` API as:

```json
    "versions": {
    "setup": {
            "path": "/schema/openapi.setup.json",
            "active": true
        }
    }
```

When you supply your own `some.json` in the `config.d` directory:

```json
    "versions": {
    "setup": {
            "active": false
        }
    }
```

the resulting configuration available to Domino REST API is:

```json
    "versions": {
    "setup": {
            "path": "/schema/openapi.setup.json",
            "active": false
        }
    }
```

In summary, the `setup` API isn't loaded. This is the mechanism to disable default components without having to update the Jar.

### Overwriting the values

All values can be [over written](https://vertx.io/docs/vertx-config/java/#_overloading_rules) by entries in the `keepconfig.d` located in your Notes/Domino Data directory. If this directory doesn't exist, create it. The structure needs to be the same as in the default file, but only needs the entries you want to change.

### Making excluded database files and directories available

`config.json` includes the following JSON object that defines the excluded NSF files and directories.

```json
"nsfExclusions": {
    "mail/": true,
    "KeepConfig.nsf": true,
    "KeepConfig.ntf": true,
    "KeepAgents.nsf": true,
    "KeepAgents.ntf": true,
    "KeepOAuth.ntf": true,
    "oauth.nsf": true,
    "names.nsf": true,
    "*.ntf": true,
    "help/": true,
    "as_": true,
    "MJ": true,
    "domino/": true
   }
```

To make an NSF file or directory, defined in the JSON object, available in the list of databases available when you define a schema in the **Admin UI**, see [Enable excluded database files and directories](../howto/database/excludeddb.md).
