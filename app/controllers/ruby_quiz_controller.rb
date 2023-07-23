# frozen_string_literal: true

class QuizController < ApplicationController
  def new
    @ruby_method = RubyMethod.new
  end
end
