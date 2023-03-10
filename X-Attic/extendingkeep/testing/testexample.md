---
layout: default
title: Cheat Sheet
parent: Testing
grand_parent: Extending Domino REST API
nav_order: 1
---

Along the way we learned a few lessons that makes testing easier.

- Create a directory in `/src/test/resources/ut/[yourClassName-no extension]` where you will store all the test data you want to process. Use `KeepTestUtils.getResourceAsJson("file.json",YourTestClass.class)` to retrieve values
- Annotate your class with `@UnitTest`, `@IntegrationTest` or `@PerformanceTest`. The first one runs on `mvn package` the second one runs on `mvn verify` and the last one only runs on manual.
- Use the `@Mock` annotation instead of `mock(classname)`
- After the mock definitions, add the Rule using `@Rule MockitoRule mockitoRule = MockitoJUnit.rule();`
- Domino REST API this sequence:
   1. Initialize your Mocks in `@BeforeEach`, using `MockitoAnnotations.initMocks(this);`
   2. Initialize your local (non mock) variables;
   3. Define mock behavior. If you switch 2 and 3, be ready for errors.
- Use `KeepTestSubscriber[Json]` (see [Test Helpers](testhelpers.md))
- Use `KeepTestUtils`
- If suitable, extend `AbstractDatabaseHandlerTest`


### Code example

```

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentMatchers;
import org.mockito.Mock;
import org.mockito.Mockito;
import com.hcl.domino.data.Document;
import com.hcl.domino.keep.Constants;
import com.hcl.domino.keep.cache.NameLookupCache;
import com.hcl.domino.keep.exceptions.KeepExceptionMissingParameters;
import com.hcl.domino.keep.testhelper.AbstractDatabaseHandlerTest;
import com.hcl.domino.keep.testhelper.KeepTestUtils;
import com.hcl.domino.keep.testhelper.KeepTestUtils.TestType;
import com.hcl.domino.security.AclEntry;
import com.hcl.tests.UnitTest;
import io.vertx.core.Vertx;
import io.vertx.core.json.JsonObject;

@UnitTest
@SuppressWarnings("resource")
class CreateTaskTest extends AbstractDatabaseHandlerTest {
  @Mock
  Document note;

  @Mock
  AclEntry aclEntry;

  @Mock
  NameLookupCache nameLookupCache;

  CreateTask request;

  @Override
  @BeforeEach
  protected void beforeEach(final Vertx vertx) {
    super.beforeEach(vertx);
    this.request = new CreateTask();
    this.factory.setLookupCache(this.nameLookupCache);
  }

 
  @Test
  void testEmptyPayload() throws KeepExceptionMissingParameters {
    this.expectFailure(Exception.class, this.request, this.getJsonParams());
  }

  @Test
  void testProcessPayloadSuccess() throws KeepExceptionMissingParameters, Exception {
    this.subscriber.minimumOnNextCount(1);
    this.request.setSubscriber(this.subscriber);
    final JsonObject inputPayload = KeepTestUtils.getJsonFromResource(TestType.UNIT_TEST,
        "/testCreateUpdateTask.json", CreateUpdateTaskTest.class);
    this.incoming.put(Constants.REQUEST_BODY, inputPayload);
    Mockito.when(this.s.createDocumentFromJson(ArgumentMatchers.any(), 	ArgumentMatchers.any()))
        .thenReturn(this.note);
      this.request.process(this.getJsonParams());
  }
}

```


  
