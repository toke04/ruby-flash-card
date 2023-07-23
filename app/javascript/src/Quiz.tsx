import { useState } from 'react';
import { client } from '../functions/api/client';
import {
  quizModeParams,
  checkChallengedMethod,
  reloadCurrentPage,
} from '../utils';
import { RubyMethodObjects } from '../types/tubyMethodObjects';
import { LearningPhase } from '../components/LearningPhase';
import { PreviousMemo } from '../components/PreviousMemo';
import { QuizHeader } from '../components/QuizHeader';

const Quiz = (props: RubyMethodObjects) => {
  const rubyMethod = JSON.parse(props.rubyMethod);
  const rubyModule = JSON.parse(props.rubyModule);
  const [userRubyMethod, setUserRubyMethod] = useState(
    props.userRubyMethod ? JSON.parse(props.userRubyMethod) : '',
  );
  const [memo, setMemo] = useState(userRubyMethod.memo);
  const [showLearningPhase, setShowLearningPhase] = useState(false);
  const [canSeeMemo, setCanSeeMemo] = useState(false);
  const [isQuestionButtonActive, setIsQuestionButtonActive] = useState(true);

  const createUserRubyMethod = (remembered: boolean) => {
    client
      .post(`user_ruby_methods.json`, {
        user_ruby_method: { ruby_method_id: rubyMethod.id, remembered },
      })
      .then((response) => {
        if (remembered === true) {
          reloadCurrentPage();
        } else {
          setUserRubyMethod(response.data.method);
          setIsQuestionButtonActive(false);
          setShowLearningPhase(true);
        }
      })
      .catch((error) => {
        console.log(error.response);
      });
  };

  const updateRemembered = (remembered: boolean) => {
    client
      .patch(`user_ruby_methods/${userRubyMethod.id}.json`, {
        user_ruby_method: { ruby_method_id: rubyMethod.id, remembered },
      })
      .then(() => {
        if (remembered === true) {
          reloadCurrentPage();
        } else {
          setIsQuestionButtonActive(false);
          setShowLearningPhase(true);
          setCanSeeMemo(false);
        }
      })
      .catch((error) => {
        console.log(error.response);
      });
  };

  return (
    <div className='lg:ms-48 mt-2'>
      <QuizHeader
        rubyModuleName={rubyModule.name}
        rubyMethodName={rubyMethod.name}
      />
      <div className={isQuestionButtonActive ? '' : 'hidden'}>
        <div>
          <button
            className='btn btn-lg mt-2 btn-neutral mb-5 mt-14'
            onClick={() =>
              checkChallengedMethod(quizModeParams)
                ? updateRemembered(true)
                : createUserRubyMethod(true)
            }
          >
            知ってる
          </button>
        </div>
        <div>
          <button
            className='btn btn-lg mt-2 btn-neutral'
            onClick={() =>
              checkChallengedMethod(quizModeParams)
                ? updateRemembered(false)
                : createUserRubyMethod(false)
            }
          >
            知らない
          </button>
        </div>
      </div>
      <PreviousMemo
        memo={memo}
        isQuestionButtonActive={isQuestionButtonActive}
        canSeeMemo={canSeeMemo}
        setCanSeeMemo={setCanSeeMemo}
      />
      {showLearningPhase && (
        <LearningPhase
          rubyMethod={rubyMethod}
          userRubyMethod={userRubyMethod}
          memo={memo}
          setMemo={setMemo}
        />
      )}
    </div>
  );
};

export default Quiz;
