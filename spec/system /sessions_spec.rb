# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  let(:normal_user) { FactoryBot.create(:normal_user) }
  before do
    driven_by(:rack_test)
  end

  it 'ユーザーはログインすることができる' do
    login_as(normal_user)
    expect(page).to have_content 'Successfully authenticated from Github account.
'
  end

  # it 'ユーザーはログアウトすることができる' do
  #   login_as(normal_user)
  #   find('.user-icon').click
  #   click_on 'ログアウト'
  #
  #   expect(page).to have_content 'ログアウトしました'
  #   expect(page).to have_content 'Rubyのよく使うメソッドだけを効率良く学びたくないですか？'
  # end
  #
  # it 'ログインしていない場合、トップページにリダイレクトされる' do
  #   visit user_ruby_methods_path
  #   expect(page).to have_content 'GitHubアカウントでログインをすることでサービスを利用することができます'
  # end
end
