# frozen_string_literal: true

module QuizHelper
  def not_challenged_methods_count
    all_methods = RubyMethod.all
    challenged_methods = current_user.challenged_ruby_methods
    "#{(all_methods - challenged_methods).count}問"
  end

  def not_remembered_methods_count
    not_remembered_methods_count = RubyMethod.user_method_count(current_user, remembered: false)
    disabled_quiz_radio if not_remembered_methods_count.zero?
    "#{not_remembered_methods_count}問"
  end

  def remembered_methods_count
    remembered_methods_count = RubyMethod.user_method_count(current_user, remembered: true)
    disabled_quiz_radio if remembered_methods_count.zero?
    "#{remembered_methods_count}問"
  end

  def disabled_quiz_radio
    'disabled:'
  end
end
