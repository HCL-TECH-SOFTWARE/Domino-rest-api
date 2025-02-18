# Modify configuration parameters

## About this task

Domino REST API is preconfigured with settings that allow you to get started right away. This task guides you on how to modify the settings by modifying the configuration parameters.

## Before you begin

- You must have access to the **Management console** to see the preconfigured settings.

    !!! note

         - Make sure the **Management console** is secure. For more information, see [Functional Accounts](../../references/functionalUsers.md).
         - Credentials for the **Management console** aren't managed by the configured IdP, but are derived from the [configuration of functional accounts](../../references/functionalUsers.md).

- Check the [Configuration parameters](../../references/parameters.md) to learn more about the configurable parameters to modify the settings.

## Procedure

1. Log in to the **Management console** (Port 8889).

    ![Management console](../../assets/images/mngmntconsole.png)

2. Click **Config** to see the preconfigured settings.
3. Identify and copy the configuration parameter or JSON object that you need to modify to change the preconfigured settings.
4. Create a JSON file using a text editor and paste the copied configuration parameter or JSON object
to the JSON file.

    The following is an example of a JSON object related to Domino REST API's metrics endpoint.

    ```json
    {
      "metrics" : {
        "enabled" : true,
        "jvmMetricsEnabled" : false
       } 
    }
    ```

5. Modify the value of the parameter and save the JSON file in the `keepconfig.d` directory.

    The following example shows the JSON object after modifying the value of the `enabled` parameter to `false` to disable Domino REST API's `metrics` endpoint. In this example, the metrics endpoint is disabled when you don't want to take advantage of the [Prometheus](https://prometheus.io/) formatted runtime metrics by using a metric server, such as [Grafana](https://grafana.com/).

    ```json
    {
      "metrics" : {
         "enabled": false,
         "jvmMetricsEnabled": false
       }
    }
    ```

    !!! note "Naming your JSON files"

        The config loader processes JSON files in alphabetical order. So when you have conflicting entries, the last one wins. Use a name that reveals its purpose such as `disable-metrics.json`.

6. Restart Domino REST API on all servers.

## Additional information

### Understanding configuration

The configuration follows the concept of an [Overlay File System](https://en.wikipedia.org/wiki/OverlayFS). The base configuration is retrieved from the installation directory or `jar` files.

When jar files contain a resource `/config/config.json`, that configuration file is added to total configuration.

Then, it's overlaid with any JSON files in the `keepconfig.d` directory within the `notesdata` directory and then finally, with any environment parameters.

### Hierarchy

![The call hierarchy](../../assets/images/ActualConfiguration.png)

All files contribute JSON, which are overlaid on top of each other. JSON elements with same names get overwritten. Arrays are replaced and not overwritten.

The JSON files in `keepconfig.d` are processed in alphabetical order. Last entry wins. This processing order allows you, for example, to disable elements temporarily through settings in a `z-final-words.json` file without impacting the permanent configuration.
