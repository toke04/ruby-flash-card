import applyCaseMiddleware from 'axios-case-converter';
import axios from 'axios';
// ヘッダーに関してはケバブケースのままで良いので適用を無視するオプションを追加
const options = {
  ignoreHeaders: true,
};

const baseURL = {
  local: import.meta.env.VITE_REACT_APP_LOCAL_API,
  production: import.meta.env.VITE_REACT_APP_PROD_API,
};

const csrfToken = document
  .querySelector('meta[name="csrf-token"]')
  ?.getAttribute('content');

export const client = applyCaseMiddleware(
  axios.create({
    baseURL: `${
      import.meta.env.VITE_REACT_APP_NODE_ENV === 'development'
        ? baseURL.local
        : baseURL.production
    }`,
    headers: {
      'content-type': 'application/json',
      'X-CSRF-Token': csrfToken,
    },
  }),
  options,
);
