# Check Domino REST API settings

--8<-- "future.md"

## About this task

The procedure guides you on how to check the Domino REST API settings.

## Prerequisite

- You must have access to **Management console** (Port 8889).

## Procedure

<!-- prettier-ignore -->
!!! note
        Make sure the **Management console** is secure. For more information, see [Functional Accounts](../../tutorial/installconfig/functionalUsers.md).

1. Log in to the **Management console** (Port 8889).
   ![Management console](../../assets/images/mngmntconsole.png)

    <!-- prettier-ignore -->
    !!! note  
        Take note that credentials for the management console are not managed by the configured IdP, but are derived from the [configuration of functional accounts](../../tutorial/installconfig/functionalUsers.md).

2. Click **Config**. The config tab opens showing the Domino REST API settings in JSON. 