# frozen_string_literal: true

class RubyModulesController < ApplicationController
  before_action :set_ruby_module, only: %i[show edit update destroy]
  before_action :admin?

  def index
    @ruby_modules = RubyModule.all
  end

  def show; end

  def new
    @ruby_module = RubyModule.new
  end

  def edit; end

  def create
    @ruby_module = RubyModule.new(ruby_module_params)
    if @ruby_module.save
      redirect_to ruby_module_url(@ruby_module), notice: '登録が完了しました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @ruby_module.update(ruby_module_params)
      redirect_to ruby_module_url(@ruby_module), notice: '更新が完了しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @ruby_module.destroy
    redirect_to ruby_modules_url, notice: '削除が完了しました'
  end

  private

  def set_ruby_module
    @ruby_module = RubyModule.find(params[:id])
  end

  def ruby_module_params
    params.require(:ruby_module).permit(:name)
  end
end
