import { useState } from 'react';
import { toast } from 'react-toastify';
import { reloadCurrentPage } from '../utils';
import { client } from '../functions/api/client';

type Props = {
  rubyMethod: {
    id: number;
    official_url: string;
  };
  userRubyMethod: {
    id: number;
  };
  memo: string;
  setMemo: React.Dispatch<React.SetStateAction<string>>;
};

export const LearningPhase = ({
                                rubyMethod,
                                userRubyMethod,
                                memo,
                                setMemo,
                              }: Props) => {
  const [previousMemo, setPreviousMemo] = useState('');

  const isInvalidMemo = () => {
    if (memo === previousMemo) return true;
  };

  const changeMemo = (
    event: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>,
  ) => {
    setMemo(event.target.value);
  };

  const updateMemo = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    client
      .patch(`user_ruby_methods/${userRubyMethod.id}.json`, {
        user_ruby_method: { ruby_method_id: rubyMethod.id, description: memo },
      })
      .then(() => {
        toast('メモを保存しました😊');
        setPreviousMemo(memo);
        setTimeout(() => {
          reloadCurrentPage();
        }, 3000);
      })
      .catch(function (error) {
        console.log(error.response);
      });
  };

  return (
    <div>
      <p className='text-blue-600 text-xl mb-10 underline mt-4'>
        <a href={rubyMethod.official_url} target='_blank'>
          公式サイトで確認する
        </a>
      </p>
      <form onSubmit={updateMemo}>
        <label>
          <span className='font-bold'>覚えやすいようにメモを取ろう</span>
          <textarea
            value={memo ?? ''}
            onChange={changeMemo}
            rows={5}
            className='block shadow rounded-md border border-black  outline-none px-3 py-2 mt-2 w-full'
          ></textarea>
        </label>
        <div className='mb-5'>
          <button className='btn btn-outline mt-2' disabled={isInvalidMemo()}>
            保存する
          </button>
        </div>
      </form>
      <div className='mb-5'>
        <div>
          <button
            className='btn mt-2 btn-info'
            onClick={() => reloadCurrentPage()}
          >
            次の問題へ
          </button>
        </div>
        <div className='mt-10'>
          <a href='new' className='me-8 underline'>
            クイズの条件を変える
          </a>
          <a href='/user_ruby_methods' className='underline'>
            メソッド一覧へ
          </a>
        </div>
      </div>
    </div>
  );
};
