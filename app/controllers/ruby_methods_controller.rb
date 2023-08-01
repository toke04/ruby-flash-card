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
    respond_to do |format|
      if @ruby_method.save
        format.html { redirect_to ruby_method_url(@ruby_method), notice: 'Ruby method was successfully created.' }
        format.json { render :show, status: :created, location: @ruby_method }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ruby_method.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @ruby_method.update(ruby_method_params)
        format.html { redirect_to ruby_method_url(@ruby_method), notice: '更新が完了しました' }
        format.json { render :show, status: :ok, location: @ruby_method }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ruby_method.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ruby_method.destroy

    respond_to do |format|
      format.html { redirect_to ruby_methods_url, notice: 'Ruby method was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_ruby_method
    @ruby_method = RubyMethod.find(params[:id])
  end

  def ruby_method_params
    params.require(:ruby_method).permit(:name, :ruby_module_id, :official_url)
  end
end
