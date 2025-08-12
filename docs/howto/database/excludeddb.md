# Enable excluded database files and directories

## About this task

The list of databases available when you define a schema in the **Admin UI** is based on the complete list of NSF files, except for the excluded NSF files and NSF files in the excluded directories defined in the following JSON object in `config.json`:

```json
{
  "nsfExclusions": {
    "mail/": true,
    "KeepConfig.nsf": true,
    "KeepConfig.ntf": true,
    "KeepAgents.nsf": true,
    "KeepAgents.ntf": true,
    "KeepOAuth.ntf": true,
    "oauth.nsf": true,
    "names.nsf": true,
    "*.ntf": true,
    "help/": true,
    "as_": true,
    "MJ": true,
    "domino/": true
  }
}
```

The procedure guides you on how to include the excluded NSF files and NSF files in excluded directories in the list of databases available when you define a schema.

## Procedure

1. Create a JSON file using a text editor.
2. Copy the complete JSON object to the JSON file.

    ```json
    {
      "nsfExclusions": {
        "mail/": true,
        "KeepConfig.nsf": true,
        "KeepConfig.ntf": true,
        "KeepAgents.nsf": true,
        "KeepAgents.ntf": true,
        "KeepOAuth.ntf": true,
        "oauth.nsf": true,
        "names.nsf": true,
        "*.ntf": true,
        "help/": true,
        "as_": true,
        "MJ": true,
        "domino/": true
      }
    }
    ```

3. Set the value of the file or directory that you want to enable to `false`.

    For example, if you want to include `names.nsf` in the list of databases available when you define a schema in the **Admin UI**, set its value to `false`.

    ```json
    {
      "nsfExclusions": {
        "mail/": true,
        "KeepConfig.nsf": true,
        "KeepConfig.ntf": true,
        "KeepAgents.nsf": true,
        "KeepAgents.ntf": true,
        "KeepOAuth.ntf": true,
        "oauth.nsf": true,
        "names.nsf": false,
        "*.ntf": true,
        "help/": true,
        "as_": true,
        "MJ": true,
        "domino/": true
      }
    }
    ```

4. Save the JSON file in the `keepconfig.d` directory.

    !!! tip

        Use a filename for the JSON file that reveals its purpose, such as `enable-names-nsf.json`. To learn more on how JSON files in `keepconfig.d` are processed, see [configuration sources and overlay process](../../references/configuration/understandingconfig.md#configuration-sources-and-overlay-process).

5. Restart Domino REST API on all servers.
