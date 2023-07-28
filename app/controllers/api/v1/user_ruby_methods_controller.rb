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
        codes = params[:code].split("\n")

        open('app/controllers/api/v1/test.rb', 'w'){|f|
          codes.map do |code|
            f.puts code unless code =~ /^#/ || code == "" || code =~ /`.+`/ || code =~ /`.+`/ || code =~ /exec\(".+"\)/
          end
        }
        result_code = `ruby app/controllers/api/v1/test.rb`


        # res = `ruby -e "app/controllers/api/v1/test.rb"`

        #
        # res = codes.map do |code|
        #   p code
        #   `ruby -e "#{code}" ` unless code =~ /^#/ || code == ""
        # end

        # binding.irb
        # res = `ruby -e "p #{params[:code]}" `
        p "みる"
        p result_code.split("\n")
        result_code = result_code.split("\n").map{ |code|
          code + "\n"
        }
        if params[:code]
          render json: { status: :ok, result_code: result_code.split("\n") }
        else
          render json: { status: :unprocessable_entity, result_code: result_code.split("\n") }
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
