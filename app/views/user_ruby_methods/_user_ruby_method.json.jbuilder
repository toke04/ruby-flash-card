# frozen_string_literal: true

json.extract! user_ruby_method, :id, :user_id, :ruby_method_id, :memo, :remembered, :created_at, :updated_at
json.url user_ruby_method_url(user_ruby_method, format: :json)
