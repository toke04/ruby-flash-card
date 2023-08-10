import { useState } from 'react'
import Editor from "react-simple-code-editor";
import {highlight, languages} from "prismjs";
import 'prismjs/components/prism-clike';
import 'prismjs/components/prism-ruby';
import 'prismjs/themes/prism.css';
import "../src/OnlineEditor.css"
export const OnlineEditor = () => {
  const [showEditor, setShowEditor] = useState(true)
  const [rubyCode, setRubyCode] = useState('')
  const [codeResult, setCodeResult] = useState('')

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
      const regex = /Error: eval:(\d+):in/; // 数字を抽出する正規表現
      const match = regex.exec(failedValue.toString());

      if (match && match[1]) {
        const originalErrorLineNumber = parseInt(match[1]);
        const errorLineNumber = originalErrorLineNumber - 1;
        const errorCode = failedValue.toString().replace(match[0], errorLineNumber.toString() + "行目でエラーが発生しました :");
        console.log(errorCode);
        setCodeResult(errorCode);
      } else {
        console.log("No numeric value found.");
      }
    }
  }

  const hightlightWithLineNumbers = (input:string, language:string) =>
    highlight(input, language)
      .split("\n")
      .map((line, i) => `<span class='editorLineNumber'>${i + 1}</span>${line}`)
      .join("\n");

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
          <Editor
            value={rubyCode}
            onValueChange={code => setRubyCode(code)}
            highlight={code => hightlightWithLineNumbers(code, languages.rb)}
            padding={10}
            placeholder={'text = "ruby love"\n' +
              'text.upcase'}
            textareaId="codeArea"
            className="editor rounded"
            style={{
              fontFamily: '"Fira code", "Fira Mono", monospace',
              fontSize: 18,
              outline: 0,
              border: "1px solid",
              minHeight: "100px"
            }}
          />
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
