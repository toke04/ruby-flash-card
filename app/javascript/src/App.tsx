import './App.css'

type Props = {
  message?: string;
}

function App(props: Props) {
  return (
    <div className="App">
      {props.message}
    </div>
  )
}

export default App
