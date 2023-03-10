# Configuration parameters

--8<-- "keepmngtURLcaution1.md"

## Configuration

Domino REST API comes with reasonable default configuration settings. They allow you to start evaluating and testing out-of-the-box. For an actual deployment, you want to understand the details as outlined here.

## Understanding configuration

The configuration follows the concept of and Overlay File System, where the base configuration is retrieved from the jar file and then overlaid with all the JSON files (if present) in the keepconfig.d directory within the Notes data directory and finally, the environment parameters, if any of those exist.

## Environment

Parameters are case sensitive.

--8<-- "environmentparam.md"

## Configuration retrieval

The current configuration can be retrieved (with sensitive information masked) on the management port:
e.g. https://keep.yourserver.io:8889/config.
