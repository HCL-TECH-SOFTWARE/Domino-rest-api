# Customize accessible API schemas and endpoints

## About this task

Guides you on how to customize which API schemas and endpoints will be accessible or visible to meet your specific requirements or use cases. 

## Before you begin

## Procedure

### Customize accessible API schemas

This procedure enables you to make API schemas inaccessble and not visible to end users. 

1. Create a JSON file using a text editor.
2. Add the `versions` JSON object with the entry name of the API schema you want to customize and the `active` property.

    ``` json
    {
        "versions" : {
            "entry name" : {
                "active" : true
            }
        }

    }
    ```

    Refer to the table for the entry name of the API schema:

    |entry name|API schema|
    |:---|:---|
    |basis|HCL Domino REST API basis 1.3.0|
    |setup|HCL Domino REST API setup 1.1.3|
    |admin|HCL Domino REST API admin 1.0.2|
    |admin-server|HCL Domino REST API admin-server 1.0.2|
    |poi|HCL Domino REST API poi 1.0.3|
    |pim|HCL Domino REST API pim 1.0.2|

4.	Set the value of the `active` property to `false` to make the API schema inaccessible.

    ``` json
    {
        "versions" : {
            "entry name" : {
                "active" : false
            }
        }

    }
    ```

    As an example, if you want to make the *HCL Domino REST API setup 1.1.3*
    and *HCL Domino REST API admin 1.0.2* API schemas inaccessible, you will add the following to the JSON file:

    ``` json
    {
        "versions" : {
            "setup" : {
                "active" : false
            },
            "admin" : {
                "active" : false
            }
        }

    }
    ``` 

5. Save the JSON file in the `keepconfig.d` directory.
6. Restart Domino REST API on all servers.

### Customize accessible endpoints in a specific API schema 

1. Create a JSON file using a text editor.
2. Add the `versions` JSON object with the entry name of the API schema you want to customize and the `disabledOperationIds` property.

    ``` json
    {
        "versions" : {
            "entry name" : {
                "disabledOperationIds" : ["value1","value2"]
            }
        }

    }
    ```

    !!!note 
        `disabledOperationIds` is an array.

3.	Enter the operationID of each endpoint you want to be inaccessible as an array value for the `disabledOperationIds` property.

    As an example, if you want to make the `POST v1/document` and `GET v1/document/{unid}` endpoints on the *HCL Domino REST API basis* API schema, and the `GET setup-v1/schema` endpoint on the *HCL Domino REST API setup* API schema, you will need to add the `operationId` of each of those endpoints in the JSON file. 

    ``` json
    {
        "versions" : {
            "basis" : {
                "disabledOperationIds" : ["createDocument","getDocument"]
            },
            "setup" : {
                "disabledOperationIds" : ["getSchema"]
            }
        }

    }
    ```

5. Save the JSON file in the `keepconfig.d` directory.
6. Restart Domino REST API on all servers.