# Troubleshooting

This reference intends to guide you in addressing common errors in installing and running the Domino REST API service. Common errors and their corresponding resolutions are described below:

<!-- ## Troubleshooting common errors with the installing and running the Domino REST API service -->

## Domino Not Running (First-Time Setup)

If Domino isn't up and running, see [Troubleshooting one-touch Domino Setup](https://help.hcltechsw.com/domino/12.0.0/admin/inst_onetouch_troubleshooting.html){: target="_blank" rel="noopener noreferrer"}.

## REST API not responding

You get a timeout error when trying to access `http://yourserver:8880`, wherein `yourserver` is the DNS name of your Domino server. 

**Solution**

You need to check if the REST API is loaded. 

1. In the Domino server console, type `show tasks`. 
2. If there is no `restapi` entry in the list, load it using `load restapi` in the Domino console. 
3. If it's listed, shut it down with `tell restapi quit` before trying `load restapi`. 
4. Take note of any messages in case you need more support.

--8<-- "iskeeprunning.md"

## Address already in use error

You get this error when you run the [sample script](../references/downloads.md) with the sample Notes database:

> 2021-01-28 15:39:07 ERROR Launch:707 - Management server failed to launch on 0.0.0.0:8889
> 2021-01-28 15:39:07 ERROR Launch:258 - Fatal
> java.net.BindException: Address already in use

**Solution** 

Stop the process that's using the jar file. Use the Windows Task Manager, or on a Mac/Linux, do this:

```bash
ps -eaf | grep launch.class
kill -9 [pid number]
```

## Unable to start the Domino REST API Domino task after updating configuration to use https

The `KeepManagementURL` setting in your `notes.ini` is the URL needed for the Domino REST API Domino task to talk to the Java side of Domino REST API. By default this is set to `http`. 

**Solution**

After updating the URL to `https`, run `load restapi`. For more information, see [Domino REST API task](../references/usingdominorestapi/restapitask.md).

## Database is not fully initialized error

You get this error when you go to your Notes client and:

1. Select **File** &rarr; **Open** &rarr; **HCL Notes Application**.
2. Select `KeepConfig.nsf` file to open.

The following error is shown:

![KeepConfigDBError](../assets/images/KeepConfigError.png){: style="height:80%;width:80%"}

**Solution** 

Delete the `KeepConfig.nsf` from the Notes data directory and restart the [sample script](../references/downloads.md).

<!-- prettier-ignore -->
!!! tip
    On Mac, the data directory path is `/Users/[userid]/Library/Application Support/HCL Notes Data/`.

## User ID and password being requested repeatedly when using Notes for Domino REST API testing

Sometimes on the initial starting up of the Domino REST API or creation of KeepConfig and KeepAgents databases, or doing things like creating a folder in mail database, you are prompted for user ID and password repeatedly. This happens if the **Don't prompt for a password** checkbox under **User Security** isn't selected or if it gets reset based on the organization's policy.

**Solution**:

1. Stop your Domino REST API debugging session.
2. Go into Notes, and then select **File** -> **Security** -> **User Security**.
3. Select the **Don't prompt for a password from other Notes-based programs (reduces security)** checkbox.
4. Exit Notes and restart your Domino REST API debugging session.

This setting can get reset each time you start Notes depending upon your organization's Policy, in which case, you'll need to enable it again.

## Logging

The Domino REST API uses the [Apache log4j2](https://logging.apache.org/log4j/2.x/) logging framework. By default, logs are stored in the `domino-keep.log` file in the subdirectory `IBM_TECHNICAL_SUPPORT` in your `Notes/Domino` data directory.

The log files are set to periodically roll over on a daily basis or when they reach a size of 10 MB. Logs are kept for a period of **30 days.**

The default `log4j2.properties` file controls all of this. If you're looking to make changes to the logging, such as modifying the filename, adjusting the logging destination like sending it to a log analyzer, or modifying the log level, you can set your own logging parameters.

Familiarity with [Apache log4j2](https://logging.apache.org/log4j/2.x/) is strongly recommended. The configuration has two steps:

   - Specify the location of the configuration file for `Notes/Domino`. You can choose any name other than `log4j2.properties` that you prefer.
   - Provide the file.
    
It's possible to have several configuration files, but only one will be active at any given time.

### To provide your own logging configuration

 This guide shows you how to create your own logging configuration. The purpose is to change the logging configuration to your needs. Typically, that would be to temporarily adjust logging levels like `DEBUG` and `TRACE` or to integrate tools like [LogStash](https://www.elastic.co/guide/en/logstash/current/logging.html#log4j2).

1. Open the `notes.ini` file. You may refer to [Editing NOTES.INI file](https://help.hcltechsw.com/domino/12.0.0/admin/conf_editingthenotesinifile_c.html).
2. You can add the `KeepLogConfigFile` parameters with the following settings and save. The `KeepLogConfigFile` option can be added to `notes.ini` to edit the log configuration file.

    **Configuration settings:**

    - **Windows:** `KeepLogConfigFile=C:\path\to\log4j2.properties`
    - **Linux:** `KeepLogConfigFile=/path/to/log4j2.properties` 

!!!note
    - You can find the default `log4j2.properties` file inside the file `keep-core jar`.
    - For example, extract the contents of the `keep-core-1.28.2.jar` file and include the `log4j2.properties` file.

Just a few things to keep in mind: 

- The "`jar`" component is included in your Java installation. If your path doesn't lead there, you'll need to indicate the directory to your `java\bin folder`.
- Make sure to specify the version of your `keep-core file`, as it may differ from the one shown in the example.
- Make sure to remove the `log4j2.properties` file from your Rest API directory to avoid potential issues with upgrades.
- The `log4j.properites` file for the Domino REST API may undergo changes without prior notice. If you observe any differences in the logging behavior after a recent upgrade, it's recommended to extract and review the updated `log4j` file.
- Check out the [Log4J documentation](https://logging.apache.org/log4j/log4j-2.0-beta7/manual/appenders.html) for details on the available settings.


