# Change Log

This page lists the changes in each release. For the latest version information, see [What's New](whatisnew.md).

## 1.7 Beta EA

- Update vert.x to 4.3.3
- Update all Java dependencies
- Fixed large amount of AdminUI and other bugs
- Installer for Windows and Linux (Java command line) available (Container image too)
- Updated Postman examples
- Updated landing page
- OpenAPI display now has dropdown showing all schemas
- Updated RichText to MIME, RichText to Markdown rendering
- [Functional accounts](functionalUsers.md) are now stored in JSON file

## 1.6 Beta EA

- Dropped Domino versioning, switched to Domino REST API's internal version
- Updated vert.x to 4.3.0
- Updated all Java dependencies
- Docker container uses Domino 12.0.2 BETA
- Database specific Domino REST API configurations now stored as design elements in database (thus also editable from Domino designer)
- reworked configuration format, close to JSON schema
- New end point `/listpivot` for server side pivot operations
- Updated admin UI
- Consistency enforcement for JSON. Fields defined as multi-value will always return array regardless of note content. Fields defined as single value will never return an array
- Domino REST API Schema caters to Names, Readers, Authors
- OAuth IdP functionality for Domino REST API applications
- extended info in JWT token
- related multi-value fields can be configured to return combined records

## 12.0.1-EarlyAccess Beta3

- Java based installer that works on all platforms (bugs fixed)
- Docker container uses Domino 12.0.1 Beta
- New endpoints
  - bulk/create
  - bulk/update
  - vcalendar/{calid}/{unid}
- Updated Postman test
- Start script fixes
- vert.x updated to 4.2.0
- Dependencies updated
- Reworked Domino REST API task (no more pipe errors)

## 12.0.1-EarlyAccess Beta2

- **Installer**: The downloads now include the Java based installer. See [installation](../tutorial/installconfig/index.md) for details. Currently the installer has been tested on Linux only but you are free to try.
- OData now is read/write for OData clients supporting write operations (such as [Salesforce](../tutorial/odata/salesforce.md)).
- Updated all Java dependencies to the latest available version.
- Improved startup sequence: eliminated dependency on DXL to bootstrap Domino REST API, hence making the process more stable.
- New Domino server add-in task created for Domino REST API. You now can start Domino REST API using `load keep` at the Domino server console.
- Bugs squashed, documentation updated, typos hunted down.
