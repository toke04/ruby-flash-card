# frozen_string_literal: true

module UserRubyMethodsHelper
  def convert_text(user_ruby_method)
    return '分からなかった' if user_ruby_method.remembered == false

    '分かっていた' if user_ruby_method.remembered == true
  end

  def module_name(user_ruby_method)
    user_ruby_method.ruby_method.ruby_module.name
  end

  # reactのtextareaから送信すると改行文字は「\n」になる。
  # railsのtext_areaヘルパーから送信すると改行文字は「\r\n」になる。
  # 空行(\nが複数続く)場合に<br>という文字列に変更してあげれば、simple_formatでHTMLのタグとして反映させる事ができる
  def add_new_line(str)
    simple_format(str.gsub(/[\r]?\n/, '<br>'))
  end
end
