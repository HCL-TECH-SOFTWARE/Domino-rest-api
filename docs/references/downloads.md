---
title: Downloads
---

# Downloadable assets to get you started

## Domino REST API

Download from:

- [HCL Software License & Download Portal](https://hclsoftware.flexnetoperations.com/){: target="_blank"}

- [My HCLSoftware Portal](https://my.hcltechsw.com/){: target="_blank"}

## Presentations

[Engage 2022 Presentation](../assets/downloads/De22%20Project%20KEEP.pdf){: download="Engage 2022 Presentation"}

## Docker

- [Docker compose file for primary server](../assets/downloads/docker-compose-primary.yml){: download="docker-compose-primary.yml"}

- [Docker compose file for additional servers](../assets/downloads/docker-compose-secondary.yml){: download="docker-compose-secondary.yml"}

- [Docker compose `sample.env` file](../assets/downloads/sample.env)

    <!-- prettier-ignore -->
    !!! note ".env"
        Rename this file to `.env` and update your values before use.

## Postman

- [Domino REST API Postman collection](../assets/downloads/Domino%20REST%20API%20Postman%20Collection.json){: download="Domino REST API Postman collection"} to exercise Domino REST APIs for configuring and consuming databases.

- [Domino REST API Postman environment](../assets/downloads/Domino%20REST%20API%20Postman%20Environment.json){: download="Domino REST API Postman environment"} for both collections.

- [Demo.nsf](../assets/downloads/Demo.nsf) - Demo database for the Postman and Tutorial examples.

The following scripts are for reference only. They have been superseded by the scripts provided by the installer, so there's no need beyond satisfying curiosity to download them.

## Mac

- [Shell script](../assets/downloads/macClient.sh) to start Domino REST API on MacOS.

- Modify the script and replace all instances in the Shell script before using as follows:

    - programDir with the directory Notes is located in
    - dataDir with the directory the Notes Data is located in
    - keepDir with the directory Domino REST API is located in

## Windows

- [Command file](../assets/downloads/winClient.cmd) to start Domino REST API on a Windows client.

- Modify the script and replace all instances in the Command file before using as follows:

    - programDir with the directory Notes is located in
    - dataDir with the directory the Notes Data is located in
    - keepDir with the directory Domino REST API is located in

## Azure AD

[AzureTester.zip](../assets/downloads/AzureTester.zip) is a simple test application you run on a local http server to check if a registered App in Azure AD can be used as JWT provider for the Domino REST API.

!!!warning 
    This is for testing only. Do **NOT** use this code in production.