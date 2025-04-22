/**
 * Render the replacement table for old vss. new URLs
 * @param {*} baseURL
 */

let pageSource = [];

const objectArraySort = (criterium) => {
  return (first, second) => {
    if (first[criterium] > second[criterium]) {
      return 1;
    }

    if (first[criterium] < second[criterium]) {
      return -1;
    }

    return 0;
  };
};

const renderTable = (baseURL) => {
  const table = document.getElementById('linkBody');

  return fetch(baseURL + 'redirect.json')
    .then((response) => response.json())
    .then((data) => {
      const template = document.createElement('template');
      template.innerHTML = data.template;
      pageSource = data.sites.sort(objectArraySort('old'));
      pageSource.forEach((page) => renderRow(page, table, template, baseURL));
    });
};

const renderRow = (page, table, template, baseURL) => {
  const clone = template.content.cloneNode(true);
  const link = clone.querySelector('a');
  const title = clone.querySelector('.title');
  const oldURL = clone.querySelector('.old');

  link.innerText = page.new;
  link.href = baseURL + page.new;
  title.innerText = page.title;
  oldURL.innerText = page.old;
  table.appendChild(clone);
};

const createUrlVariations = (source, baseURL) => {
  const result = [];
  const dropFix = baseURL.toLowerCase();
  const work = source.toLowerCase().replace(dropFix, '');
  result.push(work);
  if (work.endsWith('/')) {
    result.push(work + 'index.html');
    result.push(work.substring(0, work.length));
  } else if (!work.endsWith('.html')) {
    result.push(work + '/index.html');
    result.push(work + '/');
  }
  return result;
};

const pageHit = (source, candidates) => {
  for (const element of candidates) {
    if (source.old.toLowerCase().endsWith(element)) {
      return true;
    }
  }
  return false;
};

const captureFailedURL = (baseURL) => {
  const errorDiv = document.getElementById('error404Message');
  const errorMsg = document.createElement('p');
  const code = document.createElement('code');
  code.innerText = document.location.pathname;
  errorMsg.appendChild(document.createTextNode('You tried to reach '));
  errorMsg.appendChild(code);
  errorMsg.appendChild(
    document.createTextNode(" , which might not exist or have a new link.")
  );
  errorDiv.appendChild(errorMsg);
  const lookfor = createUrlVariations(document.location.pathname, baseURL);
  const hits = pageSource.filter((page) => pageHit(page, lookfor));
  if (hits.length > 0) {
    const tryThis = document.createElement('p');
    tryThis.innerText = 'This is what you might be looking for:';
    const list = document.createElement('ul');
    hits.forEach((page) => {
      const item = document.createElement('li');
      const link = document.createElement('a');
      link.innerText = page.title;
      link.href = baseURL + page.new;
      item.appendChild(link);
      item.appendChild(document.createTextNode(' URL:' + link.href));
      list.appendChild(item);
    });
    errorDiv.appendChild(tryThis);
    errorDiv.appendChild(list);
  }
};

const bootstrap = (rawURL) => {
  const baseURL = new URL(rawURL).pathname;
  renderTable(baseURL)
    .then(() => captureFailedURL(baseURL))
    .catch((err) => console.error(err));
};
