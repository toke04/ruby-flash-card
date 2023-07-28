# frozen_string_literal: true

module OnlineEditor
  def create_exec_code_file(codes)
    open('tmp/exec_ruby_code.rb', 'w') do |f|
      codes.map do |code|
        f.puts code unless code =~ /^#/ || code == '' || code =~ /`.+`/ || code =~ /`.+`/ || code =~ /exec\(".+"\)/
      end
    end
  end
end
