import React from 'react';
import ReactDOM from 'react-dom/client';
import Quiz from '../src/Quiz';

const element = document.getElementById('ruby_quiz_show');

ReactDOM.createRoot(element!).render(
  <div>
    <Quiz {...element?.dataset} />
  </div>,
);
