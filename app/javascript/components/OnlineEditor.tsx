import CodeEditor from '@uiw/react-textarea-code-editor'
import { useState } from 'react'

export const OnlineEditor = () => {
  const [showEditor, setShowEditor] = useState(true)
  const [rubyCode, setRubyCode] = useState('')
  const [codeExecResult, setCodeExecResult] = useState('')
  const placeholderText = `text = "ruby love"\ntext.upcase`

  const changeCode = (
    event: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>
  ) => {
    setRubyCode(event.target.value)
  }

  const { DefaultRubyVM } = window['ruby-wasm-wasi']
  const execRubyCode = async () => {
    const response = await fetch(
      'https://cdn.jsdelivr.net/npm/ruby-head-wasm-wasi@latest/dist/ruby.wasm'
    )
    const buffer = await response.arrayBuffer()
    const module = await WebAssembly.compile(buffer)
    const { vm } = await DefaultRubyVM(module)
    const res = vm.eval(`
    ${rubyCode}
    `)
    setCodeExecResult(res.toString())
  }
  return (
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
          <p className="font-bold">貼り付けたコードの最終行を出力できます</p>
          <div className="block w-full rounded border border-black">
            <CodeEditor
              value={rubyCode}
              language="ruby"
              placeholder={placeholderText}
              onChange={changeCode}
              padding={15}
              minHeight={200}
              id="CodeEditor"
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
          <button
            onClick={execRubyCode}
            className="btn btn-neutral btn-sm mt-2 mb-5"
          >
            コードを実行する
          </button>
          <p className="font-bold mt-5 mb-2">実行結果</p>
          <div className="mockup-code">
            {codeExecResult && (
              <p className="px-5 text-success">{codeExecResult}</p>
            )}
          </div>
        </div>
      )}
    </div>
  )
}
