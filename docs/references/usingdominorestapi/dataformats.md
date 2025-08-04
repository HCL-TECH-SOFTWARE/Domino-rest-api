# DataFormats

## Domino and JSON data formats

The Domino REST API translates data between native Domino structures and JSON schema-derived formats. Since this translation is not a one-to-one mapping, please refer to the following tables for details on supported conversions:
<!--The Domino REST API translates between native Domino and JSON schema derived data. Since it isn't a 1:1 mapping, refer to the following tables:-->

### Single Values, JSON to Domino

| Schema       | JSON native | Text[^1] | Number | Date | RichText |
| :----        | :----       | :--- | :----- | :--- | :------- |
| String       | String      | &#10003; | &#10003;| &#10003;| &#10003;|
| Password     | String      | &#10003; | &#10003;| &#10003;| &#10003;|
| int32        | Number      | &#10003; | &#10003;| &#10003;| &#10003;|
| int64        | Number      | &#10003; | &#10003;| &#10003;| &#10003;|
| Float        | Number      | &#10003; | &#10003;| &#10003;| &#10003;|
| Double       | Number      | &#10003; | &#10003;| &#10003;| &#10003;|
| Date         | String      | &#10003; | &#10003;| &#10003;| &#10003;|
| DateTime     | String      | &#10003; | &#10003;| &#10003;| &#10003;|
| Byte         | String      | &#10003; | &#10003;| &#10003;| &#10003;|
| Boolean      | Boolean     | &#10003; | &#10003;| &#10003;| &#10003;|
| Names        | String      | &#10003; | &#10003;| &#10003;| &#10003;|
| Readers      | String      | &#10003; | &#10003;| &#10003;| &#10003;|
| Authors      | String      | &#10003; | &#10003;| &#10003;| &#10003;|
| RichText[^2] | String      | &#10003; | &#10003;| &#10003;| &#10003;|
| RichText[^2] | Object      | &#10003; | &#10003;| &#10003;| &#10003;|

[^1]: Text includes Names, Authors, Readers
[^2]: RichText can be MIME in Base64, plain, or an Object

![Notes field hierarchy](../../assets/images/FieldStructure.png)

### Multi Values JSON to Domino

Incoming JSON data is received as JSON arrays and converted into multi-value Notes items. The rules outlined in the table above apply.

### Single Values, Domino to JSON

Domino documents may or may not contain the expected items, and those items might not always conform to the expected data format. The following table summarizes which cases are supported:

| Schema       | JSON native | Text | Number | Date | RichText |
| :----        | :----       | :--- | :----- | :--- | :------- |
| String       | String      | &#10003; | &#10003;| &#10003;| &#10003;|
| Password     | String      | &#10003; | &#10003;| &#10003;| &#10003;|
| int32        | Number      | &#10003; | &#10003;| &#10003;| &#10003;|
| int64        | Number      | &#10003; | &#10003;| &#10003;| &#10003;|
| Float        | Number      | &#10003; | &#10003;| &#10003;| &#10003;|
| Double       | Number      | &#10003; | &#10003;| &#10003;| &#10003;|
| Date         | String      | &#120;   | &#120;  | &#10003;| &#120;  |
| DateTime     | String      | &#120;   | &#120;  | &#10003;| &#120;  |
| Byte         | String      | &#10003; | &#10003;| &#10003;| &#10003;|
| Boolean      | Boolean     | &#10003; | &#10003;| &#10003;| &#10003;|
| Names        | String      | &#10003; | &#10003;| &#10003;| &#10003;|
| Readers      | String      | &#10003; | &#10003;| &#10003;| &#10003;|
| Authors      | String      | &#10003; | &#10003;| &#10003;| &#10003;|
| RichText[^3] | Object      | &#10003; | &#10003;| &#10003;| &#10003;|

[^3]: RichText is always returned as JSON object. For more information, see [Rich Text](./richtext/index.md).

### Multi Values, Domino to JSON

- Multiple Values are retrieved as a JSON array.
- When defined as single value in the Schema, but contains more than 1 value, only the first value is returned.
