# Configuration management and overlay hierarchy

<!--# Understanding configuration overlay in Domino REST API-->

The Domino REST API configuration uses an **Overlay File System** approach. This method combines multiple configuration sources, layering them to produce a final, effective configuration.

## Configuration sources and overlay process

1. **Base configuration**  

    The initial configuration is loaded from the installation directory or inside `jar` files. When a `jar` file contains the resource `/config/config.json`, that file contributes to the base configuration.

    The Domino REST API comes with default settings stored in internal files `config.json` and `security.json`

2. **Overlay from `keepconfig.d` directory**  

    Next, the configuration is overlaid by JSON files located in the `keepconfig.d` directory within the Notes data directory. These files provide additional or overriding settings.

3. **Environment variables**  

    Finally, environment variables can override any settings from the JSON files.

![The call hierarchy](../../assets/images/ActualConfiguration.png){: style="height:60%;width:60%"}

## Configuration hierarchy and merge rules

- All configuration sources provide JSON data that gets overlaid on top of each other.
- When two JSON objects contain the same key:
  - The key’s value from the overlay source **replaces** the lower layer’s value.
  - Arrays are **completely replaced**, not merged or appended.
- JSON files in the `keepconfig.d` directory are applied in **alphabetical order**, meaning the last file loaded can override previous ones.
- This order supports use cases like temporarily disabling settings by placing overriding values in a file with a name starting with `z-` to make sure it's processed last.

For more information, see [vert.x overloading rules](https://vertx.io/docs/vertx-config/java/#_overloading_rules).

## Practical example

Suppose you have the following configurations and environment setup:


**config.json**

This is an example of the initial configuration.

```json
{
  "PORT": 8880,
  "AllowJwtMail": true,
  "versions": {
    "basis": {
      "path": "/schema/openapi.basis.json",
      "active": true
    }
  }
}
```

**a.json**

This is an example of a JSON file you save in the `keepconfig.d` directory to overlay and update the initial configuration.

```json
{
  "dance": "tango",
  "PORT": 1234,
  "versions": {
    "basis": {
      "active": false
    },
    "special": {
      "path": "/schema/openapi.special.json",
      "active": true
    }
  }
}
```

**Environment variable**

This is an example of an environment variable.

`PORT=8564`

When the example JSON files are merged and the environment variable is applied, the resulting merged configuration looks like as follows:


```json
{
  "PORT": 8564,
  "AllowJwtMail": true,
  "dance": "tango",
  "versions": {
    "basis": {
      "path": "/schema/openapi.basis.json",
      "active": false
    },
    "special": {
      "path": "/schema/openapi.special.json",
      "active": true
    }
  }
}
```

## Additional information

- The overlay system does **not** allow removal of keys or objects from lower layers.  
- To disable or deactivate settings, use the `"active": false` flag or equivalent indicators without deleting keys.
- The current configuration can be retrieved, with sensitive information masked, on the Management Port such as `https://keep.yourserver.io:8889/config`.

<!--
# Understanding configuration

The configuration follows the concept of an [Overlay File System](https://en.wikipedia.org/wiki/OverlayFS). The base configuration is retrieved from the installation directory or `jar` files.

When jar files contain a resource `/config/config.json`, that configuration file is added to total configuration.

Then, it's overlaid with any JSON files in the `keepconfig.d` directory within the Notes data directory and then finally, with any environment parameters.

## Hierarchy

![The call hierarchy](../assets/images/ActualConfiguration.png)

All files contribute JSON, which are overlaid on top of each other. JSON elements with same names get overwritten. Arrays are replaced and not overwritten.

The JSON files in `keepconfig.d` are processed in alphabetical order. Last entry wins. This processing order allows you, for example, to disable elements temporarily through settings in a `z-final-words.json` file without impacting the permanent configuration.

For more information, see [vert.x overloading rules](https://vertx.io/docs/vertx-config/java/#_overloading_rules).

## Example

Given the files `config.json`, `a.json` and the environment variable `PORT=8564`, you get the result `result.json` as shown below:

### config.json

```json
{
  "PORT": 8880,
  "AllowJwtMail": true,
  "versions": {
    "basis": {
      "path": "/schema/openapi.basis.json",
      "active": true
    }
  }
}
```

### a.json

```json
{
  "dance": "tango",
  "PORT": 1234,
  "versions": {
    "basis": {
      "active": false
    },
    "special": {
      "path": "/schema/openapi.special.json",
      "active": true
    }
  }
}
```

Merge these 2 files and apply the environment variables.

### result.json

```json
{
  "PORT": 8564,
  "AllowJwtMail": true,
  "dance": "tango",
  "versions": {
    "basis": {
      "path": "/schema/openapi.basis.json",
      "active": false
    },
    "special": {
      "path": "/schema/openapi.special.json",
      "active": true
    }
  }
}
```

The actual result can be inspected on the Domino REST API management API, like [on a local install](http://localhost:8889/config).

## Important notes

> JSON overlay doesn't allow you to **remove** JSON elements. So, most settings have an `active` parameter that
> can be set to false in an overlay.
-->