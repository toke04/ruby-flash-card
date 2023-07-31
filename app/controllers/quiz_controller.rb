# frozen_string_literal: true

class QuizController < ApplicationController
  def new
    @ruby_method = RubyMethod.new
  end

  def show
    if params[:quiz_mode] == 'yes'
      @ruby_method = RubyMethod.user_methods_and_module.user_remembered(current_user, remembered: true).sample
      @user_ruby_method = @ruby_method.user_ruby_methods.first if @ruby_method.present?
    elsif params[:quiz_mode] == 'no'
      @ruby_method = RubyMethod.user_methods_and_module.user_remembered(current_user, remembered: false).sample
      @user_ruby_method = @ruby_method.user_ruby_methods.first if @ruby_method.present?
    else
      all_methods = RubyMethod.all
      challenged_methods = current_user.challenged_ruby_methods
      @ruby_method = all_methods.unchallenged_ruby_method(all_methods, challenged_methods)
    end
    @ruby_module = @ruby_method&.ruby_module if @ruby_method.present?
  end
end
