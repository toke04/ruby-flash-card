# frozen_string_literal: true

module UserRubyMethodsHelper
  def convert_text(user_ruby_method)
    return '分からなかった' if user_ruby_method.remembered == false

    '分かっていた' if user_ruby_method.remembered == true
  end

  def module_name(user_ruby_method)
    user_ruby_method.ruby_method.ruby_module.name
  end
end
