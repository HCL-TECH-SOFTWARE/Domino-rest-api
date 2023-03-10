# HTTP handler

The HTTP handler accepts incoming requests defined in the OpenAPI specification and sends them, if they are in compliance with the specification, to the [EventBus](eventbus.md).

![Data from HTTP to eventBus](../assets/images/HTTPtoEventBus.png)

All incoming request parts get mapped:

- Headers
- Cookies
- Path parameters
- Query parameters
- Body
