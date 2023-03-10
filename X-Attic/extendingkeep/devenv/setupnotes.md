---
layout: default
title: Setting up Notes
parent: Development Environment
grand_parent: Extending Domino REST API
nav_order: 2
---

This section describes how to install the proper version of Notes and then configure it to connect to a mail server.

### Preinstallation

If you have a Windows environment, take a moment to make sure that your system is up-to-date. For Windows, this means running Windows Update repeatedly until there are no new updates found. Although running the updates is not always strictly necessary, some team members encountered a mysterious "Error 1935" when trying to install Notes on Windows systems without the latest updates.

### Installing Notes

The next step is to download the Notes installer and run it.

1. Download the Notes Installer that matches your system.

2. Next run the installer, and on the installation page, select the **Notes Client**, **Domino Designer**, and **HCL Domino Administrator** features along with all their subdirectories.

### Configuring mail

After Notes has been installed, it must be configured to find your Mail file on your Mail server.

1. Your Domino Administrator should have provided you with all your mail settings.

2. Next bring up Notes and select: **File \ Locations \ Manage Locations \ Locations** and select the **Online** entry. Click **Edit**.

   ![Basics Panel](../../assets/images/BasicsPanel.png)

3. On the **Basics** panel enter your Internet mail address (example: john.dough@acme.com).

4. Switch to the **Servers** tab and enter your mail server (example: Mail1/Acme).

5. Switch to the **Ports** tab and check **TCPIP**.

6. On the **Mail** tab, set your Mail file location to **on Server**, set your Mail File (example: jdough.nsf), and your Domino mail domain (example: Acme).

7. Finally, on the **Advanced** tab, select **User ID to switch to** and point it to your Notes ID. If you have previously been using a web version of Notes Mail, you can bring up your web mail client and export your Notes ID to your Notes 11 data directory and then import it into Notes 11 from there.

8. Your location record is now complete so click **OK**.

Now that you've imported your Notes ID, do a quick check to verify that that's the ID you're actually using. This is necessary as Notes ships with a generic **user.id** file in the data directory, and if you're using user.id your security is essentially turned off.

Select **File \ Security \ User Security**. Verify that the Notes ID in use is correct. If it's not, go to **File \ Security \ Switch Id** to change it.

### Creating a server connection records

Now that you've configured your mail settings, you need to create Server Connection entries so that your mail server can be found.

1. Bring up Notes, and click the **Open** dropdown menu in the upper left. Then select **Contacts**.

2. Next click **Advanced** to bring up the Advanced page and select **Connections**.

3. Finally click the **New** dropdown menu and select **Server Connection** to bring up the Server Connection form:

![Server Connections](../../assets/images/ServerConnect.png)

On the **Basics** tab enter the **server name**, and click **tcpip**. On the **Advanced** tab enter the **server address**, and click **Save**. Do this for each of the servers listed in the mail message from your Notes Administrator.

Once the Server Connections are created, you should be good to go.
