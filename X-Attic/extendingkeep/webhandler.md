---
layout: default
title: Web Handlers
parent: Extending Domino REST API
nav_order: 4
---

All Web handlers need to implement [`Handler.handle(RoutingContext ctx)`](https://vertx.io/docs/apidocs/io/vertx/core/Handler.html). In our implementations they all extend
[AbstractAPIHandler](javadoc/com/hcl/domino/keep/handlers/core/AbstractAPIHandler.html)

/extendingkeep/javadoc/com/hcl/domino/keep/handlers/core/AbstractAPIHandler.html

### JSON processing

When a request has no body (e.g. GET, DELETE) and expects the content type `application/json` or the request body/response both are `application/json` no Web handler code needs to be written. The [`DefaultJsonHandler`](javadoc/com/hcl/domino/keep/handlers/core/DefaultJsonHandler.html) automatically takes care of this.

Only when the default processing isn't used does the API require a custom handler.

### Custom handlers

To extend the `AbstractAPIHandler` only two methods (and one constructor copied) needs to get implemented. Prepare and send it to the database handler:

```java
  @Override
  protected JsonObject preparePayload(final RoutingContext ctx, final MultiMap header) {
    // TODO: Your code goes here ...
  }
```

```java
   * @param ctx - Request/Respnse context
   * @param header The header for the EventBus
   * @param eventbusId - to identify the object
   * @return a future with the JSON Object we sent over the EventBus
```

```java
  protected abstract Future<JsonObject> prepareRequestBody(final RoutingContext ctx,
      final MultiMap header);
```

To process the returned value

```java
@Override
  protected void listenForResponse(final EventBusRequestObservable<T> observable, final RoutingContext ctx) {
    // TODO: Your code goes here ...
  }
```

### EventBusRequestObservable<T>

Interface for backpressure sensitive operationof Eventbus to HTTP/EventArch/Others transmission
Type Parameters:<T> Json, Buffer, String

```java
   * @param incomingObservable The Observable running


  protected abstract void listenForResponse(final EventBusRequestObservable<T> incomingObservable,
      final RoutingContext ctx);
```

The method subscribe the observable and send data back once the response is retrieved from the RoutingContext.

```java
Observable.create(observable).subscribe(
        value -> {
        // Your code goes here for values
        },
        error -> {
        // Your code goes here for an error
        },
        () -> {
        // Your code goes here for end of data
        });
```

```java
   * @param incomingObservable The observable that comes with JsonObject
   * @param ctx Request context

 Observable.create(incomingObservable) {
        .map(this::injectIntoObservableValue)
        .subscribe(
     value -> AbstractAPIHandler.incomingJsonValues(incomingObservable, value,
                resultExpectsAnArray,
                dataHasStarted, response, this.expiry),
     error -> this.handleErrorWhileListening(ctx, error, dataHasStarted.get()),
     () -> AbstractAPIHandler.incomingJsonValuesComplete(resultExpectsAnArray,
                dataHasStarted, response));
  }
```

### Helper functions

- Collect all the parameters you can use `payloadFromAllParams(ctx, header);`
- To add the data to a returned JSON, before it needs to be sent use `injectIntoObservableValue(value)`
- Signal an error using `endWithError`

### Handler flags

Overwrites the method `getReqOptions()` to alter the conditions like required authorization or default database. Check the ENUM [RequestOptionFlags](javadoc/com/hcl/domino/keep/handlers/core/RequestOptionFlags.html) for available details
