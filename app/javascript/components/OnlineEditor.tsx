import CodeEditor from '@uiw/react-textarea-code-editor'
import { useState } from 'react'
import { client } from '../functions/api/client'

export const OnlineEditor = () => {
  const [showEditor, setShowEditor] = useState(false)
  const [rubyCode, setRubyCode] = useState('')
  const [previousRubyCode, setPreviousRubyCode] = useState('')
  const [codeExecResult, setCodeExecResult] = useState([])
  const [errorMessage, setErrorMessage] = useState("")

  const isInvalidCodeExec = () => {
    if (rubyCode === previousRubyCode) return true
  }

  const changeCode = (
    event: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>
  ) => {
    setRubyCode(event.target.value)
  }

  const deleteExecResult = () =>{
    setCodeExecResult([])
  }

  const addPreffixP = () => {
    setRubyCode((rubyCode) =>
      rubyCode
        .padStart(rubyCode.length + 2, 'p ')
        .replaceAll('\n', '\np ')
        .slice(0, -2)
    )
  }

  const execCode = () => {
    setPreviousRubyCode(rubyCode)
    client
      .post(`/exec_code.json`, {
        ruby_code: rubyCode,
      })
      .then((res) => {
        setCodeExecResult(res.data.codeResult)
        setErrorMessage(res.data.errorMessage)
      })
      .catch((error) => {
        console.log(error)
      })
  }

  return (
    <div>
      <div>
        <button
          className="btn btn-sm mb-5 btn-neutral"
          onClick={() => setShowEditor(!showEditor)}
        >
          コードを試してみる
        </button>
      </div>
      {showEditor && (
        <div className="mb-6 className={`w-full h-96`}">
          <form
            onSubmit={(e) => {
              e.preventDefault()
            }}
          >
            <label>
              <span className="font-bold">試したいコードを貼ってください</span>
            </label>
            <div className="block w-full rounded border border-black">
              <CodeEditor
                value={rubyCode}
                language="ruby"
                placeholder="ここにコードを貼り付けて下さい"
                onChange={changeCode}
                padding={15}
                minHeight={200}
                style={{
                  fontSize: 20,
                  color: 'black',
                  backgroundColor: '#EEEEEE',
                  border: '1px',
                  fontFamily:
                    'ui-monospace,SFMono-Regular,SF Mono,Consolas,Liberation Mono,Menlo,monospace',
                }}
              />
            </div>
            <div className="mb-5 flex justify-between">
              <button
                onClick={execCode}
                disabled={isInvalidCodeExec()}
                className="btn btn-sm btn-outline mt-2"
              >
                実行する
              </button>
              <button
                onClick={addPreffixP}
                className="btn btn-sm btn-outline mt-2"
              >
                各行の先頭に「p」を追加する
              </button>
            </div>
            <div className="flex justify-between">
              <p className="font-bold mt-2">実行結果</p>
              <p><button onClick={deleteExecResult } className="btn btn-sm mb-2">結果を削除する</button></p>
            </div>
            <div className="mockup-code">
              {codeExecResult && codeExecResult.map((code, index) => {
                return (
                  <p className="p-2 text-success whitespace-pre" key={index}>
                    {code}
                    <br />
                  </p>
                )
              })}
              {errorMessage && <p className="text-error p-2">{errorMessage}</p> }
            </div>
          </form>
        </div>
      )}
    </div>
  )
}
