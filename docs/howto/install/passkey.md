# Use WebAuthn (Passkey) to log in to Admin UI

!!!caution "Important"
    This feature is only applicable if your host is using HTTPS. 

## About this task
The procedures guide you in using a passkey to log in to **Admin UI**. The procedures involve:

- signing up with passkey
- logging in to Admin UI using a passkey
- clearing the passkey

Passkeys are better options to passwords as they use public key cryptography to create secure experiences. Passkeys allow sign-in to websites without remembering and managing passwords by using a biometric sensor, PIN, or pattern. For more information, see [passkey.org](https://passkey.org/).

## Prerequisites

### For Mac using Keychain

- You have [set up iCloud Keychain](https://support.apple.com/en-ph/guide/mac-help/mh43699/13.0/mac/13.0) to create a passkey.

- You have an Apple ID to set up iCloud Keychain.
- Your Mac has a Touch ID sensor, you have a connected iPhone or iPad, or you have an external security key.

!!!note 
    Chrome supports passkeys on iCloud Keychain starting in Chrome 118, on macOS 13.5 or later. For more information, see [Chrome for Developers blog post](https://developer.chrome.com/blog/passkeys-on-icloud-keychain).

### For Windows

- You have set up [Windows Hello](https://support.microsoft.com/en-us/windows/learn-about-windows-hello-and-set-it-up-dae28983-8242-bb2a-d3d1-87c9d265a5f0) as Chrome on Windows stores passkeys in Windows Hello.
- Your Windows machine supports the Windows Hello options.  

### Other Passkey Managers

Some third-party password managers, such as [1Password](https://1password.com/product/passkeys) support Passkeys as well. Refer to their documentation for details on configuration and requirements.

## Procedures

### To sign up with passkey

1. Open the **Domino REST API Admin UI** sign-in page in your browser.
2. Enter your **Username** and **Password**, and then click **Sign up with Passkey**. 

    ![Sign up with passkey](../../assets/images/signuppasskey.png){: style="height:60%;width:60%"}
    
    A dialog opens. The following image shows an example of the dialog opened in Chrome on macOS. 

    ![Create a passkey dialog](../../assets/images/passkeydialog.png){: style="height:60%;width:60%"}          

3. Using the provided example, you can click **Create** or click **Save another way** to choose where to save your passkey from the available options. Follow the succeeding instructions to complete the process. 

You have now logged in to the **Domino REST API Admin UI**.

### To log in to Admin UI with passkey

!!!note
    See [Configure WebAuthn with Domino REST API and Domino 14](../../howto/install/webauthn.md) to use the same passkey.

1. Open the **Domino REST API Admin UI** sign-in page in your browser. The **Username** field is already filled with the username you used when you signed up with your passkey.  

    ![Log in with passkey](../../assets/images/loginpasskey.png){: style="height:60%;width:60%"}

2. Click **LOG IN WITH PASSKEY**.
3. Follow the instructions to use your passkey. The instructions vary depending on what you have chosen on how to create the passkey. 

You have now logged in to the **Domino REST API Admin UI**.

### To clear your passkey

Check and follow the instructions for clearing a passkey on the Internet based on how you created your passkey. The following are links to some of those instructions:

- [Remove a passkey or password from your Mac and iCloud Keychain](https://support.apple.com/en-ph/guide/mac-help/mchl77e2cb66/14.0/mac/14.0)
- [Manage your passkeys in Windows](https://support.microsoft.com/en-us/windows/manage-your-passkeys-in-windows-6a70599a-25e1-4461-86be-d67d1023c69f)
- [Manage passkeys in Chrome](https://support.google.com/chrome/answer/13168025?hl=en&co=GENIE.Platform%3DDesktop#zippy=%2Cmanage-passkeys-in-macos%2Cmanage-passkeys-in-windows)

