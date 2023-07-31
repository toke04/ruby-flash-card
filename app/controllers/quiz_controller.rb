# frozen_string_literal: true

class QuizController < ApplicationController
  def new
    @ruby_method = RubyMethod.new
  end

  def show
    case params[:quiz_mode]
    when 'remembered'
      @user_ruby_method = current_user.user_ruby_methods.where(remembered: true).sample
      @ruby_method = @user_ruby_method&.ruby_method
    when 'not_remembered'
      @user_ruby_method = current_user.user_ruby_methods.where(remembered: false).sample
      @ruby_method = @user_ruby_method&.ruby_method
    when 'not_challenged', nil
      ruby_methods = RubyMethod.all
      challenged_ruby_methods = current_user.challenged_ruby_methods
      @ruby_method = (ruby_methods - challenged_ruby_methods).sample
    end
    @ruby_module = @ruby_method&.ruby_module
  end
end
