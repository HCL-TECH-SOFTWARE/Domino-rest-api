|Parameter|Description|
|:----|:----|
|PORT: 8880|HTTP(S) port for the Domino REST API service.|
|METRICSPORT: 8890|Endpoint for [Prometheus](https://prometheus.io/) Metrics.|
|JwtDuration|Lifetime in seconds for the internal JWT provider. Default value is 2 hours.|
|maxJwtDuration|Maximum lifetime in seconds that the JWT tokens get accepted. Default value is 24 hours.|
|TLSFile|TLS file with key for jks, pem or pfx.|
|TLSPassword|Password for jks and pfx key file.|
|HEALTHCHECK_USER|Username for accessing Health check (Port 8886)|
|HEALTHCHECK_PASSWORD|Password for accessing Health check (Port 8886)|

