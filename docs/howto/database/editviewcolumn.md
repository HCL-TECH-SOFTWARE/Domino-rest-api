# Edit columns in a database view of a schema
 
## About this task
 
The procedures guide you in editing a database view of a schema so you can:

- select the columns you want to include in the view 
- edit the external name of the selected columns
- reset an edited view to its initial state
 
## Prerequisite
 
- The view should be in **Active** status. For more information, see this [Activate a view](../../references/usingdominorestapi/administrationui.md#activate-a-view).

## Procedures 

### To edit a view
 
1. Log in to the Domino REST API Admin UI and click **Database Management - REST API**.
2. On the **Schema Management** page, select a schema.
3. Click **Database Views** from the menu bar. 
4. Click the pencil icon corresponding to the name of the view you want to edit. The **Edit [view name] Columns** page opens. 
    
    !!!note
        The selected view should be in **Active** status.

5. From the left pane, select the names of the columns that you want to include in the view. The column names appear in the right pane. 

    !!!tip
	    - The order in which you select the name of the columns correspond to the order of the columns.
	    - Click **Add All** if you want to add all the columns. 
	    - To delete a selected column, click the corresponding trash icon. 

6.  **(Optional)** Edit the external name of a selected column.
	1. If the selected column has no existing external name, enter a name in the **Name** field under **External Name**.
	2. If the selected column has an existing external name, delete the name and enter a new name in the **Name** field under **External Name**.
7. Click **Save**. A notification informs you that the schema has been successfully updated.   

### Expected result 

The view now only shows the columns that you have selected.
 
### To reset an edited view
 
1. Log in to the Domino REST API Admin UI and click **Database Management - REST API**.
2. On the **Schema Management** page, select a schema.
3. Click **Database Views** from the menu bar. 
4. Click the pencil icon corresponding to the name of an edited view you want to reset. The **Edit [view name] Columns** page opens. 
    
    !!!note
        The selected view should be in **Active** status.

5. Click **Reset**. A confirmation dialog appears.
6. Click **Yes**. A notification informs you that the schema has been successfully updated.

### Expected result

The view is reset to its initial state showing all its columns.
