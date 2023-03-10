---
layout: default
title: Postman Testing
parent: Testing
grand_parent: Extending Domino REST API
nav_order: 3
---

[Postman](https://www.postman.com) is a tool used for API Testing. Postman allows to send requests and receive responses through the API protocols. Based on the response received, we can verify the status codes to see if the protocols are working. Domino REST API doesn't have a GUI but using Postman, we can test the Domino REST APIs.

In Postman, we can create collections, environments and user defined folders. For each API, there are JSON files. Additionally, you can also import an existing JSON file in Postman application using the Import button. The API's can be tested under different environments, like UAT.

To carry out end-to-end Acceptance Testing of Domino REST API, we have provided collection and environment JSONs in the Domino REST API directory. These files are available at /domino-keep\keep-core\src\test\downstream-openclient. Import these files into Postman. In the test collections, there are 4 folders, corresponding to the following 4 Domino REST API core APIs:

- Admin-v1
- CI/CD
- Core-v1
- Pim-v1

### How to run the Domino REST API Acceptance and CI/CD end-to-end tests

Before you run the tests, make sure that auth is running in Postman i.e. if you send a request, you should receive a response. If you get an error, make sure that the docker is running. Follow one of the below methods to execute the Domino REST API tests.

## Using the command file provided in the domino-keep directory

1. In the domino-keep directory, is the collection_runner.cmd.
2. In the command prompt, navigate to domino-keep directory and run collection_runner.cmd, as administrator.
3. Select which API you want to run.
4. Select the json file.
5. After the tests have run, you'll get an HTML report. This report gets saved under newman folder in domino-keep.
   The generated report shows the total iterations, assertions, failed tests and skipped tests. You can also find additional details in the report. The 'Failed Tests' tab on the top shows the assertions that failed, along with the error message.

## Running from Postman

1. Once you have imported the collection and environment JSON files, you can run the test by hitting the Runner button in Postman.
2. Select the collection and the folders to run. (You can also run the full collection.)
3. Select the environment.
4. Select 'Save Response'.
5. Run Domino REST API Acceptance.
   On the result window, you can see the assertions that failed. You can also export the results from here.
