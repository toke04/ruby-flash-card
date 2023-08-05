# frozen_string_literal: true

class RubyMethodsController < ApplicationController
  before_action :set_ruby_method, only: %i[show edit update destroy]
  before_action :admin?

  def index
    @search = RubyMethod.ransack(params[:q])
    @ruby_methods = @search.result.order(updated_at: :desc).page(params[:page]).per(10)
  end

  def show; end

  def new
    @ruby_method = RubyMethod.new
    @ruby_modules = RubyModule.pluck(:name)
  end

  def edit; end

  def create
    @ruby_method = RubyMethod.new(ruby_method_params)
    @ruby_method.register_method_url
    if @ruby_method.save
      redirect_to ruby_method_url(@ruby_method), notice: '登録が完了しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @ruby_method.update(ruby_method_params)
      redirect_to ruby_method_url(@ruby_method), notice: '更新が完了しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @ruby_method.destroy
    redirect_to ruby_methods_url, notice: '削除が完了しました'
  end

  private

  def set_ruby_method
    @ruby_method = RubyMethod.find(params[:id])
  end

  def ruby_method_params
    params.require(:ruby_method).permit(:name, :ruby_module_id, :official_url)
  end
end
