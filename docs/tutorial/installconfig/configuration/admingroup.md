# Manage databases

The following databases are created on the Domino server as part of the Domino REST API installation:

|Database name|Database filename|Description|
|:---|:---|:---|
|Domino Keep Configuration|keepconfig.nsf|Database that stores the scope configurations and OAuth application information.|
|Domino Keep Agent Scheduler|keepagents.nsf|Database that stores the document for tracking the processing of an agent. The document is created when running the agent asynchronously via Domino REST API.|
|Domino Keep OAuth|oauth.nsf|Database that stores OAuth refresh tokens.|

These databases must be secured and managed like other production databases.

## About this task

The procedures guide you in configuring the Domino REST API databases to secure and manage them like other production databases.

## Set administrator permission

For the databases created as part of the Domino REST API installation, the `LocalKeepAdmins` group is added automatically to the ACL of these databases. The `LocalKeepAdmins` group by default has *Editor* access level to the `KeepConfig.nsf`.

To utilize the `LocalKeepsAdmins` group to provide administrator permission, add users who should be Domino REST API administrators to the `LocalKeepAdmins` group. For more information, see [Configuring a database ACL](https://help.hcl-software.com/domino/14.0.0/admin/conf_configuringadatabaseacl_t.html "Opens a new tab"){: target="_blank" rel="noopener noreferrer"}&nbsp;![link image](../../../assets/images/external-link.svg){: style="height:15px;width:15px"} in the HCL Domino documentation.

## Update access control list

The databases created as part of the Domino REST API installation must have their [ACLs](https://help.hcl-software.com/domino/14.0.0/admin/conf_thedatabaseaccesscontrollist_c.html "Opens a new tab"){: target="_blank" rel="noopener noreferrer"}&nbsp;![link image](../../../assets/images/external-link.svg){: style="height:15px;width:15px"} updated to meet your organization’s security requirements by adding your administration and server groups. It's also recommended that you add the Domino server where Domino REST API is installed as the administration server.

- Domino Keep Agent Scheduler - `keepagents.nsf`

    The default access level for this database is *Reader*. For those users that manage the runtime agents, they must have at least an *Editor* access level to this database.

- Domino Keep OAuth - `oauth.nsf`

    The default access level for this database is *Author* without the Delete flag to allow users to revoke their consents using the **Admin UI**.

- Domino Keep Configuration - `keepconfig.nsf`

    The default access level for this database is *Reader*.

For more information on updating the access control list, see [Configuring a database ACL](https://help.hcl-software.com/domino/14.0.0/admin/conf_configuringadatabaseacl_t.html "Opens a new tab"){: target="_blank" rel="noopener noreferrer"}&nbsp;![link image](../../../assets/images/external-link.svg){: style="height:15px;width:15px"} in the HCL Domino documentation.

To learn more about access control list, see:

- [Access levels in the ACL](https://help.hcl-software.com/domino/14.0.0/admin/conf_accesslevelsintheacl_c.html "Opens a new tab"){: target="_blank" rel="noopener noreferrer"}&nbsp;![link image](../../../assets/images/external-link.svg){: style="height:15px;width:15px"}
- [Access level privileges in the ACL](https://help.hcl-software.com/domino/14.0.0/admin/conf_accesslevelprivilegesintheacl_c.html "Opens a new tab"){: target="_blank" rel="noopener noreferrer"}&nbsp;![link image](../../../assets/images/external-link.svg){: style="height:15px;width:15px"}

## Sign the databases

As with any database added to your Domino server, it's recommended you sign the databases created as part of the Domino REST API installation to vouch for their integrity. You can sign the databases with either the server’s ID or your organization’s signing ID. Using the Domino Administrator client, select `keepagents.nsf`, `keepconfig.nsf`, and `oauth.nsf` and sign them with the respective ID file.

For more specific information on the procedure for signing the databases, see [Signing a database or template](https://help.hcl-software.com/domino/14.0.0/admin/admn_signingadatabaseortemplate_t.html "Opens a new tab"){: target="_blank" rel="noopener noreferrer"}&nbsp;![link image](../../../assets/images/external-link.svg){: style="height:15px;width:15px"}.

## Next step

Proceed to [Expose databases for REST API access](exposedb.md).
