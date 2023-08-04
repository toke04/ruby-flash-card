import applyCaseMiddleware from 'axios-case-converter'
import axios from 'axios'
// ヘッダーに関してはケバブケースのままで良いので適用を無視するオプションを追加
const options = {
  ignoreHeaders: true,
}

const baseURL = {
  local: 'http://localhost:3000/api/v1',
  production: 'https://ruby-flash-card.fly.dev/api/v1',
}

const csrfToken = document
  .querySelector('meta[name="csrf-token"]')
  ?.getAttribute('content')

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
  options
)
