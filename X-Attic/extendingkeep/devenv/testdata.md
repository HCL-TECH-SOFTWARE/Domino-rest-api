---
layout: default
title: Testing Data for Docker Domino REST API
parent: Development Environment
grand_parent: Extending Domino REST API
nav_order: 10
---

Once you have finished setting up a Docker based Domino REST API development environment, all the Domino REST APIs _will_ run, but only a handful will return actual data. The next step then is to create some test users and test data in your Docker environment so that you can get meaningful results back from the APIs.

### Opening your Domino REST API directory

To begin, login to your Notes client and select **File / Open / HCL Notes Application** to bring up the Open Application dialog:

![Open Application](../../assets/images/OpenApp.png)

1. For the **Look in** field, enter name of your Domino REST API server, generally **your_castle_name.projectkeep.io/ProjectKeep**

2. For **File Name**, enter **names.nsf** and click **Open** to bring up your user file:
   <br/><br/>

![Names NSF](../../assets/images/NamesNsf.png)

### Creating test users

Once names.nsf is open, click **Add Person** to bring up an Add Person dialog. You'll want to fill it in using the user shown below as a guide:

![Add Person](../../assets/images/AddPerson.png)

1. For **User Name** enter both a long and short user name. Most folks are choosing characters from favorite books or movies (Rick Deckard is the lead character in Blade Runner).

2. Next for **Short Name**, enter an abbreviated version of the name (Rick Deckard become rdeckard).

3. For **Internet Password** enter a simple password (security is not really an issue here).

4. Now set **Domain** to **Keep** and **Mail Server** to **your_castle_name.projectkeep.io/ProjectKeep**

5. For the **Mail File**, enter: **mail/your_short_name.nsf**

6. For **Internet Address**, enter: **your_short_name@quatro.rocks**

7. Finally, change the **Format Preference** to **Keep in sender's format**

### Creating mail files

After you've created a new user, the next step is to create their corresponding mail file.

To begin, type **ctrl-n** to bring up the New Application dialog:

![New Mail File](../../assets/images/NewMailFile.png)

1. For **Server**, enter: **your_castle_name.projectkeep.io/ProjectKeep**

2. For **Title**, enter a brief description.

3. For **File name** enter: **mail/your_short_name.nsf**

4. Next you need to select a mail template, so for **Server** enter your server name again.

5. Now scroll down through the list of templates and select the Notes 11 template, **mail11.ntf**. Next, click **Save** in the upper right to create your mail file and open it automatically.

### Setting access control

1. The last step is to set the access control for the mail file. So with the mail file open, select: **File / Application / Access Control...** to bring up the Access Control dialog:

![Access Control](../../assets/images/AccessControl.png)

2. Select your own name from the list (because you have manager access) and click **Add...**, then add your new user name: **my_new_user/ProjectKeep** to the Access List. Now check the settings in the upper right, and make sure **User Type** is **Person** and **Access** is **Manager**. Click **OK**.

3. Now you should be good to go. If you want to create more users, just Cut and Paste this user and change the name fields appropriately.

### Creating test data

Once you have a test user with a corresponding mail file, creating test data is very straightforward.

If you want **Mail** data, open up your own mail file, copy a list of emails, and paste them into the mail file you've just created.

If you want **Calendar**, **Contact**, or **Todo** entries, click the **Open** button at the top of the Mail page and create them directly in the mail file.

For **Rules** or **Stationery**, click **Show More / Tools** and add what you like.
