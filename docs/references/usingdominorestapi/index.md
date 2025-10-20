# Overview of using Domino REST API

Domino REST API provides you an API for your Domino server to be used from anything that speaks http(s). To get started do the following:

- Create a database configuration (Schema) for an existing Domino database, available in the Admin UI and the API.
  - Note: You can also create a database using API calls.
- Enable the forms, views, folders, agents and document items you want available through the API, this can be done via the Admin UI and the API.
- Activate the schema by creating a scope (Rest mapping)
- Experiment using a REST http tool like `curl` or `postman`.
- Configure an application in the Admin UI to create a client_id and a client_secret, so your applications can use OAuth to authenticate
- Add REST API calls your application.

<!--See additional topics under this category for more information.-->