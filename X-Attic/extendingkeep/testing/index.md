---
layout: default
title: Testing
parent: Extending Domino REST API
nav_order: 6
has_children: true
---

- Unit testing is done using [JUnit 5](https://junit.org/junit5/) and [Mockito](https://site.mockito.org/) is used for mocking calls to Domino. The versions currently in use can be found in the main pom.xml.
- [Postman](https://www.postman.com/) and [Newman](https://learning.postman.com/docs/postman/collection-runs/command-line-integration-with-newman/) are used for integration testing.
- [PMD](https://pmd.github.io/) is used to check the quality of generated code. Results are put in PMD Results report.
- [Spot Bugs](https://spotbugs.github.io/) is used to generate bug reports. The result is in the [Spot Bugs Report](https://github01.hclpnp.com/stephan-wissel/keep-documentation/blob/master/spotbugs.html).
- [CheckStyle](https://checkstyle.sourceforge.io/index.html) with the Google ruleset is used to generate style reports and the Google ruleset. Results are put in CheckStyle report.
- Copy Paste Detection (CPD), part of PMD, is used to detect duplicate code. Results are put in CPD Result reports.

### JUnit 5

JUnit 5 uses the `org.junit.jupiter.api` packages. Tests are annotated (as usual) with `@Test`. `@DisplayName` can be used to give a nice display name for test results. However, in Eclipse, this means double-clicking throws an error because it tries to find a method with that name (which obviously doesn't exist). After the error it just loads the full class. Considering that there are not a large number of tests in each test class, this isn't a problem and ensures a cleaner description in results pages.

## Bootstrapping tests

To setup a test, define your class level variables on top without initializing them. External classes, not subject to a test can be annotated using `@Mock` and `@Rule`.

Use the `@BeforeEach` and `@AfterEach` to initialize your variables. There is also the option of using static `@BeforeAll` and `@AfterAll`. However, we try to avoid these.

Pick your method names, so the `@BeforeEach` method is sorted first.

## Test annotations

We use Annotations to define the intended test use. Our annotations include the Vertx extension
(see Vertx Tests below). We use:

- `@UnitTest` - a test that runs during the `mvn test` cycle, including in the CI/CD environment.
- `@IntegrationTest` - a test that runs during the `mvn validate` cycle (might need a Domino backend).
- `@PerformanceTest` - a test that needs manual launch and a Domino backend.

Make sure you check out the [example](testexample.md) with important details.
{: .alert .alert-info}

Assertions should use the `org.junit.jupiter.api.Assertions` static methods, e.g. `org.junit.jupiter.api.Assertions.assertEquals`. If imports of `org.junit.Assert` static methods are accidentally selected, the code will still run.

## Vert.x tests

For access to the Vertx runtime from tests, JUnit 5 is extensible and there is a Vertx extension. Annotate the class with `@ExtendWith(VertxExtension.class)` and add the parameter `Vertx vertx` to your test classes, e.g.

```java
@ExtendWith(VertxExtension.class)
public class VertxTests {

    @Test
    @DisplayName("A Vertx Test")
    void testSuccess() throws Exception {
    JsonObject doc = KeepUtils.getJsonFromResource("/testdata/A_Json_Object.json");
	when(mockDoc.getItemValueString(anyString())).then(invocation -> doc.getString(invocation.getArgument(0)));
    final JsonObject requestParams = new JsonObject();
    MyVertxHandler request = new MyVertxHandler(requestParams, vertx);
    this.request.process(this.getJsonParams());
    // do something

}
```

## Testing Vertx routes

Accessing the Vertx instance is just one scenario. But if you're setting up a verticle, the tests need to wait for the verticle to run. This is done by passing `VertxTestContext` parameter into the bootstrapping and the tests. This allows checking for completions, successes and failures of handlers.

You can then use `VertxTestContext.failNow(String)` and `VertxTestContext.completeNow()` to tear down the test context for failure or success of a test.

`VertxTestContext.completing()` creates a handler that `failNow()` and `completeNow()` can use and this can be passed as an additional parameter into an HttpServer's `listen` method like this:

```java
	vertx.createHttpServer()
	    .requestHandler(router::handle)
	    .listen(thePort, testContext.completing());
```

## Testing full Vertx responses

A recent addition to Vertx's JUnit 5 testing is the ability to create an HTTP request against a Vertx HttpServer and validate the response. This can be useful for testing bad responses, invalid methods or simple results. It doesn't really allow creating more specific tests of the response content though, so unless you know exactly what you're getting back, it doesn't really work. It also doesn't allow time for messages being passed around the EventBus though. It will automatically handle completing or failing the testContext. Here is a simple bad request test:

```java
  @Test
  void testBadRequest() throws KeepExceptionMissingParameters {
/*{
    JsonObject body = new JsonObject();
    testRequest(client, HttpMethod.POST, "/auth")
      	.with(
      			requestHeader("ContentType", "application/json")
      		)
      	.expect(
      			statusCode(400)
      		)
      	.sendJson(body, testContext);*/
	this.expectFailure(KeepExceptionMissingParameters.class, this.request, this.getJsonParams());
  }
```

## Reactive testing

All Domino side handlers in Domino REST API are reactive and need testing with `request.setSubscriber()`. To ease testing there is a generic `TestSubscriber` and a ready implementation of `TestSubscriberJson`.

It can be configured to handle success and failure cases. Check its JavaDoc for details.
It includes a callback method for even more detailed testing.

## Test suites with JUnit 5

Test suites are done with JUnitPlatform, with the following format:

```java
import org.junit.platform.runner.JUnitPlatform;
import org.junit.platform.suite.api.SelectPackages;
import org.junit.platform.suite.api.SuiteDisplayName;
import org.junit.runner.RunWith;

@RunWith(JUnitPlatform.class)
@SuiteDisplayName("Keep Test Suite")
@SelectPackages("com.hcl.domino.keep")
public class AllTests {

}
```

### Mockito

Mockito allows you to mock classes and intercept methods. This is done by creating an instance of a class via the static `org.mockito.Mockito.mock()` method. You can then intercept methods of that class by chaining `when()` and `thenReturn()`. Obviously, some mocks will need to return other mocks, e.g. `DocumentCollection.getFirstDocument()` will need to return a mock of a `Document`. In this case, you'll need to mock the `Document` prior to mocking the `DocumentCollection`.

You can also mock non-database objects, as we do with mocking `KeepJnxSession`, which needs passing into handlers.

As a sample of mocking, here is a chunk of code from `IdentityFetchjwtRequestTest`:

```java

    @Mock
    KeepJnxSession s;

    @Mock
    NotesIDTable fakeIds;

    @Mock
    NotesDbQueryResult result;

    @Mock
    Document fakeNote;

    @Mock
    Database db;

    @Mock
    DominoCollection mockNc;

    @Rule
    MockitoRule mockitoRule = MockitoJUnit.rule();


    @BeforeEach
    void beforeEach(final Vertx vertx) {
    super.beforeEach(vertx);

        // Initialize the Mock objects
        MockitoAnnotations.initMocks(this);
	MockKeepFactory keepFactory = new MockKeepFactory(vertx);
	KeepFactorySource.INSTANCE.overwriteFactory(keepFactory);

        final Integer id = 100;
        final String hash = "HashValue";

        // Defining Mock object behavior
	   when(fakeIds.isEmpty()).thenReturn(false);
	   when(fakeIds.getFirstId()).thenReturn(id);
	   when(result.getIDTable()).thenReturn(fakeIds);
	   when(fakeNote.getItemValueString("Hash")).thenReturn(hash);
	   when(fakeNote.getItemValueString("FullName")).thenReturn("John Doe");
	   when(db.query(anyString(), any(), anyInt(), anyInt(), anyInt())).thenReturn(result);
	   when(db.openNoteById(anyInt())).thenReturn(fakeNote);
	}
```

As you see, you can create a mock of a method with hard-coded parameter names. These mocks only match the specified parameters. Alternatively, as you see with `db.query()`, you can pass the relevant `org.mockito.ArgumentMatchers` static method to simulate a String, int, object etc. This then matches whatever parameter is passed in.

Sometimes, however, you need to get more creative with mocking methods. Say, for instance, you have a JsonObject that simulates a Document and you want to get the relevant property from the JsonObject to match the requested Item on the Document. Instead of `thenReturn()`, you can use `then()` and specify a method to run. You can then get the relevant argument passed into the method.

```java
    // Variable declaration
    @Mock
    Document mockDo;


    JsonObject doc = KeepUtils.getJsonFromResource("/testdata/A_Json_Object.json");
	when(mockDoc.getItemValueString(anyString())).then(invocation -> doc.getString(invocation.getArgument(0)));
```

You can also iterate over a collection by creating a JsonArray of JsonObjects and using a `java.util.concurrent.atomic.AtomicInteger` to get the relevant position. At the end of the loop, you just need to set null. Here's an example:

```java
	AtomicInteger ordinal = new AtomicInteger(0);
	final DocumentCollection dc = mock(DocumentCollection.class);
	when(dc.getFirstDocument()).thenReturn(mockDoc);	when(dc.getNextDocument(any())).then(invocation -> {
		ordinal.getAndIncrement();
		if (ordinal.intValue() == docs.size()) {
			return null;
		} else {
			return mockDoc;
    	}
	});
```

Then, when you're mocking `getItemValueString()` from mockDoc, you can access `ordinal.intValue()` to get the atomic value. You just need to bear in mind what the current value is. If you've called `getNextDocument()` at the start of the loop, `ordinal` will already have been incremented on from the document you're processing in `getItemValueString()`. So you need to use `ordinal.intValue() - 1`.

However, you cannot use Mockito to mock static methods in classes. This can cause problems if the code within a given handler makes a call to a static method. In Domino REST API, that is done for Domino sessions. All methods in `DominoSessionManager` class are static. Powermock is designed for this, but doesn't support JUnit 5 currently. As a result, any code that calls that will require a different approach.
