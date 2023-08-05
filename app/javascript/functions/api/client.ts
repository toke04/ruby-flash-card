import applyCaseMiddleware from 'axios-case-converter'
import axios from 'axios'

const options = {
  ignoreHeaders: true,
}

const csrfToken = document
  .querySelector('meta[name="csrf-token"]')
  ?.getAttribute('content')

export const client = applyCaseMiddleware(
  axios.create({
    baseURL: '/api/v1',
    headers: {
      'content-type': 'application/json',
      'X-CSRF-Token': csrfToken,
    },
  }),
  options
)
