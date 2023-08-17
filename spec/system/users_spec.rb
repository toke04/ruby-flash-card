# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe '基本的なログイン機能' do
    let(:user) { create(:user) }
    it 'ユーザーはログインすることができる' do
      login_as(user)
      expect(page).to have_content 'Github アカウントによる認証に成功しました。'
    end
    it 'ユーザーはログアウトすることができる' do
      login_as(user)
      find('.user-icon').click
      click_on 'ログアウト'
      expect(page).to have_content 'ログアウトしました'
      expect(page).to have_content 'Rubyのメソッドを効率良く学ぼう'
    end
    it 'ログインしていない場合、トップページにリダイレクトされる' do
      visit user_ruby_methods_path
      expect(page).to have_content 'Rubyのメソッドを効率良く学ぼう'
    end
  end

  describe 'ユーザーの権限に応じて管理者画面へのアクセスが決まる' do
    context 'adminユーザーの場合' do
      let!(:admin_user) { create(:user, :admin) }
      before do
        login_as(admin_user)
      end
      it '「RubyModules」リソースへアクセスできること' do
        click_link '管理者用モジュール一覧'
        expect(page).to have_selector 'h1', text: 'rubyのモジュール一覧'
        expect(page).to have_selector 'a', text: 'rubyのモジュールを追加する'
      end
      it '「RubyMethods」リソースへアクセスできること' do
        click_link '管理者用メソッド一覧'
        expect(page).to have_selector 'h1', text: 'rubyのメソッド一覧'
        expect(page).to have_selector 'a', text: '共通のrubyのメソッドを追加'
      end
    end
    context 'admin権限がない一般ユーザーの場合' do
      let!(:normal_user) { create(:user) }
      before do
        login_as(normal_user)
      end
      it '「RubyModules」リソースへのリンクが表示されないこと' do
        expect(page).to_not have_selector 'a', text: '管理者用モジュール一覧'
      end
      it '「RubyMethods」リソースへのリンクが表示されないこと' do
        expect(page).to_not have_selector 'a', text: '管理者用メソッド一覧'
      end
      it 'URLから直接アクセスしても「RubyModules」リソースへアクセスできないこと' do
        visit ruby_modules_path
        expect(page).to_not have_selector 'a', text: 'rubyのモジュールを追加する'
        expect(page).to have_content 'Rubyフラッシュカードへようこそ'
      end
      it 'URLから直接アクセスしても「RubyMethods」リソースへアクセスできないこと' do
        visit ruby_methods_path
        expect(page).to_not have_selector 'a', text: '共通のrubyのメソッドを追加'
        expect(page).to have_content 'Rubyフラッシュカードへようこそ'
      end
    end
  end
end
