require 'rails_helper'

RSpec.describe "RubyMethods", type: :system do
  let!(:zip_method) { FactoryBot.create(:zip_method) }
  let(:admin_user) { FactoryBot.create(:admin_user) }
  before do
    driven_by(:rack_test)
  end

  it 'カテゴリー検索をすることができる' do
    login_as(admin_user)
    visit ruby_methods_path
    choose 'Array'
    click_on '検索'
    expect(page).to have_content 'メソッド名:'
    expect(page).to have_content 'zip'
    expect(page).to have_content '親モジュール名:'
    expect(page).to have_content 'Array'
  end
end
