import { ToastContainer } from 'react-toastify'
import 'react-toastify/dist/ReactToastify.css'

type Props = {
  rubyModuleName: string
  rubyMethodName: string
}

export const QuizHeader = ({ rubyModuleName, rubyMethodName }: Props) => {
  return (
    <div className="text-center mb-2 mt-10">
      <ToastContainer
        position="top-center"
        autoClose={2000}
        hideProgressBar={true}
        newestOnTop={true}
        closeOnClick
        rtl={false}
        pauseOnFocusLoss
        draggable
        pauseOnHover
        theme="light"
      />
      <div className="flex justify-center method-title relative mb-16">
        <p className="mt-1 badge question-badge me-2 text-lg px-2 py-4 text-white">
          {rubyModuleName}
        </p>
        <p className="text-4xl font-bold">{rubyMethodName}</p>
      </div>
    </div>
  )
}
