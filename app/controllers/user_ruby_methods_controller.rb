# frozen_string_literal: true

class UserRubyMethodsController < ApplicationController
  before_action :set_user_ruby_method, only: %i[show edit update destroy]

  def index
    @search = current_user.user_ruby_methods.ransack(params[:q])
    @user_ruby_methods = @search.result.includes(ruby_method: :ruby_module).order(updated_at: :desc).page(params[:page]).per(10)
  end

  def show; end

  def new; end

  def edit; end

  def create
    @user_ruby_method = UserRubyMethod.new(user_ruby_method_params)
    @user_ruby_method.user_id = current_user.id

    respond_to do |format|
      if @user_ruby_method.save
        format.html { redirect_to user_ruby_method_url(@user_ruby_method), notice: 'メソッドを作成しました😊' }
        format.json { render :show, status: :created, location: @user_ruby_method }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_ruby_method.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user_ruby_method.update(user_ruby_method_params)
        format.html { redirect_to user_ruby_methods_path, notice: '更新が完了しました😊' }
        format.json { render :show, status: :ok, location: @user_ruby_method }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_ruby_method.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user_ruby_method.destroy

    respond_to do |format|
      format.html { redirect_to user_ruby_methods_url, notice: '削除が完了しました🙇' }
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
