# Configure CORS

## About this task

The procedure guides you in configuring [Cross-Origin Resource Sharing (CORS)](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/CORS "Opens a new tab"){: target="_blank" rel="noopener noreferrer"}&nbsp;![link image](../../../assets/images/external-link.svg){: style="height:15px;width:15px"} to allow approved web applications, the **Admin UI**, and OAuth clients to securely access the Domino REST API from different domains, hosts, or ports.

## Before you begin

- Domino REST API is installed.
- You have administrator access to the Domino server.
- You know the domains and ports that will access the API.

    ??? tip "Default ports"

        |Port|Description|
        |:---|:---|
        |Data port (8880)|Main port used by the Domino REST API. Default authentication uses the user name and Internet password of the person document.|
        |Healthcheck port (8886)|Used to verify whether Domino REST API is up using the `/health` endpoint. It has its own functional account that doesn't provide access to other ports.|
        |Management port (8889)|Provides access to the Domino REST API runtime behavior, such as current configuration, runtime information, or Domino REST API shutdown and restart. It's recommended that the port be blocked and accessed only from localhost. It has its own functional account that doesn't provide access to other ports.|
        |Prometheus metrics port (8890)|Provides metrics in Prometheus format. It has its own functional account that doesn't provide access to other ports.|

- You know the location of the Domino REST API configuration directory (`keepconfig.d`).

## Procedure

1. Identify and document every origin that must access Domino REST API.

    Example:

    |Origin|Description|
    |:---|:---|
    |https://sales.company.com</br>https://***.otherdomain.com|Servers hosting static applications|
    |http://localhost:5438|Local machine for development|
    |https://drapi.company.com:8880|Domino REST API host|

2. Create a CORS configuration file in JSON format in the [`keepconfig.d`](../../../references/standards.md#keepconfigd) directory.

    Example: `cors.json`

    !!! tip

        Use a filename for the JSON file that reveals its purpose. To learn more on how JSON files in `keepconfig.d` are processed, see [Configuration management and overlay hierarchy](../../../references/configuration/understandingconfig.md).

3. Define the CORS rules in the CORS configuration file.

    !!! note

        The CORS implementation is intentionally restrictive. Any HTTP request that includes an `Origin` header is checked against the configured CORS rules and is denied if no match is found. Therefore, **you must include your Domino REST API host in the CORS configuration** to allow requests originating from that host. 

    === "For Domino REST API v1.1.3 and later"

        The following example shows CORS rules for the example origins using [Regular expression (Regex)](https://en.wikipedia.org/wiki/Regular_expression 'Opens a new tab'){: target="\_blank" rel="noopener noreferrer"}&nbsp;![link image](../../../assets/images/external-link.svg){: style="height:15px;width:15px"}.

        ```json
        {
            "CORS": {
              "^https?:\\/\\/localhost(?:\\:\\d+)?$": true,
              "^https?:\\/\\/.*\\.otherdomain\\.com(?:\\:\\d+)?$": true,
              "^https?:\\/\\/drapi\\.company\\.com\\:8880?$": true,
              "^https?:\\/\\/sales\\.company\\.com(?:\\:\\d+)?$": true
            }
        }
        ```
        
        - The `"^https?:\\/\\/localhost(?:\\:\\d+)?$"` entry allows requests from `localhost` on any port. Therefore, port 5438 does not need to be specified separately. 
        - Set the value to `false` to disable access for the origin.
        - A leading dot (.) indicates a domain wildcard. For example, `"^https?:\\/\\/.*\\.otherdomain\\.com(?:\\:\\d+)?$"` allows requests from `otherdomain.com` and its subdomains. 
        
        To learn more about Regex, see [Additional information](#additional-information).

    === "For Domino REST API v1.1.2 and earlier"

        The following example shows CORS rules for the example origins.

        ```json
        {
            "CORS": {
              "localhost": true,
              ".otherdomain.com": true,
              "drapi.company.com": true,
              "sales.company.com": true
            }
        } 
        ```

        - The `"localhost"` entry allows requests from `localhost` on any port. Therefore, port 5438 does not need to be specified separately.
        - The `"drapi.company.com"` entry already allows requests from `https://drapi.company.com:8880`, which is the example origin of the Domino REST API host.
        - Set the value to `false` to disable access for the origin.
        - A leading dot (.) indicates a domain wildcard. For example, `".otherdomain.com"` allows requests from `otherdomain.com` and its subdomains.  

4. Save the JSON file.
5. Restart Domino REST API on all servers.

## Troubleshooting

If you encounter any error:

- Verify that the domain is listed in the CORS configuration.
- Confirm that the configuration file contains valid JSON.
- Check the browser console for CORS-related error messages.
- Verify that the regex is implemented correctly.

## Additional information

### Use a regex tool

Regular expressions can be difficult to read and validate due to their syntax and flexibility. Make sure that your regular expressions match the intended patterns by testing with an interactive tool, such as [Regex101](https://regex101.com/ 'Opens a new tab'){: target="\_blank" rel="noopener noreferrer"}&nbsp;![link image](../../../assets/images/external-link.svg){: style="height:15px;width:15px"}. Select the Java flavor to ensure the results reflect the behavior of the intended implementation.

### Regex pointers

- `^` &rarr; beginning of the string
- `http` &rarr; the literal string `http`
- `s?` &rarr; optional the string `s`
- `\\/` &rarr; double escape the string `/`
- `.*` &rarr; one or more characters of any type
- `\\.` &rarr; double escape the string `.`
- `(?:\\:\\d+)?` &rarr; double escaped optional colon and port number
- `$` &rarr; end of string

!!! note

    When a regular expression is specified in JSON, each backslash (`\`) must be escaped as `\\`.

## Next step

Proceed to [Check connectivity](connectivity.md).
