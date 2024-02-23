# Setup Office Round Trip Experience

Microsoft Office Round Trip Experience is a feature included in Domino REST API that simplifies editing of a supported Microsoft Office file attached to a Domino document. The feature enables you to access, edit, and save the changes to the attached file using applicable Microsoft Office application without having to download and re-attach the file to the Domino document. 

## About this task 

The procedure guides you on how to setup and use the Microsoft Office Round Trip Experience feature included in Domino REST API. 

## Prerequisite

- Make sure your computer has Microsoft Office installed or can access Office 365.
- You must run your Domino REST API in HTTPs. 

## Procedure

**To add an MS Office attachment and create a link**

1. Add a Microsoft Office file as an attachment to a Domino document. 

    !!!tip
        You can use the `POST attachments/{unid}` endpoint to add the file as attachment. 


2. Manually create the link to access the attached file using the following format.

    ```
    <scheme name>:<command name>|u|<DRAPI HTTPs hostname>/api/webdav-v1/<dataSource>/<document UNID>/<filename>
    ```


    |Property|Description|
    |:-----|:--------|
    |scheme name|Scheme name of Microsoft Office application</br></br>When Microsoft Office is installed, each scheme name is registered with the operating system to be handled by the Office product of the same name. Below is a list of scheme names:</br></br>ms-word</br>ms-powerpoint</br>ms-excel</br>ms-visio</br>ms-access|
    |command name|Describes the action that the application should perform.</br></br>ofv - to view the file attachment</br>ofe - to edit the file attachment</br>|
    |DRAPI HTTPs hostname| Domino REST API HTTPS hostname|
    | dataSource | Domino database where your current document is uploaded or attached.|
    | document UNID| Universal ID of the Domino document.|
    | filename | Filename of the Microsoft Office file attached to the Domino document.|

    **Example link**:</br>
    `ms-word:ofv|u|whitepalace.keepproject.io:8880/api/webdav-v1/attachmentdb/2D88CDF9549379C700258A9F002797CA/sample.docx`

    !!!info
        The link format is based on the [Office URI Schemes](https://learn.microsoft.com/en-us/office/client-developer/office-uri-schemes).

**To access and edit the MS Office file attachment**

1. Open the manually created link to the MS Office file attachment in any web browser.
2. In the Open MS Office application dialog, click Open.

    ![alt text](../assets/images/rtprompt.png)

3. In the log in dialog, enter your Domino REST API login credentials and click **Login**. 

    ![alt text](../assets/images/ofbalogin.png)

    !!!info
        The authentication is based on the [Office Forms Based Authentication (OFBA)](https://learn.microsoft.com/en-us/openspecs/sharepoint_protocols/ms-ofba/30c7bbe9-b284-421f-b866-4e7ed4866027) protocol. This is necessary since browsers and office applications don't currently support cookie and header sharing.

    The MS Office file attachment is now opened in the applicable MS Office application. In the following image, you will see an opened MS Word document as an example.

    ![alt text](../assets/images/rtmodify.png)

4. Edit the attachment. 

    !!!note
        Editing is only possible if the specified command name in the manually created link is `ofe`.

    As an example, the content of the opened MS Word document is changed from *Nothing to see here* to *Hello Sprint playback 114!!*.   

5. Save your changes, and close the MS Office application. You have now edited the attachment without downloading it and reattaching it again the Domino document.

**To verify your updates to the MS Office file attachment**

1. Open the manually created link to the MS Office file attachment that you have edited in any web browser.
2. In the Open MS Office application dialog, click Open.
3. In the log in dialog, enter your Domino REST API login credentials and click **Login**. The MS Office file attachment is now opened in applicable MS Office application and you can verify the updates that you have made.

    The following image shows that the content of the edited attachment has been updated.  

    ![alt text](../assets/images/rtsave.png)


## Additional information

For more information on MS Office file extensions recognized by **Office Forms Based Authentication**, see [Extensions used to open Microsoft Office in OFBA](../references/ofba.md).


<!--

## Access and edit the MS Office attachment

1. **Attach** files in your documents on your Domino server. In order to use the "*office round trip experience*", you must attach any MS Office Word, Powerpoint or Excel or CSV or any file that runs in Microsoft Office.

2. After attaching the file, those Office attachments will be accessible using the following format:
    ```
    (office scheme name):(optional office command argument)|u|(DRAPI+ HTTPs hostname)/api/webdav-v1/(dataSource)/(document UNID)/(filename)
    ```
    Example:
    [ms-word:ofv|u|whitepalace.keepproject.io:8880/api/webdav-v1/attachmentdb/2D88CDF9549379C700258A9F002797CA/sample.docx](ms-word:ofv|u|whitepalace.keepproject.io:8880/api/webdav-v1/attachmentdb/2D88CDF9549379C700258A9F002797CA/sample.docx)
    
    ![alt text](../assets/images/rtlink.png)

    |Fomat |Description|
    |:-----|:--------|
    |(office scheme name)| Here is a list of scheme names that have been implemented in Microsoft Office applications. Once Microsoft Office is installed, the operating system registers each scheme name to be managed by the corresponding Office product. <br></br> <br>ms-word:</br><br>ms-powerpoint:</br><br>ms-excel:</br><br>ms-visio:</br><br>ms-access:</br>|
    | office command argument (optional) | Executing this command will prompt the program to open the document specified by the URI in a mode that only allows reading or viewing.  <br></br> <br> ofv - to view the document </br> <br>ofe - to edit the document</br>|
    |Domino REST API hostname| It is the Domino REST API where your Domino document is attached. Note: This feature works only for HTTPs|
    | dataSource | It is the Domino database where your current document is uploaded or attached.|
    | document UNID| The Universal ID in which the document is attached or uploaded.|
    | filename | It is the name of the the file that ends in  Office extension. |

3. **Click** the URL link. When MS Office detects the document extension, it will display a notice prompting the user to open the file in a specific Office document. 

    For details on the file extension of MS-Office that is recognized by **Office Forms Based Authentication**, click on the following [link](../references/ofba.md).

    Example: `sample.docx, sample.xls.`

    ![alt text](../assets/images/rtprompt.png)
    
    Example link:
    [ms-word:ofv|u|whitepalace.keepproject.io:8880/api/webdav-v1/attachmentdb/2D88CDF9549379C700258A9F002797CA/sample.docx](ms-word:ofv|u|whitepalace.keepproject.io:8880/api/webdav-v1/attachmentdb/2D88CDF9549379C700258A9F002797CA/sample.docx)

3. The **Office Forms Based Authentication (OFBA)** page will appear. **Provide** your login details for the Domino REST API. If your credentials are incorrect, the MS Office will restrict you from opening the document.
    
    !!!info
        One way to handle authentication is by using Office Forms Based Authentication [(OFBA)](https://learn.microsoft.com/en-us/openspecs/sharepoint_protocols/ms-ofba/30c7bbe9-b284-421f-b866-4e7ed4866027), which includes a link to the format [Office URI schemes](https://learn.microsoft.com/en-us/office/client-developer/office-uri-schemes). This is necessary since browsers and office applications do not currently support cookie and header sharing.

    !!!note
        - For the Office Forms Based Authentication to work, your Domino REST API must be connected to and running on HTTPs.
        - If the command argument is `ofe`, this will open and and lets you edit the document.
        - If the command argument is `ofv`, this will let you open and read only the document.
    
    ![alt text](../assets/images/ofbalogin.png)

4. **Modify** your document, **save** and **close** the Microsoft Office. It will save without downloading on your local and reattach again the document. It will be save on your Domino server.

    !!!tip "Microsoft Office Round Trip edit"
        This feature enables you to access compatible file formats, particularly those commonly used in Microsoft office settings, using their respective native applications. When saving the file, it is sent back to the document on the server. No need to download and reattach again the document.

    In the example, we will going to **modify** the "Nothing to see here" into "Sprint playback 114!!". Do not forget to **save** and **close** the Microsoft app.

    ![alt text](../assets/images/rtmodify.png)

    Try to open the link again, enter your **OFBA** or your **Domino REST API credentials**. The document has been modified.

    ![alt text](../assets/images/rtsave.png)

-->