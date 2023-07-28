# frozen_string_literal: true

module Api
  module V1
    class OnlineEditorController < ApplicationController
      include OnlineEditor
      def exec_code
        codes = params[:ruby_code].split("\n")

        create_exec_code_file(codes)

        code_result = `ruby tmp/exec_ruby_code.rb`

        File.delete("tmp/exec_ruby_code.rb") if File.exist?("tmp/exec_ruby_code.rb")

        fixed_code_result = code_result.split("\n").map{ |code|
          code + "\n"
        }
        if params[:ruby_code]
          render json: { status: :ok, result_code: fixed_code_result.split("\n") }
        else
          render json: { status: :unprocessable_entity, result_code: fixed_code_result.split("\n") }
        end
      end
    end
  end
end
