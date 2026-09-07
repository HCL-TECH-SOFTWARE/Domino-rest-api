# Functional accounts

There are a series of endpoints that aren't associated with regular user IDs:

- Management console (Port 8889)
- Metrics endpoint (Port 8890)
- Health check (Port 8886)

    !!! tip

        You can also configure access to Health check (Port 8886) using the following environment parameters:
        
        - HEALTHCHECK_USER
        - HEALTHCHECK_PASSWORD

To enable access to those, you need functional accounts. The same applies to the use of Domino REST API in a local context when running on a client.

There are many reasons to keep these users separate from your enterprise directory:

- They need to be available when the directory isn't available.
- They don't need access to regular end points.

!!! note

    Functional account names are verbatim. Domino REST API doesn't accept any variations as you expect in a Domino login.
  
For information on setting up a functional account, see [Set up a functional account](../tutorial/installconfig/configuration/setupfunctionalaccount.md).
