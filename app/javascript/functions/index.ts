export const quizModeParams = new URL(location.href).searchParams.get(
  'quiz_mode',
);

export const checkChallengedMethod = (quizModeParams: string | null) => {
  if (quizModeParams === 'yes' || quizModeParams === 'no') {
    return true;
  } else {
    return false;
  }
};

export const reloadCurrentPage = () => {
  location.reload();
};
