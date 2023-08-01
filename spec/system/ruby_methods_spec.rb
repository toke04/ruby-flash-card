# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RubyMethods', type: :system do
  let!(:zip_method_of_array) { create(:zip_method_of_array) }
  let!(:merge_method_of_hash) { create(:merge_method_of_hash) }
  let(:admin_user) { create(:user, :admin) }
  before do
    login_as(admin_user)
    visit ruby_methods_path
  end
  describe '一覧画面にアクセスした場合' do
    it '登録したメソッドが表示されること' do
      expect(page).to have_content 'zip'
      expect(page).to have_content 'Array'
      expect(page).to have_link 'URL', href: 'https://docs.ruby-lang.org/ja/latest/method/Array/i/zip.html'
    end
  end
  describe '一覧画面で検索を行う場合' do
    context '正しい条件の場合' do
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
    end
    context '正しくない条件の場合' do
      it 'メソッド名とモジュール名が間違っていると検索できないこと' do
        choose 'Hash'
        fill_in 'q[name_cont]', with: 'zip'
        click_on '検索'
        expect(page).to_not have_content 'zip'
      end
    end
  end
  describe '新規登録画面にアクセスした場合' do
    it 'メソッドを登録できること' do
      visit new_ruby_method_path
      fill_in 'メソッド名', with: 'keys'
      select 'Hash', from: 'Ruby module'
      click_on '登録する'
      expect(page).to have_content '登録が完了しました'
      expect(page).to have_content 'keys'
      expect(page).to have_content 'Hash'
      expect(page).to have_link 'URL', href: 'https://docs.ruby-lang.org/ja/latest/method/Hash/i/keys.html'
    end
  end
  describe '編集画面にアクセスした場合' do
    it 'メソッドを編集できること' do
      expect(page).to have_content 'merge'
      page.first(".edit-ruby-method").click
      fill_in 'メソッド名', with: 'keys'
      fill_in 'Official url', with: 'https://docs.ruby-lang.org/ja/latest/method/Hash/i/keys.html'
      click_on '更新する'
      expect(page).to have_content '更新が完了しました'
      expect(page).to have_content 'keys'
      expect(page).to have_link 'URL', href: 'https://docs.ruby-lang.org/ja/latest/method/Hash/i/keys.html'
    end
  end
  describe '詳細画面にアクセスした場合', js: true do
    it 'メソッドを削除できること' do
      expect(page).to have_content 'merge'
      page.first(".show-ruby-method").click
      click_button '削除する'
      expect do
        expect(accept_confirm).to eq '削除してよろしいですか？'
        expect(page).to have_content '削除が完了しました'
      end.to change {RubyMethod.count}.by(-1)
    end
  end
end
