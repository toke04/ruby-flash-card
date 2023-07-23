class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @message = "Hello, world!"
  end
end
