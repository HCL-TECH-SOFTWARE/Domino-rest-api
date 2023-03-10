---
layout: default
title: Running the Domino REST API with Docker
parent: Development Environment
grand_parent: Extending Domino REST API
nav_order: 8
---

This section describes how to setup Domino REST API to run as part of a Docker image. As the image also includes a complete Domino server, it will enable you to run all the Domino REST APIs, including the ones that require a server instance of Domino.

**Please also check [this page](../../installconfig/installation/docker)**

While the installation instructions may seem a bit intimidatingly at first, if you follow them carefully they _will_ work. And once a Docker environment has been setup, it is easy to both use and maintain.

### Installing and prepare Docker

- Check the [official documentation](https://docs.docker.com/get-docker/) for installing Docker on your OS.
- Run through [a tutorial](https://www.docker.com/101-tutorial) when you are new to Docker
- Create a Domino base image using the instructions in the [domino-docker](https://github.com/IBM/domino-docker) GitHub repository. Domino REST API will build on top of this image

### Creating the Domino REST API image

See [Running Domino REST API with a Docker Image](../../installconfig/installation/docker).

### Scripts

Three additional scripts are included in the Docker container.

**post_startup_script**

```bash
#!/bin/sh
# Starts the vert.x tasks that talks to Domino
export GodMode=false
export DEBUG=true
export DOMINO_HOME=/opt/hcl/domino/notes/latest/linux
export JAVA_HOME=/opt/hcl/domino/notes/latest/linux/jvm
export NOTESDATA=/local/notesdata
export DYLD_LIBRARY_PATH=$DOMINO_HOME
export LD_LIBRARY_PATH=$DOMINO_HOME
export V_PATH=/opt/hcl/keep/resources:/opt/hcl/keep/classes:/opt/hcl/keep/resources:/opt/hcl/keep/libs/*
export CLASSPATH=.:$V_PATH:$CLASSPATH
export NOTES_ENV=SERVER
export LOG_DIR=$NOTESDATA/logs
[ -d $LOG_DIR ] || mkdir -p $LOG_DIR
# This is important - must be writable -otherwise the docker blows
cd $NOTESDATA
$JAVA_HOME/bin/java -XX:+HeapDumpOnOutOfMemoryError -XX:+UseG1GC -XX:+UseStringDeduplicationJVM -cp $CLASSPATH -jar projectkeep.jar > $LOG_DIR/vertx.log 2>&1 &
```

When you installed the expanded version of Domino REST API (not the fat JAR) the launch line needs to look like this:

```bash
$JAVA_HOME/bin/java -XX:+HeapDumpOnOutOfMemoryError -XX:+UseG1GC -XX:+UseStringDeduplicationJVM -cp $CLASSPATH com.hcl.domino.keep.Launch > $LOG_DIR/vertx.log 2>&1 &

```

**pre_shutdown_script**

```bash
#!/bin/bash
# Before she shutdown domino we shutdown Domino REST API
export ADMINPORT=8889
curl --max-time 10 -d '{"shutdownkey" : "The End is near!!"}' -H "Content-Type: application/json" -X POST http://localhost:$ADMINPORT/shutdown
```

**post_shutdown_script**

```bash
#!/bin/bash
# After shutdown - kill the Java task if it is still there
pkill -9 -f projectkeep
```

### Debugging with Docker

There is also more Docker documentation available here: [Docker Documentation](../../installconfig/installation/docker). Some of the information is a bit dated, in particular don't worry about building your own Docker images as that now happens automatically. Instead focus on the section for setting up a Docker debugging environment.

### Creating Docker users and test data

Once you have your Docker image up and running, you'll need to create test users and test data for the Domino REST APIs to run against. You'll find instructions here: [Docker Test Data](./testdata)
