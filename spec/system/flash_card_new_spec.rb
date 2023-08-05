# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'FlashCard new', type: :system do
  context '初めて利用した場合' do
    let!(:user) { create(:user) }
    let!(:zip_method_of_array) { create(:zip_method_of_array) }

    before do
      login_as(user)
      visit flash_card_new_path
    end

    it '選択肢は無しで「START」ボタンが表示されること' do
      expect(page).to have_content 'Rubyフラッシュカードへようこそ'
      expect(page).to have_content 'START'
    end

    it '「START」ボタンでフラッシュカードが出題されること', js: true do
      click_on 'START'
      expect(page).to have_content 'Array'
      expect(page).to have_content 'zip'
      expect(page).to have_content '分かっているので次へ'
      expect(page).to have_content '分からないので確認する'
    end
  end

  context '一回でもフラッシュカードを解いた場合', js: true do
    let!(:user) { create(:user) }
    let!(:user_zip_method) { create(:user_zip_method, { user: }) }
    let!(:user_merge_method) { create(:user_merge_method, :remembered_true, { user: }) }
    let!(:upcase_method_of_String) { create(:upcase_method_of_String) }

    before do
      login_as(user)
      visit flash_card_new_path
    end

    it '３つの選択肢が表示されること' do
      expect(page).to have_content '選んだ条件で出題されます'
      expect(page).to have_content '挑戦してないメソッドから出題する'
      expect(page).to have_content '分からなかったメソッドから出題する'
      expect(page).to have_content '分かっているメソッドから出題する'
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
      expect(page).to have_content 'Array'
      expect(page).to have_content 'zip'
    end

    it '「分かっているメソッドから出題する」を選択すると、前回分かっているメソッドから出題されること' do
      choose '分かっているメソッドから出題する'
      click_on 'START'
      expect(page).to have_content 'Hash'
      expect(page).to have_content 'merge'
    end
  end

  describe '選択した条件で残りのメソッドがなくなった場合', js: true do
    let!(:user) { create(:user) }
    let!(:user_zip_method) { create(:user_zip_method, { user: }) }
    let!(:user_merge_method) { create(:user_merge_method, :remembered_true, { user: }) }
    let!(:upcase_method_of_String) { create(:upcase_method_of_String) }

    before do
      login_as(user)
      visit flash_card_new_path
    end

    context '次のメソッドが表示されないこと' do
      it '「挑戦してないメソッドから出題する」を選んでいた場合' do
        choose '挑戦してないメソッドから出題する'
        click_on 'START'
        expect(page).to have_content 'String'
        expect(page).to have_content 'upcase'
        click_on '分かっているので次へ'
        expect(page).to have_content '条件で指定したで全てのメソッドが出題されました。'
      end

      it '「分からなかったメソッドから出題する」を選んでいた場合' do
        choose '分からなかったメソッドから出題する'
        click_on 'START'
        expect(page).to have_content 'Array'
        expect(page).to have_content 'zip'
        click_on '分かっているので次へ'
        expect(page).to have_content '条件で指定したで全てのメソッドが出題されました。'
      end

      it '「分かっているメソッドから出題する」を選んでいた場合' do
        choose '分かっているメソッドから出題する'
        click_on 'START'
        expect(page).to have_content 'Hash'
        expect(page).to have_content 'merge'
        click_on('分からないので確認する')
        click_on '次の問題へ'
        expect(page).to have_content '条件で指定したで全てのメソッドが出題されました。'
      end
    end
  end
end
