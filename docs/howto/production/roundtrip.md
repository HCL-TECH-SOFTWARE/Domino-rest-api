# Set up Office Round Trip Experience

Microsoft Office Round Trip Experience is a feature included in Domino REST API that simplifies editing of a supported Microsoft Office file attached to a Domino document. The feature enables you to access, edit, and save the changes to the attached file using the applicable Microsoft Office application without having to download and re-attach the file to the Domino document. 

## About this task 

The procedure guides you on how to setup and use the Microsoft Office Round Trip Experience feature included in Domino REST API. 

## Prerequisite

- Make sure your computer has Microsoft Office installed or can access Office 365.
- You must run your Domino REST API in HTTPs. 

## Procedures

### Add an MS Office attachment and create a link

1. Add a Microsoft Office file as an attachment to a Domino document. 

    !!!tip
        You can use the `POST /attachments/{unid}` endpoint in the [OpenAPI UI](../../tutorial/swagger.md) to add the file as attachment.

2. Create a link to access the attached file. You can do this by either:
    
    - Manually creating the link to access the attached file using the following format.

        ```
        <scheme name>:<command name>|u|<DRAPI HTTPs hostname>/api/webdav-v1/attachment/<dataSource>/<document UNID>/<filename>
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
        `ms-word:ofv|u|whitepalace.keepproject.io:8880/api/webdav-v1/attachment/attachmentdb/2D88CDF9549379C700258A9F002797CA/sample.docx`

        !!!info
            The link format is based on the [Office URI Schemes](https://learn.microsoft.com/en-us/office/client-developer/office-uri-schemes).

    **OR**

    - Using the `GET /attachmentnames/{unid}` endpoint to retrieve URLs to access the attached files.

        !!!caution "Important"
            Make sure to set the value of the `includeProtocolUrl` query parameter to `true` to include the attachment URLs in the query response. 

        The query response shows the filenames of the attachments and the URLs of the attachments with supported file extensions. There are two URLs for each attachment, one for viewing as indicated by the `ofv` command name and one for editing as indicated by the `ofe` command name included in the URLs. Attachments with unsupported file extensions will have no URLs. 

        The query response example below shows the attachment file named `document.docx` has two URLs, as the file extension `.docx` is supported. However, no URLs are available for the attachment file named `sample.png` as the file extension `.png` isn't yet supported.   

        ```json
        {
        "Files": [
            {
            "filename": "document.docx",
            "urls": [
                "ms-word:ofv|u|http://localhost:8880/api/webdav-v1/attachment/dataSource/documentUNID/document.docx",
                "ms-word:ofe|u|http://localhost:8880/api/webdav-v1/attachment/dataSource/documentUNID/document.docx"
                    ]
            },
            {
            "filename": "sample.png",
            "urls": []
            }
                ]
        } 
        ```


### To access and edit the MS Office file attachment

1. Open the created link to the MS Office file attachment in a web browser.
2. In the Open MS Office application dialog, click Open. 

    The following image shows an example of the **Open Microsoft Word** dialog when trying to open a Microsoft Word attachment.

    ![Open MS Office application](../../assets/images/SaveMSW.png){: style="height:70%;width:70%"}

3. In the login dialog, enter your Domino REST API login credentials and click **Login**. 

    ![Login dialog](../../assets/images/ofbalogin.png)

    !!!info
        The authentication is based on the [Office Forms Based Authentication (OFBA)](https://learn.microsoft.com/en-us/openspecs/sharepoint_protocols/ms-ofba/30c7bbe9-b284-421f-b866-4e7ed4866027) protocol. This is necessary since browsers and office applications don't currently support cookie and header sharing.

    The MS Office file attachment is now opened in the applicable MS Office application. In the following image, you see an opened MS Word document as an example.

    ![Example of opened Microsoft Word attachment](../../assets/images/rtmodify.png)

4. Edit the attachment. 

    !!!note
        Editing is only possible if the specified command name in the created link is `ofe`.

    As an example, the content of the opened MS Word document is changed from *Nothing to see here* to *Hello Sprint playback 114!!*.   

5. Save your changes, and close the MS Office application. You have now edited the attachment without downloading it and reattaching it again to the Domino document.

### To verify your updates to the MS Office file attachment

1. Open the created link to the MS Office file attachment that you have edited in a web browser.
2. In the Open MS Office application dialog, click Open.
3. In the login dialog, enter your Domino REST API login credentials and click **Login**. The MS Office file attachment is now opened in applicable MS Office application and you can verify the updates that you have made.

    As an example, the following image shows that the content of the edited Microsoft Word attachment has been updated.  

    ![Example of edited content](../../assets/images/rtsave.png)


## Additional information

For more information on MS Office file extensions recognized by **Office Forms Based Authentication**, see [Extensions used to open Microsoft Office in OFBA](../../references/ofba.md).
