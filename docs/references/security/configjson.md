# config.json

--8<-- "keepmngtURLcaution1.md"

Domino REST API reads all config.json from Domino REST API core and deployed extensions. Below is a sample JSON representation of the resource:

```json
{
  "PORT": 8880,
  "MANAGMENTPORT": 8889,
  "METRICSPORT": 8890,
  "HEALTHCHECKPORT": 8886,
  "FIREHOSEPORT": 42424,
  "CalendarTemplateFileName": "mail12.ntf",
  "AllowJwtMail": true,
  "AllowLocalMailFile": true,
  "ServerDirectDBAccess": false,
  "createKeepDBfromTemplate": true,
  "singleDbMode": {
    "active": false
  },
  "oauth": {
    "active": true,
    "database": "oauth.nsf",
    "url": "http://localhost:8880",
    "authCodeExpiresIn": 120,
    "accessTokenExpiresIn": 3600,
    "refreshTokenExpiresIn": 525600
  },
  "keepVersion": 1,
  "dropMethodsWithMissingVersions": true,
  "versions": {
    "basis": {
      "path": "/schema/openapi.basis.json",
      "active": true
    },
    "setup": {
      "path": "/schema/openapi.setup.json",
      "active": true
    },
    "admin": {
      "path": "/schema/openapi.admin.json",
      "active": true
    }
  },
  "bodyHandler": {
    "uploadsDirectory": "keep-file-uploads.d",
    "bodyLimit": 10000000
  },
  "verticles": {
    "Design": {
      "worker": true,
      "className": "com.hcl.domino.keep.verticles.DominoDefaultVerticle",
      "tags": {
        "design": "com.hcl.domino.keep.dbrequests.designcode",
        "code": "com.hcl.domino.keep.dbrequests.designcode",
        "schema": "com.hcl.domino.keep.dbrequests.schema"
      },
      "threadPoolName": "codeThreads",
      "active": true
    },
    "Data": {
      "worker": true,
      "className": "com.hcl.domino.keep.verticles.DominoDefaultVerticle",
      "tags": {
        "data": "com.hcl.domino.keep.dbrequests.data",
        "scope": "com.hcl.domino.keep.dbrequests.scope"
      },
      "threadPoolName": "dataThreads",
      "active": true
    },
    "OData": {
      "worker": true,
      "className": "com.hcl.domino.keep.verticles.DominoDefaultVerticle",
      "tags": {
        "odata": "com.hcl.domino.keep.dbrequests.odata"
      },
      "threadPoolName": "odataThreads",
      "active": true
    },
    "Identity": {
      "worker": false,
      "className": "com.hcl.domino.keep.verticles.DominoDefaultVerticle",
      "tags": {
        "authentication": "com.hcl.domino.keep.dbrequests.identity"
      },
      "active": true
    },
    "KeepOAuth": {
      "worker": false,
      "className": "com.hcl.domino.keep.verticles.DominoOAuthVerticle",
      "messages": {
        "keep.oauth.getAccessToken": "com.hcl.domino.keep.dbrequests.oauth.GetAccessToken",
        "keep.oauth.createAuthorization": "com.hcl.domino.keep.dbrequests.oauth.CreateAuthorization"
      },
      "active": true
    },
    "KeepAdmin": {
      "worker": false,
      "className": "com.hcl.domino.keep.verticles.DominoDefaultVerticle",
      "tags": {
        "admin": "com.hcl.domino.keep.dbrequests.keepadmin"
      },
      "active": true
    },
    "AdminAccess": {
      "worker": false,
      "className": "com.hcl.domino.keep.verticles.DominoDefaultVerticle",
      "tags": {
        "admin-database": "com.hcl.domino.keep.dbrequests.admin",
        "admin-user": "com.hcl.domino.keep.dbrequests.admin",
        "directory-assistance": "com.hcl.domino.keep.dbrequests.admin",
        "admin-tls": "com.hcl.domino.keep.dbrequests.admin",
        "saml": "com.hcl.domino.keep.dbrequests.admin",
        "smtp": "com.hcl.domino.keep.dbrequests.admin"
      },
      "active": true
    },
    "RestAPI": {
      "className": "com.hcl.domino.keep.verticles.HttpListener",
      "worker": false,
      "instances": 1,
      "versions": {
        "basis": {
          "package": "com.hcl.domino.keep.handlers.core",
          "route": "/api/v1",
          "defaultClass": "com.hcl.domino.keep.handlers.core.DefaultJsonHandler",
          "defaultDatabase": "keepconfig"
        },
        "setup": {
          "package": "com.hcl.domino.keep.handlers.core",
          "route": "/api/setup-v1",
          "defaultClass": "com.hcl.domino.keep.handlers.core.DefaultJsonHandler",
          "defaultDatabase": "keepconfig"
        },
        "admin": {
          "package": "com.hcl.domino.keep.handlers.admin",
          "route": "/api/admin-v1",
          "defaultClass": "com.hcl.domino.keep.handlers.core.DefaultJsonHandler",
          "defaultDatabase": "names"
        }
      },
      "active": true
    },
    "AsyncAgentScheduler": {
      "worker": true,
      "className": "com.hcl.domino.keep.verticles.AgentSchedulerServiceVerticle",
      "active": true,
      "threadPoolName": "AgentScheduler",
      "threads": 10,
      "agentDefaultMaxDurationSeconds": 3600,
      "logFrequencyMs": 30000
    }
  },
  "cache": {
    "KeepRequest": "off",
    "NameLookup": "Java",
    "JWTLogout": "Java"
  },
  "webapps": {
    "active": true,
    "appRoot": "/keepweb",
    "appSource": "keepweb.d"
  },
  "vertx": {},
  "prometheusMetrics": {
    "endpoint": "/metrics",
    "enabled": true,
    "publishQuantiles": true
  },
  "metrics": {
    "enabled": true,
    "jvmMetricsEnabled": false
  }
}
```
{: .resize-config-json}

