---
layout: default
title: REST Principles
parent: Extending Domino REST API
nav_order: 3
---

This page outlines how we use REST in the Domino REST API.
If you are not familiar with REST, click on the [tutorial](https://restfulapi.net/) link to know more about REST API.

### Pragmatism vs. principle

We will stick to the REST principles, but don't let principles get in the way of practical solution.

### Approach

Our design goal is to produce an API that is understandable and usable for to developers regardless of their exposure to Domino terminology. Also we strive for freedom of choice for tools
and methods, so you don't have to struggle with the Domino Designer or Domino Administrator clients.

### Methods used

These are the methods used in Domino REST API. Each method call has a corresponding named `operationId`.

For collections we use, as far as practical, plural names for resource parts, while individual resource are called
with singular names. Deviating from observed practice, we don't use `POST` methods for resource creation.
We use `POST /somepath/resource` to create a new unit of a resource.

This leaves us the option to extend the API for bulk creation at a later point of time.

## GET

Retrieve one resource or a collection of resources. Data will never change.

Successful `GET` returns `HTTP 200`

- When retrieving a **single** resource (e.g. one document) the `operationId` start with **get**.
- When retrieving a **collection** the `operationId` start with **fetch**.

## POST

This is the most flexible verb we use. It is used for:

- Creating resources.
- Sending queries (DQL).
- Triggering actions (e.g inline script, run agents etc).
- Authentication (Entering valid username and valid password).

Successful `POST` returns `HTTP 201` for resource creation and `HTTP 200` for other operations.
For operations that run asynchronously can return `HTTP 202`

- The `operationId` for `POST` requests that **create resources** start with **create**.
- The `operationId` for `POST` requests that **send queries** start with **query**.
- The `operationId` for `POST` requests that **revolve around authentication** start with **auth**.
- The `operationId` for `POST` requests that **run or execute actions** start with **execute**.
- The `operationId` for `POST` requests that **generate results** start with **generate**.

## PUT

Updates an existing resource, completely replacing the server side information with data provided in the `PUT` request.
The request must have the identifier in the path or query to clearly point to a **single** resource.

Successful `PUT` returns `HTTP 200`

- The `operationId` for `PUT` requests start with **replace** or **replaceCreate**

## DELETE

Deletes an existing resource, completely.
The request must have the identifier in the path or query to clearly point to a **single** resource.

Successful `DELETE` returns `HTTP 200`

- The `operationId` for `DELETE` requests start with **delete**

## PATCH

Updates one or more resources on the server. The `PATCH` payload is **NOT** a replacement object (or collection),
but a set of instruction what needs to change. E.g. a list of unids to update read status or a set of names to remove
from an item.

You **need to check** the documentation of the individual patch method for details

Successful `PATCH` returns `HTTP 200`

- The `operationId` for `PATCH` requests start with **update**

### OperationId, Tag, Config and Class Names

The `operationId` gets mapped into a class name on Domino REST API. The `operationId` gets the first letter in uppercase as class name
within the context of the specific package. The other key piece of information from the OpenAPI spec is the `tag`. This is used to match against the config, to get the package name to use for the NSFHandler.

**Pattern**: `Package`.*O*perationId

The [configuration](../installconfig/index) defines where to find the package.

**WebHandler**: Note the version mapping to this OpenAPI file in "versions" parameter in the config. Look under the "RestAPI.versions" parameter for this version.and look for the "package" parameter. If there is no class with the operationId in that package, the class in the "defaultClass" parameter will be used. Example: `getAnswerToAllQuestions`, package set as `com.hcl.domino.keep.handlers.experimentalv0` -> com.hcl.domino.keep.handlers.**experimentalv0**.**GetAnswerToAllQuestions**.

**NSFHandler**: Look at the JSON objects under the "verticles" parameter in the config, and find the tag for this OpenAPI endpoint. This will give the package name. Example: `getAnswerToAllQuestions` with tag `experimental`, which has package name set as `com.hcl.domino.keep.dbrequests.experimental` -> com.hcl.domino.keep.dbrequests.**experimental**.**GetAnswerToAllQuestions**.
