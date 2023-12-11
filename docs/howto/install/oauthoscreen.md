# Configure oAuth consent screen

!!!warning
    - This experimental feature is not essential for you to gain recognition. Exercise caution when attempting this. Proficiency in HTML, CSS, and Javascript is essential for this role. It's important to have an excellent understanding of the screen's structure and build.

The oAuth consent screen makes use of [Mustache](https://mustache.github.io/) to populate the variables within {{customs}}.

## About this task

The procedure guides you to customized your oAuth consent screen  with Domino REST API using your own html file.

## Prerequisites

- You must know about `oauth.nsf` and configure Domino REST API.
- You must add `OAuthAdmin` role for the ACL entry that gives your server manager access to the `oauth.nsf`
- You must be proficient in using the HTML, CSS and Javascript
- You must know how to configure and understand the structure of oAuth consent screen


## Procedure

!!! warning "Caution"
     This is subject to change. Consult Domino REST API documentation (or code, or experts) for the latest steps. Currently, these general steps must be performed:

1.	Create a JSON file using a text editor.
2.	Copy the JSON object to the JSON file.

    ```json
    {
    "oauth": {
        "active": true,
        "alternateConsentDir": "directory",
        "database": "oauth.nsf",
        "url": "http://yourquickstarthost-qs-keep-8880.qs.hcllabs.net",
        "authCodeExpiresIn": 120,
        "accessTokenExpiresIn": 3600,
        "refreshTokenExpiresIn": 525600
    }
    }
    ```

3.	Change the value of the `alternateConsentDir` parameter to your preferred file location where your .html file is located.
In the example, the file location is D:customOAuthscreen/html. 

    ```json
    {
    "oauth": {
        "active": true,
        "alternateConsentDir": "D:customOAuthscreen/html",
        "database": "oauth.nsf",
        "url": "http://yourquickstarthost-qs-keep-8880.qs.hcllabs.net",
        "authCodeExpiresIn": 120,
        "accessTokenExpiresIn": 3600,
        "refreshTokenExpiresIn": 525600
    }
    }
    ``` 
    !!!note
        The `alternateConsentDir` is the directory where you configure your oAuth consent screen. Using the .html file located in this directory, it customizes the oAuth consent screen according to your design.

4.	Save the JSON file in the `keepconfig.d` directory.

    !!!tip
        Use a filename for the JSON file that reveals its purpose. To learn more on how JSON files in `keepconfig.d` are processed, see [Understanding configuration](../production/configparam.md#understanding-configuration).

5.	Restart Domino REST API on all servers.

!!!tip "Support"
   If you encounter any issues with the oAuth consent screen, you can revert to the default settings by removing the `alternateConsentDir` in the `oauth.json` configuration. 



