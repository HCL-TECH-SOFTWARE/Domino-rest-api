---
title: Agent processing
---

## Agents - One of Domino's Differentiators

One of the differentiators for Domino compared to some other NoSQL databases is the ability for agents to store business logic, workflow processing logic or ad hoc data processing. Moreover, this can be stored in Domino's Formula Language, LotusScript (Lotus's VB-like generic scripting language, only surviving in HCL Notes) or Java. A context document can be passed into the agent, a selection formula can be set via simple settings, or the agent itself can define the document set to run on.

<!-- prettier-ignore -->
!!! note "About triggers"
    Certain triggers like selected documents or programmatic collections like `unprocessedDocuments` only make sense in Notes Client. Other triggers like "Before Mail Arrives" only make sense in the context of server scheduling. LotusScript UI classes for interacting with the Notes Client will cause an agent to error if you attempt to run it from outside the context of the Notes Client.

    For further clarification, a developer can use the `/design/agents?dataSource=` endpoint to get full information about properties of an agent. The **@validForKeep** property will confirm whether or not the agent can be used from Domino REST API. ***This does not (currently) introspect the LotusScript to check for NotesUI classes. It only uses the triggers to identify agents that cannot be called from outside the Notes Client.***

## Running Agents

There are three ways to run an agent via Domino REST API:

### **POST: /run/agent**

This is used to run an agent in real time. The payload expects at least `agentName` to define which agent to trigger. **NOTE:** the calling HTTP thread will be tied up until the agent finishes, so this should only be used for short-running agents. This is designed to simulate running an agent using the "?OpenAgent" URL endpoint. Any content from LotusScript `print` statements will be returned as the HTTP response or, if no print statements are used `{"agentResponse":"done"}`. In addition, `NotesSession.documentContext` will get an in-memory document with the following properties:

- **REQUEST_METHOD** set to "KEEP". This can be used to identify how the agent was triggered, for contextual processing.
- **CONTENT_TYPE** set to "application/json".
- **SERVER_NAME** set to "".
- **HTTPS** set to "ON".
- **SERVER_PORT** set to "443".
- **QUERY_STRING** set to "openagent"
- **REQUEST_CONTENT** set to any additional content from the payload.

### **POST: /run/agentWithContext**

<!-- prettier ignore -->

!!! warning "Caution"
Might not be supported on current version.

This is used to run an agent in real time, passing the `unid` of a document to use as context and the `returnMode` to use to generate the response for the agent. If `returnMode` was not specified or does not exist, the default `{"agentResponse":"done"}` response is returned.

<!-- prettier-ignore -->
!!! note
    The calling HTTP thread will be tied up until the agent finishes, so this should only be used for short-running agents.

### **POST:/run/agentAsync**

<!-- prettier-ignore -->
!!! warning "Caution"
    Might not be supported on current version.

This is used to run an agent asynchronously via Domino REST API. A successful response contains a status of "processing" and a uuid for the request. The uuid can be used to check the status of the agent (GET **/run/agentAsync/{uuid}**) or cancel the agent (DELETE **/run/agentAsync/{uuid}**). The payload is of the format:

```json
{
  "agentName": "processJson",
  "runAsServer": false,
  "callbackUrl": "https://www.acme.com/api/callback",
  "method": "POST",
  "payload": {
    "FirstName": "Adrian",
    "TestBoolean": false,
    "TestVal": "20"
  }
}
```

The properties are:

| Property           | Description                                                                                                                                |
| ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------ |
| `agentName`        | Name of the agent in this Domino REST API Database to run                                                                                  |
| `runAsServer`      | True if the agent should be run under the server's access. **_Note This cannot be used if the agent has the "Run As Web User" flag set._** |
| `callbackUrl`      | A URL for Domino REST API to send a response to once the agent has completed.                                                              |
| `callbackUrlError` | A URL for Domino REST API to send to if the agent fails.                                                                                   |
| `method`           | HTTP Method to use for the callbackUrl and callbackUrlError.                                                                               |
| `payload`          | A JSON object to pass into then agent. This can contain any additional information the agent needs to use.                                 |

This process creates a document in **KeepAgents.nsf** to track processing of the agents. You can check that in the Notes Client, with the UUID, or query with an API.

## Asynchronous Agent Scheduler

The asynchronous agent scheduler picks up and processes asynchronous agents. The **threads** property in the config.json defines how many agents can be run asynchronously, by default **10**. Multiple agents within the same database and even multiple instances of the same agent can be run simultaneously. Any additional agents are queued up for processing once a thread becomes available.

Domino REST API can still be stopped with agents running or queued. In this scenario, running agents will be cancelled and set to the status "CANCELLED". Because we can't know if it will cause problems to restart the agents, you will need to manually review and, if necessary, start the agent again or complete any remedial data fixup.

Any queued agents will be picked up for processing when the server restarts.
