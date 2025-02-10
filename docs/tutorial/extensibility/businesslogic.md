# Implementing business logic

To implement functionality two Java classes get involved. A handler class that takes in the http request and forwards it on the Eventbus and a dbrequest class that performs the database interaction.

For the most common use case of JSON in/out, the default handler performs all the necessary actions, no custom code is required.

![Default handler](../../assets/images/HTTPtoEventBus.png)

## Handlers

The handler is part of the initial REST processing which includes:

- Checking the validity of the JWT Token
- Ckecking the conformance to the API specification (all mandatory fields present, reject extra fields when specified so in the API)
- Gather all parameters and body for the EventBus
- Prepare response type chunked for Array or blob returns

All of that is take care of.

## DBRequests

We have two OperationIDs to take care of: `getApprovals` and `submitDecision`. The will both act on the database specified in the `dataSource` query parameter and accept / return JSON data. There is some overlap in utility methods needed, we shall entertain a utility class for that. Both will extend the abstract class `AsyncDominoJNXJson` which only needs the method `process` to be implemented.

## Primer on DbRequestParameters<?>

The class provides convenient access to everthing needed to implement a custom functionality:

| Property / Method        | Type           | Purpose                                            |
| ------------------------ | -------------- | -------------------------------------------------- |
| `client`                 | DominoClient   | Access to the Domino API                           |
| `db` or `db()`           | DominoDatabase | the database specified in dataSource               |
| `incoming`               | JSON Object    | All parameters, headers, body                      |
| `factory`                | Keepfactory    | Access to helper objects & methods                 |
| `session` or `session()` | KeepJNXSession | EntryPoint for regular operations, user, other dbs |
| emit(JsonObject)         | void           | Sending data back, can be called more than once    |

There are a few more, check the JavaDoc for details.

In a nutshell: the `process` method needs to call `emit()` at least once or throw an error. When the return type ia an array, it can call `emit()` multiple times.

### Errors to throw

While you can throw any [Exception](https://docs.oracle.com/en/java/javase/17/docs/api/java.base/java/lang/Exception.html) to terminate a failed operation, DRAPI has a set of Exception classses that determine how the exception maps to a http status code.

![KEEP Exceptions](../../assets/images/KeepErrors.png)

### GetApprovals

### SubmitDecision

## Testing

!!! info "Next"

    [Access Control](accesscontrol.md)

## Let's connect

--8<-- "feedback.md"
