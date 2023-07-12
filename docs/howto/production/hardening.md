# Hardend production setup

The Domino REST API can be configured to run without configuration and admin access on the server that hosts production databases. Let us outline how.

![Production layout](../../assets/images/access/productionsample.jpg)

- the admin server is only accessible by administrators and not reachable from the general network
- The Domino REST API is installed on both servers
- the `KeepConfig.nsf` replicates between admin and production server
- we have a TLS certificate `thecertificate.pem`
- the password for the tls certificate is provided as environment parameter `TLSPassword`
- the production server has a hardened config using `hardening.json`
- Domino's nhttp isn't running or is not using Port 443

## hardening.json

The name, as long as it ends in `.json`, can ve choosen freely. It needs to be placed into the `keepconfig.d` directory.

![hardened JSON](../../assets/images/hardening.json.png)

```json
{
  "CORS": {
    "localhost": false,
    ".local": false
  },
  "DEBUG": false,
  "DisableEventBusSocket": true,
  "enabledProtocols": {
    "TLSv1.2": false
  },
  "PORT": 443,
  "showDeprecatedEndpoints": false,
  "showPreviewFeatures": false,
  "TLSFile": "thecertificate.pem",
  "TLSType": "pem",
  "versions": {
    "setup": {
      "active": false
    },
    "admin": {
      "active": false
    }
  },
  "verticles": {
    "Design": {
      "active": false
    },
    "KeepAdmin": {
      "active": false
    },
    "AdminAccess": {
      "active": false
    },
    "Firehose": {
      "active": false
    }
  }
}
```

## Things to consider

- Are all API consumers capable of TLS 1.3?
- Do you need CORS support for static application on other servers?
- Shall the Domino REST API serve as Identity Provider (IdP) or is there a corporate IdP to be used?

YMMV

## Let's connect

--8<-- "feedback.md"
