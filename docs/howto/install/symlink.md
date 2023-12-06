# Symlink Domino 14 and Domino Rest API

The Domino program directory needs to be symbolically linked (symink) to the `(DominoDir)\jvm\bin` directory. The  `nskn5en.dll` and `nsen50en.dll` must be the files that must be linked.

## About this task

The procedure guides you on using symlink with Domino 14 and the Domino REST API in case there are errors in installing the Domino REST API v1.0.9 or greater.

## Prerequisite

- Domino Rest API v1.0.9 or greater must be installed.

## Procedure

### For Windows

1. Open the **Command Prompt** app.
2. Enter the `mklink` space (`link`) space (`target`). The `link` must be located where your **Domino Server** is installed, and the `target` is the Domino program location to which you want to create a link.

```
     mklink c:\domino\jvm\bin\nskn50en.dll d:\domino\nskn50en.dll
     mklink c:\domino\jvm\bin\nsen50en.dll d:\domino\nsen50en.dll 
```

`mklink` is a term that is used to connect folders symbolically. Let say that you wanted to save a list C: directory and have an easy way to get to it from D: directories. This job could be done with `mklink` keyword in Windows.