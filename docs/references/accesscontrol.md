# Access control

The Domino REST API requires the various [roles](usingdominorestapi/roles.md) to have matching Access control levels as follows:

## Domino API administrator

- should be member of the group `LocalKeepAdmins`
- `LocalKeepAdmins` by default has `Editor` access to `KeepConfig.nsf`

The [Domino API Administrator](../references/usingdominorestapi/roles.md#dominodomino-rest-api-administrator) creates **scopes** and (OAuth) applications. They don't create schemas, that's the responsibility of the [Domino Developer](../references/usingdominorestapi/roles.md#domino-developer). They need reader access to the application databases.

## Domino developer

The [Domino Developer](../references/usingdominorestapi/roles.md#domino-developer) creates **schemas**. A schema resides in the individual database. To create, update or delete a schema they need `Designer` access to the application database. Access to `KeepConfig.nsf` can be as little as `Reader`,which is the default.

<!-- prettier-ignore -->
!!! note "Roles aren't mutually exclusive"
    The various roles aren't mutually exclusive. A user can have both administrator and developer roles. In this case, they need the sum of access rights.

## Application access

The Domino REST API provides its own IdP (Identity Provider) implementation following OICD standards. Applications are configured using a `client_id` and a `client_secret` to request access on behalf of an user.

When an enterprise IdP shall be used, the resulting `AccessToken` needs to comply with the [Domino REST API JWT specification](jwt.md)

## Anonymous access

The Domino REST API **does NOT** support anonymous access.

## Access via curl / Postman

Direct access to configuration via `curl` or `Postman` has the same access requirements as the AdminUI. The request header needs to have a `Authorization: Bearer heading` with a valid [JWT](jwt.md) token. Since direct access doesn't perform lookups, only access to the target database, `KeepConfig.nsf` for administrators and the application databases for developers will need to be set correctly.
