# Adjust number of retrieved entries when pulling in view data 

## About this task

The procedure guides you in adjusting the number of view entries or documents you can retrieve from a view with more than 1000 entries. Currently, a maximum of 1000 entries are returned when retrieving view data. 

## Procedure

### Using `count` parameter

To adjust the number of entries or documents you can retrieve from a view, use the `count` parameter. A default of 1000 entries is returned if the `count` parameter is not specified. Add the `count` parameter to your API request and specify a value to set how many entries are to be returned. 

For example, to retrieve all the entries from a view that has 1350 entries, set the value of the `count` parameter to 1350 or more to retrieve all view entries.

`(hostName)/api/v1/lists/(viewName)?dataSource=(scope)&count=1350`

**Using the OpenAPI UI**

1. Go to [SwaggerUI](http://localhost:8880/openapi/index.html).

2. Follow the authorization steps in [Create a document with SwaggerUI](../../tutorial/swagger.md#create-a-document-with-swaggerui).

3. Go to and expand **data**, and then expand the **GET /lists/{name}** endpoint.
4. Enter the scope name in **dataSource**.
5. Enter the number of entries to be returned in **count**. Using the requirements above as an example, enter `1350`.  
6. Enter the name of the view in **name**, and then click **Execute**.

### Using `start` parameter

You can also use the `start` parameter. Add the `start` parameter to your API request and specify at which entry should return values start. 

For example, to retrieve all the entries from a view with 1350 entries, execute an API request to return 1000 entries. Execute another API request, but set the value of `start` parameter to 1000 as shown below.

`(hostName)/api/v1/lists/(viewName)?dataSource=(scope)&start=1000`

This returns the remaining 350 entries not included in the returned entries in the first API request. 

**Using the OpenAPI UI**

1. Go to [SwaggerUI](http://localhost:8880/openapi/index.html).

2. Follow the authorization steps in [Create a document with SwaggerUI](../../tutorial/swagger.md#create-a-document-with-swaggerui).

3. Go to and expand **data**, and then expand the **GET /lists/{name}** endpoint.
4. Enter the scope name in **dataSource**, view name in **name**, and then click **Execute**.
You have now retrieved 1000 entries of the view.
5. Enter the scope name and view name again, then enter a value in **start**. Using the requirements above as an example, enter 1000.  
6. Click **Execute**. You have now retrieved the remaining view entries starting from the 1001 entry.  
