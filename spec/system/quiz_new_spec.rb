# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Quiz new', type: :system do
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

    it '「クイズ START！」ボタンでクイズが出題されること', js: true do
      click_on 'START'
      expect(page).to have_content 'Array'
      expect(page).to have_content 'zip'
      expect(page).to have_content '分かっているので次へ'
      expect(page).to have_content '分からないので確認する'
    end
  end

  context '一回でもクイズを解いた場合' do
    let!(:user) { create(:user) }
    let!(:user_zip_method) { create(:user_zip_method, { user: }) }

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
  end
end
