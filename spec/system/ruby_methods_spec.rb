require 'rails_helper'

RSpec.describe "RubyMethods", type: :system do
  let!(:zip_method_of_array) { create(:zip_method_of_array) }
  let!(:merge_method_of_hash) { create(:merge_method_of_hash) }
  let(:admin_user) { create(:user, :admin) }
  before do
    driven_by(:rack_test)
    login_as(admin_user)
    visit ruby_methods_path
  end

  it 'モジュール名で検索をすることができる' do
    choose 'Array'
    click_on '検索'
    expect(page).to have_content 'zip'
    expect(page).to have_content 'Array'
  end

  it 'メソッド名で絞り込みを行うことができる' do
    choose '全て'
    fill_in 'q[name_cont]', with: 'zip'
    click_on '検索'
    expect(page).to have_content 'zip'
    expect(page).to have_content 'Array'
  end

  it 'メソッド名とモジュール名が間違っていると検索できないこと' do
    choose 'Hash'
    fill_in 'q[name_cont]', with: 'zip'
    click_on '検索'
    expect(page).to_not have_content 'zip'
  end
end
