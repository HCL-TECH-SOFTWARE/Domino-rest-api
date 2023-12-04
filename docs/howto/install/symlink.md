# Symlink the Domino 14 and Domino Rest API

The Domino program directory need to be symbolically linked (symink) to the `(DominoDir)\jvm\bin` directory. The  `nskn5en.dll` and `nsen50en.dll` must be the files that must be linked.

## About this task

The procedure guides you on using symlink with Domino 14 and Domino REST API in case there are error installing the Domino REST API v1.0.9 or greater.

## Prerequisites

### For Windows

1. Open the **Command Prompt** app.
2. Enter the `mklink` space (`link`) space (`target`). The `link` must be located where your **Domino Server** is installed, and the `target` is the Domino program location to which you want to create a link.

```
     mklink c:\domino\jvm\bin\nskn50en.dll c:\domino\nskn50en.dll
     mklink c:\domino\jvm\bin\nsen50en.dll c:\domino\nsen50en.dll 
```
