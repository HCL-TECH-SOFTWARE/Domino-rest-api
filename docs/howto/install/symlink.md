# Domino 14 and Domino REST API

When using Domino 14.0 (GA version) with Domino REST API on Windows, 2 files need to be symbolically linked (symlink) to the `(DominoDir)\jvm\bin` directory.

## About this task

This procedure guides you through creating symbolic links for 2 files on Domino 14 in case there were errors creating these during the installation of Domino REST API.

## Prerequisite

- Domino Rest API v1.0.9 or greater must be installed.

## Procedure

### For Windows

1. Open a elevated Windows **Command Prompt** (run as administrator).
2. Enter the following commands replacing `c:\domino` with the path to your Domino program directory.

```
     mklink c:\domino\jvm\bin\nskn50en.dll c:\domino\nskn50en.dll
     mklink c:\domino\jvm\bin\nsen50en.dll c:\domino\nsen50en.dll 
```
