# Edit database schema JSON

## About this task

The procedures guide you in editing the database schema JSON in the **Tree View** mode in the **Source** tab under **Schema Management** so you can:

- add a new JSON object to the database schema
- add a JSON object to an existing JSON object
- edit the value and data type of JSON object
- delete a JSON object from the database schema
- duplicate a JSON object

## Prerequisite

- You have selected a schema on the **Schema Management** page.
- You have selected **Source** from the menu bar and is in the **Tree View** mode.  

## Procedures

### To add a JSON object to the database schema

1. Hover over any JSON object and then click the down arrow icon to open the context menu.

    ![Source tab context menu](../../assets/images/SrcCntxtMenu.png)

    !!! tip
        You can also right-click in the value of the JSON object to open the context menu. This option isn't applicable for JSON objects whose data type is *Object* or *Array*. 

2. Select **Add**. 

3. Enter a **Key**, select a **Type**, and then enter a **Value**.

    ![Insert Object](../../assets/images/insertjsonobject1.png)
 
    !!!tip
        The available value **Types** are *String*, *Boolean*, *Number*, *Array*, and *Object*.

3. Click **Insert**. The added JSON object is placed at the end of the list. 

4. Click the **Save** icon to save the changes. 

    ![Save icon in the Source tab](../../assets/images/SrcSaveIcn.png)

<!--
### To add a JSON object to the database schema

1. Click **Insert Object**.

    ![Insert Object](../../assets/images/insertjsonobject.png)

2. Enter a **Key**, select a **Type**, and then enter a **Value**.

    ![Insert Object](../../assets/images/insertjsonobject1.png)
 
    !!!tip
        The available value **Types** are string, number, Boolean, null, object, and array.

3. Click **Update**, and then click **Save**. 
-->

### To add a JSON object to an existing JSON object

!!!note
    You can only add a new JSON object to existing JSON object whose data type is either an *Object* or an *Array*. 

1. Hover over the object you want to add a new object to and then click the down arrow icon to open the context menu.

2. Select **Add**. 

3. Enter a **Key**, select a **Type**, and then enter a **Value**.

4. Click **Insert**. The added JSON object is placed at the end of the list of JSON objects. 

4. Click the **Save** icon to save the changes.

<!--
**For a JSON object whose data type is *Object***

1.	Hover over the object you want to add a new object to  and then click **Add**.

    ![Insert Object](../../assets/images/insertjsonobject2.png)

2.	Enter a **Key**, select a **Type**, and then enter a **Value**.
3.	Click **Update**, and then click **Save**. 

**For a JSON object whose type is *array***

1. Hover over the object you want to add a new object to, and then click **Add**.

    ![Insert Object](../../assets/images/insertjsonobject3.png)

2.	Select a **Type**, and then enter a **Value**.
3.	Click **Update**, and then click **Save**. 

-->

### To update a JSON object

!!!note
    You can only update JSON objects whose data type isn't *Object* or *Array*.

1. Hover over any JSON object and then click the down arrow icon to open the context menu.

    !!! tip
        You can also right-click in the value of the JSON object to open the context menu.

2. Select **Edit**. 

3. Update the **Key**, **Type**, and **Value** as required.

3. Click **Insert**. The added JSON object is placed at the end of the list. 

4. Click the **Save** icon to save the changes.

<!--
### To update the type and value of a JSON object

!!!note
    You can only update the type and value of the JSON object whose type isn't *object* or *array*. 

1. Click the object to be updated.

    Or
	
    Hover over the object to be updated, and then click **Edit**.

2.	Select the new **Type**, and then enter the new **Value**.

    !!!tip
        If you only need to update the **Value**, then just enter the new value.

3.	Click **Update**, and then click **Save**. 
-->

### To delete a JSON object from the database schema

1. Hover over the JSON object that you want to delete and then click the down arrow icon to open the context menu.   

2. Select **Remove**. 

3. Click the **Save** icon to save the changes.

<!--
### To delete a JSON object from the database schema

- Click the object to be deleted, click **Delete**, and then click **Save**.

    Or

    Hover over the object to be deleted, click **Delete**, and then click **Save**.
-->

### To duplicate a JSON object

!!!note
    You can only duplicate JSON objects whose data type is either an *Object* or an *Array*.

1. Hover over any JSON object and then click the down arrow icon to open the context menu.

2. Select **Duplicate**. The duplicated JSON object is placed at the end of the list.

3. Click the **Save** icon to save the changes.