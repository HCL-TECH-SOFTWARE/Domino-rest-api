# Troubleshooting

This reference intends to guide you in addressing common errors in installing and running the Domino REST API service. Common errors and their corresponding resolutions are described below:

<!-- ## Troubleshooting common errors with the installing and running the Domino REST API service -->

## Domino Not Running (First-Time Setup)

If Domino isn't up and running, follow the steps for [Troubleshooting one-touch Domino Setup](https://help.hcltechsw.com/domino/12.0.0/admin/inst_onetouch_troubleshooting.html).

## REST API not responding

You get a timeout error when trying to access `http://yourserver:8880` (replace `yourserver` with the DNS name of your Domino server). You need to check if the REST API is loaded: In the Domino server console type `show tasks`. If there is no entry `restapi` in the list, load it using `load restapi` in the Domino console. If it is listed shut it down with `tell restapi quit` before trying `load restapi`. Take note of any messages in case you need more support.

--8<-- "iskeeprunning.md"

## Address already in use error

You get this error when you run the [sample script](../references/downloads.md) with the sample Notes database:

> 2021-01-28 15:39:07 ERROR Launch:707 - Management server failed to launch on 0.0.0.0:8889
> 2021-01-28 15:39:07 ERROR Launch:258 - Fatal
> java.net.BindException: Address already in use

**Solution**: Stop the process that's using the jar file. Use the Windows Task Manager, or on a Mac/Linux, do this:

```bash
ps -eaf | grep launch.class
kill -9 [pid number]
```

## Unable to start the Domino REST API Domino task after updating configuration to use https

The `KeepManagementURL` setting in your `notes.ini` is the URL needed for the Domino REST API Domino task to talk to the Java side of Domino REST API. By default this is set to `http`. You will have to update this URL to `https` and then `load restapi` after this update.

For more information, see [Domino REST API task](../references/usingdominorestapi/restapitask.md).

## Database is not fully initialized error

You get this error when you go to your Notes client and:

1. Select File menu -> Open menu -> Open HCL Notes Application menu.
2. Select `KeepConfig.nsf` file to open.

The following error is shown:

![KeepConfigDBError](../assets/images/KeepConfigError.png)

**Solution**: Delete the `KeepConfig.nsf` from the Notes data directory and restart the [sample script](../references/downloads.md).

<!-- prettier-ignore -->
!!! tip
    On Mac, the data directory path is `/Users/[userid]/Library/Application Support/HCL Notes Data/`.

## User ID and password being requested repeatedly when using Notes for Domino REST API testing

Sometimes on the initial starting up of the Domino REST API or creation of KeepConfig and KeepAgents databases, or doing things like creating a folder in mail database, you can get prompted for user ID and password repeatedly. This happens if the "Don't prompt for a password" checkbox under User Security is unchecked or if it gets reset based on the organization's policy.

To fix this, stop your Domino REST API debugging session, go into Notes, go to the Notes setting under File -> Security -> User Security -> enable "Don't prompt for a password from other Notes-based programs (reduces security)", exit Notes and restart your KEEP debugging session.

This setting can get reset each time you start Notes depending upon your organization's Policy, in which case, you'll need to enable it again.

## Logging

Domino REST API logging of info and errors are stored in the `domino-keep.log` file located in your Notes Data's `IBM_TECHNICAL_SUPPORT` directory. This log file is a rolling file and will get moved to a new file with a date stamp if the Domino REST API is restarted or the file is larger for 10 MB. Thirty days of logs are retained.

### Provide your own logging configuration

 This guide will show you how to create your own logging configuration. The purpose of this is to ensure that the logging level for the Domino Rest API is kept specifically for the `DEBUG` and `TRACE` levels and other errors.

1. Open the `notes.ini` file. You may refer to [Editing NOTES.INI file](https://help.hcltechsw.com/domino/10.0.1/admin/conf_editingthenotesinifile_c.html).
2. You can add the `KeepLogConfigFile` parameters with the following settings and save. The `KeepLogConfigFile` option can be added to `notes.ini` to edit the log configuration file.

    **Configuration settings:**

    - **Windows:** `KeepLogConfigFile=C:\path\to\log4j2.properties`
    - **Linux:** `KeepLogConfigFile=/path/to/log4j2.properties` 

!!!note
    - You can find the `log4j2.properties` file in the `keep-core jar` located in your Rest API directory.
    - For example, extract the contents of the `keep-core-1.28.2.jar` file and include the `log4j2.properties` file.

Just a few things to keep in mind: 

- The "`jar`" component is included in your Java installation. If your path doesn't lead there, you'll need to indicate the directory to your `java\bin folder`.
- Make sure to specify the version of your `keep-core file`, as it may differ from the one shown in the example.
- Make sure to remove the `log4j2.properties` file from your Rest API directory to avoid potential issues with upgrades.
- The `log4j.properites` file for the Domino REST API may undergo changes without prior notice. If you observe any differences in the logging behavior after a recent upgrade, it is recommended to extract and review the updated `log4j` file.
- Check out the [Log4J documentation](https://logging.apache.org/log4j/log4j-2.0-beta7/manual/appenders.html) for details on the available settings.
