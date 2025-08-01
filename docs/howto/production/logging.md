# Provide your own logging configuration

## Logging overview

The Domino REST API uses the [Apache log4j2](https://logging.apache.org/log4j/2.x/) logging framework. By default, logs are stored in the `domino-keep.log` file in the subdirectory `IBM_TECHNICAL_SUPPORT` in your `Notes/Domino` data directory.

The log files are set to roll over daily or when they reach a size of 10 MB. Logs are kept for a period of **30 days.**

The default `log4j2.properties` file controls all this. If you need to make changes to the logging, such as modifying the filename, adjusting the logging destination, or modifying the log level, you can set your own logging parameters.

It's possible to have several configuration files, but only one is active at any given time.

## About this task

Guides you on how to create your own logging configuration to meet your requirements such as temporarily adjusting logging levels like `DEBUG` and `TRACE` or integrating tools like [LogStash](https://www.elastic.co/guide/en/logstash/current/logging.html#log4j2).

## Before you begin

Familiarity with [Apache log4j2](https://logging.apache.org/log4j/2.x/) is strongly recommended. 

## Procedure

1. Specify the location of the configuration file for `Notes/Domino`. You can choose any name other than `log4j2.properties` that you prefer.

    1. Open the `notes.ini` file. For more information, see [Editing the notes.ini file](https://help.hcltechsw.com/domino/14.0.0/admin/conf_editingthenotesinifile_c.html).

    2. Add the `KeepLogConfigFile` parameters with the following settings and then save.

        - **Windows:** `KeepLogConfigFile=C:\path\to\log4j2.properties`
        - **Linux:** `KeepLogConfigFile=/path/to/log4j2.properties`

2. Provide your configuration file in the location you specified.

!!! note

    You can find the default `log4j2.properties` file inside the file `keep-core jar`.

## Additional information

- The "`jar`" component is included in your Java installation. If your path doesn't lead there, indicate the directory to your `java\bin folder.`
- Specify the version of your `keep-core jar` file if you want to extract the default `log4j2.properties` file
- Remove the `log4j2.properties` file from your Rest API directory to avoid potential issues with upgrades.
- The `log4j.properites` file for the Domino REST API may change without prior notice. When you observe any differences in the logging behavior after a recent upgrade, extract and review the updated `log4j` file.

- Check out the [Log4J documentation](https://logging.apache.org/log4j/log4j-2.0-beta7/manual/appenders.html) for details on the available settings.
