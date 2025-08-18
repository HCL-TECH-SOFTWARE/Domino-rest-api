# Disable and enable module in production

## About this task

Guides you in enabling or disabling modules in your Domino REST API configuration.

<!--If your specific configuration entry or references suggest that there are variables or function in the `config.json` file, you may be able to change them.-->

## Before you begin

- You must have access to the **Management console**.

!!! note

    - Make sure the **Management console** is secure. For more information, see [Functional Accounts](../../references/functionalUsers.md).
    - Credentials for the **Management console** aren't managed by the configured IdP, but are derived from the [configuration of functional accounts](../../references/functionalUsers.md).

- Check the [Configuration parameters](../../references/configuration/parameters.md) to learn more about the configurable parameters to modify the settings.

## Procedure

1. Log in to the **Management console** (Port 8889).
2. Click **Config**. The actual configuration settings open.
3. Identify and copy the configuration parameter or JSON object of the module in the configuration that you need to enable or disable.
4. Create a JSON file using a text editor and paste the copied configuration parameter or JSON object
to the JSON file.

    **Example**:

    The following is a JSON object in the configuration related to the Design verticles that's currently not enabled.

    ```json
    {
      "verticles": {
        "Design": {
          "active": false
        }
      }
    }
    ```

5. Change the value of the `active` parameter to `true` or `false` based on whether you want to enable or disable the module in the configuration.

    **Example**:

    The following is a JSON object in the configuration related to the Design verticles that has been modified to be enabled by setting the value of the `active` parameter to `true`.

    ```json
    {
      "verticles": {
        "Design": {
          "active": true
        }
      }
    }
    ```

6. Save the JSON file in the `keepconfig.d` directory.

    !!! note "Naming your JSON file"

        The config loader processes json files in alphabetical order, so when you have conflicting entries, the last one wins. Use a name that reveals its purpose such as `inactive-design.json`.

7. Restart Domino REST API on all servers.
