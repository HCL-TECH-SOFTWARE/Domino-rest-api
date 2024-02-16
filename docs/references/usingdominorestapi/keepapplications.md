# Domino REST API Applications

## Connecting your application to Domino REST API

Any programming language is able to connect to a REST API.
Depending on your approach, there are some particularities to observe.

We distinguish between client and server based applications.
**Client based applications** can access databases that have been marked for **Open Access**,
while **server based applications** can provide an application id and application secret to get a different level of access.

### Browser based applications

Browser based applications (ReactJS, Angular, Vue, VanillaJS) can be hosted on a different server than the URL of the Domino REST API.
To enable access to Domino REST API (besides the user's credential), [CORS](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS) need to be configured to allow access from the server providing
the static files to Domino REST API. This is configured in the `security.json` in the `CORS` section. You need to add your domain and set it to `true`. To simplify corporate deployment, we check domain endings only. Which means that `acme.com` covers `www.acme.com`, `hr.acme.com` or even `one.two.three.acme.com`.

The default entry in `security.json` is like this:

```json
"CORS": {
        "localhost": true,
        "hcl.com": true,
        ".local": true
    }
```

Let's say you want to disable the preset and enable `acme.com`, you create a `security.json` with this content:

```json
{
  "CORS": {
    "localhost": false,
    "hcl.com": false,
    ".local": false,
    "acme.com": true
  }
}
```

### Hosting your static application on Domino REST API

Frameworks like Angular, ReactJS, Swelte etc. usually generate a `build` directory with a set of static files.

You can copy that directory to `keepweb.d` in your Domino data directory and Domino REST API will serve them on the `/keepweb/` URL path. This eliminates the need for CORS configuration.

Check the details in [Security Configuration](../security/index.md).

### Server based applications

In the Admin UI (or the [Admin API](../../references/usingwebui/index.md)), we can define an "application" which consists of:

[![Application](../../assets/images/Application.png){: style="height:80%;width:80%"}](../../assets/images/Application.png){: target="_blank" rel="noopener noreferrer"}

1. Application Name.
2. Application Description.
3. AppID otherwise known as the Application ID.
4. Edit this Application.
5. Generate Application Secret.
6. If shown, notifies that a Client Secret has already been generated for this Application.
7. Delete this application.
8. Launch this application.

When creating a new Application, you will need to enter the Application Name and Description as well as one or more Callback URLs and Scopes, this provides access to Domino REST API schema that the application wants to get data from.

When the application presents AppID and ClientSecret in the header of a request, it can access the databases,
even when they're not defined as "Open Access". This information is required for an application to use an OAuth flow to gain access to data. Thus, an application server can have more access than a browser application.

Domino REST API offers an OAuth/OICD controlled access.

### Desktop applications

These are applications designed using Java or .NET, Electron or shell scripts with curl.

Since desktop applications can't keep secrets, we treat them like browser applications. They can only access Domino databases that are flagged for "Open Access". You don't need to worry about CORS setup, unless you are running a local http server. This is why localhost is in the default CORS permission list.
