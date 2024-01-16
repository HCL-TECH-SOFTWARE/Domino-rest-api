# Obtain authentication token from HCL Container Repository

## About this procedure

The container images <!--and Helm charts-->for Domino REST API can be pulled from the HCL Container Repository. This requires you to get your authentication token from the HCL Container Repository. This procedure guides you on how to obtain your authentication token or password.

## To obtain your authentication token

1. Go to the [HCL Container Repository](https://hclcr.io){: target="_blank"}.
2. On the login page, click **LOGIN VIA OIDC Provider**, and then login using your corporate email address.
3. On the **Projects** page, click your username and select **User Profile**.

    ![user profile](../../assets/images/harborproject.png)

4. On the **User Profile** dialog, copy the value of the **CLI secret** by clicking the copy icon.

    ![user profile dialog](../../assets/images/userprofile.png)

5. Save the **CLI secret** value as you will use it as your authentication token or password when using Docker or Helm CLI to access HCL Container Repository.
6. Take note of exactly how your email address or username is written in the **User Profile** dialog as authentication is case sensitive on the user email.
