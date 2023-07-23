module ApplicationHelper

  def registered_user_ruby_method?
    UserRubyMethod.where(user_id: current_user).present? ? true : false
  end
end
