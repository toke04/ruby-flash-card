import CodeEditor from '@uiw/react-textarea-code-editor'
import { useState } from 'react'
import { client } from '../functions/api/client'
import './Ifram.css'

export const OnlineEditor = () => {
  const [showEditor, setShowEditor] = useState(true)
  const [rubyCode, setRubyCode] = useState('')
  const [previousRubyCode, setPreviousRubyCode] = useState('')
  const [codeExecResult, setCodeExecResult] = useState([])
  const [timeoutMessage, setTimeoutMessage] = useState('')

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
        setTimeoutMessage(res.data.timeoutMessage)
      })
      .catch((error) => {
        console.log(error)
      })
  }

  const scrollIfram = () => {
    let iframeWrap = document.getElementsByClassName('iframeWrap')[0];
    iframeWrap.scrollTo({
      top: 1000,
      left: 100,
      behavior: "smooth"
    });
    console.log(iframeWrap)
    console.log("確認")
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
          <form
            onSubmit={(e) => {
              e.preventDefault()
            }}
          >
            <label>
              <span className="font-bold">試したいコードを貼ってください</span>
            </label>
            <iframe
              id="myIfram"
              scrolling="auto"
              frameborder="0"
              className={`w-full h-96 iframeWrap`}
              src={'http://try.ruby-lang.org/'}
            ></iframe>
            <button onClick={scrollIfram}>位置を変える</button>
            {/*<div className="block w-full rounded border border-black">*/}
            {/*  <CodeEditor*/}
            {/*    value={rubyCode}*/}
            {/*    language="ruby"*/}
            {/*    placeholder="ここにコードを貼り付けて下さい"*/}
            {/*    onChange={changeCode}*/}
            {/*    padding={15}*/}
            {/*    minHeight={200}*/}
            {/*    style={{*/}
            {/*      fontSize: 20,*/}
            {/*      color: 'black',*/}
            {/*      backgroundColor: '#EEEEEE',*/}
            {/*      border: '1px',*/}
            {/*      fontFamily:*/}
            {/*        'ui-monospace,SFMono-Regular,SF Mono,Consolas,Liberation Mono,Menlo,monospace',*/}
            {/*    }}*/}
            {/*  />*/}
            {/*</div>*/}
            {/*<div className="mb-5 flex justify-between">*/}
            {/*  <button*/}
            {/*    onClick={execCode}*/}
            {/*    disabled={isInvalidCodeExec()}*/}
            {/*    className="btn btn-neutral btn-sm mt-2"*/}
            {/*  >*/}
            {/*    コードを実行する*/}
            {/*  </button>*/}
            {/*  <button*/}
            {/*    onClick={addPreffixP}*/}
            {/*    className="btn btn-sm btn-outline mt-2"*/}
            {/*  >*/}
            {/*    各行の先頭に「p」を追加する*/}
            {/*  </button>*/}
            {/*</div>*/}
            {/*<div className="flex justify-between mt-10">*/}
            {/*  <p className="font-bold mt-2">実行結果</p>*/}
            {/*  <p>*/}
            {/*    <button onClick={deleteExecResult} className="btn btn-sm mb-2">*/}
            {/*      結果を削除する*/}
            {/*    </button>*/}
            {/*  </p>*/}
            {/*</div>*/}
            {/*<div className="mockup-code">*/}
            {/*  {codeExecResult &&*/}
            {/*    codeExecResult.map((code, index) => {*/}
            {/*      return (*/}
            {/*        <p className="p-2 text-success whitespace-pre" key={index}>*/}
            {/*          {code}*/}
            {/*          <br />*/}
            {/*        </p>*/}
            {/*      )*/}
            {/*    })}*/}
            {/*  {timeoutMessage && (*/}
            {/*    <p className="text-error p-2">{timeoutMessage}</p>*/}
            {/*  )}*/}
            {/*</div>*/}
          </form>
        </div>
      )}
    </div>
  )
}
