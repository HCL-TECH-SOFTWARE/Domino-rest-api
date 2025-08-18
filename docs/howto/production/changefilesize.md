# Change file size limit

## About this task

The procedure guides you on how to change the file size limit in Domino REST API. The procedure addresses the *413 Request Entity Too Large* error when trying to POST an attachment to the Domino REST API. 

## Procedure

1.	Create a JSON file using a text editor.
2.	Copy the JSON object to the JSON file.

    ```json
    {
      "bodyHandler": {
        "uploadsDirectory": "keep-file-uploads.d",
        "bodyLimit": 10000000
      }
    }
    ```

3.	Change the value of the `bodyLimit` parameter to your preferred file size limit in bytes.
In the example, the file size limit is set to 128 MB. 

    ```json
    {
      "bodyHandler": {
        "uploadsDirectory": "keep-file-uploads.d",
        "bodyLimit": 128000000
      }
    }  
    ```

	!!!tip
        You can set the value of the bodyLimit parameter to `-1` to remove the file size limit. 

4.	Save the JSON file in the `keepconfig.d` directory.

    !!!tip
        Use a filename for the JSON file that reveals its purpose. To learn more on how JSON files in `keepconfig.d` are processed, see [Configuration management and overlay hierarchy](../../references/configuration/understandingconfig.md).

5.	Restart Domino REST API on all servers.
