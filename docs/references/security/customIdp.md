# Custom Identity Provider (IdP)

Domino REST API requires an access token in [JWT](https://jwt.io/) ([RFC 7519](https://tools.ietf.org/html/rfc7519)) format. As long as Domino REST API trusts the signature of the presented token, it does not matter how the token was obtained.

<!-- prettier-ignore -->
!!!error "Caution"

    Check carefully which systems you trust to provide identity. They hold the key to data access.

When none of the existing IdP solutions fit your needs, you can use a custom provider that generates your JWT token. Just make sure, such code isn't accessible for abuse as unauthorized impersonation.

## Sample function

This function turns a given user name and scope into a signed JWT token.

```js
const template = require('./template.json');
const jwt = require('jsonwebtoken');
const fs = require('fs');
const privateKey = fs.readFileSync('private.key');

const signOptions = {
  algorithm: 'RS256',
  expiresIn: `${template.expSeconds}s`,
  mutatePayload: true
};

const renderJwt = (sub, scope) => {
  const claim = { sub, scope, ...template };
  const bearer = jwt.sign(claim, privateKey, signOptions);
  return { bearer: bearer, ...claim };
};

module.export = { renderJwt };
```

Error handling omitted for clarity.

## The template

```json
{
  "iss": "Joe and the wailors",
  "aud": "Domino",
  "expSeconds": 3000
}
```

## Dependencies

This the relevant part of the `package.json`.

```json
"dependencies": {
    "jsonwebtoken": "^8.5.1"
  }
```

## Keys you need

You need to generate a public/private key pair.

```shell
ssh-keygen -t rsa -b 4096 -m PEM -f private.key
openssl rsa -in private.key -pubout -outform PEM -out public.key.pub
```
