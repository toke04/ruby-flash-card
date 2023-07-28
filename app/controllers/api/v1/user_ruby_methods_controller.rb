# frozen_string_literal: true

module Api
  module V1
    class UserRubyMethodsController < ApplicationController
      before_action :set_user_ruby_method, only: %i[update]
      def create
        @user_ruby_method = UserRubyMethod.new(user_ruby_method_params)
        @user_ruby_method.user_id = current_user.id

        if @user_ruby_method.save
          render json: { status: :ok, method: @user_ruby_method }
        else
          render json: @user_ruby_method.errors, status: :unprocessable_entity
        end
      end

      def update
        if @user_ruby_method.update(user_ruby_method_params)
          render json: { status: :ok, method: @user_ruby_method }
        else
          render json: @user_ruby_method.errors, status: :unprocessable_entity
        end
      end

      def exec_code
        # p params[:code]
        codes = params[:code].split("\n")

        res = codes.map do |code|
          p code
          `ruby -e "#{code}" ` unless code =~ /^#/ || code == ""
        end
        # res = `ruby -e "p #{params[:code]}" `
        p res
        if params[:code]
          render json: { status: :ok, result_code: res }
        else
          render json: { status: :unprocessable_entity, result_code: res }
        end
      end

      private

      def set_user_ruby_method
        @user_ruby_method = UserRubyMethod.find(params[:id])
      end

      def user_ruby_method_params
        params.require(:user_ruby_method).permit(:ruby_method_id, :memo, :remembered)
      end
    end
  end
end
