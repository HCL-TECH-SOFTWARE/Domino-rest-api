# JavaScript

Sample code to interact with the Domino REST API in JavaScript. No additional libraries have been harmed.

!!! note "Know your runtime"

    The [`fetch`](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch) API is ubiquitous in browsers, but available only in current versions of server side JavaScript environments like NodeJS (so check your documentation).

We will look at three functions that can give you a headstart

## URL collection

Instead of sprinkling URLs across the JS functions, I use a global objects to abstract them away:

```js
const urls = {
  login: '/api/v1/auth',
  list: '/api/v1/query?dataSource=approvals&action=execute'
};
```

You will want to adjust the list to your needs.

## Login function

The function returns the bearer or throws an error

```js
const login = async (user, pwd) => {
  try {
    const response = await fetch(urls.login, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ username: user, password: pwd })
    });
    const jBody = await response.json();
    if (jBody.bearer) {
      return jBody.bearer;
    }
    throw new Error('No bearer returned');
  } catch (err) {
    console.err(err);
    throw err;
  }
};
```

## Calling an API

In this example we call the query endpoint and return the JSON when successful.

```js
const loadApprovals = async (bearer, status) => {
  const query = {
    query: `form = 'equipment' and status = '${status}'`,
    viewRefresh: true,
    noViews: false
  };

  const options = {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${bearer}`
    },
    body: JSON.stringify(query)
  };

  try {
    const response = await fetch(urls.list, options);
    if (response.status != 200) {
      throw new Error(
        `Query returned failure status ${response.status}: ${response.statusText}`
      );
    }
    const jBody = await response.json();
    // Add additional checks here
    return jBody;
  } catch (err) {
    console.error(err);
    throw err;
  }
};
```

## Considerations

- Once you retrieve the bearer you need to keep it somewhere. A simple, not very secure option is to save it into `window.bearer`. Advantage: goes away when window closes. Problem: can be read fom elsewhere unless your [CSP](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP) is tightly managed. A common way is to use [local storage](https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage) which also needs th be handled [carefully](https://auth0.com/docs/secure/security-guidance/data-security/token-storage)
- The Domino REST API uses chunked returns for anythin that returns an array and thus could return a lot of data. A call to `await response.json()` would wait until all data has been received. Here you need to [process the result asynchonously](https://wissel.net/blog/2023/07/handle-http-chunked-responses.html)
- Tighten your [CSP](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP) and **please** only HTTP**S**
- Besides extracting the bearer, you could grab the expiry time and create a function that first validates the token's lifespan before making a call
