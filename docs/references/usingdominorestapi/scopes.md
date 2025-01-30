---
#layout: default
title: Scopes
#parent: How the Domino REST API Works
#nav_order: 1
---

# Scopes

When a Domino REST API access presents its [JWT](https://jwt.io/) claim, it includes a `scopes` element.
This element determines what resources the API access intends to use.

Scopes are a space-separated lists of values. By default, a user who authenticates with Domino to gain a JWT token has the following scope values in the claim:

- MAIL: Access to the user's mailbox and calendar.
- $DATA: Access to any application the user has access to.
- $DECRYPT: Access to decrypt encrypted items if the database has decryption enabled. (Requires proper setup.)
- $SETUP: Access control to endpoints that run write operations (CUD) in the `/setup-v1/` URL space. When your application is accessing endpoints that run write operations (CUD) in the `/setup-v1/` URL space, update your scope from `$DATA` to `$DATA $SETUP`.

A scope doesn't **open** access to a resource; that's the job of the database ACL. A scope **limits** access.

Besides the default scopes of `MAIL`, `$DATA`, `$DECRYPT`, and `$SETUP`, any of the database aliases can be used as a scope term. This allows an IdP to ask a user for tailored permissions in an OIDC flow to limit exact access required instead of having the full user spectrum.

For more information, see [Scope](../../topicguides/understanding.md#databases-schemas-and-scopes).
