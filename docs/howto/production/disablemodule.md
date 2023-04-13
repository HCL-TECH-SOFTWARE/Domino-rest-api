# Disable and enable module in production
   If your specific configuration entry or references suggest that there are variables or function in the `config.json` file, you may be able to change them. 



## Procedure

1. **Log in** into the Management console (Port 8889). 
2. **Go** to the `keepconfig.d` and open the `config.json`. The default configuration settings are here, [config.json](/docs/references/security/configjson.md).

   Example:
   config.json
    ```json
        {
        "verticles": {
           "Design": {
             "active": false
           }
        }
        }
     ```

   This is how the 'isActive' value to the corresponding configuration entry is turned off or disabled.

 3. **Create** text file and **paste** the resource code. You may edit the file according to your reference. False and true are the indicator for disable and enable.

 3. Click **Save** in a `.json` file format on `keepconfig.d`.
 4. **Restart** Domino REST API on all servers with this new configuration.



