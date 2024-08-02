<!--# Install Volt MX Go via installers-->
# Run Domino REST API using Helm Charts

The procedure guides you on running Domino REST API using helm charts on a Kubernetes platform, such as OpenShift.

## Prerequisite

You have [obtained your authentication token from the HCL Container Repository](../../howto/install/obtainauthenticationtoken.md). 

## Configure Helm to pull from HCL Container Repository

You need to set up Helm with the details necessary to authenticate with the HCL Container Repository. You need your [email and authentication token](../../howto/install/obtainauthenticationtoken.md) used with the HCL Container Repository.

- Run the following command to set up Helm:

    ```
    helm repo add hclcr https://hclcr.io/chartrepo/domino --username <your hclcr username> --password <your hclcr password>
    ```

    !!!example
         `helm repo add hclcr https://hclcr.io/chartrepo/domino --username user.name@example.com --password xx3ds2w`


    !!!note
        Use the **CLI secret** value you saved from [obtaining authentication token from HCL Container Repository](../../howto/install/obtainauthenticationtoken.md) as your authentication token or password.

    If you get an error message similar to the following:

    ``` { .yaml .no-copy }
    Error: looks like https://hclcr.io/chartrepo/domino is not a valid chart repository or cannot be reached: failed to fetch https://hclcr.io/chartrepo/domino/index.yaml : 401 Unauthorized
    ```

    Most likely, you haven't specified your username or authentication token correctly. Make sure the case and content matches exactly what's listed on the HCL Container Repository site and retry.

## Create a namespace and a temp directory for the charts

Run the following commands to create a namespace, set the current context to **drapi**, create a temp directory for downloading the charts, and make it the current directory:

```
kubectl create namespace drapi
kubectl config set-context --current --namespace=drapi
mkdir ~/drapi
cd ~/drapi
```

!!!note
    You must run the `kubectl config set-context --current --namespace=drapi` command to set the current namespace context after each restart of Windows or Rancher Desktop.

## Download the Domino REST API Helm chart

1. Run the following command to make sure that the chart information for the repositories is up-to-date. 

    ```
    helm repo update
    ```
     
2. Run the following command to download the chart:

    ```
    helm pull hclcr/restapi
    ```
    The file `drapi-1.n.n.tgz` is downloaded.

3. Run the following commands to unpack the chart and make the DRAPI directory your current directory:

    ```
    tar -xzvf drapi-1.n.n.tgz
    cd drapi
    ```
    !!!note
        Ensure the version number specified here with tar matches the version you downloaded, such as `drapi-1.0.7.tgz`.

4. Edit the `values.yaml` file using your preferred editor to update the file with your HCL Container Repository credentials, and the DNS name settings.

    1. Locate the following lines in the file and replace `your-email` and `your-authentication-token` with your email and authentication token used with the HCL Container Repository:

        ```{ .yaml .no-copy }
        imageCredentials:
            username: your-email
            password: your-authentication-token
        ```

        !!!note
            Use the **CLI secret** value you saved from [obtaining authentication token from HCL Container Repository](obtainauthenticationtoken.md) as your authentication token or password.

    2. Locate the following lines in the file and add your DNS hostname settings:

        ```{ .yaml .no-copy }
        ingress:
            drapiDnsName:
            drapiManagementDnsName:
        ```
        Whatever hostnames you specify here, you need to ensure that the hostnames are resolvable. There is no additional work if you have already registered the hostnames in DNS. However, if you haven't registered them, you must add the hostnames to the server's /etc/hosts file, substituting your hostnames.

        !!!note
            The example names are `drapi.mymxgo.com` and `drapi-management.mymxgo.com` respectively.

    3. Locate the following lines in the file for the Administrator's first name, last name, and password. Set values for each of these settings. In our example, we're using *admin*, *keep* and *password*. However, if you use your own values, remember the values and use them when required. Remember that the values of `dominoAdminFirstName` and `dominoAdminLastName` are combined, but separated by a space, to form the **username**.

        ```{ .yaml .no-copy }
        dominoAdminFirstName: "admin"
        dominoAdminLastName: "keep"
        dominoAdminPassword: "password"
        ```

        The following fields may be of interest to you as well and may be customized to suite your deployment:

        ```{ .yaml .no-copy }
        dominoServerDomainName: "ocp"
        dominoOrgName: "ocp"
        dominoServerName: "drapi"
        dominoNetworkHostname: ""
        ```

        Consult the [table of variables](../installconfig/docker.md#update-env-file) to determine if you need to update these fields as well. The mapping of `values.yaml` settings to variables is as follows:

        - `dominoServerDomainName = SERVERSETUP_SERVER_DOMAINNAME`
        - `dominoOrgName = SERVERSETUP_ORG_ORGNAME`
        - `dominoServerName = SERVERSETUP_SERVER_NAME`
        - `dominoNetworkHostname = SERVERSETUP_NETWORK_HOSTNAME`

    4. Determine how you want to expose the Domino server to Notes clients by setting the value of the `exposeNRPC` parameter to any of the following options:

        - `do-not-expose`: Set this value to prevent exposure of TCP port 1352 to the network.
        - `HostPort`: Set this value to use TCP port 1352 on your machine for the Notes client to communicate with Domino using the Notes Remote Procedure Call (NRPC) protocol. **This is only recommended when using Rancher Desktop for Kubernetes**.
        - `NodePort`: Set this value if you want Kubernetes to allocate a random port in a specified range, by default 30000 to 32767, that's available on every worker node in the cluster. Kubernetes automatically routes traffic on this port from the Kubernetes node to the back-end Domino pod. **This is the recommended option if you want to expose NRPC to your Notes Clients when deploying into a non Rancher Desktop cluster**. See [Create a new server connection under Procedure](https://opensource.hcltechsw.com/voltmxgo-documentation/howto/connectdominofromnotes.html#procedure) for instructions on how to obtain the random port number.
        - `LoadBalancer`: Set this value if you want an external load balancer to be provisioned by a cloud provider which supports external load balancers. Traffic from the external load balancer is directed at the Domino pod, and the cloud provider decides how it's load balanced. Kubernetes typically starts off by making the changes that are equivalent to you requesting NodePort. The cloud-controller-manager component then configures the external load balancer to forward traffic to that assigned node port.

        You can read more about these options at [https://kubernetes.io/docs/concepts/services-networking/service/](https://kubernetes.io/docs/concepts/services-networking/service/).

6. Save the file and exit. 

<!--5. **(Optional)** If you would like to configure Ingress for Domino REST API, proceed to [Configure Kubernetes Ingress for Domino REST API](../howto/drapiingress.md).-->

## Deploy Domino REST API

1. Deploy Domino REST API by running the following Helm install command:

    ```
    helm install domino . -f values.yaml -n drapi
    ```

    !!!note
        The images must be pulled. It might take awhile, 90 seconds or longer, for the pod to start.

2. Run the following command to wait for the Domino pod to be running and in the ready state:

    ```
    kubectl get pods -o wide -w
    ```

    !!!note
        The `-w` flag tells the kubectl command to wait, and updates the output over time with any changes.

    Eventually you should see 3/3 in the READY column as shown in the example below:

    ```{ .yaml .no-copy }
    NAME                           READY   STATUS              RESTARTS   AGE
    domino-drapi-68596f98fd-bkpdz  0/3     ContainerCreating   0          34s
    domino-drapi-68596f98fd-bkpdz  3/3     Running             0          72s
    ```

3. Once you see the READY column showing 3/3, press `Ctrl-c` to cancel the command.



