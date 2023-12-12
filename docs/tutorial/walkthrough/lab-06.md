# Lab 06 - Create a NodeJS application

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

    !!!note
        As a user you must know you must know what are the needed fields to be modify in order to run the `setup.json`.

7. On your Terminal in your IDE, run `npm install`
8. Run `npm start`. You must start your browser to check.


## How to check

- navigate to http://localhost:3000 - UI should show
- retrieve data

## Things to explore

- [Official Domino REST API documentation](https://opensource.hcltechsw.com/Domino-rest-api/index.html)
- [Discord discussion](https://discord.com/invite/jmRHpDRnH4)
- Check out the source code.
