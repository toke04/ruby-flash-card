# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    redirect_to new_flash_card_path if user_signed_in?
  end

  def terms_of_service; end

  def privacy_policy; end
end
