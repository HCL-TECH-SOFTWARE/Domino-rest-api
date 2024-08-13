# Rich Text extension

Rich Text extension is for customers or users that prefer to have or use their own implementation of Rich Text processor. Users will be able to adjust it to meet their own needs, resulting in a better representation of their Rich Text.

## Extend Domino REST API Rich Text

Starting Domino REST API version `1.0.12`, you can now add Rich Text processors for Domino REST API.

## Built-in Rich Text processors

There has been no change for the existing processors, namely:

- mime
- html
- markdown
- plain

## Set up extending Rich Text

There are a number of things you should set up before you can create an extension.

### Install KEEP core and extension JARs

1. Install Domino REST API using the Domino REST API installer.
2. Find `keep-core-<version>.jar` and `keep-extension-<version>.jar` in the **Domino REST API install directory** and do a **Maven** install using the following command:

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
      <version>1.33.0</version> <!-- your Keep version -->
      <scope>provided</scope>
    </dependency>
    ```

4. Save the `pom.xml` after adding the dependency.

!!!note
    The **`scope`** is set to **`provided`** because you don't want the dependency to be compiled together with your Rich Text extension as you will be putting the extension JAR alongside the DRAPI JARs. The DRAPI JARs contain all the dependencies that your extension JAR needs.

!!!note
    Though DRAPI has many transitive dependencies, those listed in the `keep-extension` module directly are considered safe to rely on. Others may change in any version.

### Creating your own Rich Text processors

There are 2 different interfaces that you can implement to create your own Rich Text processor, `IncomingRichtextProcessor` and `OutgoingRichtextProcessor`.

#### Incoming Rich Text processor

This processes how the incoming Rich Text JSON is saved in the `richtext` field. This processor makes use of the `type` property in Rich Text JSON to determine what incoming Rich Text processor to use.

##### Built-in incoming Rich Text processors

There are four built-in incoming Rich Text processors:

- `multipart/mixed` - used by default if `type` in Rich Text JSON doesn't equate to any existing Rich Text processor.
- `text/plain`
- `text/markdown`
- `text/html`

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
