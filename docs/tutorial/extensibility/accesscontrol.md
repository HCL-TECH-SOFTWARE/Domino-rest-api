# Access Control

DRAPI follows Domino's access control, there's no sidestepping. You can however tighten the screws to be very specific on individual access requirements.

## Access Annotations

You can decorate each request class with a series of [Java annotations](https://en.wikipedia.org/wiki/Java_annotation) to both document and early enforce access requirements:

- `@MinimumAcl(AclLevel)` - specify the required ACL access. While e.g. Editor access suffices for updating a document, you can specify that this function requires Designer access
- `@AclAttributes(AclAccessFlags)` - require specific flags like `CreateDocuments` or `CreateSharedFoldersViews`, all the checkboxes in the ACL
- `@AclRoles(String[])` - User must have one of the roles to perform the operation
- `@ServerAclSecurity(ServerAclType)` - required Server ACL entries like `SERVER_ADMIN`, `FULL_ADMIN`, `DATABASE_ADMIN` and more
- `@ServerEclSecurity(ServerEclType)` - required execution permissions like `RUN_UNRESTRICTED_CODE`, `RUN_RESTRICTED_CODE` and `RUN_FORMULA`

So your class could look like this:

```java
@MinimumAcl(AclLevel.AUTHOR)
@AclAttributes({AclAccessFlags.CreateDocuments})
@AclRoles({"Approver"})
public class SubmitDecision extends AsyncDominoJNXJson {
  public void process(final DbRequestParameters<JsonObject> request) throws Exception {
    request.validate();
    // Your code goes here
  }
}
```

## Helper methods

There are a number of helper methods available to perform common checks. Most of them can be found in the `KeepJnxSession`, or as static methods in `DocumentFunctions` check the JavaDoc for details:

- `Optional<Document> session.getDocumentByUNID(request.db, unid, DocumentScope.VALID_DOCUMENTS_ONLY)`
- `Document validateDocumentAccessRequest(final Database db, final String unid, final DocumentAccess docAccess, final Optional<KeepRequestId> requestId)`
- `Document createDocFromJson(final Database db, final JsonObject body)`
- `void updateDocumentFromJson(final JsonObject jsonSource, final Document doc)`
- `JsonObject DocumentFunctions.document2Json(doc, includeMeta)`

Typical code pattern would look like this:

```java
// Get a specific document
final Optional<Document> optionalNote = request.session.getDocumentByUNID(request.db, unid, DocumentScope.VALID_DOCUMENTS_ONLY);

// Throw an error
final Document note = optionalNote.orElseThrow(() -> new KeepExceptionNotFound(KeepExceptionStrings.NO_DOCUMENT_ACCESS, unid));

// Create a new doc
final Document note = optionalNote.orElse(() -> db.createDocument());
```

## Priviledged operations

A typical requirement in web applications is the need for operation specific elevated priviledges. E.g. you want the default access for "ApprovalLog.nsf" to be Reader,
so nobody can manually create or alter documents, but the code in `SubmitDecision` needs to be able to create. For this scenario, the `KeepJnxSession` allows to execute
operations as the server, using server privileges.

The modified code from [Business Logic](./businesslogic.md) would look like this:

```java
    try (KeepClient kc = request.session.getClientAsIDUser(); // Session as server
        Database approvalLog = kc.openDatabase("ApprovalLog.nsf")) {
      // Write to log
      Document logEntry = approvalLog.createDocument();
      logEntry.replaceItemValue("Form", "logentry");
      // like before
      logEntry.save();

      // Update document
      // like before
      doc.save();
    } catch (Exception e) {
      logger.error(e.getMessage());
      throw e;
    }
```

!!! failure "With great powers..."

    ...come great responsibilites. While this allows to have tight access control,
    it can backfire when not implemented carefully

!!! info "Next"

    [Deployment](deployment.md)

## Let's connect

--8<-- "feedback.md"
