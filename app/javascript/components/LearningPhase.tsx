import { useState } from 'react'
import { toast } from 'react-toastify'
import { reloadCurrentPage } from '../functions'
import { client } from '../functions/api/client'
import { OnlineEditor } from './OnlineEditor'
import { useHotkeys } from 'react-hotkeys-hook'

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
  useHotkeys(
    'metaKey+s',
    () => {
      updateMemo()
    },
    { enableOnFormTags: true, // 入力中でもショートカットの実行を有効にする
      preventDefault: true // ブラウザーのデフォルトの動作を防止する
    }
  )

  const isInvalidMemo = () => {
    if (memo === previousMemo || memo === undefined) return true
  }

  const changeMemo = (
    event: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>
  ) => {
    setMemo(event.target.value)
  }

  const updateMemo = () => {
    if(isInvalidMemo()){
      return console.log("保存できな状態なので処理を中断します") // ショートカットキーで実行された時に、保存処理を無効にする
    }
    client
      .patch(`user_ruby_methods/${userRubyMethod.id}.json`, {
        user_ruby_method: { ruby_method_id: rubyMethod.id, memo },
      })
      .then(() => {
        toast('メモの保存が完了しました🎉次の問題に移行します。')
        setPreviousMemo(memo)
        setTimeout(() => {
          reloadCurrentPage()
        }, 2000)
      })
      .catch(function (error) {
        console.log(error.response)
      })
  }

  return (
    <div>
      <p className="mb-2 font-bold text-xl official-url-title relative">
        公式リファレンス
      </p>
      <div className="flex mb-4 flex-col">
        <iframe
          id="officialSite"
          className={`w-full h-96`}
          src={rubyMethod.official_url}
        ></iframe>
        <p className="flex justify-end text-blue-800 text-bold text-xl mt-4 mb-4 underline">
          <a href={rubyMethod.official_url} target="_blank">
            公式リファレンスへ
          </a>
        </p>
      </div>
      <OnlineEditor />
      <form onSubmit={ (e: React.FormEvent<HTMLFormElement>) => {e.preventDefault()}}>
        <label>
          <p className="mb-2 mt-8 font-bold text-xl official-url-title relative">
            おぼえるためにメモを残そう
          </p>
          <textarea
            value={memo ?? ''}
            onChange={changeMemo}
            rows={7}
            className="text-lg block shadow rounded-md border border-black outline-none mt-1 px-3 py-2 w-full"
          ></textarea>
        </label>
        <div className="mb-5 flex justify-center">
          <button
            className="btn btn-sm w-48 h-10 mt-7 mb-2 border-2 border-slate-200	bg-white hover:bg-white-100 rounded"
            disabled={isInvalidMemo()}
            onClick={updateMemo}
          >
            保存する((⌘+s)
          </button>
        </div>
      </form>
      <div className="mb-5">
        <div className="flex justify-center">
          <button
            className="w-48 h-10 py-2 px-4 main-red-color hover:bg-red-800 text-white font-bold rounded"
            onClick={() => reloadCurrentPage()}
          >
            次の問題へ
          </button>
        </div>
        <div className="mt-8 flex justify-center text-blue-700">
          <a href="flash_card/new" className="me-8 underline">
            出題条件を変える
          </a>
          <a href="/user_ruby_methods" className="underline">
            メソッド一覧へ
          </a>
        </div>
      </div>
    </div>
  )
}
