# Rich Text extension

## Overview

The Rich Text extension enables you to implement custom Rich Text processors. This allows customization to meet specific needs and improves how Rich Text is represented. **Starting with Domino REST API version 1.0.12**, you can add Rich Text processors for the Domino REST API.

### Outgoing Rich Text processor

The outgoing Rich Text processor handles how saved data in a `richtext` field appears when returned as a response to a `GET` request. The value of the `richTextAs` query parameter is used to determine the outgoing Rich Text processor to use. The Domino REST API includes these built-in outgoing Rich Text processors:

- mime
- html
- markdown
- plain

### Incoming Rich Text processor

The incoming Rich Text processor handles how incoming Rich Text JSON is saved in the `richtext` field. The value of the `type` property in the Rich Text JSON is used to determine the incoming Rich Text processor to use. The Domino REST API includes these built-in incoming Rich Text processors:

- multipart/mixed [^1]
- text/plain
- text/markdown
- text/html

[^1]:Used by default if the value of the `type` property in the Rich Text JSON doesn't equate to any existing Rich Text processor.

## Create a Rich Text extension

### Install KEEP core and extension JARs

Before creating a Rich Text extension, install **KEEP Core** and extension JARs to your local Maven repository.

1. Install Domino REST API using the Domino REST API installer.
2. Locate `keep-core-<version>.jar` and `keep-extension-<version>.jar` in the Domino REST API install directory.
3. Install both JARs to you local Maven M2 repository using the following commands:

    ```shell
    mvn install:install-file -Dfile=<path-to-keep-core-jar>
    mvn install:install-file -Dfile=<path-to-keep-extension-jar>
    ```

    !!! note

        Replace `<path-to-keep-core-jar>` with the path to `keep-core-<version>.jar` and `<path-to-keep-extension-jar>` with the path to `keep-extension-<version>.jar`.

This adds **KEEP Core** and the extension module to your local Maven M2 repository.

### Create a Rich Text extension project

Create a Maven project for your Rich Text extension.

1. Run the following command to create a new Maven project:

    ```shell
    mvn archetype:generate -DgroupId=com.example -DartifactId=richtext-extension -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4 -DinteractiveMode=false
    ```

    This creates the `richtext-extension` directory that includes a `src` folder and a `pom.xml` file.

2. Update the `pom.xml` file.

    1. Set `maven.compiler.source` and `maven.compiler.target` to:
        - `1.8` for Domino r12
        - `17` for Domino r14

    2. Under `dependency`, include the extension JAR you installed earlier:

        ```xml
        <dependency>
          <groupId>com.hcl.domino.keep</groupId>
          <artifactId>keep-extension</artifactId>
          <version>1.33.0</version> <!-- your Domino REST API version -->
          <scope>provided</scope>
        </dependency>
        ```

        !!! note

            - The `scope` is set to `provided` so that the dependency is not compiled with your Rich Text extension, as you will be putting the extension JAR alongside the Domino REST API JARs. The Domino REST API JARs contain all the dependencies that your extension JAR needs. 

            - While Domino REST API has many transitive dependencies, only those directly listed in `keep-extension` are safe to rely on. Others may change between versions.

3. Save your changes.

### Create your Rich Text processor

You can implement two interfaces, `IncomingRichtextProcessor` and `OutgoingRichtextProcessor`, to create your own Rich Text processor.

??? info "`IncomingRichtextProcessor` methods"

    The `IncomingRichtextProcessor` has three methods:

    - `getProcessorName` returns a *string* representing the name of the incoming Rich Text processor. It checks the name of the incoming Rich Text processor against the value of the `type` property in the Rich Text JSON to determine if the incoming Rich Text processor should be used. 
    - `process` checks if the incoming content of the Rich Text JSON is MIME, and returns it as a `Buffer` if it is. If it is not, it constructs a MIME using the Rich Text JSON properties and returns the constructed MIME as a `Buffer`. You can override this method to control how you want to save the incoming Rich Text.
    - `getPriority`, by default, returns `0`. You can override this method to set which incoming Rich Text processor to use when multiple processors share the same name. The higher the set value, the higher the priority. 

