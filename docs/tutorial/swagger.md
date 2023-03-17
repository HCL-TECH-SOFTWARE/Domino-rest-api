# SwaggerUI

This tutorial shows how to use SwaggerUI to create a document and to list views.

## Create a document with SwaggerUI

1. Go to [SwaggerUI](http://localhost:8880/openapi/index.html).

2. Provide the server variables as shown:

      ![JwtToken](../assets/images/TokenJwt.png)

3. Provide the JWT token for authorization: Go to the authorization API in swaggerUI and click `/auth`, provide valid credentials in the request body and click execute. Then a JWT token will be generated.

      ![JwtToken1](../assets/images/TokenJwt1.png)

4. Enter JWT token and click **Authorize**.

5. Go to the required API, enter all the mandatory field values, and then click **Execute**.

      ![SwaggerAPI](../assets/images/ApiSwagger.png)

### List views with SwaggerUI

1. Follow Steps of authorization from above.

2. Go to the required API, enter the dataSource value, and then click **Execute**.

      ![SwaggerAPIViews](../assets/images/ApiSwaggerViews.png)

### View the SwaggerUI for a specific KEEP Database

1. In the Explore field in the banner, enter `/api/v1/openapi?dataSource=demo`. This will display the KEEP OpenAPI specification specifically for the demo database.

2. Review the endpoints. The admin and design APIs aren't included since they're not appropriate for accessing the demo database's data. The `dataSource` parameter is always "demo" because the OpenAPI specification is for that Keep database.

3. Review the Schemas at the bottom. If you haven't specified read/write fields on a form, you will see the genericFormResult/genericFormRequest. If you have specified read or write fields, you will see a schema for `_formName_-_modeName_ Responses`/`_formName_-_modeName_ Requests`.

      ![SwaggerAPIDatabase](../assets/images/ApiSwaggerDatabase.png)

If you URL encode `/api/v1/openapi?dataSource=demo`, you can create a URL to share with developers who consume the Domino REST API for that database. The URL encoded value should be appended as the "url" querystring parameter. The resulting URL will look like `http://localhost:8880/openapi/index.html?url=/api/v1/openapi%3FdataSource%3Ddemo`, where the Domino REST API database name is after the `%3D` (url encoded "=").
