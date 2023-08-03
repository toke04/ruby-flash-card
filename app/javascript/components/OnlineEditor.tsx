export const OnlineEditor = () => {
  const { DefaultRubyVM } = window["ruby-wasm-wasi"];
  const main = async () => {
    const response = await fetch("https://cdn.jsdelivr.net/npm/ruby-head-wasm-wasi@latest/dist/ruby.wasm")
    const buffer = await response.arrayBuffer()
    const module = await WebAssembly.compile(buffer)
    const { vm } = await DefaultRubyVM(module)

    const res = vm.eval(`
        %w(C C++ Rust Ruby).sample
      `)

    const result = document.getElementById('result')
    result.innerText = res.toString()
  }
  return(
    <>
      <div className="container-sm p-5">
        <button type="button" className="btn btn-sm btn-primary my-3 px-3" onClick={main}>Run</button>
        <div id="result"></div>
      </div>
    </>
  )
}
