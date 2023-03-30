# Configuration parameters

To be able to securely and efficiently deploy Domino REST API into a production environment, you must understand how Domino REST API configuration works. See the [configurating section](/docs/references/security/securityindex.md) for a deeper dive.

## Understanding configuration
The configuration follows the concept of an Overlay File System. The base configuration is retrieved from the installation directory or jar files.

When jar files contain a resource /config/config.json, that configuration file is added to total configuration

Then, it's overlaid with any JSON files in the keepconfig.d directory within the Notes data directory and then finally, with any environment parameters.

## Procedure

1. **Log in** into the Management console (Port 8889).

2. **Open** the keepconfig.d.

    Examples of the default security settings are here, [security.json ](/docs/references/security/securityjson.md) and the default configuration settings are here, [config.json](/docs/references/security/securityjson.md). Whenever you do a new Domino REST API install, these two files and the projectkeep.jar file are overwritten.

    Our recommendation is to keep your configuration changes in the config.d directory so that they persist when you reinstall or update your Domino REST API version.

3. **Modify** your configuration parameters according to your reference and click **Save** as a .json format.

    !!! Notes "Overwriting the values"
        All values can be over written by entries in the keepconfig.d directory. The structure needs to be the same as in the default file, but only needs the entries you want to change.

Hierarchy

![The call hierarchy](../../assets/images/ActualConfiguration.png)

All files contribute JSON, which are overlaid on top of each other. JSON elements with same names get overwritten. Arrays are replaced and not overwritten.

The JSON files in keepconfig.d are processed in alphabetical order. Last entry wins. This processing order allows you, for example, to disable elements temporarily through settings in a z-final-words.json file without impacting the permanent configuration.
