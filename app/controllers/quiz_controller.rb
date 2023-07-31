# frozen_string_literal: true

class QuizController < ApplicationController
  def new
    @ruby_method = RubyMethod.new
  end

  def show
    if params[:quiz_mode] == 'yes'
      @user_ruby_method = current_user.user_ruby_methods.where(remembered: true).sample
      @ruby_method = @user_ruby_method&.ruby_method
    elsif params[:quiz_mode] == 'no'
      @user_ruby_method = current_user.user_ruby_methods.where(remembered: false).sample
      @ruby_method = @user_ruby_method&.ruby_method
    else
      ruby_methods = RubyMethod.all
      challenged_ruby_methods = current_user.challenged_ruby_methods
      @ruby_method = RubyMethod.unchallenged_ruby_method(ruby_methods, challenged_ruby_methods)
    end
    @ruby_module = @ruby_method&.ruby_module
  end
end
