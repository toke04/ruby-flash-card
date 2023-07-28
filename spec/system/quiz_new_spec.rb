# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Quiz new', type: :system do
  let!(:user) { create(:user) }
  let!(:zip_method_of_array) { create(:zip_method_of_array) }

  before do
    login_as(user)
    visit quiz_new_path
  end

  context '初めて利用した場合' do
    it '選択肢は無しで「クイズ start！」ボタンが表示されること' do
      expect(page).to have_content 'Ruby Quizへようこそ！'
      expect(page).to have_content 'クイズ START！'
    end

    it '「クイズ START！」ボタンでクイズが出題されること', js: true do
      click_on 'クイズ START！'
      expect(page).to have_content 'Array'
      expect(page).to have_content 'zip'
      expect(page).to have_content '分かる'
      expect(page).to have_content '分からない'
    end
  end

  context '一回でもクイズを解いた場合' do
    it '３つの選択肢が表示されること' do
    end
  end
end
