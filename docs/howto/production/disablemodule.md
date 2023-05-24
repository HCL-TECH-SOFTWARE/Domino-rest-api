# Disable and enable module in production
   If your specific configuration entry or references suggest that there are variables or function in the `config.json` file, you may be able to change them. 



## Procedure

1. Log in into the Management console (Port 8889). 
2. Open the `config.json` in `Config` button. The default configuration settings opens, [config.json](/docs/references/security/configjson.md).

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

      This is how the `active` value to the corresponding configuration entry is turned off or disabled.

 3. Copy the one where you need to change your `config.json` values in any text/code app such as vscode, notepad,notepad++ etc.

      You may edit the file according to your reference. False and true are the indicator for disable and enable.

4. Save the file in `.json` format inside the `keepconfig.d` directory.

   !!!note
      Use other names aside from `config.json`

5. Restart Domino REST API on all servers with this new configuration.



