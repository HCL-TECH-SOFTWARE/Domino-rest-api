# Configure oAuth consent screen

!!!warning
    This experimental feature is not essential for you to gain recognition. Exercise caution when attempting this. Proficiency in HTML, CSS, and Javascript is essential for this role. It's important to have an excellent understanding of the screen's structure and build. 

## About this task

The procedure guides you to customized your oAuth consent screen  with Domino REST API using your own html file.

## Prerequisites

- You must know how to configure and understand the architecture of oAuth consent screen.


## Procedure

1. Deploy oauth.nsf and configure Domino REST API to recognize that file.
2. Add OAuthAdmin role for the ACL entry that gives your server manager access to the oauth.nsf.
    To deploy and configure the NSF, place the following in the domino data directory (you may need to create the keepconfig.d folder if it doesn't already exist):

    [data folder]/oauth.nsf
    [data folder]/keepconfig.d/oauth.json
    An example of oauth.json is shown below. Expiration times can be adjusted. Make sure to replace the Domino REST API URL to match your Domino REST API host (a fictitious Quickstart Domino REST API url is shown in this example.).

    {
    "oauth": {
        "active": true,
        ""
        "database": "oauth.nsf",
        "url": "http://yourquickstarthost-qs-keep-8880.qs.hcllabs.net",
        "authCodeExpiresIn": 120,
        "accessTokenExpiresIn": 3600,
        "refreshTokenExpiresIn": 525600
    }
    }
Note

If you are using Domino+Domino REST API docker image, the oauth.nsf should already be "deployed" in the image but may not be fully configured. If for some reason you need to create oauth.nsf, see Set up oauth.nsf.