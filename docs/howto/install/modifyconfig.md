# Modify configuration of Domino REST API 

## About this task

The procedure guides you on how to modify the Domino REST API configuration.

## Procedure

1. Identify the configuration entries that you want to modify.

    !!!tip
        To check Domino REST API settings, see [Check Domino REST API settings](checksettings.md).

2. Create a JSON file and include the configuration entries that you want to modify with the new values.

    !!!note
       The structure of the configuration entries must be the same as in the config.json file. Only include entries that you want to modify in the JSON file.

3. Save the created JSON file in `keepconfig.d`. You can use any file name for the JSON file. 

## Expected result

The updated configuration takes effect the next time you start Domino REST API.

## Example

In this example, the configuration of “dominoProxy” is enabled and its idle timeout is changed.

Default configuration:   

```json
“dominoProxy”: {
	“dominoProxyEnabled”: false,
	“dominoEnabledTLS”: false,
	“dominoHost”: “localhost”,
	“dominoPort”: 80,
    “dominoProxyVerifyHost”: false,
    “dominoProxyTrustAll”: true,
    “dominoProxyKeepAlive”: true,
    “dominoProxyConnectionTimeout”: 10000,
    “dominoProxyIdleTimeout”: 200,
    “dominoProxyMaxWaitQueueSize”: 10
}
```

Entry in created JSON file to enable "dominoProxy" and update idle timeout. 

```json
“dominoProxy”: {
	“dominoProxyEnabled”: true,
    “dominoProxyIdleTimeout”: 400
}
```