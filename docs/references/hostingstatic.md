# Hosting static applications

A typical use case for Domino REST API is to build a web UI with the flavor of the day web development framework like Angular, ReactJS, Swelte etc. These frameworks usually generate a `build` directory with a set of static files.

You can copy that directory to `keepweb.d` in your Domino data directory and Domino REST API will serve them on the `/keepweb/` URL path. This eliminates the need for [CORS](../../references/usingdominorestapi/keepapplications.md) configuration.

This is similar to Domino's feature serving static files from its `domino/html` directory.
