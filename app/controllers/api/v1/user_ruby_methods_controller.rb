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
          render json: { status: :unprocessable_entity, error: @user_ruby_method.errors }
        end
      end

      def update
        if @user_ruby_method.update(user_ruby_method_params)
          render json: { status: :ok, method: @user_ruby_method }
        else
          render json: { status: :unprocessable_entity, error: @user_ruby_method.errors }
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
