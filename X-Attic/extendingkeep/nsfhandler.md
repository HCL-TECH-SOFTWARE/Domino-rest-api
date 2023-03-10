---
layout: default
title: NSF Handler
parent: Extending Domino REST API
nav_order: 5
---

The CORE database handlers can be found in the package `com.hcl.domino.keep.dbrequests` or in its sub-packages.

Handlers extend the [`AsyncDominoJNX`](./javadoc/com/hcl/domino/keep/dbrequests/AsyncDominoJNX.html) (or a subclass) that contains the required code. There are two subclasses that can handle most use cases:

- [`AsyncDominoJNXJson`](./javadoc/com/hcl/domino/keep/dbrequests/AsyncDominoJNXJson.html) returning one or more instances of JsonObjects
- [`AsyncDominoJNXBuffer`](./javadoc/com/hcl/domino/keep/dbrequests/AsyncDominoJNXBuffer.html) returning binary data, typically using a [`ResponseSubscriberOutputStream`](./javadoc/com/hcl/domino/keep/eventbus/ResponseSubscriberOutputStream.html)

The only function which we need to implement is the `process` method

```Java
@Override
  public void process(final DbRequestParameters<JsonObject> request) throws Exception {
    request.validate();
      // Your code goes here
}
```

### DbRequestParameters

DbRequestParameters is a parameter object that is used to hand over allElements that are needed to execute operations synchronously against a database for a given user.
DbRequestParameters granting access to session, database, Domino client and the `emit()` function.

### Response

Inside the method `process` there are 2 ways to send results back to the EventBus:

- With data: `request.emit(resultData)` - can be called multiple times.
- On error: `throw new KeepExceptionWrongDataRequest` - can be called only once. You can throw any error, but we highly recommend [Domino REST API Exceptions](../assets/images/KeepErrors.png), since they carry the HTTP status code back.

We don't need to call this.onComplete(), this is handled in the abstract class already.

### Cross handler calling

For some of the calls (e.g OData, Inbox, Drafts, All Documents) an existing handler does all the work. Instead of copy and paste we can create an instance of the other handler and pass across the relevant content.

```Java
    final Query dpqr = new Query();
    dpqr.setVertx(this.vertx);
    dpqr.setRequestParams(this.requestParams);
    dpqr.setFormModeName("odata");
    dpqr.setKeepDbInfo(this.getKeepDbInfo());
    final DbRequestParametersBuilderJson builder = new DbRequestParametersBuilderJson();
    final DbRequestParameters<JsonObject> delegate =
        builder.db(request.db).factory(request.factory).client(request.client)
            .incoming(localPayload).session(request.session).validator(json -> true)
            .observer(this.emitterToObserver(this.getSubscriber())).build();
    dpqr.process(delegate);
```

### emit(JsonObject | Buffer)

emit() is used to return results from the database operationIt can be called zero to N times.

## Securing dbRequest classes

Domino REST API code runs with the given permissions of the user, so Domino will throw an error when a given permission is missing. However we prefer to check before a function call is executed. For this purpose we have created a series of annotations at the class level you can use to indicate the required access.

These annotations allow to further **restrict** access, not expand it. You could e.g. require that modifying a certain document would need Designer access etc.

**If any of the security annotations is not met, an unauthorized error (403) is thrown**.

### @AclAttributes

Allowed values are from `com.hcl.domino.keep.security.acl.AclAccessFlags`

- CreateDocuments
- DeleteDocuments
- CreatePrivateAgents
- CreatePersonalFoldersViews
- CreateSharedFoldersViews
- CreateLotusScriptJavaScriptAgents
- ReadPublicDocuments
- WritePublicDocuments
- ReplicateOrCopyDocuments

### @MinimumAcl

Allowed values are from `com.hcl.domino.security.AclLevel`

- NOACCESS
- DEPOSITOR
- READER
- AUTHOR
- EDITOR
- DESIGNER
- MANAGER

### @AclRoles

Strings from the ACL Roles, no brackets required

### @ServerAclSecurity

Allowed values are from `com.hcl.domino.security.ServerAclType`

- SERVER_ADMIN
- FULL_ADMIN
- DATABASE_ADMIN
- CREATE_DATABASE
- CREATE_REPLICA
- CREATE_MASTER_TEMPLATE

### @ServerEclSecurity

Allowed values are from `com.hcl.domino.security.ServerEclType`

- RUN_UNRESTRICTED_CODE
- RUN_RESTRICTED_CODE
- RUN_FORMULA

### Example

```java
@MinimumAcl(AclLevel.EDITOR)
@ServerEclSecurity(ServerEclType.RUN_UNRESTRICTED_CODE)
public class MyFancyExtension extends AsyncDominoJNXBuffer {

@Override
  public void process(final DbRequestParameters<Buffer> request) throws Exception {
    request.validate();
    // YOUR CODE GOES HERE
  }
}
```
