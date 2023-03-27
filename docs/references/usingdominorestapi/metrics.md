# Metrics

## Accessing metrics

Metrics are exposed on their own dedicated port, "METRICSPORT" in the config. The default, if not set, is port 8890.
Domino REST API supports metrics produced by [MicroMeter](https://micrometer.io) in a [Prometheus](https://prometheus.io/) compatible format, pollable from the metrics port.

### Metrics config

```json
{
  "enabled": true,
  "jvmMetricsEnabled": false
}
```

When **jvmMetricsEnabled** is set to true, more metrics data is collected and it will impact the performance.Don't configure this unless you need to troubleshoot.
{: .alert .alert-danger}

### Metrics collected

Out-of-the-box Vert.x automatically collects a variety of metrics about JVM, CPU, thread pools, HTTP servers and the event bus.

In addition to standard Vert.x metrics, there are metrics specific to Domino REST API. The following metrics and tags are collected:

- Counter of unauthenticated / badly authenticated requests (`keep.unauthenticated.request.count`). The tags are:

    - Source class name (className)
    - Error class name (errorClassName)

- Counter of API requests (`keep.web.handler.requests.total`). The tags are:

    - route (e.g. `api.v1`, `api.admin.v1`) and operationId (e.g. `fetchjwt`)

- Counter of requests to database-facing handlers (`keep.database.handler.count`). The tags are:

    - Source class name (className)
    - Domino REST API database queried (keepDatabase)
    - Requests type - application, basic auth, user token (type)

- Counter of erroring requests to database-facing handlers (`keep.database.handler.errors.count`). The tags are:

    - Source class name (className)
    - Domino REST API database queried (keepDatabase)
    - Requests type - application, basic auth, user token (type)

- Timer of database-facing handler requests (`keep.database.handler.duration`). The tags are:

    - Source class name (className)
    - Domino REST API database queried (keepDatabase)

- Counter of requests from server-side applications (`keep.application.requests.count`). The tags are:

    - Source class name (className)
    - Domino REST API database queried (keepDatabase)
    - ID of the Domino REST API Application making the request (appId)

- Counter of view entries requested (`keep.database.handler.entries.count`). The tags are:
  
    - Source class name (className)
    - Domino REST API database queried (keepDatabase)
    - Requests type - application, basic auth, user token (type)
