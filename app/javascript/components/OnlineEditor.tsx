import CodeEditor from '@uiw/react-textarea-code-editor'
import { useState } from 'react'

export const OnlineEditor = () => {
  const [showEditor, setShowEditor] = useState(true)
  const [rubyCode, setRubyCode] = useState('')
  const [codeResult, setCodeResult] = useState('')

  const changeCode = (
    event: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>
  ) => {
    setRubyCode(event.target.value)
  }

  const codeColor = () => {
    return codeResult.match(/Error/) ? 'text-error' : 'text-success'
  }

  const execCode = async () => {
    const wasmCDN = await fetch(
      'https://cdn.jsdelivr.net/npm/ruby-head-wasm-wasi@latest/dist/ruby.wasm'
    )
    const buffer = await wasmCDN.arrayBuffer()
    const module = await WebAssembly.compile(buffer)
    const { DefaultRubyVM } = window['ruby-wasm-wasi']
    const { vm } = await DefaultRubyVM(module)
    let succeedValue = ''
    try {
      succeedValue = vm.eval(`
        ${rubyCode}
      `)
      setCodeResult(succeedValue.toString() || 'nil')
    } catch (failedValue) {
      setCodeResult(failedValue.toString())
    }
  }
  return (
    <div className="hidden md:block">
      <div className="flex justify-end">
        <button
          className="btn btn-sm btn-outline block"
          onClick={() => setShowEditor(!showEditor)}
        >
          {showEditor ? 'エディターを閉じる' : 'エディターを開く'}
        </button>
      </div>
      {showEditor && (
        <div className="mb-6 className={`w-full h-96`}">
          <p className="font-bold">貼り付けたコードの最終行を出力します</p>
          <div className="block w-full rounded border border-black">
            <CodeEditor
              value={rubyCode}
              language="ruby"
              placeholder={`text = "ruby love"\ntext.upcase`}
              onChange={changeCode}
              padding={15}
              minHeight={150}
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
            onClick={execCode}
            className="btn btn-sm btn-outline mt-2 mb-5 code-exec-button"
          >
            コードを実行する
          </button>
          <p className="font-bold mt-1 mb-1">実行結果</p>
          <div className="mockup-code">
            {codeResult && (
              <p className={`px-2 ${codeColor()}`}>{codeResult}</p>
            )}
          </div>
        </div>
      )}
    </div>
  )
}
