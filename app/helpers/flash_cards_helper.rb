# frozen_string_literal: true

module FlashCardsHelper
  def not_challenged_methods_count
    all_methods = RubyMethod.all
    challenged_methods = current_user.challenged_ruby_methods
    "#{(all_methods - challenged_methods).count}問"
  end

  def not_remembered_methods_count
    not_remembered_methods_count = current_user.user_ruby_methods.where(remembered: false).count
    "#{not_remembered_methods_count}問"
  end

  def remembered_methods_count
    remembered_methods_count = current_user.user_ruby_methods.where(remembered: true).count
    "#{remembered_methods_count}問"
  end
end
