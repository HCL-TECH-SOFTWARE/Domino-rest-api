# Lab 08 - Create a Java application

## Duration 15 min

## What you will learn

We use an example that could be some scheduled process to ETL data

## Prerequisites

- Lab 07 completed
- Java installed
- Maven installed
- Internet connection

## Steps

1. Download and unzip the [apps-src.zip](../downloads/apps-src.zip) from the `source for all apps` in a folder. This folder includes all of the source projects that the user may work with whenever they would like to. The user needs to make the project folder to be the current or root folder whenever they used it with the user's IDE. 
2. Open your IDE (vscode, eclipse, intelliJ) The user needs to make the project folder to be the current or root folder whenever they used it with the user's IDE.

    **Using the IDE VSCode**
    a. Navigate to File menu&rarr;Open Folder&rarr; and select the `src` folder from the unzipped `apps-src.zip.`. There are 
    b. 

3. Open the `src` folder from the unzipped `apps-src.zip` in your IDE.
4. Access the `JavaETL` folder to locate the `config.json` file.
5. Edit `config.json` and click **save**.
6. From your IDE terminal, run `mvn clean install` (optional) and `java -jar target/etl.jar`.

## How to check

File sample.csv created training requests

## Things to explore

- [Official Domino REST API documentation](https://opensource.hcltechsw.com/Domino-rest-api/index.html)
- [Discord discussion](https://discord.com/invite/jmRHpDRnH4)
- Modify app to upload data.
