# Deprecated features

The following features are deprecated from this and earlier releases. 

## v1.0.9

|Deprecation|Recommendation|Additional information|
|:----|:----|:----|
|Use of `dataSource` or a path to an NSF in the `dataSource` parameter by most admin-v1 endpoints.|Use the parameter `nsfPath` to specify the path to an NSF.|The use of `dataSource` or path to an NSF in the `dataSource` parameter has been deprecated.|

<!--## v1.0.7

|Deprecation|Recommendation|Additional information|
|:----|:----|:----|
|Use of `dataSource` or a path to an NSF in the `dataSource` parameter by most admin-v1 endpoints.|Use the parameter `dataSource` for a valid `dataSource` or the parameter `nsfPath` to specify the path to an NSF.|The use of `dataSource` or path to an NSF in the `dataSource` parameter is still supported but will be removed in **Domino REST API v1.0.9**. Until then, found usage will be logged in the `domino-keep.log` file, and the response for that call will contain the header `X-API-Status : deprecated`.|-->