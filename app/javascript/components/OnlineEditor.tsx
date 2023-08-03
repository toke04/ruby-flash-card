import CodeEditor from '@uiw/react-textarea-code-editor'
import { useState } from 'react'

export const OnlineEditor = () => {
  const [showEditor, setShowEditor] = useState(true)
  const [rubyCode, setRubyCode] = useState('')
  const [previousRubyCode, setPreviousRubyCode] = useState('')
  const [codeExecResult, setCodeExecResult] = useState([])
  const [timeoutMessage, setTimeoutMessage] = useState('')
  const placeholderText = `text = "ruby love"
text.upcase`;
  const isInvalidCodeExec = () => {
    if (rubyCode === previousRubyCode) return true
  }

  const changeCode = (
    event: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>
  ) => {
    setRubyCode(event.target.value)
  }

  const deleteExecResult = () => {
    setCodeExecResult([])
  }

  const { DefaultRubyVM } = window["ruby-wasm-wasi"];
  const main = async () => {
    const response = await fetch("https://cdn.jsdelivr.net/npm/ruby-head-wasm-wasi@latest/dist/ruby.wasm")
    const buffer = await response.arrayBuffer()
    const module = await WebAssembly.compile(buffer)
    const { vm } = await DefaultRubyVM(module)
    const res = vm.eval(`
    ${rubyCode}
    `)
    setCodeExecResult(res.toString())
  }
  return(
    <div>
      <div className="flex justify-end">
        <button
          className="btn btn-sm mt-10 block"
          onClick={() => setShowEditor(!showEditor)}
        >
          {showEditor ? 'エディターを閉じる' : 'エディターを開く'}
        </button>
      </div>
      {showEditor && (
        <div className="mb-6 className={`w-full h-96`}">
          <form
            onSubmit={(e) => {
              e.preventDefault()
            }}
          >
            <p>
              <span className="font-bold">貼り付けたコードの最終行を出力できます</span>
            </p>
            <div className="block w-full rounded border border-black">
              <CodeEditor
                value={rubyCode}
                language="ruby"
                placeholder={placeholderText}
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
                onClick={main}
                disabled={isInvalidCodeExec()}
                className="btn btn-neutral btn-sm mt-2"
              >
                コードを実行する
              </button>
            </div>
            <div className="flex justify-between mt-10">
              <p className="font-bold mt-2">実行結果</p>
              <p>
                <button onClick={deleteExecResult} className="btn btn-sm mb-2">
                  結果を削除する
                </button>
              </p>
            </div>
            <div className="mockup-code">
              {codeExecResult &&
                    <p className="p-2 text-success whitespace-pre">
                      {codeExecResult}
                      <br />
                    </p>
              }
              {timeoutMessage && (
                <p className="text-error p-2">{timeoutMessage}</p>
              )}
            </div>
          </form>
        </div>
      )}
    </div>
  )
}
