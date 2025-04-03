# Configure ports in production

By default the ports are set in Domino REST API as specified in the documentation [configuring ports](../../tutorial/installconfig/configuringPorts.md)  and there's no supported way to change them other than creating a configuration setting as specified in the [parameters](../../references/parameters.md).

## Procedure

1. Go to the `keepconfig.d` directory on your Domino Data directory. 
    - on Linux `/local/notesdata/keepconfig.d` 
    - on Windows `C:\Program Files\HCL\Domino\Data\keepconfig.d`
2. The default configuration is stored in a `config.json`. 
    You may know that someone change the configuration if there are other `.json` files in the `config.json`. For example, `sample.json`.
3. Open each `.json` file and see if the ports are being changed. To know that there are changes, the following settings are modified. See [configuring port](../../tutorial/installconfig/configuringPorts.md) for more details.

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
