# Configure ports in production

Domino REST API uses ports which have different purposes. Each of these ports have a default port number. For example, the main API port has a default port number of 8880 and the port for Prometheus metrics has a default port number of 8890.

## About this task

The procedure guides you on how to create a new configuration setting to change the default port number of the ports.

## Before you begin

Check the [configuration parameters](../../references/configuration/parameters.md) to learn the parameters and allowed port numbers to use in the new configuration setting.

## Procedure

1. Create a JSON file using a text editor.
2. Add a JSON object to the JSON file. The JSON object includes the parameter corresponding to the port to be configured and the new port number.

    For example:

    ```json
    {
    "PORT": 8857,
    "MANAGEMENTPORT": 9000
    }
    ```

    The example JSON object will change the port number of the main API port from 8880, which is the default, to 8857. The example will also change the port number of the port for accessing the Management Console from 8889, which is the default, to 9000.

3. Save the JSON file in the `keepconfig.d` directory.

    !!! tip

        Use a filename for the JSON file that reveals its purpose. To learn more on how JSON files in `keepconfig.d` are processed, see [Understanding configuration](../production/configparam.md#understanding-configuration).

4. Restart Domino REST API on all servers.

<!--By default, the [ports](../../topicguides/configuringPorts.md) are set in Domino REST API and there's no supported way to change them other than creating a new configuration setting as specified in the [parameters](../../references/configuration/parameters.md).

## Procedure

1. Go to the `keepconfig.d` directory on your Domino Data directory.
    - on Linux `/local/notesdata/keepconfig.d` 
    - on Windows `C:\Program Files\HCL\Domino\Data\keepconfig.d`
2. The default configuration is stored in a `config.json`. 
    You may know that someone change the configuration if there are other `.json` files in the `config.json`. For example, `sample.json`.
3. Open each `.json` file and see if the ports are being changed. To know that there are changes, the following settings are modified.

    - "PORT" for the main API port
    - "MANAGMENTPORT" for the Management page port
    - "METRICSPORT" for the Metrics port
    - "HEALTHCHECKPORT" for the Health Check port

    ```json    
        {
        "PORT": 8857,
        "MANAGMENTPORT": 8889,
        "METRICSPORT": 8890,
        "HEALTHCHECKPORT": 8886,
        "FIREHOSEPORT": 42424
        }
    ``` 

4. Copy the function where you need to change a certain port in `config.json` values in any text/code app such as VSCode, Notepad, Notepad++ etc, and save the file in `.json` format inside the `keepconfig.d` directory.

    !!! note "Naming your json files"

        The config loader processes json files in alphabetical order, so when you have conflicting entries, the last one wins. Use a name that reveals its purpose such as `management-port.json`.

5. Restart Domino REST API on all servers with this new configuration.
-->