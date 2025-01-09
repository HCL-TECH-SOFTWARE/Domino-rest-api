# ReactJS

The Domino REST API allows hosting [SPA](https://en.wikipedia.org/wiki/Single-page_application) in its `keepweb.d` directory. This page highlight the steps to make this work with [ReactJS](https://react.dev).

!!! warning "This is not a ReactJS tutorial"

    When you are not familiar with ReactJS, this is not the place for you.
    Rather, learn [open standards](https://www.webcomponents.org), but if you insist:

    [Google tutorials](https://www.google.com/search?q=react+tutorial+2023)

## Before you begin

- You are familiar with [ReactJS](https://react.dev).

- You have installed NodeJS and ReactJs CLI.

## Procedure

In the steps below, the name of the application, and thus the folder name, will be `mydominoreact`. Each application needs its own name, so replace `mydominoreact` with the name of your choice. Following web conventions, use lowercase characters and nothing special in the name, especially no spaces or slashes in any direction.

1. To ensure proper path resolution, you need to add `PUBLIC_URL=/keepweb/mypromydominoreactject` parameter to `.env` file.

    !!!note
        `keepweb` can be something else in your configuration.
        
2. Reconfigure React to use [HashRouter](https://reactrouter.com/en/main/router-components/hash-router) instead of [BrowserRouter](https://reactrouter.com/en/main/router-components/browser-router).

3. Make sure that all links have `%PUBLIC_URL%` prefix. For example, for favicon.ico, it's `<link rel="shortcut icon" href="%PUBLIC_URL%/favicon.ico">`.
4. Execute `npm run build`, or whatever build process you use.
5. Rename `build` folder to `mydominoreact` and copy to the `keepweb.d` folder on your Domino server. To avoid the rename step, you can alter your build script to directly build into `mydominoreact` by adding to the `.env` file the entry `BUILD_PATH='./mydominoreact'`.

## Let's connect

--8<-- "feedback.md"
