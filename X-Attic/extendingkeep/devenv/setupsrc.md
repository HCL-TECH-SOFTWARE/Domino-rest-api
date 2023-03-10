---
layout: default
title: Setting up your Source Code
parent: Development Environment
grand_parent: Extending Domino REST API
nav_order: 4
---

Ths section tells you how to find the Domino REST API source code and download it onto your machine.

### Cloning the Domino REST API source code

The latest source code is in the **develop** branch (not master), so you will need to clone down that branch in particular.

1. Bring up the domino-keep repository.

2. Click **Clone or download** in the upper right corner.

3. Click **Use SSH**.

4. Copy the string provided by clicking the icon next to the text box.

5. Bring up a command window, and cd to your development root directory (for example: cd \dev)

6. Clone down the **develop** branch of the repo:

    **git clone -b develop --single-branch \<copied_string\>**
