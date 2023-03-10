---
layout: default
title: Test Helpers
parent: Testing
grand_parent: Extending Domino REST API
nav_order: 2
---

We use a set of helpers to make the testing easier:

- Mockito is used to copy objects see [Testing](/extendingkeep/testing/index).

- Custom annotations: `@UnitTest`, `@IntegrationTest` and `@PerformanceTest`
- Class KeepTestUtils: is used to retrieve the test specific sources.
- Classes TestSubscriberGeneric, TestSubscriberJson is used in Assertions when extending the `AbstractAsycDomino`

### Use of TestSubscriberJson

As example for the whole set of TestSubscribers, the TestSubscriber can be used to expect success or error from the specific function under test. Expected outcomes are added fluently to the test subscriber. Not all combinations makes sense.

```java
TestSubscriberJson subscriber = new TestSubscriberJson();
```

Sets the subscriber receiving the events that the class generates from interacting with the database. Could be and EventbusResponseSubscriber or a SubTaskor a KeepTestSubscriber.
And subscriber is used to set the subscriber.

```java
this.request.setSubscriber(this.subscriber);
```

## Testing failure

There are at least three methods to indicate an expected failure.

Function to capture expectFailure() to failing UnitTest that throw Exceptions

/\*```java
subscriber.expectFailure(true);

````*/

```java
subscriber.expectFailure(KeepException.class, this.request, this.getJsonParams());
````

Expectation is that the code under test will call the `onError()` function and not `onComplete()` without further specifying why the test fails if `onComplete()` runs.

```java
subscriber.errorClass(KeepException.class)
```

Expectation that `onError()` gets called with a specific error class. Test fails if a different error is raised or `onComplete()` runs.

```java
subscriber.errorMessage("A specific error message")
```

Expectation that `onError()` is called and the error has the specified message. Fails if the message is different or `onComplete()` runs.

## Testing success

There are various switches to test success. By default a TestSubscriber expects `onComplete()` to run and not `onError()`.

```java
subscriber.expectedOnNextCount(7)
```

Expect exactly seven calls to `onNext()` and one call to `onComplete()`, will fail with less or more calls

```java
subscriber.minimumOnNextCount(2)
```

Expect two or more calls to `onNext()` and one call to `onComplete()`, will fail with less calls.
Typical use with 1 to ensure at least one result is returned.

```java
subscriber.maximumOnNextCount(2)
```

Expect zero, one or two calls to `onNext()` and one call to `onComplete()`, will fail with more calls.

```java
subscriber.expectEmpty(true)
```

When set a call to `onNext()` can be an empty object `{}`. If not set `onNext("{}")` fails.

```java
subscriber.addfieldToExist("SomeField").addfieldToExist("SomeOtherField")
```

Expect every call to `onNext()` contains a JSON element with the given field names, no assertion on data type is made.

```java
subscriber.addExpectedValue(Json1).addExpectedValue(Json2)
```

Adds expected JSON objects for the first and second call to `onNext()`fails if other values arrive. Exact behavior can be tuned
using additional methods:

```java
subscriber.failOnAdditionalFieldsInActual(false)
```

Ignore additional fields returned in a `onNext()` call. Just check that fields specified in `addFieldsToExist()` and/or
`addexpectedValue()`are present.

```java
subscriber.ignoreMissingFieldsInActual(true)
```

Specified by: process(...) in AsyncDominoBase
Provide all the parameters for a successful callto the process() method all database calls rely on and returns the parameters.

```java
subscriber.request.process(this.getJsonParams());
```