??? info "`OutgoingRichtextProcessor` methods"

    The `OutgoingRichtextProcessor` has three methods:

    - `getProcessorName` returns a *string* representing the name of the outgoing Rich Text processor. It checks the name of the outgoing Rich Text processor against the value of the `richTextAs` query parameter of the GET request to determine if the outgoing Rich Text processor should be used.

    - `process` is an abstract method that can be overwritten to specify how to represent the Rich Text content in the response.

    - `getPriority`, by default, returns 0. You can override this method to set which outgoing Rich Text processor to use when multiple processors share the same name. The higher the set value, the higher the priority.

#### Create incoming Rich Text processor

1. Create a class that implements `IncomingRichtextProcessor`.

    ??? example
  
        The following code shows an example Java class that implements `IncomingRichtextProcessor` interface to create an incoming Rich Text processor. This custom processor overrides the normal processing of incoming rich text JSON data by converting the received Rich Text JSON content and saves "Hi!" as a text/plain MIME part in the `richtext` field.

        ```java
        package com.example;

        import java.util.Optional;
        import java.util.Set;

        import com.hcl.domino.keep.info.richtext.CreateAdditional;
        import com.hcl.domino.keep.info.richtext.RichtextMimeHelper;
        import com.hcl.domino.keep.info.richtext.spi.IncomingRichtextProcessor;

        import io.vertx.core.buffer.Buffer;
        import io.vertx.core.json.JsonObject;

        /**
         * Always saves "Hi!" as a text/plain mime regardless of what's inside the Rich Text JSON
        */
        public class AlwaysHiIncomingRichtextProcessor implements IncomingRichtextProcessor {

          @Override
          public String getProcessorName() {
            return "alwayshi";
          }

          @Override
          public Optional<Buffer> process(JsonObject richJson, byte[] contentBytes,
              final Set<CreateAdditional> createAdditional) {
            final Optional<String> mime = RichtextMimeHelper.plain2mime("Hi!".getBytes());

            if (!mime.isPresent()) {
              return Optional.empty();
            }
            return Optional.of(Buffer.buffer(mime.get()));
          }

        }
        ```

2. Create a file in the `src/main/resources/META-INF/services` directory named `com.hcl.domino.keep.info.richtext.spi.IncomingRichtextProcessor`.

3. Edit the created file to include all your created Rich Text processors. For example:

    ```text
    com.example.AlwaysHiIncomingRichtextProcessor
    ```

    !!! warning "Important"

        All classes declared in this file must exist and implement the `IncomingRichtextProcessor` interface. Otherwise, Domino REST API will fail to load them, causing an error.

#### Create outgoing Rich Text processor

1. Create a class that implements `OutgoingRichtextProcessor`.

    ??? example

        The following code shows an example Java class that implements the `OutgoingRichtextProcessor` to create a custom outgoing Rich Text processor. This custom processor intercepts rich text items from Domino documents and always returns a fixed JSON response containing “Hello!” as plain text, ignoring the actual document content. 

        ```java
        package com.example;

        import com.hcl.domino.DominoClient;
        import com.hcl.domino.data.Document;
        import com.hcl.domino.keep.info.richtext.spi.OutgoingRichtextProcessor;

        import io.vertx.core.json.JsonObject;

        /**
         * Always returns "Hello!" in the content of the Rich Text JSON response.
        */
        public class AlwaysHelloRichtextProcessor implements OutgoingRichtextProcessor {

          @Override
          public String getProcessorName() {
            return "alwayshello";
          }

          @Override
          public JsonObject process(DominoClient client, Document doc, String itemName) {
            return new JsonObject()
                .put("type", "text/plain")
                .put("encoding", "plain")
                .put("content", "Hello!");
          }

        }
        ```

