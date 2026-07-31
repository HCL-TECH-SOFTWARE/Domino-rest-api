# Configure metrics

Metrics are exposed on a dedicated port specified by the configuration setting `METRICSPORT`. If this setting isn't defined, the default port used is `8890`. The Domino REST API exposes metrics produced by [MicroMeter](https://micrometer.io) in a [Prometheus](https://prometheus.io/) compatible format, which can be polled via this metrics port.

## About this task

The procedure guides you in configuring Domino REST API related to the exposure of metrics on the dedicated port.

## Before you begin

Check the [Metrics parameters](../../references/configuration/parameters.md#metrics-parameters) to learn and understand the parameters you can use in configuring Domino REST API to expose metrics.

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

3. Add metrics parameters in the JSON object as required to modify the configuration. See [Metrics parameters](../../references/configuration/parameters.md#metrics-parameters) for parameter details.

4. Save the JSON file in the `keepconfig.d` directory.

    !!! tip

        Use a filename for the JSON file that reveals its purpose. To learn more on how JSON files in `keepconfig.d` are processed, see [Configuration management and overlay hierarchy](../../references/configuration/understandingconfig.md).

5. Restart Domino REST API on all servers.

## Additional information

Out-of-the-box, Vert.x automatically collects various of metrics related to JVM, CPU, thread pools, HTTP servers, and the event bus. In addition to these standard Vert.x metrics, there are metrics specific to Domino REST API. Refer to the following table for the collected metrics and tags.

|Metric|Description|Tags|
|:---|:---|:---|
|`keep.unauthenticated.request.count`|Unauthenticated or badly authenticated requests counter| `className` (source class name)</br>`errorClassName` (error class name)|
|`keep.web.handler.requests.total`|API requests counter|`route` (such as `api.v1`, `api.admin.v1`)</br>`operationId` (such as `fetchjwt`)|
|`keep.database.handler.count`|Database-facing handlers requests counter|`className` (source class name)</br>`keepDatabase` (Domino REST API database queried)</br>`type` (requests type: application, basic auth, user token)|
|`keep.database.handler.errors.count`|Failing requests to database-facing handlers counter|`classname` (source class name)</br>`keepdatabase` (Domino REST API database queried)</br>`type` (requests type: application, basic auth, user token)|
|`keep.database.handler.duration`|Database-facing handler request duration timer|`className` (source class name)</br>`keepDatabase` (Domino REST API database queried)|
|`keep.application.requests.count`|Server-side application request counter|`className` (source class name)</br>`keepDatabase` (Domino REST API database queried)</br>`appId` (ID of the Domino REST API Application making the request)|
|`keep.database.handler.entries.count`|View entries requested counter|`className` (source class name)</br>`keepDatabase` (Domino REST API database queried)</br>`type` (requests type: application, basic auth, user token)|
