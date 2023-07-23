class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @message = "Hello, world!"
    redirect_to quiz_new_path if user_signed_in?
  end
end
