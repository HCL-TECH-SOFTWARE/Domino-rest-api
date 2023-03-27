# Configure Domino REST API as SAML identity provider

To be able to access encrypted resources, like emails or confidential documents in application databases, Domino REST API needs to be configured as a SAML identity provider.

There are two scenarios:

- Domino REST API is the only identity provider (This feature is subject to a later code drop).
- Domino REST API is an additional identity provider (This feature is subject to a later code drop).

<!--SAML is already available for you. You just need to add Domino REST API as an Identity Provider. Below is how you can do that and setup websites to use an ID Vault via SAML.-->

## About this task

As SAML is already available for you, the procedure guides you on adding Domino REST API as an Identity Provider and setting up websites to use an ID Vault via SAML.

The procedure guides you on configuring

## Procedure

1. Open Domino Administrator. Go to **Current Server Document** and open **Configuration** tab. Make sure **Load Internet configurations from Server\Internet Sites documents** is enabled. Save and close.

      ![Load Internet Configuration](../../assets/images/SAML-LoadInternetConfigurations.png)

2. From the left panel, select **Web** and then select **Internet Sites**. Click on **Add Internet Site** tab and select **Web** from the menu.

      ![Add Internet Site](../../assets/images/SAML-AddInternetSite.png)

      Now enter the following under **Basics**:

      - **Organization Name** (For example: Domino REST API)
      - **Host names or addresses**: Add your hostname.
      - **Domino servers that host this site**: Add your server name.

      ![Server Name](../../assets/images/SAML-ServerName.png)

      Under **Domino Web Engine** tab, set **Session authentication** to SAML.

      ![Web Engine Tab](../../assets/images/SAML-WebEngineTab.png)

      Under **Security** tab, for **TCP Authentication**, disable **Anonymous**.

      ![TCP Authentication](../../assets/images/SAML-TCPAuthentication.png)

      Save and close.

3. Create an idpcat.nsf file using idpcat.ntf template. To do that, click **File**, go to **Application** and select **New**. In the **New Application** pop up, fill in the following details:

      - **Server**: Select your server from the dropdown.
      - **Title**: Give title as idpcat.
      - **Template**: Click on advanced template and select IdP catalog template.

      ![IdP Catalog](../../assets/images/SAML-IdPCatalog.png)

      Click **OK**. Now try to open the Idpconfig. To do that press **ctrl+o**, enter the name of the current server and file name as “idpcat.nsf”. Click **Open**.

      ![idpcat](../../assets/images/SAML-idpcat.png)

      Click **Add IdP Config**.
      Under the **Basics** tab, add the following:

      - **Host names or addresses mapped to this site**: Add your host name.
      - **Service provider ID**: Add your server URL.
      - **Single sign-on service URL**: https://keycloak.quattro.rocks/auth/realms/hcllabs/protocol/saml

      You should have _descriptor.xml_ file on your machine. Import it here using **Import XML file**.

      ![DescriptorXML](../../assets/images/SAML-DescriptorXML.png)

      Under **Client Settings** tab, set the following:

      - **Enable Windows single sign-on**: Yes
      - **Enforce TLS**: No

      ![Enforce TLS](../../assets/images/SAML-EnforceTLS.png)

      Under **Certificate Management** tab, click **Company name**. You should see **Create SP Certificate** button.

      ![CreateSPCertificate](../../assets/images/SAML-CreateSPCertificate.png)

      Click **Create SP Certificate**. You will be prompted for **Company name**. Give a unique name. Also set the below field:
      **Domino URL**: Add your service URL.

      Click on **Export SP XML** and save `ServiceProvider.xml` for further use.

      ![Service Provider](../../assets/images/SAML-ServiceProvider.png)

      Save and close.

4. Create ID Vault. Open **Domino Administrator** and expand **ID Vaults** on right hand side navigator.

      ![Expand ID Vaults](../../assets/images/SAML-ExpandIDVaults.png)

      Click on **Create...**. On the dialog that comes up, click on **Next**.

      ![Create ID Vault Dialog](../../assets/images/SAML-CreateIDVaultDialog.png)

      On the next screen, add **ID vault name** and click **Next**.

      ![ID Vault Name](../../assets/images/SAML-IDVaultName.png)

      On the next screen, set your password and hit **Next**.

      ![ID Vault Password](../../assets/images/SAML-IDVaultPassword.png)

      On the next screen, select the **Vault server**.

      ![Vault Server](../../assets/images/SAML-VaultServer.png)

      Add or remove administrators who can access vault.

      ![Administrator](../../assets/images/SAML-Administrator.png)

      You can also add or remove organizations.

      ![Organization](../../assets/images/SAML-Organization.png)

      You can specify who is authorized to reset passwords.

      ![Password Reset](../../assets/images/SAML-PasswordReset.png)

      Click on **Next** and select **Create a new policy assigned to specific people or groups.**

      ![Policy](../../assets/images/SAML-Policy.png)

      You can add or remove people who can add or edit ID vault policy settings.

      ![People](../../assets/images/SAML-People.png)

      Set the hint for **Forgotten Password Help**.

      ![Password Hint](../../assets/images/SAML-PasswordHint.png)

      Now by clicking on **Create Vault**, the vault will be created.

   You now need to set up your ID Vault.
   Open your vault NSF (for example: `IBMID_VAULT\testsaml.nsf`). Click **Open** by selecting the file.

   Navigate to **Configuration** tab, edit document and add the host address in **Web federated login approved IDP configurations**.
