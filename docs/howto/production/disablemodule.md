# Disable and enable module in production

If your specific configuration entry or references suggest that there are variables or function in the `config.json` file, you may be able to change them.

## Procedure

1. Log in into the Management console (Port 8889).
2. Click the `Config` button. The actual configuration settings opens. The default configuration is this: [config.json](../../references/parameters.md).

    **Example**:

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

3. Copy the KEEP configuration where you need to change your `config.json` values in any text/code editor app such as VSCode, Notepad, Notepad++ etc.

    You may edit the file according to your reference. False and true are the indicator for disable and enable.

4. Save the file in `.json` format inside the `keepconfig.d` directory.

    !!!note "Naming your json files"
        The config loader processes json files in alphabetical order, so when you have conflicting entries, the last one wins. Use a name that reveals its purpose such as `inactive-design.json`.

5. Restart Domino REST API on all servers with this new configuration.
