require 'rails_helper'

RSpec.describe "UserRubyMethods", type: :system do
  let!(:user) { create(:user) }
  let!(:user_zip_method) { create(:user_zip_method, {user: user}) }
  let!(:user_merge_method) { create(:user_merge_method, {user: user}) }
  before do
    driven_by(:rack_test)
    login_as(user)
    visit user_ruby_methods_path
  end

  context '正しい条件の場合' do
    it '学習の進捗で絞り込みを行うことができる' do
      choose '分からなかった'
      click_on '検索'
      expect(page).to have_content 'zip'
      expect(page).to have_content 'レシーバーのインデックス番号に合わせて引数の配列を合体させて、配列を作成する'
    end
    it 'モジュール名で検索をすることができる' do
      choose 'Array'
      click_on '検索'
      expect(page).to have_content 'zip'
      expect(page).to have_content 'レシーバーのインデックス番号に合わせて引数の配列を合体させて、配列を作成する'
    end
  end

  context '正しくない条件の場合' do
    it '学習の進捗とモジュール名が間違っていると検索できないこと' do
      choose '分かっていた'
      choose 'Array'
      click_on '検索'
      expect(page).to_not have_content 'zip'
    end
  end
end