2. Create a file within the `src/main/resources/META-INF/services` directory named `com.hcl.domino.keep.info.richtext.spi.OutgoingRichtextProcessor`.

3. Edit the created file to include all your created Rich Text processors. For example:

    ```text
    com.example.AlwaysHelloRichtextProcessor
    ```

    !!! warning "Important"

        All classes declared in this file must exist and implement the `OutgoingRichtextProcessor` interface. Otherwise, Domino REST API will fail to load them, causing an error.

## Apply the Rich Text extension

Once you have created your Rich Text extension, you now need to build and deploy it.

1. Build the JAR file for the Rich Text extension by running the following command in your project root:

    ```shell
    mvn clean package
    ```

    This generates `richtext-extension-1.0-SNAPSHOT.jar` in the `target/` directory.

2. Copy the generated JAR file to your Domino REST API installation directory, where the KEEP JARs are located.
  
## Test your Rich Text extension

After building and deploying your Rich Text extension, you can now test it.

### Test your incoming Rich Text processor

Create a form with a `richtext` field and ensure the value of the type property matches the name of your incoming Rich Text processor. As shown in the following example, the `richtext` field is `rtfield` and the value of the `type` property is set to `alwayshi`, which is returned by the `getProcessorName()` method of the example incoming Rich Text processor.

```json
{
  ...
  "Form": "SampleForm",
  "rtField": {
    "type": "alwayshi",
    "encoding": "plain",
    "content": "my content"
  },
  ...
}
```

Before executing the request, make sure to set the value of the `richTextAs` query parameter to `plain`, so you can verify the value of the `richtext` field in plain text. After executing the request, you should get the following JSON for the `richtext` field:

```json
{
  "type": "text/plain",
  "encoding": "plain",
  "content": "Hi!"
}
```

### Test your outgoing Rich Text processor

To test your outgoing Rich Text processor, you can call any API that has a `richTextAs` query parameter. You just need to make sure that the value of the `richTextAs` query parameter is set to the name of your processor.

For example, using `AlwaysHelloRichtextProcessor` whose `getProcessorName()` method returns `alwayshello`, and performing an API call with `richTextAs=alwayshello`, you should get the following JSON value for the `richtext` fields:

```json
{
  "type": "text/plain",
  "encoding": "plain",
  "content": "Hello!"
}
```

<!--
Rich Text extension is for customers or users that prefer to have or use their own implementation of Rich Text processor. Users can customize it to better represent their Rich Text content.

## Extend Domino REST API Rich Text

Starting Domino REST API version `1.0.12`, you can now add Rich Text processors for Domino REST API.

## Built-in Rich Text processors

The following existing processors have been unchanged:

- mime
- html
- markdown
- plain

## Set up extending Rich Text

There are a number of things you should set up before you can create an extension.

### Install KEEP core and extension JARs

1. Install Domino REST API using the Domino REST API installer.
2. Find `keep-core-<version>.jar` and `keep-extension-<version>.jar` in the Domino REST API install directory, and do a **Maven** install using the following command:

  ```shell
  mvn install:install-file -Dfile=<path-to-keep-core-jar>
  mvn install:install-file -Dfile=<path-to-keep-extension-jar>
  ```

This adds **KEEP Core** and the extension module to your local Maven M2 repository.

## Extend Rich Text

### Set up Rich Text extension project

1. Create a new project for the Rich Text extension by creating a new Maven project using the following command:

    ```shell
    mvn archetype:generate -DgroupId=com.example -DartifactId=richtext-extension -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4 -DinteractiveMode=false
    ```

    The command generates a directory called `richtext-extension`, including a `src` folder and a `pom.xml` file.

2. Open the `pom.xml` file and change the settings of `maven.compiler.source` and `maven.compiler.target` to `1.8` for Domino r12. For Domino r14, change it to `17`.
3. Under the dependencies section, include the extension JAR you installed earlier:

    ```xml
    <dependency>
      <groupId>com.hcl.domino.keep</groupId>
      <artifactId>keep-extension</artifactId>
      <version>1.33.0</version> -- your Keep version --
      <scope>provided</scope>
    </dependency>
    ```

