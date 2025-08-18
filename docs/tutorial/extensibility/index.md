# Extensibility tutorial

The tutorial will walk you through the creation of a custom URL endpoint approving and rejecting generic request. You need to be familiar with Java and Domino to follow it.

## Setting up the Maven Java project

First step is to setup the Java project. It will use a published parent project and libraries installed with your DRAPI installation

## OpenAPI specification

Second step is to create an OpenAPI 3.0.x specification. You can do that using notepad, but you want to use [available tooling](https://openapi.tools/#gui-editors). You could use the original [Swagger Editor](https://editor.swagger.io/), Redhat's [Apicurio](https://www.apicur.io/) (Apicurito will suffice in most cases) or (what the creator of this tutorial liked best [APIGit](https://apigit.com/))

## Creating the config.json

DRAPI is driven by a [dynamic configuration](../../references/configuration/understandingconfig.md). In order to get your extension recognized you must provide the information what verticle will run your code and what classes implement your business logic. To do so a file `resources/config/config.json` is required

## Implementing business logic

To implement functionality two Java classes get involved. A handler class that takes in the http request and forwards it on the Eventbus and a dbrequest class that performs the database interaction.

For the most common use case of JSON in/out, the default handler performs all the necessary actions, no custom code is required.

## Access Control

DRAPI follows Domino's access control, there's no sidestepping. You can however tighten the screws to be very specific on individual access requirements

## Deployment

## Setting up a devcontainer

This step is strictly optional. It can, after the initial setup steps greatly improve your developer experience by creating a well known development environment.

!!! info "Next"

    [Setting up the Maven Java project](javaproject.md)

## Future Versions and Breaking Changes

While the intent is that Java extensibility APIs will be stable over time, the specifics are more likely to change across major versions than the published REST API endpoints. Be sure to check release notes for any changes between versions that may affect Java extensions.

Beyond the published DRAPI APIs, take care to not assume the presence of most specific dependencies within DRAPI's "libs" directory. Some dependencies - namely, domino-jnx-api and Vert.x - are almost guaranteed to remain consistent over time. Others, like specific utility libraries, are liable to change or be removed even between minor versions of DRAPI. The safest route is to use few third-party dependencies in your Java projects, and otherwise check each DRAPI version for changes.

<!--## Let's connect

"feedback.md"-->
