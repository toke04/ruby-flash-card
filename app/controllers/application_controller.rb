# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def admin?
    return if current_user.admin

    redirect_to root_path
  end
end
