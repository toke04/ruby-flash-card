import React from 'react'
import ReactDOM from 'react-dom/client'
import FlashCard from '../src/FlashCard'

const element = document.getElementById('ruby_flash_card_show')

ReactDOM.createRoot(element!).render(
  <div>
    <FlashCard {...element?.dataset} />
  </div>
)
