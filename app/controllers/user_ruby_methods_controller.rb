class UserRubyMethodsController < ApplicationController
  before_action :set_user_ruby_method, only: %i[ show edit update destroy ]

  # GET /user_ruby_methods or /user_ruby_methods.json
  def index
    @user_ruby_methods = UserRubyMethod.all
  end

  # GET /user_ruby_methods/1 or /user_ruby_methods/1.json
  def show
  end

  # GET /user_ruby_methods/new
  def new
    @user_ruby_method = UserRubyMethod.new
  end

  # GET /user_ruby_methods/1/edit
  def edit
  end

  # POST /user_ruby_methods or /user_ruby_methods.json
  def create
    @user_ruby_method = UserRubyMethod.new(user_ruby_method_params)

    respond_to do |format|
      if @user_ruby_method.save
        format.html { redirect_to user_ruby_method_url(@user_ruby_method), notice: "User ruby method was successfully created." }
        format.json { render :show, status: :created, location: @user_ruby_method }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_ruby_method.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_ruby_methods/1 or /user_ruby_methods/1.json
  def update
    respond_to do |format|
      if @user_ruby_method.update(user_ruby_method_params)
        format.html { redirect_to user_ruby_method_url(@user_ruby_method), notice: "User ruby method was successfully updated." }
        format.json { render :show, status: :ok, location: @user_ruby_method }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_ruby_method.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_ruby_methods/1 or /user_ruby_methods/1.json
  def destroy
    @user_ruby_method.destroy

    respond_to do |format|
      format.html { redirect_to user_ruby_methods_url, notice: "User ruby method was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_ruby_method
      @user_ruby_method = UserRubyMethod.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_ruby_method_params
      params.require(:user_ruby_method).permit(:user_id, :ruby_method_id, :memo, :remembered)
    end
end
