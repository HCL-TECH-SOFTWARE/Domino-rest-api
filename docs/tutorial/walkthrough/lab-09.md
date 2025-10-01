# Lab 9 - Unlock additional ports

## What you will learn

- Understanding of metrics, healthcheck, and management.
- How to configure functional accounts.

## Before you begin

Your Domino server must be running.

## Procedure

1. Create a JSON file in the `keepconfig.d` directory and provide it with any filename, such as `portmagic.json`.
2. Add the following content in the JSON file:

    ```json
    {
      "DEBUG": true,
      "identity": {
        "healthcheckAPI": {
          "health": {
            "active": true,
            "secret": "FA1D8FC7DAA715F20A3C19F62451DCD011483EFBABE46A1C03F2CF0702365726:0A2AC2338974379073BEF880B2EA9E4FE86651974C83D3958DB73C81047CF3815456678A3EE206975CE17B7874589478A2FC92DCDF2C1794087AED94BF8FD4CA"
          }
        },
        "managementAPI": {
          "Doctor Notes": {
            "active": true,
            "secret": "FA1D8FC7DAA715F20A3C19F62451DCD011483EFBABE46A1C03F2CF0702365726:0A2AC2338974379073BEF880B2EA9E4FE86651974C83D3958DB73C81047CF3815456678A3EE206975CE17B7874589478A2FC92DCDF2C1794087AED94BF8FD4CA"
          }
        },
        "metricsAPI": {
          "metrics": {
            "active": true,
            "secret": "FA1D8FC7DAA715F20A3C19F62451DCD011483EFBABE46A1C03F2CF0702365726:0A2AC2338974379073BEF880B2EA9E4FE86651974C83D3958DB73C81047CF3815456678A3EE206975CE17B7874589478A2FC92DCDF2C1794087AED94BF8FD4CA"
          }
        }
      },
      "metrics": {
        "enabled": true,
        "jvmMetricsEnabled": true
      }
    }
    ```

    !!! note

        - The secret `FA1D8FC7DAA715F20A3C19F62451DCD011483EFBABE46A1C03F2CF0702365726:0A2AC2338974379073BEF880B2EA9E4FE86651974C83D3958DB73C81047CF3815456678A3EE206975CE17B7874589478A2FC92DCDF2C1794087AED94BF8FD4CA` is the result of salting the password *supersecret*. 
        - Never use the password *supersecret* in production or externally reachable servers as it is weak and not a good password to use. 

3. Restart Domino REST API.

## How to verify

To verify access using the functional accounts, navigate to the following URLs. You will be prompted for basic authentication. Enter the username corresponding to the key specified in the JSON file and the password *supersecret*.

- Healthcheck: [http://localhost:8886/health](http://localhost:8886/health)

- Metrics: [http://localhost:8890/metrics](http://localhost:8890/metrics)

- Management UI: [http://localhost:8889/](http://localhost:8889/)

## Things to explore

- [Domino REST API documentation](https://opensource.hcltechsw.com/Domino-rest-api/index.html)

- [Discord discussion](https://discord.com/invite/jmRHpDRnH4)

- [Configuration management and overlay hierarchy](../../references/configuration/understandingconfig.md)

## Next step

Proceed to [Lab 10 - Configure JWT](lab-10.md).


<!--
## Duration 20 min

## What you will learn

- Learn about metrics, healthcheck & management
- Configure the functional accounts

## Prerequisites

- Domino running

## Steps

![config stack](img/ActualConfiguration.svg){: style="height:80%;width:80%"}

- Create a JSON file in `keepconfig.d` with any name, such as `portmagic.json`.
- Add the content like below:

!!! danger "[supersecret] isn't a good password"

    You have to promise never to use that in production or externally reachable servers:

    `FA1D8FC7DAA715F20A3C19F62451DCD011483EFBABE46A1C03F2CF0702365726:0A2AC2338974379073BEF880B2EA9E4FE86651974C83D3958DB73C81047CF3815456678A3EE206975CE17B7874589478A2FC92DCDF2C1794087AED94BF8FD4CA`

```json
{
  "DEBUG": true,
  "identity": {
    "healthcheckAPI": {
      "health": {
        "active": true,
        "secret": "FA1D8FC7DAA715F20A3C19F62451DCD011483EFBABE46A1C03F2CF0702365726:0A2AC2338974379073BEF880B2EA9E4FE86651974C83D3958DB73C81047CF3815456678A3EE206975CE17B7874589478A2FC92DCDF2C1794087AED94BF8FD4CA"
      }
    },
    "managementAPI": {
      "Doctor Notes": {
        "active": true,
        "secret": "FA1D8FC7DAA715F20A3C19F62451DCD011483EFBABE46A1C03F2CF0702365726:0A2AC2338974379073BEF880B2EA9E4FE86651974C83D3958DB73C81047CF3815456678A3EE206975CE17B7874589478A2FC92DCDF2C1794087AED94BF8FD4CA"
      }
    },
    "metricsAPI": {
      "metrics": {
        "active": true,
        "secret": "FA1D8FC7DAA715F20A3C19F62451DCD011483EFBABE46A1C03F2CF0702365726:0A2AC2338974379073BEF880B2EA9E4FE86651974C83D3958DB73C81047CF3815456678A3EE206975CE17B7874589478A2FC92DCDF2C1794087AED94BF8FD4CA"
      }
    }
  },
  "metrics": {
    "enabled": true,
    "jvmMetricsEnabled": true
  }
}
```

- Restart the restapi.

![Enable Ports](img/portenable.png)

## How to check

Navigate to the new URLs, you should be prompted with basic auth. Password is `supersecret` and user is the respective key from the JSON file.

![Ports in use](img/PortUse.png)

- Healthcheck: [http://localhost:8886/health](http://localhost:8886/health)

- Metrics: [http://localhost:8890/metrics](http://localhost:8890/metrics)

- Management UI: [http://localhost:8889/](http://localhost:8889/)

## Things to explore

- [Domino REST API documentation](https://opensource.hcltechsw.com/Domino-rest-api/index.html)

- [Discord discussion](https://discord.com/invite/jmRHpDRnH4)

-->