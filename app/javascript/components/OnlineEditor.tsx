import { useState } from 'react'
import Editor from 'react-simple-code-editor'
import { useHotkeys } from 'react-hotkeys-hook'
import { highlight, languages } from 'prismjs'
import 'prismjs/components/prism-clike'
import 'prismjs/components/prism-ruby'
import 'prismjs/themes/prism.css'
import '../src/OnlineEditor.css'

export const OnlineEditor = () => {
  const [showEditor, setShowEditor] = useState(true)
  const [rubyCode, setRubyCode] = useState('')
  const [codeResult, setCodeResult] = useState('')
  useHotkeys(
    'metaKey+enter',
    () => {
      execCode()
    },
    { enableOnFormTags: true } // textareaに入力中でもショートカットの実行を有効にする
  )

  const codeColor = () => {
    return codeResult.match(/Error/) ? 'text-error' : 'text-success'
  }

  const hightlightWithLineNumbers = (input: string, language: string) =>
    highlight(input, language)
      .split('\n')
      .map(
        (line, index) =>
          `<span class='editorLineNumber'>${index + 1}</span>${line}`
      )
      .join('\n')

  const setCorrectErrorMessage = (wrongErrorMessage: string) => {
    // 以下のようなエラーが発生するので、それを取得する「"Error: eval:5:in `fetch_values': key not found: \"bird\" (KeyError) eval:5:in `<main>'"」
    const regex = /Error: eval:(\d+):in `([^']+)'(.*)/
    const match = regex.exec(wrongErrorMessage.toString())
    if (match && match.length === 4) {
      const wrongLineNumber = parseInt(match[1])
      const causeOfError = match[2]
      const errorMessage = match[3]
      const correctLineNumber = wrongLineNumber - 1 // ruby.wasmの仕様で、行番号が1ズレてしまうので、修正する
      const correctErrorMessage = `Error occurred on line ${correctLineNumber} : \`${causeOfError}'${errorMessage}`
      setCodeResult(correctErrorMessage)
    } else {
      console.log(`Not correctly acquired by regular expression：${match}`)
    }
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
    } catch (wrongErrorMessage) {
      setCorrectErrorMessage(wrongErrorMessage)
    }
  }

  return (
    <div className="hidden md:block">
      <p className="mt-7 font-bold text-xl official-url-title relative">
        コードを実行して試す
      </p>
      <div className="flex justify-end">
        <button
          className="btn btn-sm w-40 h-10 border-2 border-slate-200	bg-white hover:bg-white-100 rounded"
          onClick={() => setShowEditor(!showEditor)}
        >
          {showEditor ? 'エディターを閉じる' : 'エディターを開く'}
        </button>
      </div>
      {showEditor && (
        <div className="mb-6 className={`w-full h-96`}">
          <p className="font-bold">
            貼り付けたコードの最終行の戻り値を出力します
          </p>
          <Editor
            value={rubyCode}
            onValueChange={(rubyCode) => setRubyCode(rubyCode)}
            highlight={(rubyCode) =>
              hightlightWithLineNumbers(rubyCode, languages.rb)
            }
            padding={10}
            placeholder={'text = "ruby love"\n' + 'text.upcase'}
            textareaId="codeArea"
            className="editor rounded"
            style={{
              fontFamily: '"Fira code", "Fira Mono", monospace',
              fontSize: 18,
              outline: 0,
              border: '1px solid',
              minHeight: '100px',
            }}
          />
          <div className="flex">
            <button
              onClick={execCode}
              className="btn btn-sm w-48 h-10 mt-3 mb-7　border-2 border-slate-200 bg-white hover:bg-white-100 rounded code-exec-button"
            >
              実行する(⌘+Enter)
            </button>
          </div>
          <p className="font-bold mt-5 mb-1">実行結果</p>
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
