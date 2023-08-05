# frozen_string_literal: true

class UserRubyMethodsController < ApplicationController
  before_action :set_user_ruby_method, only: %i[edit update destroy]

  def index
    @search = current_user.user_ruby_methods.ransack(params[:q])
    @user_ruby_methods = @search.result.includes(ruby_method: :ruby_module).order(updated_at: :desc).page(params[:page]).per(10)
  end

  def edit; end

  def update
    if @user_ruby_method.update(user_ruby_method_params)
      redirect_to user_ruby_methods_path, notice: '更新が完了しました😊'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user_ruby_method.destroy
    redirect_to user_ruby_methods_url, notice: '削除が完了しました🙇'
  end

  private

  def set_user_ruby_method
    @user_ruby_method = current_user.user_ruby_methods.find(params[:id])
  end

  def user_ruby_method_params
    params.require(:user_ruby_method).permit(:user_id, :ruby_method_id, :memo, :remembered)
  end
end
