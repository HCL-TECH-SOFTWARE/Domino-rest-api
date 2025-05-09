# Setting up the Java Maven project

You will install the DRAPI dependencies and configure a `pom.xml` as well a the maven standard directory structure. We outline the manual steps, your Ide might have some automation that works faster.

## Prerequisites

- You need a matching JDK installed (Domino doesn't ship a JDK);
  - Java 8 for Domino 12
  - Java 17 for Domino 14
  - Java 21 for Domino 14.5
- Apache [Maven](https://maven.apache.org/) latest 3.9 edition
- Version control, we presume `git` for this tutorial
- An Ide, but you could just use `vi` if you remember how to exit it

Be careful when installing a JDK, it might have license requirents (e.g. the Oracle version), so stick with OpenJDK.

## Locate and install DRAPI dependencies

Maven at compile time relies on dependencies in the `~/.m2` direcory structure, so you need to install DRAPI's jar files there manually since they are not published to Maven central and can't be automagically downloaded.

Locate the DRAPI installation diectory and change into it. It typically is something like `/opt/hcl/keep` or `C:\Program files\HCL\restapi`, Make sure you see the following files (there are more, but not relevat here):

- keep-core-\*.jar
- keep-extension-\*.jar
- keep-core-\*-javadoc.jar
- keep-extension-\*-javadoc.jar

where `*` stands for the internal build number, e.g `1.38.0` for DRAPI 1.1.2.

!!! tip "You can use the installer"

    An easy way to get the files is to [run the installer](../installconfig/index.md) using the parameters `-a -n -s` to "install" the files to a temp directory.
    Make sure you have the matching installer for your Domino version

Install the jars to `~/.m2` using this command (all OS):

```bash
mvn install:install-file -dfile=keep-core-1.38.0.jar
mvn install:install-file -dfile=keep-core-1.38.0-javadoc.jar
mvn install:install-file -dfile=keep-extension-1.38.0.jar
mvn install:install-file -dfile=keep-extension-1.38.0-javadoc.jar
```

## Create the direcory structure

I keep all my code in `~/Code` ( `%HOME%\Code` for Windows), Don't put files under version control in your `Documents` or `Desktop` folder, you only risk conflicts between version control and cloud sync (Google Drive, OneDrive, iCloud etc).

Decide on your organisation, usually it is the reverse URL, so when your url is `acme.com`, you use `com.acme` as org, which is the entry to your packet hierachy, for the purpose of this tutorial we will use `io.projectkeep`. Please **do not** use it for your actual code.

![Directory Structure](../../assets/images/DirectoryStructure.png)

For macOS or Linux:

```bash
mkdir -p extension-tutorial/src/main/java/io/projectkeep/domino/keep/dbrequests/approvals
mkdir -p extension-tutorial/src/main/resources/config
mkdir -p extension-tutorial/src/main/resources/openapi
mkdir -p extension-tutorial/src/test/java/io/projectkeep/domino/keep/dbrequests/approvals
mkdir -p extension-tutorial/src/test/resources
```

For Windows:

```cmd
mkdir "extension-tutorial\src\main\java\io\projectkeep\domino\keep\dbrequests\approvals"
mkdir "extension-tutorial\src\main\resources\config"
mkdir "extension-tutorial\src\main\resources\openapi"
mkdir "extension-tutorial\src\test\java\io\projectkeep\domino\keep\dbrequests\approvals"
mkdir "extension-tutorial\src\test\resources"
```

The strucutre follows the maven defaults and the package naming used in DRAP

## Add the `pom.xml`

In this tutorial we will only add the pieces we absolutely need. SO, depending on your corporate standards you might add additional entries, listing developers, version control, check style, documentation creation etc.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <groupId>io.projectkeep.domino.keep</groupId>
    <artifactId>extension-tutorial</artifactId>
    <version>1.0.0-SNAPSHOT</version>
    <packaging>pom</packaging>
    <name>Keep API Extension Example</name>

    <properties>
       <!-- Adjust Domino & Java version to your environment -->
       <domino.version>14.0.0</domino.version>
       <java.version>17</java.version>
       <keep.version>1.38.0</keep.version> <!-- your Keep version -->
       <maven.compiler.plugin.version>3.13.0</maven.compiler.plugin.version>
       <maven.surefire.plugin.version>3.5.1</maven.surefire.plugin.version>
       <mockito.version>5.15.2</mockito.version>
       <restassured.version>5.5.0</restassured.version>
       <smallrye.jandex.version>3.2.3</smallrye.jandex.version>
       <!-- IMPORTANT: Encoding all UTF-8 -->
       <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
       <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>

    <dependencies>
        <dependency>
            <groupId>com.hcl.domino.keep</groupId>
            <artifactId>keep-core</artifactId>
            <version>${keep.version}</version>
            <scope>provided</scope>
        </dependency>
        <dependency>
            <groupId>com.hcl.domino.keep</groupId>
            <artifactId>keep-extension</artifactId>
            <version>${keep.version}</version>
            <scope>provided</scope>
        </dependency>
    </dependencies>

    <build>
       <plugins>
                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-compiler-plugin</artifactId>
                    <version>${maven.compiler.plugin.version}</version>
                    <configuration>
                        <source>${java.version}</source>
                        <target>${java.version}</target>
                    </configuration>
                </plugin>

                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-surefire-plugin</artifactId>
                    <version>${maven.surefire.plugin.version}</version>
                    <configuration>
                        <testFailureIgnore>false</testFailureIgnore>
                        <includes>
                            <include>**/*Test.java</include>
                            <include>**/*Tests.java</include>
                        </includes>
                        <forkNode
                            implementation="org.apache.maven.plugin.surefire.extensions.SurefireForkNodeFactory" />
                    </configuration>
                </plugin>

                <plugin>
                    <groupId>org.apache.maven.plugins</groupId>
                    <artifactId>maven-surefire-report-plugin</artifactId>
                    <version>${maven.surefire.plugin.version}</version>
                </plugin>

                <plugin>
                    <groupId>org.jetbrains.dokka</groupId>
                    <artifactId>dokka-maven-plugin</artifactId>
                    <version>2.0.0</version>
                    <executions>
                        <execution>
                            <id>site-gen</id>
                            <phase>pre-site</phase>
                            <goals>
                                <goal>javadocJar</goal>
                            </goals>
                        </execution>
                        <execution>
                            <id>package</id>
                            <phase>prepare-package</phase>
                            <goals>
                                <goal>javadocJar</goal>
                            </goals>
                        </execution>
                    </executions>
                </plugin>

                <plugin>
                    <groupId>org.cyclonedx</groupId>
                    <artifactId>cyclonedx-maven-plugin</artifactId>
                    <version>2.9.0</version>
                </plugin>

                <plugin>
                    <groupId>io.smallrye</groupId>
                    <artifactId>jandex-maven-plugin</artifactId>
                    <version>${smallrye.jandex.version}</version>
                    <executions>
                        <execution>
                            <id>make-index</id>
                            <goals>
                                <goal>jandex</goal>
                            </goals>
                        </execution>
                    </executions>
                </plugin>
         </plugins>
    </build>
</project>
```

## Configure version control

Create the file `.gitignore` in the root of your project. Take inspiration from existing files [here](https://github.com/github/gitignore/blob/main/Maven.gitignore) or [here](https://github.com/HCL-TECH-SOFTWARE/domino-jnx/blob/develop/.gitignore). Also **strongly** recommended is to create the file [`.gitattributes`](https://github.com/HCL-TECH-SOFTWARE/domino-jnx/blob/develop/.gitattributes). Once created, initialize and populate the repository:

```bash
git init
git add --all
git commit -m 'initial creation'
```

By frequently commiting to your local git, you work with the assurance that you can respawn when things go south.

!!! info "Next"

    [OpenAPI specification](openapi.md)

## Let's connect

--8<-- "feedback.md"
