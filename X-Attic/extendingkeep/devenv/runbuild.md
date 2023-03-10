---
layout: default
title: Running a Maven Build
parent: Development Environment
grand_parent: Extending Domino REST API
nav_order: 7
---

Ths section will take you through setting up a Maven build evironment so that you will be able to compile and build the Domino REST API source code.

### Setting up Java 8

If you haven't already, go to the Java 8 section and download and configure Java 8.  In particular, make sure to configure symbolic links to the three Notes jars: **notes**, **websrc**, and **njempcl**.  Without the links, Domino REST API will not compile cleanly, as the **lotus.domino** package will not be found.  Also check that the **JAVA_HOME** environment variable is set correctly, so that Maven will find the proper Java version.

### Installing Maven

Maven is an open source build program that came out of the Apache Jakarta project nearly twenty years ago.  To download a copy, go to the Maven website and select the download link: https://maven.apache.org/download.cgi. Select the zip or tar.gz file of your choice and then expand it into a root level directory, for example: **C:\Maven**.  Then add the bin directory to the end of your PATH environment variable, for example: **C:\Maven\apache-maven-3.6.3\bin**.  To verify your work so far, type: **mvn -v** from the command line.  This will return your Maven version as well as your Java setup.

### The Project Object Model (POM)

A Project Object Model file, pom.xml, provides all the configuration information necessary to build a particular project. If you bring up the pom.xml file in the root domino-keep directory you'll see it begins with general information about the project, including the project name and version number which are used as identifiers.  The project information is followed by a list of Maven Plugins, as one can customize Maven's behavior by adding a number of specialized plugins that perform a desired function. Finally the pom file ends with a list of the projects dependencies.  The Pom file in root domino-keep directory builds the whole project, but there are also satellite Pom files in each of the major sub directories.  If there is a Pom file present, you know that a Maven build will run there.

In general, someone setting up a build environment will not need to modify the existing pom files, as they are already present and correct.  But they are worth a mention here so that you have a basic understanding of how a Maven build works.  If you need to add a new dependency or a new Maven plugin this is where it's done.

### Running a full Domino REST API build

If you are making a number of changes, you might want to completely rebuild the Domino REST API source from the Domino REST API root directory.  The following command first does a **clean** to remove old files, followed by **package** to rebuild the **projectkeep.jar**, and **site** to rebuild the documentation.

- Open up a command window
- cd \<devhome>\domino-keep\keep-core
- mvn clean package site

### Build logging

Maven accepts a number of command line options (get the full list here: **mvn --help**).  If you're having trouble getting a module to build, you might want to capture the build output in a log file using the -l option:

mvn -l bldlog.log site:run


### Maven references:

Apache Maven Home: https://maven.apache.org/index.html
Maven in Wikipedia: https://en.wikipedia.org/wiki/Apache_Maven
20 Minute Maven Tutorial: https://www.youtube.com/watch?v=KNGQ9JBQWhQ
