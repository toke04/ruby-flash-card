# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RubyModules', type: :system do
  let!(:array_module) { create(:array_module) }
  let(:admin_user) { create(:user, :admin) }
  before do
    login_as(admin_user)
    visit ruby_modules_path
  end

  describe '一覧画面にアクセスした場合' do
    it '登録したメソッドが表示されること' do
      expect(page).to have_content 'rubyのモジュール一覧'
      expect(page).to have_content 'Array'
    end
  end

  describe '新規登録画面にアクセスした場合' do
    it 'モジュールを登録できること' do
      visit new_ruby_module_path
      fill_in 'モジュール名', with: 'Hash'
      click_on '登録する'
      expect(page).to have_content '登録が完了しました'
      expect(page).to have_content 'Hash'
    end
  end
  describe '編集画面にアクセスした場合' do
    it 'モジュールを編集できること' do
      expect(page).to have_content 'Array'
      click_on '編集'
      fill_in 'モジュール名', with: 'Hash'
      click_on '更新する'
      expect(page).to have_content '更新が完了しました'
      expect(page).to have_content 'Hash'
    end
  end

  describe '詳細画面にアクセスした場合', js: true do
    it 'モジュールを削除できること' do
      expect(page).to have_content 'Array'
      click_on '詳細'
      click_button '削除する'
      expect do
        expect(accept_confirm).to eq '削除してよろしいですか？'
        expect(page).to have_content '削除が完了しました'
      end.to change { RubyModule.count }.by(-1)
    end
  end
end
