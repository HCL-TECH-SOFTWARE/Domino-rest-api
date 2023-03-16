---
#layout: default
title: Reserved Form mode names
#parent: Using Domino REST API
#nav_order: 9
---

## 
You use a mode which will set a different sets of data coming from a document within the same form. 
There are three reserved form mode names in Domino API database management namely:

| Name                          | Description                                                                                       |
| -----------                   | ----------- |
| Default                       | Default is the pre-selected option that is available to the user. The user may use the default mode in creating, reading, updating and deleting the data that come from any server that uses the API.  |
| DQL                           | A unique mode that may be created using the Database Management REST API is denoted by the DQL mode name. It allows you to define the data come through with DQL endpoints.  Domino Query Language, often known as DQL, is the method that is used in order to get data from a Domino Server. It always use a DQL query to retrieve the data and returns a JSON data back. |
| odata                         | The odata mode lets you define the data that comes through our odata endpoints. The API support the odata standard [Open Data Protocol(oData)](https://en.wikipedia.org/wiki/). The odata mode defines the data that may be obtained or changed using odata mode.    |


<!--See additional topics under this category for more information.-->
