# Lab 10 - Configure JWT

Out of the box KEEP uses a random symmetrical JWT signing key, that's changed on any reboot of the API. This is OK for test and single server use, but not for multi-server operation or use as IdP.

## Duration 20 min

## What you will learn

- How KEEP configuration works
- Additional endpoints beyond 8880
- Use the management UI

## Prerequisites

- Domino running

## Steps

- Access [http://localhost:8889](http://localhost:8889)

![ManagementConsole](img/ManagementConsole.png)

- Fill in **Certificate Name**, and click **Create IdP Certificate**.
- Restart Domino REST API. 

## How to check

- New files in `keepconfig.d`, such as when you filled in `KeepLabIdP` as Certificate Name, you end up with:
    - `KeepLabIdP.json`
    - `KeepLabIdP.cert.pem`
    - `KeepLabIdP.private.key.pem`
    - `KeepLabIdP.public.key.pem`
- on restart keep: JWT provider changes (see login in KEEP).

When you copy these files to another server, the JWT issued by the first server will be accepted by the second server as well. This extends to the Domino HTTP task if core Domino is configured for JWT.

Check [`http://localhost:8880/.well-known/openid-configuration`](http://localhost:8880/.well-known/openid-configuration).

![OpenID config](img/Openidconfig.png)

## Things to explore

- [Official Domino REST API documentation](https://opensource.hcltechsw.com/Domino-rest-api/index.html)

- [Discord discussion](https://discord.com/invite/jmRHpDRnH4)

- Copy files generated to another server and try cross login.
