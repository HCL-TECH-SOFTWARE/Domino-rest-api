# Richtext extension
As of KEEP version 1.30.1-SNAPSHOT, you can now add additional richtext processors for KEEP.

## Built in richtext processors
There has been no change for the existing processors, namely:
    -mime
    - html
    - markdown
    - plain

## Setting up extending richtext
There are quite a number of things we should setup first before we can make an extension.

1. Install KEEP core jar
2. Find keep-core-<version>.jar file and do a Maven install on it.

``` mvn org.apache.maven.plugins:maven-install-plugin:2.5.2:install-file -Dfile=<path-to-keep-core-jar> ```

This will add in KEEP core to your local Maven M2 repository.

## Create an extension helper
For this step, we need to create an extension helper. The goal would be that this helper will generate a single JAR file containing all the stuff we need to depend on.

In this case, extending richtext will need three dependencies:

1. KEEP core
2. Vert.X core
3. Domino JNX API

Create a new folder and create a pom.xml with the following content:
```
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">

  <modelVersion>4.0.0</modelVersion>

  <groupId>com.hcl.domino.extension.helper</groupId>
  <artifactId>keep-richtext-extension-helper</artifactId>
  <version>1.0</version>
  <name>Helper for KEEP richtext extension</name>
  <description>Don't try this at home</description>

  <dependencies>
    <dependency>
      <groupId>com.hcl.domino.keep</groupId>
      <artifactId>keep-core</artifactId>
      <version>1.30.1-SNAPSHOT</version>
    </dependency>
    <dependency>
      <groupId>io.vertx</groupId>
      <artifactId>vertx-core</artifactId>
      <version>4.5.4</version>
    </dependency>
    <dependency>
      <groupId>com.hcl.domino</groupId>
      <artifactId>domino-jnx-api</artifactId>
      <version>1.36.0</version>
    </dependency>
  </dependencies>

</project>
```
Save the pom.xml and do:

``` mvn clean install```

This will create a keep-richtext-extension-helper-1.0.jar inside the target directory, as well as add this JAR file to your local Maven M2 repository, so we can now depend on this JAR file for our richtext extension project.

## Extending richtext
1. Set up richtext extension project.
2. Finally, we can now start creating our very own richtext extension. To do this, we should first generate a new Maven project. We can do this easily by doing:

mvn archetype:generate -DgroupId=com.example -DartifactId=richtext-extension -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4 -DinteractiveMode=false
This will create a folder named richtext-extension, with src directory and pom.xml file inside.

Open up pom.xml and change maven.compiler.source and maven.compiler.target to 1.8. Also, inside dependencies, we can then add in the JAR file created by our extension helper earlier:

<dependency>
  <groupId>com.hcl.domino.extension.helper</groupId>
  <artifactId>keep-richtext-extension-helper</artifactId>
  <version>1.0</version>
  <scope>provided</scope>
</dependency>
Click save after adding that depedency in. Take note of the scope here, we set it to provided because we want this dependency to not be compiled together with our richtext extension, because in the end, we will be putting the extension JAR alongside the KEEP JARs. The KEEP JARs will contain all the dependencies that our extension JAR will need.

## Creating your very own richtext processor
Now, what's left is to create our very own richtext processor. Any class will do, as long as it implements RichtextProcessor.

As of this writing, RichtextProcessor has three methods, two of which that needs to be overwritten. These methods are:

/**
 * Get the name of the richtext processor. This should equate to the value of
 * {@code richTextAs} query parameter (case insensitive), and will be used to
 * determine which richtext processor provider will execute.
 * 
 * @return a {@code String} describing the processor's name
 */
String getProcessorName();

/**
 * Execute richtext processor.
 * 
 * @param client {@code DominoClient} with API access
 * @param doc Domino document with source data
 * @param itemName field item name (internal name)
 * @return a {@code JsonObject} that contains the converted richtext and other
 *         properties
 */
JsonObject process(DominoClient client, Document doc, String itemName);

/**
 * Used for processors that has the same name to determine what will be used. The higher
 * the number, the higher the priority.
 * 
 * @return an {@code int} representing the priority of the processor
 */
default int getPriority() {
  return 0;
}
An example richtext processor would be:

package com.example;

import com.hcl.domino.DominoClient;
import com.hcl.domino.data.Document;
import com.hcl.domino.keep.info.richtext.spi.RichtextProcessor;

import io.vertx.core.json.JsonObject;

public class AlwaysHelloRichtextProcessor implements RichtextProcessor {

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
Then, we need to create a file inside src/main/resources/META-INF/services with file name com.hcl.domino.keep.info.richtext.spi.RichtextProcessor.

Edit this file and add in all the richtext extension you made, for example:

com.example.AlwaysHelloRichtextProcessor
com.example.MyOwnRichtextProcessor
Please bear in mind that all classes you declared in this file must exists and implements the RichtextProcessor class. Otherwise, an error will occur once we try loading this with KEEP.

Applying the richtext extension
After you're done creating your own richtext extension, it is finally time to use it. First, create the richtext extension JAR via:

mvn clean package
This will create a JAR file inside the target directory with the name richtext-extension-1.0-SNAPSHOT.jar. Copy this JAR file and paste it into where your KEEP JARs are at (REST API directory).

If you want to try this out with your debug or non-debug container, you can paste the JAR in /opt/hcl/keep.

Trying it out
To try it out, you can call any API that has a richTextAs query parameter, and set its value to your processor name.

For example, if you use the AlwaysHelloRichtextProcessor, since its getProcessorName method returns alwayshello, if you do an API and set richTextAs=alwayshello, you should get the following JSON value for the richtext fields:

{
  "type": "text/plain",
  "encoding": "plain",
  "content": "Hello!"
}
## Example richtext extension repository
If you want a reference repository for this, please refer to this repository. It follows all the steps this documentation did so far and also has more richtext processor examples.