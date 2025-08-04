# Configure metrics

Metrics are exposed on a dedicated port specified by the configuration setting `METRICSPORT`. If this setting isn't defined, the default port used is `8890`. The Domino REST API exposes metrics produced by [MicroMeter](https://micrometer.io) in a [Prometheus](https://prometheus.io/) compatible format, which can be polled via this metrics port.

## About this task

The procedure guides you in configuring Domino REST API related to the exposure of metrics on the dedicated port.

## Before you begin

Check the [Metrics parameters](../../references/parameters.md#metrics-parameters) to learn and understand the parameters you can use in configuring Domino REST API to expose metrics.

## Procedure

1. Create a JSON file using a text editor.
2. Add a JSON object to the JSON file.

    ```json
        {
        "metrics" : {
            "enabled" : true,
            "jvmMetricsEnabled" : false
            } 
        }
    ```

    !!! note

        - Enabling `jvmMetricsEnabled` by setting it to `true` increases the volume of collected metrics data and may impact system performance. Only enable this option when troubleshooting is necessary.
        - Changing `enabled` to `false` prevents exposure of metrics on the dedicated port.

3. Add metrics parameters in the JSON object as required to modify the configuration. See [Metrics parameters](../../references/parameters.md#metrics-parameters) for parameter details.

4. Save the JSON file in the `keepconfig.d` directory.

    !!! tip

        Use a filename for the JSON file that reveals its purpose. To learn more on how JSON files in `keepconfig.d` are processed, see [Understanding configuration](configparam.md#understanding-configuration).

5. Restart Domino REST API on all servers.

## Additional information

### Collected metrics

Out-of-the-box, Vert.x automatically collects various of metrics related to JVM, CPU, thread pools, HTTP servers, and the event bus.

In addition to these standard Vert.x metrics, there are metrics specific to Domino REST API. The following metrics and tags are collected:

- Unauthenticated or badly authenticated requests counter (`keep.unauthenticated.request.count`)

    Tags:

    - `className` (source class name)
    - `errorClassName` (error class name)

- API requests counter (`keep.web.handler.requests.total`)

    Tags:

    - `route` (such as `api.v1`, `api.admin.v1`) 
    - `operationId` (such as `fetchjwt`)

- Database-facing handlers requests counter (`keep.database.handler.count`)

    Tags:

    - `className` (source class name)
    - `keepDatabase` (Domino REST API database queried)
    - `type` (requests type: application, basic auth, user token)

- Erroring requests to database-facing handlers counter (`keep.database.handler.errors.count`) 

    Tags:

    - `classname` (source class name)
    - `keepdatabase` (Domino REST API database queried)
    - `type` (requests type: application, basic auth, user token)

- Database-facing handler request duration timer (`keep.database.handler.duration`). 

    Tags:

    - `className` (source class name)
    - `keepDatabase` (Domino REST API database queried)

- Server-side application request counter (`keep.application.requests.count`)

    Tags:

    - `className` (source class name)
    - `keepDatabase` (Domino REST API database queried)
    - `appId` (ID of the Domino REST API Application making the request)

- View entries requested cpunter (`keep.database.handler.entries.count`) 

    Tags:
  
    - `className` (source class name)
    - `keepDatabase` (Domino REST API database queried)
    - `type` (requests type: application, basic auth, user token)
