# Configure `computeTotalCount` query parameter

## About this task

The procedure guides you on how to modify the default value of the `computeTotalCount` query parameter of the `GET v1/lists/{name}` endpoint in a configuration file in `keepconfig.d`.

The `computeTotalCount` query parameter, which controls whether to compute the x-total-count header and return it with the result, is set to `true` by default. Setting it to `false` significantly improves processing time by avoiding the computation of the x-total-count header and its subsequent return with the result.

## Procedure

1. Create a JSON file using a text editor.
2. Copy the JSON object to the JSON file.

    ```json
    {
        "views": { "computeTotalCount": false }
    }
    ```

3. Save the JSON file in the `keepconfig.d` directory.

    !!! tip

        Use a filename for the JSON file that reveals its purpose. To learn more on how JSON files in `keepconfig.d` are processed, see [Configuration management and overlay hierarchy](../../references/configuration/understandingconfig.md).

4. Restart Domino REST API on all servers.
