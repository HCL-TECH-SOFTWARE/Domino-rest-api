# Using encryption, decryption, and signing during development

!!!warning "Important!"
    This functionality is only available if you've configured your Domino server. For more information, see [Set up Domino REST API for encryption, decryption, and signing](../../howto/production/signencrypt.md). 

## Encryption

When Field items in a Form mode's schema have the **Encrypt** option enabled, the endpoint payload must contain a `@encryption` JSON object to configure the encryption behavior:

- `keys` can be set to an array of named keys expected to be in the user's ID. These are the keys listed in **File**&nbsp;&rarr;**Security**&nbsp;&rarr;**User Security**&nbsp;&rarr;**Notes Data**&nbsp;&rarr;**Documents** in the Notes client. Developers must know what those key names are to be able to encrypt.
- `users` can be set to an array of usernames to encrypt the document for. When set, Domino will look up the public keys for those users and encrypt the items in a way they can read. Use the Canonical format of the name, for example `CN=test user/O=myorg`.

    !!!note
        If neither `keys` nor `users` are specified, the items are encrypted for the calling user only, which means only that user can decrypt those fields.

- `options` - (optional) The following options aren't typically necessary to include. For more information, search for these options in the [Domino C API](https://opensource.hcltechsw.com/domino-c-api-docs/).

    - `ENCRYPT_WITH_USER_PUBLIC_KEY` (the default)
    - `ENCRYPT_SMIME_IF_MIME_PRESENT`
    - `ENCRYPT_SMIME_NO_SENDER`
    - `ENCRYPT_SMIME_TRUST_ALL_CERTS`

If encryption is set for any items and the `@encryption` object, even an empty one, isn't present in the payload, it will fail with error message **E1130, This form mode requires encryption but no @encryption payload was provided**.

## Decryption

Decryption happens passively and requires no schema configuration or special endpoint request. When a document contains encrypted items, Domino REST API attempts to load the user's ID from the Vault and, if it can, tries to decrypt the document. If the user ID isn't accessible or the user doesn't have the keys to decrypt the document, a warning will be included in the payload's `@warnings` object.

## Signing

When a Form mode's schema has the **Sign Document** option enabled, creating or updating a document will result in an attempt to load the user's ID from the Vault and sign the document with the user's ID. If that's not possible, the operation will fail with the error message **E1131, Unable to retrieve user ID from Vault for cryptography operations**.

