# Modify configuration of Domino REST API

## About this task

The procedure guides you on how to modify the Domino REST API configuration. Be sure to check the [detailed explanation before proceeding](../../references/parameters.md#remarks).

## Procedure

1. Identify the configuration entries that you want to modify.

    !!!tip
        To check Domino REST API settings, see [Check Domino REST API settings](../management/checksettings.md).

2. Create a JSON file and include the configuration entries that you want to modify with the new values.

    !!!note
        The structure of the configuration entries must be the same as in the config.json file. Only include entries that you want to modify in the JSON file.

3. Save the created JSON file in `keepconfig.d`. You can use any filename for the JSON file.

    !!!note
        For more information on modifying the configuration, see [Overwriting the values](../../references/parameters.md#overwriting-the-values).

4. Restart Domino REST API on all servers with this new configuration.

## Expected result

The updated configuration takes effect the next time you start Domino REST API.

## Example

In this example, the configuration of **enabledProtocols** is altered by disabling TLSv1.2 and enabling TLSv1.3.

Default configuration:

```json
{
  /* Lots of JSON here */
  "enabledProtocols": {
    "TLSv1.3": false,
    "TLSv1.2": true
  }
  /* more JSON here */
}
```

Entry in created JSON file to "swap protocols".

```json
{
  "enabledProtocols": {
    "TLSv1.3": true,
    "TLSv1.2": false
  }
}
```

!!!tip "Pick a good name"

    Don't call your files `mod1.json`, `mod2.json` etc.

    Use a name that clearly indicates its purpose. e.g. `min-tls-v1.3.json`
