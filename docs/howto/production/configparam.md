# Configuration parameters

Domino REST API is preconfigured with settings that allow you to get started right away. However, you should familiarize yourself with all configuration parameters and security settings before you deploy into a production environment.

## Procedure

1. Log in into the Management console (Port 8889).

   Make sure that the administration location can only be accessed from a network that can be accessed by a your system administrator.

2. Click the `Config` button. The actual configuration settings opens. The default configuration is in [config.json](/docs/references/quickreference/parameters.md).

3. Only copy the KEEP configuration where you need to change your `config.json` values in any text/code app such as vscode, notepad, notepad++ etc.

   Example:

   When you don't take advantage of the [Prometheus](https://prometheus.io/) formatted runtime metrics by using a metric server (e.g. [Grafana](https://grafana.com/) ), you can and should disable KEEP's metrics endpoint.

   ```json
     "metrics": {
       "enabled": false,
       "jvmMetricsEnabled": false
       }
   ```

4. Save the file in `.json` format inside the `keepconfig.d` directory.

   !!!note "Naming your json files"
   The config loader processes json files in aphabetical order, so when you have conflicting entries, the last one wins. Use a name that reveals its purpose. e.g. disable-metrics.json

5. Restart Domino REST API on all servers with this new configuration.

## Understanding configuration

The configuration follows the concept of an [Overlay File System](https://en.wikipedia.org/wiki/OverlayFS). The base configuration is retrieved from the installation directory or `jar` files.

When jar files contain a resource `/config/config.json`, that configuration file is added to total configuration.

Then, it's overlaid with any JSON files in the `keepconfig.d` directory within the Notes data directory and then finally, with any environment parameters.

### Hierarchy

![The call hierarchy](../../assets/images/ActualConfiguration.png)

All files contribute JSON, which are overlaid on top of each other. JSON elements with same names get overwritten. Arrays are replaced and not overwritten.

The JSON files in `keepconfig.d` are processed in alphabetical order. Last entry wins. This processing order allows you, for example, to disable elements temporarily through settings in a `z-final-words.json` file without impacting the permanent configuration.
