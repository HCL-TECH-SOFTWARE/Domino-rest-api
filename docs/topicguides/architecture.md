# Architectural decisions

"_Architecture represents the significant design decisions that shape a system,
where significant is measured by cost of change._"
-- [Grady Booch](https://en.wikipedia.org/wiki/Grady_Booch)

<!-- prettier-ignore -->
!!! tip "Domino REST API objectives"
    "_Make Domino development and access available to a broad audience with diverse development backgrounds. Keep the barrier to entry low without sacrificing enterprise and container deployability. Ensure access control through declaration on the server and its databases, relieving end-user applications from that task_"

The following sections provide some insight into the architectural decisions that were made keeping in mind the objectives of Domino REST API. Listed here are the justifications, alternatives that were considered and the implications. The objective is to help you understand how Domino REST API was designed and implemented.

## 1. API definition

Domino REST API uses the [OpenAPI v3](https://www.openapis.org/) (a.k.a Swagger) specification to describe its APIs.

### Justification

OpenAPI offers the following benefits:

- OpenAPI provides definitions and descriptions that are both machine- and human-readable. It supports several GUI implementations ([Swagger](https://swagger.io/tools/swagger-ui/), [Redoc](https://github.com/Redocly/redoc), [Apicurio](https://www.apicur.io)) to make it accessible to different audiences.

- The OpenAPI specification combines endpoint definitions, data types, examples and textual explanations in a single document. So, a potential disconnect between documentation and implementation is less likely.

- Accessing data via REST is available to all programming languages without the need to generate custom libraries. There is rich tooling (code generation, if required) available. Security of https is well understood.

- OpenAPI is governed by the OpenAPI Initiative, an open source consortium under the auspices of the Linux foundation. No single company can steer it in a new direction.

### Alternatives

We considered but decided against the following APIs:

- SOAP (outdated)
- Protocol buffers (backend format, no support in browser despite being donated to Cloud Computing Foundation driven by single vendor, code generation limited to a few languages, poor documentation of proto files)
- Java RPC (single language only)
- Websockets (not suitable for backend, no documentation format)
- oDATA (decided to implement that as a database specific option)

### Implication

OpenAPI allows for [contract-first-design](https://en.wikipedia.org/wiki/Design_by_contract) with well defined and documented APIs. We're not limited by CRUD operation considerations and OpenAPI offers higher function calls (like accepting meetings, sending emails and more). In one Domino REST API instance, we can load different API definitions, which can then be used for versioning and for add-on APIs like Admin or Quattro.

We use the OpenAPI specified _OperationId_ to identify what EventBus routes and processing classes to use. When Domino REST API starts, it checks for the availability of operation classes matching each _OperationId_. In info API, where the information about the configuration is available, Domino REST API specifies which classes have been identified and loaded and gives error messages on startup console for missing classes.

<hr />

## 2. Network protocol

Domino REST API uses HTTP(S) distributed over four ports:

- Domino REST API (the main access)
- Domino REST API Admin commands (usually limited to localhost)
- Prometheus metrics (usually only accessible by Prometheus)
- Domino REST API JWT service for responding to IdVault requests (typically on one Domino REST API node)

However, we are not limited to HTTP. [The EventBus model](eventbus.md) allows us to implement additional protocols. We have an experimental PubSub access using Redis to the EventArch. There's also an ability to use gRPC, once its format (Protocol Buffers or JSON) is clarified.

### Justification

HTTP is a well understood and well supported protocol. Given the [EventBus](eventbus.md) framework we use, support for Http/2 is already available. Using HTTP not only allows application servers (NodeJS, Websphere, SpringBoot etc) to access Domino REST API but also Web clients hosted on static URLs, opening access to front-end developers who want to use Domino as the backend.

### Alternatives

We also looked at NRPC (Notes only, no SDK), gRPC (server to server only, no browser support), native sockets (not routable), custom (outright crazy!) and UDP (not supported in browsers).

### Implication

HTTP is the most used and widely supported transport protocol. Considering that we also cater to MS-Excel (on Windows) and pure browser applications, it was the only logical choice.

<hr />

## 3. Programming language

Domino REST API is written in Java 8.

### Justification

Domino provides its own JVM (OpenJava 8), so Java was a good option. Furthermore, it allows flexible access to the C API without the limitations (see alternatives) of the C API. Domino REST API bypasses Domino's Java API and can run "outside" of Domino. This makes Domino REST API compatible with Java 11 (or later) and/or [GraalVM](https://www.graalvm.org) going forward.

### Alternatives

LotusScript is not flexible enough to process Open API, caching, etc. C/C++ offers extensibility but is not a common skill in customer environments. Although we loved RUST, that is also not a common skill set.

### Implication

Domino REST API depends (for now) on the modified Java 8 runtime that Domino provides. This eliminates the need for an additional runtime install (e.g. NodeJS or dotNet). Using Java 8, the option stays open to upgrade to later JVM versions, as they become available for Domino or fast forward and use its own JVM (or GraalVM), which is more cloud native.

<hr />

## 4. Framework

Domino REST API uses the [Eclipse vert.x](https://vertx.io) framework. Vert.x offers polyglot, event-driven and reactive development capabilities and an EventBus.

### Justification

Running Domino REST API standalone outside the Domino HTTP stack allows for deployment into a Notes client, thus minimizing the barrier to entry for a developer who wants to test things out or develop offline. Vert.x is the foundation of (and is sponsored by) RedHat's Quarkus cloud native Java stack. It also offers excellent support for OpenAPI contracts. The [EventBus](eventbus.md) allows separation of incoming protocols from the database operations, thus enabling the deployment of multi-protocol access.

### Alternatives

OSGI plugins would limit us to Domino servers. Spring Boot involved a learning curve and bundled Tomcat. Plain servlets are not polyglot and are an outdated model.

### Implication

We can deploy Domino REST API to Linux (server), Windows (client & server), and Mac (client only) with minimal effort. The vert.x HTTP stack supports HTTP2 and SSL certificates in multiple formats. Using more than one port allows us to fine-tune access, so administrator operations (shutdown, restart) and metrics can be network isolated from regular operations. Vert.x also offers deployment into multiple threads (Workers) and can make use of available cores by deploying extra instances of its unit of work, the verticle.<br />

**Caveat**: Event driven or reactive programming is a new technology and might require some learning for most Java developers.

<hr />

## 5. Authentication

Access to the Domino REST APIs requires a valid JavaScript Web Token (JWT), signed by a trusted party. There is an API Endpoint available that allows, if activated (default = yes), exchange of Domino credentials for a JWT token. Tokens generated by RedHat Keycloak and custom generated tokens have also been successfully tested.

### Justification

Domino REST API is API only, so any dance that requires user interaction must happen before Domino REST APIs are accessed. The ability to use Domino credentials, including local users (note: _local users work in Notes client only_) to obtain a JWT token lowers the barrier to entry. JWT is an established [industry standard (RFC7519)](https://tools.ietf.org/html/rfc7519) and also is the end result of an [OpenID Connect (OICD)](https://openid.net/connect/) dance. So its use and risks are well understood and documented.

### Alternatives

We also looked at OICD, SAML, and Kerberos. They all require user interaction to authorize access. Since Domino REST API is API only and has no user interface, the application must authorize access.

### Implication

Developers can get started with Domino REST API without deploying an IdP (Identity Provider) infrastructure. By using an established standard, customers can integrate their own identity solution without the need to deploy a Domino-only Identity and Access Manager.

<hr />

## 6. EventBus

Domino REST API uses the vert.x internal EventBus to separate database operations from network I/O.

### Justification

The [EventBus](eventbus.md) caters to multiple network protocols (PubSub, WebSockets, HTTP, gRPC) without duplicating database operations. Furthermore, Verticles (units of work in vert.x) can run in their own threads, allowing full utilization of available cores. We wrapped the EventBus into a reactive observer pattern, so the regular maintainer doesn't need to deal with EventBus specifics.

### Alternatives

Manual thread programming required too much effort and Google Guava EventBus was not flexible enough.

### Implication

Since all data flows from a point of entry over the EventBus to a database request handler, identity checking (validating the JWT token) needs to happen on both ends- point of entry and database level. This is important since requests on the EventBus can come from a custom module and there is no way to determine if security checks have been performed. By segregating runtime flow into different verticles/threads, the EventBus allows us to run certain operations with server privileges without compromising the regular database operations bound by user and ACL settings.

<hr />

## 7. CI/CD

Domino REST API uses [Apache Maven](https://maven.apache.org/) as its build system. The Maven plugin [Google JIB](https://github.com/GoogleContainerTools/jib) generates container images for use in Docker, Kubernetes or OpenShift

### Justification

Maven allows us to build Domino REST API, its satellite projects, Docker containers, and documentation from a single source. It runs tests (unit & integration) and generates code coverage and code quality reports, as well as technical documentation (like this page that you are currently reading). Thus, information stays in the repository, where it is more likely to stay current.

### Alternatives

Shell scripts are too messy, Apache Ant involves too much dependency management, Gradle site plugin is too weak, and Jenkins scripts don't allow local builds.

### Implication

Focusing on Maven-based builds allows us to run builds both locally and on our CI environment Jenkins. So a developer can ensure all is well before a pull request kicks off a build.

<hr />

To familiarize yourself with Domino REST API's functionality, you should read the following pages:

- [Domino REST API Overview](../topicguides/introducingrestapi.md)

- [OpenAPI specification](https://swagger.io/specification/)

- [The EventBus](eventbus.md)

- [The Barbican](barbican.md)

- [OData](../tutorial/odata/excel.md)
