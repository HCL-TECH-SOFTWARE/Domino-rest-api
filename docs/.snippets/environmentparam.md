| Parameter            | Description                                                                      |
| :------------------- | :------------------------------------------------------------------------------- |
| PORT: 8880           | HTTP(S) port for the Domino REST API service.                                               |
| ADMINPORT: 8889      | HTTP Port for the Admin listener. It should not be reachable from outside.       |
| METRICSPORT: 8890    | Endpoint for [Prometheus](https://prometheus.io/) Metrics.                                                 |
| GodeMode: true/false | Should local users in KeepConfig be recognized.                                  |
| JwtDuration          | Lifetime in minutes for the internal JWT provider. Default value is 60mins.      |
| JwtMaxDuration       | Maximum lifetime in minutes that the JWT tokens get accepted.                    |
| DEBUG: true/false    | Debug mode. Creates more console output.                                         |
| PEMCert              | If your TLS is PEM format (e.g. LetsEncrypt), the path to the certificate file.  |
| TLSFile              | TLS file with key for jks, pem or pfx.                                           |
| TLSPassword          | Password for jks and pfx key file.                                               |
| shutdownkey          | Passphrase for posting to http://localhost:adminport/shutdown to shut down Domino REST API. |