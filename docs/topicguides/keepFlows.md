---
#layout: default
title: Domino REST API flows
#parent: How the Domino REST API Works
#nav_order: 2
---

## Selected Flows in the Domino REST API Architecture

To fully understand Domino REST API, it is helpful to know the main flows, Domino REST API has three of them:

- Domino REST API Boot
- Loading of OpenAPI defined routes
- serving requests on the loaded routes

## Domino REST API Boot

[![Domino REST API Boot](../assets/images/LaunchFlow.png)](../assets/images/plantuml/LaunchFlow.plantuml)

[![DBVerticle](../assets/images/DBVerticleFlow.png)](../assets/images/plantuml/DBVerticleFlow.plantuml)

## Loading of OpenAPI defined routes

[![OpenAPI](../assets/images/HttpLaunchFlow.png)](../assets/images/plantuml/HttpLaunchFlow.plantuml)

## Serving requests on the loaded routes

### Accepting requests on HTTP

Request get put on the EventBus after successful acceptance.

[![HTTPRequest](../assets/images/HttpRequestFlow.png)](../assets/images/plantuml/HttpRequestFlows.plantuml)

### Processing requests from EventBus

Actual database communication happens here:

[![DBRequest](../assets/images/DBRequestFlow.png)](../assets/images/plantuml/DBRequestFlow.plantuml)

[![DBRequest2](../assets/images/DBRequestFlow2.png)](../assets/images/plantuml/DBRequestFlow2.plantuml)
