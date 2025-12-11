# Extensibility tutorial

The tutorial guides you through the creation of a custom URL endpoint that handles the approval and rejection of generic requests. To follow along, you need to be familiar with Java and Domino.

!!! warning "Future versions and breaking changes"

    Although the goal is for Java extensibility APIs to remain stable over time, their details are more likely to change between major versions compared to the published REST API endpoints. Be sure to review the release notes for any version changes that might impact Java extensions.

## [Set up the Maven Java project](javaproject.md)

The first step is to set up the Java project. It will use a published parent project and libraries installed with your Domino REST API installation.

## [Create OpenAPI specification](openapi.md)

The second step is to create an OpenAPI 3.0.x specification. It can be done using Notepad, but you want to use [available tooling](https://openapi.tools/#gui-editors). You can use [Swagger Editor](https://editor.swagger.io/), Redhat's [Apicurio](https://www.apicur.io/), or [APIGit](https://apigit.com/).

## [Create the config.json](configjson.md)

Domino REST API is driven by a [dynamic configuration](../../references/configuration/understandingconfig.md). To get your extension recognized, you must provide the information what verticle will run your code and what classes implement your business logic. To do so, a file `resources/config/config.json` is required.

## [Implement business logic](businesslogic.md)

To implement the functionality, two Java classes are involved. One is a handler class that takes in the http request and forwards it on the Eventbus. The other is a dbrequest class that performs the database interaction.

For the most common use case of JSON in/out, the default handler performs all the necessary actions, no custom code is required.

## [Access Control](accesscontrol.md)

Domino REST API follows Domino's access control with no exceptions. However, you can further tighten the security to be very specific on individual access requirements.

## [Deployment](deployment.md)

## [Setting up a devcontainer](devcontainer.md)

This step is strictly optional. It can, after the initial setup steps, improve your developer experience by creating a well-known development environment.
