# Plan you application

The Domino REST API allows a flexible approach to utilizing Domino as a NoSQL data store. This flexibility requires that you plan well and consider several questions based on the properties of the Domino REST API.

## About this task

The procedure guides you on planning your application by considering the following key criteria:

- application type
- authentication
- access management

## Procedure

1. Determine the type of application you want to build.

    - If your application is mobile, desktop, including Microsoft Excel[^1], or uses a command line with cURL, it requires direct access to the server.

        [^1]: Microsoft and Microsoft Excel are registered trademarks or trademarks of Microsoft Corporation in the United States and/or other countries.

        ![Local applications](../../assets/images/access/LocalApp.png)

    - If your application is a web application built with frameworks like ReactJS or Angular, you can host the static files in the `keepweb.d` directory or on your chosen Domino server.

        ![Domino REST API Properties](../../assets/images/access/WebApp-local.png)

        ![Domino REST API Properties](../../assets/images/access/WebApp-nginx.png)

    - If you are building a server-based application using technologies like NodeJS, Ruby, Spring Boot, PHP, Rust, or Go, it can act as an intermediary between the Domino REST API and another application. Note that this type of application doesn't support open access and requires additional credentials.

        ![Application server](../../assets/images/access/AppServer-App.png)

2. Determine the authentication method you want to implement for your application.

    - You can use the Domino REST API, which offers an endpoint allowing you to exchange a Domino username and password for a JWT access token.

    - For a more robust and flexible authentication method, you can use an external identity provider (IdP) that generates the JWT access token as a result of an OAuth flow. Refer to the following diagram to better understand the OAuth flow.

        ![Domino REST API Properties](../../assets/images/OAuthDance.png)

3. Fine-tune your access permissions through the Domino REST API configuration. The Domino REST API allows you to:

    - Execute DQL queries. Further access can be fine-tuned using an `@Formula`.
    - Post code snippets (JS or Groovy) for execution.
    - Decrypt encrypted items if the user has a suitable key.
    - Specify which forms, views, and agents to expose on the API.

    !!! tip

        For more information, check [the Barbican's capabilities](../../references/extensibility/barbican.md), which tailor field access based on document data and the current user to ensure API-based data integrity.

    ![Domino REST API Properties](../../assets/images/access/KEEPproperties.png)
