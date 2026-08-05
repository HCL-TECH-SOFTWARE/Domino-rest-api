# Lab 0 - Overview

## What you will learn

- How to validate your laptop setup for the workshop.
- Gain a first overview of the Domino REST API.

## Before you begin

You must have:

- a laptop
- an internet connection to download the necessary files and tools
- met all the [prerequisites](index.md#prerequisites), such as having Domino REST API installed on a server

## Procedure

1. Verify the Domino server.

    Confirm you have a running Domino server with admin access. This is mandatory for the exercises.

2. Download the KEEP tool.
    - For Mac/Linux, download [`keep`](../downloads/keep).
    - For Windows, download [`keep.cmd`](../downloads/keep.cmd).
  
    This tool is used if you plan to run Domino REST API locally.

3. Download the database file.

    Download `ApprovalCentral.zip`, which contains the needed Domino database file.

4. Download the Postman [collection](../downloads/dachnug2023.postman_collection.json) & [environment](../downloads/dachnug2023.postman_environment.json).

5. Import the downloaded collection and environment into Postman.

## How to verify

- The following commands should work successfully on your laptop:

    ```bash
    node -v
    java -version
    curl --version
    ```

- Postman is installed and able to start.

- Domino is running with REST API active.

    - If using Domino REST API installed locally, open [http://localhost:8880](http://localhost:8880) in your browser.
    - If connecting to an internet-based Domino REST API server, open your Domino REST API server’s web address.

    You should see a page similar to the following:

    ![Landing page](img/landingPage.png){: style="height:75%;width:75%"}

## Things to explore

- [Domino REST API documentation](https://opensource.hcltechsw.com/Domino-rest-api/index.html)

- [Discord discussion](https://discord.com/invite/jmRHpDRnH4)

- Open the **OpenAPI v3** tile.

## Next step

Proceed to [Lab 01 - Login to the REST API](lab-01.md).