4. Save the `pom.xml` after adding the dependency.

!!! note

    - The **`scope`** is set to **`provided`** because you don't want the dependency to be compiled together with your Rich Text extension as you will be putting the extension JAR alongside the Domino REST API JAR files. The Domino REST API JAR files contain all the dependencies that your extension JAR needs.

    - Though Domino REST API has many transitive dependencies, those listed in the `keep-extension` module directly are considered safe to rely on. Others may change in any version.

### Creating your own Rich Text processors

There are 2 different interfaces that you can implement to create your own Rich Text processor, `IncomingRichtextProcessor` and `OutgoingRichtextProcessor`.

#### Incoming Rich Text processor

This processes how the incoming Rich Text JSON is saved in the `richtext` field. This processor makes use of the `type` property in Rich Text JSON to determine what incoming Rich Text processor to use.

##### Built-in incoming Rich Text processors

There are four built-in incoming Rich Text processors:

- `multipart/mixed`[^1]
- `text/plain`
- `text/markdown`
- `text/html`

[^1]: Used by default if `type` in Rich Text JSON doesn't match any existing Rich Text processor.

##### Creating your own incoming Rich Text processor

1. Create a class that implements `IncomingRichtextProcessor`.

    Currently, `IncomingRichtextProcessor` has three methods. Two of which have default implementations.

    `getProcessorName` is an abstract method that should return a `String` that represents the name of the incoming Rich Text processor. It checks this against the `type` property of a Rich Text JSON to determine if this incoming processor should be used.

    `process` is a method that has a default implementation. By default, it checks if the incoming `content` of the Rich Text JSON looks like a mime and directly returns it as a `Buffer`. If not, it manually constructs a mime using the Rich Text JSON properties, and return the constructed mime as a `Buffer`. You are also free to override this method and control how you want to save the incoming Rich Text.

    `getPriority` is a default method that returns `0`. You can leave this method be, unless you have an incoming Rich Text processor that has the same return value of `getProcessorName` with other existing incoming Rich Text processors. The higher the number, the higher the priority.

    An example incoming Rich Text processor will be:

    ```java
    package com.example;

    import java.util.Optional;
    import java.util.Set;

    import com.hcl.domino.keep.info.richtext.CreateAdditional;
    import com.hcl.domino.keep.info.richtext.RichtextMimeHelper;
    import com.hcl.domino.keep.info.richtext.spi.IncomingRichtextProcessor;

    import io.vertx.core.buffer.Buffer;
    import io.vertx.core.json.JsonObject;

    /**
     * Always saves "Hi!" as a text/plain mime regardless of what's inside the Rich Text JSON
     */
    public class AlwaysHiIncomingRichtextProcessor implements IncomingRichtextProcessor {

      @Override
      public String getProcessorName() {
        return "alwayshi";
      }

      @Override
      public Optional<Buffer> process(JsonObject richJson, byte[] contentBytes,
          final Set<CreateAdditional> createAdditional) {
        final Optional<String> mime = RichtextMimeHelper.plain2mime("Hi!".getBytes());

        if (!mime.isPresent()) {
          return Optional.empty();
        }
        return Optional.of(Buffer.buffer(mime.get()));
      }

    }
    ```

2. Create a file within the `src/main/resources/META-INF/services` directory and name the file `com.hcl.domino.keep.info.richtext.spi.IncomingRichtextProcessor`.

3. Edit the file `com.hcl.domino.keep.info.richtext.spi.IncomingRichtextProcessor` and include all the Rich Text extensions you created, such as:

    ```text
    com.example.AlwaysHiIncomingRichtextProcessor
    ```

!!!warning "Important"
    All classes declared in this file must exist and implement the `IncomingRichtextProcessor` class. Otherwise, an error occurs when attempting to load this using Domino REST API.

#### Outgoing Rich Text processor

