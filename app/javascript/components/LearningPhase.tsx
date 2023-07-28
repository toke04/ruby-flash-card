import { useState } from 'react'
import { toast } from 'react-toastify'
import { reloadCurrentPage } from '../functions'
import { client } from '../functions/api/client'
import CodeEditor from '@uiw/react-textarea-code-editor';

type Props = {
  rubyMethod: {
    id: number
    official_url: string
  }
  userRubyMethod: {
    id: number
  }
  memo: string
  setMemo: React.Dispatch<React.SetStateAction<string>>
}

export const LearningPhase = ({
  rubyMethod,
  userRubyMethod,
  memo,
  setMemo,
}: Props) => {
  const [previousMemo, setPreviousMemo] = useState('')
  const [showEditor, setShowEditor] = useState(false);
  const [code, setCode] = useState('');
  const [resCode, setResCode] = useState([]);
  const isInvalidMemo = () => {
    if (memo === previousMemo) return true
  }

  const changeMemo = (
    event: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>
  ) => {
    setMemo(event.target.value)
  }

  const changeText = (
    event: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>
  ) => {
    setCode(event.target.value)
  }

  const addPreffixP = () => {
    console.log(code)
    setCode((code) => code.padStart(code.length + 2, 'p '))
    console.log(code)
  }

  const updateMemo = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault()
    client
      .patch(`user_ruby_methods/${userRubyMethod.id}.json`, {
        user_ruby_method: { ruby_method_id: rubyMethod.id, memo },
      })
      .then(() => {
        toast('メモを保存しました😊')
        setPreviousMemo(memo)
        setTimeout(() => {
          reloadCurrentPage()
        }, 2000)
      })
      .catch(function (error) {
        console.log(error.response)
      })
  }

  const execCode = () => {
    console.log(code)
    client
      .post(`/exec_code.json`, {
        code: code,
        // change_text: changeText,
      })
      .then((res) => {
        console.log(res.data)
        console.log(res.data.resultCode)
        // console.log(res.data.resultCode[0])
        setResCode([res.data.resultCode])
        console.log('成功')
      })
      .catch(function (error) {
        console.log(error.response)
      })
  }


  return (
    <div>
      <div className="flex mb-6">
        <iframe
          className={`w-full h-96`}
          src={rubyMethod.official_url}
        ></iframe>
      </div>
      <div>
        <button
          className="btn btn-sm mb-5 btn-neutral"
          onClick={() => setShowEditor(!showEditor)}
        >
          コードを試してみる
        </button>
      </div>
      {showEditor && (
        <div className="flex mb-6">
          <form onSubmit={(e) => {e.preventDefault()}}>
            <label>
              <span className="font-bold">試したいコードを貼ってください</span>
              <CodeEditor
                value={code}
                language="ruby"
                placeholder="rubyのコードを貼り付けて下さい"
                onChange={changeText}
                padding={15}
                minHeight={300}
                style={{
                  fontSize: 12,
                  color: 'white',
                  backgroundColor: "dark",
                  fontFamily: 'ui-monospace,SFMono-Regular,SF Mono,Consolas,Liberation Mono,Menlo,monospace',
                }}
              />
            </label>
            <div className="mb-5 flex">
              <button onClick={execCode} className="btn btn-sm btn-outline mt-2">
                実行する
              </button>
              <button onClick={addPreffixP} className="btn btn-sm btn-outline mt-2">
                行の先頭にpを追加する
              </button>
            </div>
            <p>[実行結果]</p>
            <div className="mockup-code">
              {resCode.map((code) => {
                return <p className="p-2 text-success" key={code}>{code}</p>
              })}
            </div>
          </form>
        </div>
      )}
      <form onSubmit={updateMemo}>
        <label>
          <span className="font-bold">覚えやすいようにメモを取ろう</span>
          <textarea
            value={memo ?? ''}
            onChange={changeMemo}
            rows={5}
            className="block shadow rounded-md border border-black  outline-none px-3 py-2 w-full"
          ></textarea>
        </label>
        <div className="mb-5">
          <button className="btn btn-outline mt-2" disabled={isInvalidMemo()}>
            保存する
          </button>
        </div>
      </form>
      <div className="mb-5">
        <div>
          <button
            className="btn mt-2 btn-info"
            onClick={() => reloadCurrentPage()}
          >
            次の問題へ
          </button>
        </div>
        <p className="text-blue-700	text-bold text-xl mt-20 mb-10 underline mt-4">
          <a href={rubyMethod.official_url} target="_blank">
            公式サイトへアクセスして確認する
          </a>
        </p>
        <div className="mt-10">
          <a href="new" className="me-8 underline">
            クイズの条件を変える
          </a>
          <a href="/user_ruby_methods" className="underline">
            メソッド一覧へ
          </a>
        </div>
      </div>
    </div>
  )
}
