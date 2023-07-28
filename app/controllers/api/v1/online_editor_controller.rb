# frozen_string_literal: true

module Api
  module V1
    class OnlineEditorController < ApplicationController
      def exec_code
        codes = params[:ruby_code].split("\n")

        open('tmp/exec.rb', 'w'){|f|
          codes.map do |code|
            f.puts code unless code =~ /^#/ || code == "" || code =~ /`.+`/ || code =~ /`.+`/ || code =~ /exec\(".+"\)/
          end
        }
        code_result = `ruby tmp/exec.rb`

        File.delete("tmp/exec.rb") if File.exist?("tmp/exec.rb")

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
