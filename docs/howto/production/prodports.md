#  Configuring Ports in Production

By default the ports are set in Domino REST API as specified in the documentation [configuring ports](../../tutorial/installconfig/configuringPorts.md)  and there's no supported way to change them other than creating a configuration setting as specified in the [parameters](../../references/quickreference/parameters.md).


## Procedure:

1. Go to the `keepconfig.d` directory on your Domino Data directory. For linux `/local/notesdata/keepconfig.d` or on windows `C:\Program Files\HCL\Domino\Data\keepconfig.d` 
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
        "FIREHOSEPORT": 42424,
        "CalendarTemplateFileName": "mail12.ntf",
        "AllowJwtMail": true,
        "AllowLocalMailFile": true,
        "ServerDirectDBAccess": false,
        "createKeepDBfromTemplate": true,
        "singleDbMode": {
        "active": false
        },
    ``` 

4. Copy the one where you need to change a certain port in `config.json` values in any text/code app such as vscode, notepad,notepad++ etc, and save the file in `.json` format inside the `keepconfig.d` directory.
 

6. Restart Domino REST API on all servers with this new configuration.