---
layout: default
title: Setting up Java 8
parent: Development Environment
grand_parent: Extending Domino REST API
nav_order: 3
---

This section describes how to install the proper version of Java and then configure it to support development builds.

### Installing Java 8

Both the **Windows** and **Mac** version of OpenJDK Version 8 can be downloaded from the AdoptOpenJDK foundation here:

https://adoptopenjdk.net/index.html

You want the latest version of Java 8 (not the latest version of Java) so select **OpenJDK 8 (LTS)**. Now click **Latest Release** to begin the download. Once the download completes, open up your downloads directory and run the installer.

![OpenJDK](../../assets/images/OpenJDK.png)

### Configuring Java 8

The OpenJDK requires a little configuration to function properly as part of a Domino REST API build.

## Setting your JAVA_HOME directory

Bring up your environment variables, and add JAVA_HOME to point to your new Java 8 directory (for example: C:\Java8\jdk8u252-b09). This will allow the build to find the proper Java instance.

## Setting symbolic links

For Domino REST API to build properly, the Java 8 compiler needs to be able to resolve Notes Domino references. This done by configuring symbolic links between the Java 8 lib directory and the Notes lib directory, for three Notes jars.

For **Windows**, open a command window and go to the jre\lib\ext directory within your OpenJDK directory.

Then create the sybolic links for the **Notes.jar**, the **websvc.jar**, and the **njempcl.jar**.

**cd %JAVA_HOME%\jre\lib\ext**

**mklink .\Notes.jar C:\Notes\jvm\lib\ext\Notes.jar**

**mklink .\websvc.jar C:\Notes\jvm\lib\ext\websvc.jar**

**mklink .\njempcl.jar C:\Notes\jvm\lib\ext\njempcl.jar**

Note: If your Notes is not installed in C:\Notes adjust the paths above accordingly.

For the **Mac**, the process is essentially the same, except you would use the Mac symbolic link command: **ln -s**
