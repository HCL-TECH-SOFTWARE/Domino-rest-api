# curl

## Introduction

curl is an open source utility for executing APIs from the command line. It has been in continuous usage since 1997 and over time has gathered widespread support. It currently offers a rich set of command line options and supports all the common network protocols.

## Installing curl

In the latest Mac and Windows systems, curl is installed by default. For those who need to download it, there are a couple of approaches:

If you have already installed **Git Bash** on your system, then you can run curl commands directly from the Git Bash window, without installing any other applications.

curl for Windows can also be downloaded from the site mentioned [here](https://curl.haxx.se/windows/).

## Command line options

curl can be a little overwhelming for someone used to working with APIs through a user interface. However, once you're familiar with it, it's easy to use.

The basic layout of a curl command is:

**curl \<list of command options\> \<url\>**

The list of command options that you include in the command largely controls its behavior. To see all the options, use **curl --help**. Below are some commonly-used options.

| Command Option               | Description                                                           |
| :--------------------------- | :-------------------------------------------------------------------- |
| -d, --data \<data\>          | HTTP POST data (that is the data payload for a post request)          |
| -i, --include                | Include response headers in the output                                |
| -I, --head                   | Show document info only (that is just the header)                     |
| -K, --config \<file\>        | Read config from a file (that is to get options from a file)          |
| -o, --output \<file\>        | Write response to a file instead of stdout                            |
| -O, --remote-name            | Write output to a file named as the remote file (that is to download a file) |
| -u, --user \<user:password\> | Server user and password (authentication)                             |
| -v, --verbose                | Make the operation more talkative                                     |
| -X, --request \<command\>    | Specify request command to use (that is a PUT command is: -X PUT)        |

## Learning curl

curl can be used against the Domino REST APIs to practice. However, there is also the JSONPlaceholder site (in the Resources below) that provides a safe online REST API site full of fake data that can be used to test your curl skills.

## Resources to learn curl

- [curl Home Page](https://curl.se/)

- [curl Documentation Page](https://curl.se/docs/)

- [Basic cURL Tutorial](https://www.youtube.com/watch?v=7XUibDYw4mc)

- [Testing APIs with the cURL Command](https://www.youtube.com/watch?v=iLVoA1DTE60)

- [JSONPlaceholder (fake data)](https://jsonplaceholder.typicode.com/)

- [Postman Homepage](https://www.postman.com/)
