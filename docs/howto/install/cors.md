# Configure CORS for AdminUI, OAuth and your applications

## About this task

The [CORS protocol](https://fetch.spec.whatwg.org/#http-cors-protocol) is designed to prevent accidential data leakage. A client (Browser, curl, Postman, Bruno etc.) presents an [`origin`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Origin) to DRAPI to gain access to valid responses. Browsers do that automatically when the origin schema, hostname or **port** differ from DRAPI. Commandline or developer tools like curl or Bruno don't automatically sen the `origin` header and thus are not subject to a CORS check. Same applies to server code like NodeJS, Java or GO

!!! tip "You can avoid CORS"

    DRAPI allows to [host your static applications](../../references/hostingstatic.md) which doesn't require additional CORS setup besides your host

## Procedure

Lets presume the following setup

- Your DRAPI host is `https://drapi.company.com:8880`
- You have multiple servers hosting static applications: `https://sales.company.com` and `https://***.otherdomain.com` (running on different ports)
- For development you want to allow `http://localhost:5438`

Cors mapping uses [Java Regular Expressions](https://www.w3schools.com/java/java_regex.asp) (Regex)

!!! tip "Use a Regex tool"

    Regex can be hard to decipher and understand due to their syntax and flexibility. To test if a Regex does what you want, use an [online interactive tool](https://regex101.com/) for validation. Make sure to pick the Java flavor.

Create a JSON file in `keepconfig.d` E.g. `cors.json` that contains one element per regex with the value `true`. If you need to temporay disable an entry, you can set it to false. Make sure you understand [DRAPI configuration](../../references/understandingconfig.md)

The regex for `https://drapi.company.com:8880` is `https:\\/\\/.drapi\\.mycompany\.com:8880$`

!!! note

    Inside JSON, the `\` of Regex gets escaped to `\\`.

### A few pointers

- `^` &rarr; beginning of the string
- `http` &rarr; the literal string `http`
- `s?` &rarr; optional the string `s`
- `\\/` &rarr; double escape the string `/`
- `.*` &rarr; one or more characters of any type
- `\\.` &rarr; double escape the string `.`
- `(?:\\:\\d+)?` &rarr; double escaped optional colon and port number
- `$` &rarr; end of string

## Expected result

```json
{
  "CORS": {
    "^https?:\\/\\/localhost(?:\\:\\d+)?$": true,
    "^https:\\/\\/.*\\.otherdomain\\.com(?:\\:\\d+)?$": true,
    "^https:\\/\\/drapi.company\\.com\\:8880$": true,
    "^https:\\/\\/sales.company\\.com$": true
  }
}
```

!!! tip "You need to include your host"

    The CORS implementation is designed to be restrictive, any HTTP request presenting an `origin` header will be checked
    against your configuration and denied if no match can be found. The [CORS specification](https://fetch.spec.whatwg.org/#http-cors-protocol) states:

    *Ultimately server developers have a lot of freedom in how they handle HTTP responses and these tactics can differ between the response to the [CORS-preflight request](https://fetch.spec.whatwg.org/#cors-preflight-request) and the [CORS request](https://fetch.spec.whatwg.org/#cors-request) that follows it*

    We decided on the side of caution, and fail any request that is not a match for a presented `origin` header. As a result you have to include your DRAPI host in your CORS setup.

!!! tip

    To check Domino REST API settings, see [Check Domino REST API settings](../management/checksettings.md).

## Calling DRAPI from your browser based application

You can use the browser's build in [Fetch API](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch) (for your favorite framework, check its documentation) with a simple function:

```js
const drapiFetch = async (url, method, token, body) => {
  const options = {
    method: method,
    mode: 'cors',
    headers: {
      Authorization: `Bearer ${token}`
    }
  };
  if (body) {
    options.body = JSON.stringify(body);
  }
  const response = await fetch(url, options);
  if (!response.ok) {
    throw new Error('Fetch failed');
  }
  const json = await response.body.json();
  return json;
};
```

This is just an example, you need to add error handling. To deal with chunked responses [check this out](https://www.wissel.net/blog/2023/07/handle-http-chunked-responses.html)

## Let's connect

--8<-- "feedback.md"
