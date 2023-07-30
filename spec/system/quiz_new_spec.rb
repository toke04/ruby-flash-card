# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Quiz new', type: :system, js: true do
  context '初めて利用した場合' do
    let!(:user) { create(:user) }
    let!(:zip_method_of_array) { create(:zip_method_of_array) }

    before do
      login_as(user)
      visit quiz_new_path
    end

    it '選択肢は無しで「クイズ start！」ボタンが表示されること' do
      expect(page).to have_content 'Rubyフラッシュカードへようこそ！'
      expect(page).to have_content 'START'
    end

    it '「クイズ START！」ボタンでクイズが出題されること' do
      click_on 'START'
      expect(page).to have_content 'Array'
      expect(page).to have_content 'zip'
      expect(page).to have_content '分かっているので次へ'
      expect(page).to have_content '分からないので確認する'
    end
  end

  context '一回でもクイズを解いた場合', js: true do
    let!(:user) { create(:user) }
    let!(:user_zip_method) { create(:user_zip_method, { user: }) }
    let!(:user_merge_method) { create(:user_merge_method,:remembered_true, { user:, }) }
    let!(:upcase_method_of_String) { create(:upcase_method_of_String) }

    before do
      login_as(user)
      visit quiz_new_path
    end

    it '３つの選択肢が表示されること' do
      expect(page).to have_content '選んだ条件から出題されます'
      expect(page).to have_content '挑戦してないメソッドから出題する'
      expect(page).to have_content '分からなかったメソッドから出題する'
      expect(page).to have_content '分かっていたメソッドから出題する'
    end

    it '「挑戦してないメソッドから出題する」を選択すると、まだ挑戦していないメソッドが表示されること' do
      choose '挑戦してないメソッドから出題する'
      click_on 'START'
      expect(page).to have_content 'String'
      expect(page).to have_content 'upcase'
    end

    it '「分からなかったメソッドから出題する」を選択すると、前回分からなかったメソッドから出題されること' do
      choose '分からなかったメソッドから出題する'
      click_on 'START'
      expect(page).to have_content ''
      expect(page).to have_content 'zip'
    end

    it '「分かっていたメソッドから出題する」を選択すると、前回分かっていたメソッドから出題されること' do
      choose '分かっていたメソッドから出題する'
      click_on 'START'
      expect(page).to have_content 'Hash'
      expect(page).to have_content 'merge'
    end
  end

  context '「分かっているので次へ」を押した場合', js: true do
    let!(:user) { create(:user) }
    let!(:zip_method_of_array) { create(:zip_method_of_array) }
    let!(:merge_method_of_hash) { create(:merge_method_of_hash) }

    before do
      login_as(user)
      visit quiz_new_path
    end

    it '次の問題が表示されること' do
      expect(page).to have_content 'Rubyフラッシュカードへようこそ！'
      click_on 'START'
      expect(page).to have_content 'Rubyフラッシュカード'
      click_on '分かっているので次へ'
      expect(page).to have_content '分かっているので次へ'
      expect(page).to have_content '分からないので確認する'
    end
  end

  context '「分からないので確認する」を押した場合', js: true do
    let!(:user) { create(:user) }
    let!(:zip_method_of_array) { create(:zip_method_of_array) }
    let!(:merge_method_of_hash) { create(:merge_method_of_hash) }

    before do
      login_as(user)
      visit quiz_new_path
      expect(page).to have_content 'Rubyフラッシュカードへようこそ！'
      click_on 'START'
      expect(page).to have_content 'Rubyフラッシュカード'
      click_on('分からないので確認する')
    end

    it '公式サイトが表示されること' do
      official_site_ifram = find('iframe[id=officialSite]')
      Capybara.within_frame official_site_ifram do
        expect(page).to have_content /Ruby [3-9]\.[0-9] リファレンスマニュアル/
      end
    end

    it 'オンラインエディターが表示されること' do
      expect(page).to have_content 'コードを貼り付けて試す事ができます'
    end

    it 'メモを取って保存することができる' do
      fill_in '覚えやすいようにメモを取ろう', with: 'メモを書き込みました'
      click_on '保存する'
      expect(page).to have_content 'メモを保存しました😊'
    end

    it '「次の問題へ」を押すと、次の問題が出題されること' do
      click_on '次の問題へ'
      expect(page).to have_content 'Rubyフラッシュカード'
      expect(page).to have_content '分かっているので次へ'
      expect(page).to have_content '分からないので確認する'
    end

    it '公式サイトへ遷移するためのリンクが表示されること' do
      expect(page).to have_link '公式サイトへアクセスして確認する', href: /^https:\/\/docs.ruby-lang.org\/ja\/latest\/method.*/
    end

    it '「出題条件を変える」をクリックすると、設定画面へ遷移すること' do
      click_on '出題条件を変える'
      expect(page).to have_content '選んだ条件から出題されます'
      expect(page).to have_content '挑戦してないメソッドから出題する'
      expect(page).to have_content '分からなかったメソッドから出題する'
      expect(page).to have_content '分かっていたメソッドから出題する'
    end

    it '「メソッド一覧へ」をクリックすると、メソッド一覧画面へ遷移すること' do
      click_on 'メソッド一覧へ'
      expect(page).to have_content 'メソッド一覧'
      expect(page).to have_content '学習の進捗で絞り込む'
      expect(page).to have_content '検索'
    end
  end
end
