# Lab 06 - Create a NodeJS application

## What you will learn

How to run a custom NodeJS application that interacts with the Domino REST API.

## Before you begin

- You have completed [Lab 05 - Create an application](lab-05.md).
- Your Domino server must be running.
- You have NodeJS installed on your machine.
- You have internet connection.

## Procedure

1. Download and extract the [apps-src.zip](../downloads/apps-src.zip) file from the `source for all apps` in a folder.

    The `apps-src.zip` contains 3 folders. In this activity, you are going to use the *DominoOAuth* folder.

2. Open your IDE, such as Visual Studio Code.
3. Open the folder `src`&rarr;`DominoOAuth` from your IDE.
4. From the `DominoOAuth` folder, select and edit `package.json`, and then save your changes.
5. From the `DominoOAuth` folder, select and edit `setup.json`. Add the values from [Lab 04 - Additional scope & schema](lab-04.md) and [Lab 05 - Create an application](lab-05.md), and save your changes.

    !!! note

        As a user, you must know what are the needed fields to be modified to run the `setup.json`.

6. On your Terminal in your IDE and run `npm install`.
7. Run `npm start`. You must start your browser to check.

## How to verify

- Navigate to http://localhost:3000, and the UI of the app should show.
- Retrieve data.

## Things to explore

- [Domino REST API documentation](https://opensource.hcltechsw.com/Domino-rest-api/index.html)

- [Discord discussion](https://discord.com/invite/jmRHpDRnH4)

- Check out the source code.

## Next step

Proceed to [Lab 07 - Create an SPA](lab-07.md).

<!--
## Duration 15 min

## What you will learn

Run a custom NodeJS application that interacts with the Domino Rest API

## Prerequisites

- Lab 05 completed
- Domino running
- NodeJS installed
- Internet connection

## Steps

1. Download and unzip the [apps-src.zip](../downloads/apps-src.zip) from the `source for all apps` in a folder. The `apps-src.zip` contains 3 independent folder. In this activity will going to use the `DominoOAuth` folder.

2. Open your IDE (vs code, etc)
3. Open the folder `src`&rarr;`DominoOAuth`.
4. From the `DominoOAuth` folder,inside your IDE, select `package.json`
5. Edit the `package.json`.
6. Edit the `setup.json` and add the values from **Lab05-Create Application** and also add values from the **Lab-04-Scope**.

    !!! note

        As a user, you must know what are the needed fields to be modified to run the `setup.json`.

7. On your Terminal in your IDE, run `npm install`
8. Run `npm start`. You must start your browser to check.

## How to check

- Navigate to http://localhost:3000 - UI should show
- Retrieve data

## Things to explore

- [Domino REST API documentation](https://opensource.hcltechsw.com/Domino-rest-api/index.html)

- [Discord discussion](https://discord.com/invite/jmRHpDRnH4)

- Check out the source code.
-->