## Properties

A current `config.json` has the following top-level properties. These properties are case-sensitive.

| Property | Type | Description |
| :---- | :---- | :---- |
| MANAGEMENTPORT           | int (0 to 65353)                               | (default 8889) Commands regarding the runtime, such as config and shutdown, should only be exposed to an admin network workstation.                      |
| METRICSPORT              | int (0 to 65353)                               | (default 8890) Port for Prometheus metrics.                                                                                                           |
| Firehoseport             | int (0 to 65353)                               | (default 42424) Port for Firehose to successfully deliver data to custom HTTP endpoints.                                                              |
| PORT                     | int (0 to 65353)                               | (default 8880) The port for regular API access.                                                                                                       |
| prometheusMetrics        | [prometheusParameters](#prometheus-parameters) | Parameters to hand over to the Prometheus task from vert.x.                                                                                           |
| versions                 | [versionParameters](#version-parameters)       | List of the OpenAPI definition files to load.                                                                                                         |
| verticles                | [verticlesParameters](#restapi-verticle)       | The verticles to load.                                                                                                                                |
| vertx                    | [vertxParameters](#vertx-parameters)           | Parameters to hand to the start of vert.x, see [the vert.x documentation](https://vertx.io/docs/apidocs/io/vertx/core/VertxOptions.html) for details. |
| ServerDirectDBAccess     | Boolean                                        | True to allow Direct Database access for server.                                                                                                      |
| createKeepDBfromTemplate | Boolean                                        | True to allow create Domino REST API Database from template.                                                                                          |
| AllowJwtMail             | Boolean                                        | True to allow email to be sent via a JWT token.                                                                                                       |
| AllowLocalMailFile       | Boolean                                        | True to allow local mail file.                                                                                                                        |
|⁠showDeprecatedEndpoints|Boolean|True to allow access to deprecated endpoints / APIs|
|⁠showPreviewFeatures|Boolean|True to allow preview access to new features, endpoints, or APIs|

## Prometheus Parameters

| Property         | Type    | Description                        |
| :--------------- | :------ | :--------------------------------- |
| Endpoint         | String  | Route path to metrics.             |
| enabled          | Boolean | true to enable metrics collection. |
| publishQuantiles | Boolean | true to publish Quantiles.         |

## Version parameters

Versions has a named list of entries with two parameters:

|Property|Type|Description|
| :------- | :------ | :------ |
| path     | String  | Path used by [`getResourceAsStream`](https://docs.oracle.com/javase/8/docs/api/java/lang/Class.html#getResourceAsStream-java.lang.String-) to load an OpenAPI specification file. |
| active   | Boolean | Whether the spec is loaded.|

The name of the entries must match the name used in versions of the RestAPI verticle, see [below](#restapi-verticle).

## Vert.x parameters

| Property | Type | Description |
| :---- | :---- | :---- |
| metric   | [metricsParameters](https://vertx.io/docs/vertx-micrometer-metrics/java/) | Parameter for vert.x metrics. |
|bodyHandler |[Interface BodyHandler](https://vertx.io/docs/apidocs/io/vertx/ext/web/handler/BodyHandler.html)| Handles HTTP file uploads and used to limit body sizes|

### Metrics parameters

Here is a JSON representation of the resource:

```json
{
  "enabled": true,
  "jvmMetricsEnabled": true,
  "metricuser": "metrics"
}
```

| Property | Type | Description |
| :------ | :------ | :------ |
| disabledMetricsCategories | Array of Strings | Specified in the [MetricsDomain Java class](https://github.com/vert-x3/vertx-micrometer-metrics/blob/master/src/main/java/io/vertx/micrometer/MetricsDomain.java), such as `vertx.http.server.`. |
| enabled                   | Boolean          | Whether metrics are enabled on the Vert.x instance.                                                                                                                                           |
| jvmMetricsEnabled         | Boolean          | Whether JVM metrics are collected.                                                                                                                                                            |
| labels                    | Array of Strings | List of labels to enable / disable.                                                                                                                                                           |
| labelMatches              | Array of Match   | List of rules for label matching.                                                                                                                                                             |
| registryName              | String           | Name for the metrics registry, so that a new registry is created and associated with this name. Leave blank for default.                                                                      |

### BodyHandler parameters

|Property|Type|Description|
|:----|:----|:----|
|uploadsDirectory|String|Sets the uploads directory to use. Default value is `keep-file-uploads.d`|
|bodyLimit|int|Sets the maximum body size in bytes. Setting the value to `-1` means no limit.|


## Verticle parameters

Verticles define a separate unit of work for particular tags. For the RestAPI verticle, see [below](#restapi-verticle). The rest have a standard set of parameters:

| Property | Type | Description |
| :------ | :------ | :------- |
| active  | Boolean | Whether to load this verticle. |
| className | String  | Class to use for the verticle. Typically this is `com.hcl.domino.keep.verticles.DominoDefaultVerticle`, unless you need to extend that class. |
| tags | Object  | Tags from OpenAPI specs to allocate to this verticle and the package in which to find the NSFHandlers. |
| instances      | int     | Relevant only for RestAPI verticle, loads multiple instances that each use a thread pool. You will need to be aware of the number of cores available and scalability, see the [Vert.x documentation](https://vertx.io/docs/vertx-core/java/#_specifying_number_of_verticle_instances). |
| threadPoolName | String  | If a worker verticle should use a dedicated pool, a required thread pool name. By default it's assigned 10 threads, but this can be overwritten with threadPoolSize. If the same threadPoolName is used by multiple verticles, the thread pool is shared across those verticles.       |
| threads        | int     | This will only be used for worker threads with a specific threadPoolName. The default is 10, but this can be overwritten.                                                                                                                                                               |
| worker         | Boolean | To make this a [worker verticle](https://medium.com/@levon_t/java-vert-x-starter-guide-part-2-worker-verticles-c49866df44ab). Worker verticles don't run on the event loop thread, but on worker threads from a preconfigured pool of 20 threads. Use for heavy-duty verticles.       |

The following are types of verticles with additional parameters:

### AsyncAgentScheduler verticle

This is the verticle for running async agents - calls to "/run/agent" with "async" set to true in the payload. In the Notes client you can look at KeepAgents.nsf for the asynchronous agents that are running or have run. This properties for this verticle include the [above](#vertical-parameters), plus these:

| Property                       | Type | Description                                                                                                        |
| :----------------------------- | :--- | :----------------------------------------------------------------------------------------------------------------- |
| agentDefaultMaxDurationSeconds | int  | Timeout for asynchronous agents, in seconds. A value of -1 allows all agents to run to completion without timeout. |
| logFrequencyMs                 | int  | Frequency to log messages of running async agents to the console.                                                  |

### RestAPI verticle

This is the verticle for managing WebHandlers. `worker`, `threadPoolName`, `threadPoolSize`, `className` and `active` parameters are as for the other verticles. This verticle also has a `versions` parameter. This maps to the top-level "versions" parameter and has the following properties:

| Property        | Type   | Description                                                                                                                                                                                                                                                                        |
| :-------------- | :----- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| defaultClass    | String | Class to use for the WebHandler if no class is defined. `com.hcl.domino.keep.handlers.v1.DefaultJsonHandler` handles any authenticated endpoint that receives either no body or a body with ContentType as "application/json" and responds with ContentType as "application/json". |
| defaultDatabase | String | Domino REST API Database to use if there is no query parameter for "db" passed.                                                                                                                                                                                                    |
| filesBodyLimit  | int    | Maximum size of the body if including files. For PIM and POI                                                                                                                                                                                                                                      |
| jsonBodyLimit   | int    | Maximum size of the request body as JSON. For PIM and POI                                                                                                                                                                                                                                        |
| package         | String | Package in which to find the WebHandlers for this version.                                                                                                                                                                                                                         |
| route           | String | URL path for all OpenAPI endpoints for this spec.                                                                                                                                                                                                                                  |

## Remarks

### Named elements vs arrays

All configuration entries are **named** entries and not arrays since named entries can be merged in the configuration while arrays can only be overwritten.

### Deactivation of entries

The `config.json` in the Jar has the entry:

```json
"versions": {
    "v1": {
            "path": "/schema/openapi.v1.json",
            "active": true
        }
}
```

When you supply your own `some.json` in the `config.d` directory:

```json
"versions": {
    "v1": {
            "active": false
        }
}
```

the resulting configuration available to Domino REST API is:

```json
"versions": {
    "v1": {
            "path": "/schema/openapi.v1.json",
            "active": false
        }
}
```

In summary, the `v1` isn't loaded. This is the mechanism to disable default components without packing the Jar apart.

### Overwriting the values

All values can be [over written](https://vertx.io/docs/vertx-config/java/#_overloading_rules) by entries in the `keepconfig.d` directory. The structure needs to be the same as in the default file, but only needs the entries you want to change.

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

To make an NSF file or directory, defined in the JSON object, available in the list of databases available when you define a schema in the **Admin UI**, see [Enable excluded database files and directories](../../howto/database/excludeddb.md).
