export const quizModeParams = new URL(location.href).searchParams.get(
  'question_mode'
)

export const checkChallengedMethod = (quizModeParams: string | null) => {
  if (quizModeParams === 'not_remembered' || quizModeParams === 'remembered') {
    return true
  } else {
    return false
  }
}

export const reloadCurrentPage = () => {
  location.reload()
}
