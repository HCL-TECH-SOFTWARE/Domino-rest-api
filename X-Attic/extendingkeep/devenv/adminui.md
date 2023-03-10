---
layout: default
title: Admin User Interface
parent: Development Environment
grand_parent: Extending Domino REST API
nav_order: 11
---

## Admin User Interface Training

Getting up to speed on the Admin UI can be a little daunting because of the number of different technologies involved. The trick then is to use the list below as a guide, and select the tutorials you need to fill in the gaps in your knowledge.  And yes the code will make sense eventually.

### Core technologies

**ECMAScript 6 (ES6)** is the base language for the user interface; you will need to be familiar the ES6 extensions to JavaScript, particularly arrow functions.

**TypeScript** is a superset of JavaScript that allows for the strict type setting of variables.

**React** provides a component based framework for the user-interface.

**React-Router** controls the navigation between (virtual) pages in the application.

**React-Redux** provides a method for tracking the state of the user interface across components.

**Immer** provides support for immutable data structures.  While not exactly a "core technology", it's included here as it's used to manage Redux state.

**Node Package Manager (npm)** is the world's largest software registry. We use it to pull in the software packages we need to build and run our code. You will need to have a general idea of how npm and package.json work.

### Core resources

For basic **JavaScript**, **TypeScript**, and **React** tutorials, I've always liked the ones offered by [Net Ninja](https://www.youtube.com/channel/UCW5YeuERMmlnqo4oq8vwUpg).  They are clear and easy to follow, and broken up into 10 minute chunks, making it easy to go back later and brush up on a particular language feature.

Udemy is also a good resource for JavaScript / React tutorials, and includes a 6 hour course on ES6: [Udemy](https://hclsoftwarelearning.udemy.com/organization/home/)

If you want to understand how Immer works with Redux read [Introduction to Immer](https://immerjs.github.io/immer/).

The NPM home page is a good spot to find [NPM Documentation](https://docs.npmjs.com/).  There are also dozens of tutorials available.

### User interface support

**Material UI** is a popular React User Interface framework, that provides a set of layout components, navigation components, and form controls for building web pages.  It also controls how color themes are handled in the Admin UI.

**Formik** has a set of helper functions that make it easier to deal with Forms.

**Yup** provides a framework for doing Form validation.

**Axios** is used to communicate with the Domino REST API layer and provide content to the user interface.  Along with Axios, you will need a basic understanding of asynchronous programming in JavaScript using promises.

### User interface resources:

For **Material UI**, I would start by looking through the documentation on the [Material UI Home Page](https://material-ui.com/).  Once you have the basics, head to youtube and watch one of the Tutorials.

You can find information on **Formik** at the [Formik Home Page](https://formik.org/docs/overview), and **Yup** at [An Introduction to Validation](https://medium.com/@rossbulat/introduction-to-yup-object-validation-in-react-9863af93dc0e).  There is also a tutorial showing the interaction between the two packages at the [React Native School](https://www.reactnativeschool.com/build-and-validate-forms-with-formik-and-yup/).

There is a good overview of Axios in its [NPM Package Doc](https://www.npmjs.com/package/axios#features).  There are also several tutorials on it, ranging from the 10 minute overview to the 40 minute in depth discussion.
