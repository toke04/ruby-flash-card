type Props = {
  isQuestionButtonActive: boolean;
  canSeeMemo: boolean;
  setCanSeeMemo: React.Dispatch<React.SetStateAction<boolean>>;
  memo: string;
};

export const PreviousMemo = ({
                               memo,
                               isQuestionButtonActive,
                               canSeeMemo,
                               setCanSeeMemo,
                             }: Props) => {
  const showPreviousMemo = () => {
    setCanSeeMemo((canSeeMemo) => !canSeeMemo);
  };
  return (
    <div className='mt-7'>
      {memo && isQuestionButtonActive && (
        <p
          className='underline text-blue-600 cursor-pointer'
          onClick={() => showPreviousMemo()}
        >
          前回のメモを見る
        </p>
      )}
      {canSeeMemo && (
        <div className='bg-stone-50	shadow-md rounded-lg p-4 mt-3'>
          <p className='my-4' style={{ whiteSpace: 'pre-line' }}>
            {memo}
          </p>
        </div>
      )}
    </div>
  );
};
