import { useState } from 'react'
import { client } from '../functions/api/client'
import {
  quizModeParams,
  checkChallengedMethod,
  reloadCurrentPage,
} from '../functions'
import { RubyMethodObjects } from '../types/rubyMethodObjects'
import { LearningPhase } from '../components/LearningPhase'
import { PreviousMemo } from '../components/PreviousMemo'
import { QuizHeader } from '../components/QuizHeader'

const FlashCard = (props: RubyMethodObjects) => {
  const rubyMethod = JSON.parse(props.rubyMethod)
  const rubyModule = JSON.parse(props.rubyModule)
  const [userRubyMethod, setUserRubyMethod] = useState(
    props.userRubyMethod ? JSON.parse(props.userRubyMethod) : ''
  )
  const [memo, setMemo] = useState(userRubyMethod.memo)
  const [isLearningPhase, setIsLearningPhase] = useState(false)
  const [canSeeMemo, setCanSeeMemo] = useState(false)
  const [isQuestionButtonActive, setIsQuestionButtonActive] = useState(true)

  const createUserRubyMethod = (remembered: boolean) => {
    client
      .post(`user_ruby_methods.json`, {
        user_ruby_method: { ruby_method_id: rubyMethod.id, remembered },
      })
      .then((response) => {
        if (remembered === true) {
          reloadCurrentPage()
        } else {
          setUserRubyMethod(response.data.method)
          setIsQuestionButtonActive(false)
          setIsLearningPhase(true)
        }
      })
      .catch((error) => {
        console.log(error.response)
      })
  }

  const updateRemembered = (remembered: boolean) => {
    client
      .patch(`user_ruby_methods/${userRubyMethod.id}.json`, {
        user_ruby_method: { ruby_method_id: rubyMethod.id, remembered },
      })
      .then(() => {
        if (remembered === true) {
          reloadCurrentPage()
        } else {
          setIsQuestionButtonActive(false)
          setIsLearningPhase(true)
          setCanSeeMemo(false)
        }
      })
      .catch((error) => {
        console.log(error.response)
      })
  }

  return (
    <div className="lg:ms-48">
      <QuizHeader
        rubyModuleName={rubyModule.name}
        rubyMethodName={rubyMethod.name}
      />
      <div className={isQuestionButtonActive ? '' : 'hidden'}>
        <div>
          <button
            className="btn btn-lg mt-2 btn-neutral mb-3 mt-14"
            onClick={() =>
              checkChallengedMethod(quizModeParams)
                ? updateRemembered(true)
                : createUserRubyMethod(true)
            }
          >
            分かっているので次へ
          </button>
        </div>
        <div>
          <button
            className="btn btn-lg mt-1 btn-neutral"
            onClick={() =>
              checkChallengedMethod(quizModeParams)
                ? updateRemembered(false)
                : createUserRubyMethod(false)
            }
          >
            分からないので確認する
          </button>
        </div>
      </div>
      <PreviousMemo
        memo={memo}
        isQuestionButtonActive={isQuestionButtonActive}
        canSeeMemo={canSeeMemo}
        setCanSeeMemo={setCanSeeMemo}
      />
      {isLearningPhase && (
        <LearningPhase
          rubyMethod={rubyMethod}
          userRubyMethod={userRubyMethod}
          memo={memo}
          setMemo={setMemo}
        />
      )}
    </div>
  )
}

export default FlashCard
