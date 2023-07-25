import { ToastContainer } from 'react-toastify'
import 'react-toastify/dist/ReactToastify.css'

type Props = {
  rubyModuleName: string
  rubyMethodName: string
}

export const QuizHeader = ({ rubyModuleName, rubyMethodName }: Props) => {
  return (
    <div>
      <h1 className="font-bold text-4xl mb-7">Rubyクイズ</h1>
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
      <p className="badge badge-neutral me-2 mt-2 text-2xl p-3">
        {rubyModuleName}
      </p>
      <p className="mt-2 text-2xl">{rubyMethodName}</p>
    </div>
  )
}