This processes how the saved data in a `richtext` field is shown when returned as a response to a GET request. This processor uses the value of the `richTextAs` query parameter to know which outgoing Rich Text processor to use.

##### Built-in outgoing Rich Text processors

There are four built-in outgoing Rich Text processors:

- `mime`
- `plain`
- `markdown`
- `html`

##### Creating your own outgoing Rich Text processor

1. Create a class that implements `OutgoingRichtextProcessor`.

    Currently, `OutgoingRichtextProcessor` has three methods. One of which has default implementations.

    `getProcessorName` is an abstract method that should return a `String` that represents the name of this incoming Rich Text processor. It checks this against the `richTextAs` query parameter of the GET request to know which outgoing Rich Text processor to use.

    `process` is an abstract method that can be overwritten to specify how to represent the Rich Text content in the response.

    `getPriority` is a default method that returns `0`. You can leave this method be, unless you have an outgoing Rich Text processor that has the same return value of `getProcessorName` with other existing outgoing Rich Text processors. The higher the number, the higher the priority.

    An example outgoing Rich Text processor would be:

    ```java
    package com.example;

    import com.hcl.domino.DominoClient;
    import com.hcl.domino.data.Document;
    import com.hcl.domino.keep.info.richtext.spi.OutgoingRichtextProcessor;

    import io.vertx.core.json.JsonObject;

    /**
     * Always returns "Hello!" in the content of the Rich Text JSON response.
     */
    public class AlwaysHelloRichtextProcessor implements OutgoingRichtextProcessor {

      @Override
      public String getProcessorName() {
        return "alwayshello";
      }

      @Override
      public JsonObject process(DominoClient client, Document doc, String itemName) {
        return new JsonObject()
            .put("type", "text/plain")
            .put("encoding", "plain")
            .put("content", "Hello!");
      }

    }
    ```

2. Create a file within the `src/main/resources/META-INF/services` directory and name the file `com.hcl.domino.keep.info.richtext.spi.OutgoingRichtextProcessor`.

3. Edit the file `com.hcl.domino.keep.info.richtext.spi.OutgoingRichtextProcessor` and include all the Rich Text extensions you created, such as:

    ```text
    com.example.AlwaysHelloRichtextProcessor
    ```

!!!warning "Important"
    All classes declared in this file must exist and implement the `OutgoingRichtextProcessor` class. Otherwise, an error occurs when attempting to load this using Domino REST API.

### Apply the Rich Text extension

Once you have finished creating your Rich Text extensions, it's time to use it. Create the JAR file for the Rich Text extension by running the following command:

  ```shell
  mvn clean package
  ```

This creates a JAR file inside the target directory with the name `richtext-extension-1.0-SNAPSHOT.jar`. Copy this JAR file and paste it into where your KEEP JARs are at (Domino REST API directory).

### Try it out

#### Try the incoming Rich Text processor

Create a form that has a `richtext` field in it. An example response body would be:

```json
{
  ...
  "Form": "SampleForm",
  "rtField": {
    "type": "alwayshi",
    "encoding": "plain",
    "content": "my content"
  },
  ...
}
```

Notice that the `type` in the Rich Text JSON is set to the name of your own incoming Rich Text processor `alwayshi`.

Before executing the request, you should set the value of `richTextAs` query parameter to `plain` so you can verify the value of the `richtext` field in plain text.

After executing the request, you should get the following JSON for the `richtext` field:

```json
{
  "type": "text/plain",
  "encoding": "plain",
  "content": "Hi!"
}
```

#### Try the outgoing Rich Text processor

To try it out, you can call any API that has a `richTextAs` query parameter, and set its value to your processor name.

For example, if you use the `AlwaysHelloRichtextProcessor`, since its `getProcessorName` method returns `alwayshello`, if you do an API and set `richTextAs=alwayshello`, you should get the following JSON value for the `richtext` fields:

```json
{
  "type": "text/plain",
  "encoding": "plain",
  "content": "Hello!"
}
```
-->