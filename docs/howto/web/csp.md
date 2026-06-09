# Configure CSP for front-end application hosted in the `keepweb.d` directory

## About this task

This task guides you on how to configure [Content Security Policy](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/CSP "Opens a new tab"){: target="_blank" rel="noopener noreferrer"}&nbsp;![link image](../../assets/images/external-link.svg){: style="height:15px;width:15px"} (CSP) settings for front-end applications hosted in the `keepweb.d` directory and served directly by the Domino REST API. Configuring the CSP helps to prevent or minimize security threats by controlling which resources can load scripts, stylesheets, fonts, APIs, and other resources from multiple sources.

## Before you begin

- Make sure that your front-end application is already deployed and accessible from the `keepweb.d` directory.
- Make sure you have the necessary access to files and permission to restart the Domino REST API service if required.
- Review the external resources used by your application, such as APIs, fonts, scripts, and hosted assets.

## Planning

A restrictive CSP provides a first layer of defense against content injection attacks. Spending time to tighten CSP rules can significantly improve application security. [Learn more about CSP](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/CSP "Opens a new tab"){: target="_blank" rel="noopener noreferrer"}&nbsp;![link image](../../assets/images/external-link.svg){: style="height:15px;width:15px"} and use the [CSP builder tool](https://report-uri.com/home/generate "Opens a new tab"){: target="_blank" rel="noopener noreferrer"}&nbsp;![link image](../../assets/images/external-link.svg){: style="height:15px;width:15px"}.

Start by implementing a strict CSP configuration and enabling report-only mode first. In this mode, the browser logs CSP violations without blocking content, allowing you to identify the required resource sources and make adjustment to the policy before enforcement.  

Example of a strict CSP configuration that reports CSP violation that you can add to the `manifest.json`.

```json
{
    "csp": "default-src 'self'; object-src 'none'; base-uri 'none'; frame-ancestors 'none'; script-src 'nonce-YOUR_SERVER_NONCE' 'strict-dynamic'; img-src 'self' data:; font-src 'self'; connect-src 'self'; report-uri /api/csp-violation-report;"
}
```

## Procedure

1. Go to your application folder in the `keepweb.d` directory, and open the `manifest.json` file.

    !!! note

        If your application folder does not have a `manifest.json` file, you need to create one before proceeding. To learn more on how to create the `manifest.json` file, see [Additional information](#additional-information). 

2. Add the `csp` section in the `manifest.json` file.
3. Define the required CSP directives based on the resources used by your application.

    For example:

    ```json
    {
        "short_name": "Doc Editor",
        "name": "Edit your MS Office documents",
        "start_url": ".",
        "display": "standalone",
        "theme_color": "#000000",
        "background_color": "#aacccc",
        "icon": "office-center.png",
        "csp": "default-src 'self'; img-src 'self' data:; report-uri /api/csp-violation-report; connect-src 'self' https://office.projectkeep.io; font-src 'self';"
    }
    ```

    In the example, refer to the following table for the description of the CSP directives added to the `manifest.json` file:

    |CSP directive|Description|
    |:---|:---|
    |default-src|The fallback directive for all fetch directives.</br></br>The `'self'` value restricts the loading of resources (such as scripts, images, or stylesheets) to the exact same origin as the document being viewed. This means content is only allowed to load if it shares the same protocol, host, and port.|
    |img-src|Defines permitted sources for loading images.</br></br>The `'self' data` value allows the loading of local images and Base64-encoded inline images, but strictly blocks images loaded from any external, unlisted websites.|
    |report-uri|Reports CSP violation attempts to a specified URL.</br></br>In the example, CSP violation attemps will be reported to `/api/csp-violation-report`|
    |connect-src|Restricts the URLs to which you can make API requests using interfaces like `fetch()`.</br></br> In the example, the `'self'` value allows requests to APIs from the same origin as the document. The `https://office.projectkeep.io` value allows the front-end application to make API or network requests to that domain.</br></br>**This directive is required if the front-end application connects to external APIs or non-Domino REST services. Add the required endpoints to this directive.**|
    |font-src|Sets the origin from which fonts can be downloaded.</br></br>The `'self'` value restricts the loading of the fonts from the same origin as the document.|

    !!! tip

        For more information on other available directives, see [CSP Directives](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Content-Security-Policy#directives "Opens a new tab"){: target="_blank" rel="noopener noreferrer"}&nbsp;![link image](../../assets/images/external-link.svg){: style="height:15px;width:15px"}.

4. Save the `manifest.json` file.
5. Restart the Domino REST API service or redeploy the application to apply the updated CSP settings.
6. Open the front-end application hosted in the `keepweb.d` and verify that all resources load correctly.
7. Check the browser developer console for CSP-related errors and update the configuration if additional resource sources must be allowed.

!!! warning "Important"

    Perform this procedure for each front-end application in the `keepweb.d` directory that requires a CSP to be configured. 

## Additional information

In case your front-end application does not have a `manifest.json` file, follow the steps below to create one.

1. Create a plain text document and save it as `manifest.json` in the folder of your front-end application in the `keepwed.d` directory.
2. Populate the `manifest.json` file with key-value pairs. Refer to the table for the common manifest members for details:

    |Manifest member|Description|
    |:--|:--|
    |name|Specifies the full name of your web application as it's usually displayed to users.|
    |short_name|Specifies a short name for your web application, which may be used when the full name is too long for the available space.|
    |start_url|Specifies the URL that should be opened when launching your application.</br></br>When the value of this manifest member is `"."`, it tells the browser to launch the application at the current directory or folder where the `manifest.json` is located. This typically directs users to the root of your domain, for example, https://example.com/|
    |display|Specifies your preferred display mode for the application.</br></br>A value of `"standalone"` hides browser UI, like the URL bar. Other value options include `"fullscreen"` or `"minimal-ui"`.|
    |background_color|Specifies an initial background color for your application. This color appears in the application window before your application's stylesheets have loaded.|
    |theme_color|Specifies the default color for your web application's user interface.|
    |icons|Specifies one or more image files that define the icons to represent your web application.|

    !!! tip

        For more information on other manifest members, see [Manifest members reference](https://developer.mozilla.org/en-US/docs/Web/Progressive_web_apps/Manifest/Reference "Opens a new tab"){: target="_blank" rel="noopener noreferrer"}&nbsp;![link image](../../assets/images/external-link.svg){: style="height:15px;width:15px"}.

3. Save the `manifest.json`.
