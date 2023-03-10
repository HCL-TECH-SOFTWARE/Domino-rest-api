---
title: Downloads
---

# Downloadable assets to get you started.

## Domino REST API

- Download from [Flexnet](https://hclsoftware.flexnetoperations.com/)

## Presentations

- [Engage 2022 Presentation](../assets/downloads/De22%20Project%20KEEP.pdf)

## Docker

- [Docker compose file for primary server](../assets/downloads/docker-compose-primary.yml)
- [Docker compose file for additional servers](../assets/downloads/docker-compose-secondary.yml)
- [Docker compose `sample.env` file](../assets/downloads/sample.env)

  !!! note
  Rename this file to `.env` and update your values before use.

## Postman

- [Domino REST Postman collection](../assets/downloads/Domino%20REST%20API%20Postman%20Collection.json) to exercise Domino REST APIs for configuring and consuming databases.
- [Postman environment](../assets/downloads/Domino%20REST%20API%20Postman%20Environment.json) for both collections.
- [Demo.nsf](../assets/downloads/Demo.nsf) - Demo database for the Postman and Tutorial examples.

The scripts below are only for reference. They have been superseded by the scripts provided by the installer, so there's no need beyond satisfying curiosity to download them.
{: .alert .alert-danger}

## Mac

- [Shell script](../assets/downloads/macClient.sh) to start Domino REST API on MacOS.
- Modify the script and replace all instances in the Shell script before using as follows:

  - programDir with the directory Notes is located in.
  - dataDir with the directory the Notes Data is located in.
  - keepDir with the directory Domino REST API is located in.

## Windows

- [Command file](../assets/downloads/winClient.cmd) to start Domino REST API on a Windows client.
- Modify the script and replace all instances in the Command file before using as follows:

  - programDir with the directory Notes is located in.
  - dataDir with the directory the Notes Data is located in.
  - keepDir with the directory Domino REST API is located in.
