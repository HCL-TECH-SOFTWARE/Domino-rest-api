# Setup Virtual Spreadsheet

Virtual spreadsheet is a preview feature that allows you to open up and edit view entries using Microsoft Excel. This feature makes use of the existing round trip editing feature that Domino REST API already has for Microsoft Office applications.

Coming from the word *"virtual"*, virtual spreadsheet doesn't really exist as a spreadsheet file anywhere. It is only created on demand and returned as a spreadsheet file to the user. It is also not saved back as a whole spreadsheet file, instead, Domino REST API reads each row and updating each document tied to its respective view entry.

Virtual spreadsheet is best used when it comes to viewing a list view using Microsoft Excel and performing bulk updates.

## About this task

The procedure guides you on how to setup and use the virtual spreadsheet feature included in Domino REST API.

## Prerequisite

- Make sure your computer has Microsoft Excel installed.
- You must run your Domino REST API in HTTPs.

## Procedures

1. Choose an active view that you want to open. One easy way of getting a list of your views is by going into the Admin UI and going in the **Database Views** section of your target schema.

    !!!tip
      You can also setup the view schema however you wish as virtual spreadsheet respects the configured view schema.

2. Based on the view you selected, you have to setup a `vsheet` mode in the form that your chosen view is selecting from. `vsheet` is a reserved mode name that virtual spreadsheet makes use of when it saves the changes you made per view entry in the Microsoft Excel.

    !!!tip
      For example, if your view's `selectionFormula` states `Form = 'Customers'...`, then the form that must have the `vsheet` mode is `Customers`.

    To do this, you can go into the Admin UI and going in the **Database Forms** section. Find the form in there and click the edit icon. Inside the form configuration page, click the `Add Mode` button and save a mode named `vsheet`.

    Once `vsheet` mode is created, it is recommended to add all the fields from the form in the `vsheet` mode. This way, you can make sure that each field is available to be updated using the virtual spreadsheet.

3. Form the MS Office Excel URI scheme we need to open the virtual spreadsheet. The format is:

    `ms-excel:<command name>|u|<DRAPI HTTPs hostname>/api/webdav-v1/view/<dataSource>/<view name>.xlsx`

    | Property             | Description                                                                                                                             |
    |----------------------|-----------------------------------------------------------------------------------------------------------------------------------------|
    | command name         | Describes the action that the application should perform.<br><br>ofv - to view the file attachment<br>ofe - to edit the file attachment |
    | DRAPI HTTPs hostname | Domino REST API HTTPS hostname.                                                                                                         |
    | dataSource           | Domino database where your view is in.                                                                                                  |
    | view name            | A URL encoded name of your view.                                                                                                        |

    **Example link**:<br>
    `ms-excel:ofe|u|https://whitepalace.projectkeep.io:8880/api/webdav-v1/view/sales/Customers.xlsx`

4. Enter the URI in a browser. A prompt should appear asking if you want to open Microsoft Excel, approve the prompt.

    A login form should greet you next, enter your Domino REST API credentials to proceed.

    If successful, it should look like this:

    ![Virtual Spreadsheet in MS Excel](../../assets/images/VirtualSpreadsheet.png)

    !!!note
      Cells with colored backgrounds are protected cells. This is because these cells are formula columns or a view entry metadata. Cell protection also applies to the cells outside of the main table.

      Cells that are editable are only the cells inside the main table and has a white background.

5. If you made some changes and want to save, do the Microsoft Excel save command and you should see a prompt saying *"Saving..."*. If it becomes *"Saved."*, then it should be good to go.

    !!!note
      Notice the warning label at cell `A1`.

      This means that changes that results into an error when the corresponding document of the view entry is updated won't be saved.

      For example, if you edited 10 rows and 1 row encountered an error, Microsoft Excel would prompt a successful save, but in reality, that 1 row's changes wouldn't get reflected back in its corresponding document.

      This also includes trying to save the changes made with no `vsheet` mode, Microsoft Excel would show that it's saved, but in reality it's not.
