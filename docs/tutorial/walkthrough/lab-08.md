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

1. Download and unzip the [apps-src.zip](../downloads/apps-src.zip) from the `source for all apps` in a folder. This folder includes all of the source projects that the user may work with whenever he would like to. 
2. Open your IDE (vscode, eclipse). The user needs to make the project folder to be the current or root folder whenever they used it with the user's IDE.

    **Using the IDE VSCode**
    a. Navigate to File menu&rarr;Open Folder&rarr; and select the `src` folder from the unzipped `apps-src.zip.`. There are three folders included inside the `src` folder. 
    b. Choose `JavaETL` folder and locate the `config.json` file.
    c. Edit `config.json` and click **save**.

    **Using the IDE Eclipse**
    a. Navigate to File menu&rarr;Import&rarr; and select the `src` folder from the unzipped `apps-src.zip.`. There are three folders included inside the `src` folder. 
    b. Choose `JavaETL` folder&rarr;target folder and locate the `config.json` file.
    c. Edit `config.json` and click **save**. 

3. From your **Terminal**, choose and select the folder where your project is located, (e.g, JavaETL) and run `mvn clean install` (optional) and `java -jar target/etl.jar`.

## How to check

File sample.csv created training requests

## Things to explore

- [Official Domino REST API documentation](https://opensource.hcltechsw.com/Domino-rest-api/index.html)
- [Discord discussion](https://discord.com/invite/jmRHpDRnH4)
- Modify app to upload data.
