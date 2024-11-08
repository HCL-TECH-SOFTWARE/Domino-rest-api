# Customize available API schemas and endpoints

## About this task

Guides you on how to customize which API schemas and endpoints are available or visible to meet your specific requirements or use cases. 

## Before you begin

Take note of the `operationId` of the endpoints in a specific API schema that you want to be inaccessible. This prerequisite is applicable to [Customize available endpoints in a specific API schema](#customize-accessible-endpoints-in-a-specific-api-schema).

**To know the operationId**:

1. Go to [OpenAPI (SwaggerUI)](http://localhost:8880/openapi/index.html).
2. Select the API schema that contains the endpoints that you don't want to be available.
3. Select the endpoint or endpoints that you don't want to be available. You will see the value of the `operationId` after the endpoint description.

In the example image, the `operationId` of each listed endpoint is enclosed in the red box. 

![API endpoint operationId](../../assets/images/opID.png)

## Procedure

### Customize accessible API schemas

This procedure enables you to make API schemas unavailable to end users. 

1. Create a JSON file using a text editor.
2. Add the `versions` JSON object with the entry name of the API schema you want to be unavailable and the `active` property.

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

4.	Set the value of the `active` property to `false` to make the API schema unavailable.

    ``` json
    {
        "versions" : {
            "entry name" : {
                "active" : false
            }
        }

    }
    ```

    For example, if you want to make the *HCL Domino REST API setup 1.1.3*
    and *HCL Domino REST API admin 1.0.2* API schemas unavailable, you will add the following to the JSON file:

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

### Customize available endpoints in a specific API schema 

This procedure enables you to customize which endpoints in a specific API schema unavailable to end users by using the endpoint's `operationId`. 

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

3.	Enter the `operationID` of each endpoint you want to be unavailable as an array value for the `disabledOperationIds` property.

    For example, if you want to make the `POST v1/document` and `GET v1/document/{unid}` endpoints on the *HCL Domino REST API basis* API schema, and the `GET setup-v1/schema` endpoint on the *HCL Domino REST API setup* API schema to be unavailable, add the `operationId` of each of those endpoints in the JSON file as array values of the `disabledOperationIds` property. 

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

### Customize accessible endpoints according to the Domino REST API version 

This procedure enables you to make endpoints in API schemas available to end users according to the `keepVersion` parameter. Each endpoint in an API schema has an `x-keep-version` attribute whose value corresponds to the version of Domino REST API when they were supported. By modifying the value of the `keepVersion` parameter, you can make endpoints supported in future releases available to meet your specific use case.  

    !!!note
        Even if endpoints to be supported in future releases can be made available, there is no guarantee that they will function as expected.

1. Create a JSON file using a text editor.
2. Add the `keepVersion` parameter.

    ``` json
    {
        "keepVersion" : "number"

    }
    ```

3.  Change the value of the `keepVersion` parameter to a later main version of Domino REST API.

    For example, if you want to make endpoints that will be supported on the second main version of Domino REST API available, set the value of `keepVersion` to 2. By doing this, supported endpoints in the current main version of Domino REST API, which is version 1, and endpoints to be supported on the second main version of Domino REST API will be available. 

    ``` json
    {
        "keepVersion" : 2

    }
    ```

5. Save the JSON file in the `keepconfig.d` directory.
6. Restart Domino REST API on all servers.