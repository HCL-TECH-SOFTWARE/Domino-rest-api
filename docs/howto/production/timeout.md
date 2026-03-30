# Change timeout for retrieving data from Domino

## About this task

The procedure guides you on how to change the timeout for retrieving data from Domino to give long-running operations, such as complex DQL queries, more time to complete before timing out.

## Procedure

1. Create a JSON file using a text editor.
2. Copy the JSON object to the JSON file.

    ```json
    {
        "httpIdleTimeOut": [timeout value in seconds]
    }
    ```

3. Change the value of the `httpIdleTimeOut` parameter to your preferred timeout value in seconds.
In the example, the timeout is set to 300 seconds or 5 minutes.

    ```json
    {
        "httpIdleTimeOut" : 300
    }
    ```

4. Save the JSON file in the `keepconfig.d` directory.

    !!! tip

        Use a filename for the JSON file that reveals its purpose. To learn more on how JSON files in `keepconfig.d` are processed, see [Configuration management and overlay hierarchy](../../references/configuration/understandingconfig.md).

5. Restart Domino REST API on all servers.
