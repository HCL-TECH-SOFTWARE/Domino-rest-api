# Lab 08 - Create a Java application

## What you will learn

How to use an example that can be some scheduled process to ETL data.

## Before you begin

- You have completed [Lab 07 - Create an SPA](lab-07.md).
- You have Java installed.
- You have Maven installed.
- You have internet connection.

## Procedure

1. Download and extract the [apps-src.zip](../downloads/apps-src.zip) from the [source for all apps](downloadindex.md#resource-materials) in a folder. You get a `src` folder that includes all the source projects that you may work with.

2. Open your IDE such as VS Code or Eclipse.

    !!! note

        The `src` folder contains 2 JavaScript project folders and a Java project folder that you can work with. You need to make the project folder that you will use with your IDE the current or root folder. Since it’s a Java application, use the JavaETL project folder. 

    **Using VSCode**

    1. Navigate to **File** &rarr; **Open Folder**, and select `src` &rarr; `JavaETL` folder.
    2. Inside the `JavaETL` folder, locate the `config.json` file.
    3. Edit `config.json` and click **Save**.

    **Using Eclipse**

    1. Navigate to **File** &rarr; **Open File**, and select `src` &rarr; `JavaETL` folder.
    2. Inside the `JavaETL` folder, locate the `config.json` file.
    3. Edit `config.json` and click **Save**.

3. From your **Terminal**, select the folder where your project is located, such as `JavaETL`, and run `mvn clean install` (optional) and `java -jar target/etl.jar`.

## How to verify

A file named `sample.csv` is created containing the training requests.

## Things to explore

- [Domino REST API documentation](https://opensource.hcltechsw.com/Domino-rest-api/index.html)

- [Discord discussion](https://discord.com/invite/jmRHpDRnH4)

- Modify the app to upload data.

## Next step

Proceed to [Lab 9 - Unlock additional ports](lab-09.md).
<!--
## Duration 15 min

## What you will learn

We use an example that could be some scheduled process to ETL data.

## Prerequisites

- Lab 07 completed
- Java installed
- Maven installed
- Internet connection

## Steps

1. Download and unzip the [apps-src.zip](../downloads/apps-src.zip) from the `source for all apps` in a folder. This folder includes all the source projects that the user may work with.

2. Open your IDE such as VS Code, Eclipse.

    There are three folders to work with inside the `src`. There are two JavaScript folders and one Java folder to work with. The user needs to make the project folder to be the current or root folder whenever they use it with the user's IDE. Since it's Java application, use the `JavaETL` folder.

    **Using VSCode**

    1. Navigate to **File** &rarr; **Open Folder**, and select `src` &rarr; `JavaETL` folder.
    2. Inside the `JavaETL` folder, locate the `config.json` file.
    3. Edit `config.json` and click **Save**.

    **Using Eclipse**

    1. Navigate to **File** &rarr; **Open File**, and select `src` &rarr; `JavaETL` folder.
    2. Inside the `JavaETL` folder, locate the `config.json` file.
    3. Edit `config.json` and click **Save**.

3. From your **Terminal**, select the folder where your project is located, such as `JavaETL`, and run `mvn clean install` (optional) and `java -jar target/etl.jar`.

## How to check

File sample.csv created training requests

## Things to explore

- [Domino REST API documentation](https://opensource.hcltechsw.com/Domino-rest-api/index.html)

- [Discord discussion](https://discord.com/invite/jmRHpDRnH4)

- Modify app to upload data.
-->