# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UserRubyMethods', type: :system do
  let!(:user) { create(:user) }
  let!(:user_zip_method) { create(:user_zip_method, { user: }) }

  before do
    login_as(user)
    visit user_ruby_methods_path
  end

  describe '一覧画面にアクセスした場合', js: true do
    it '表示されるメソッド名をクリックするとiframeで公式サイトを表示すること' do
      find('#zip', text: 'zip').click
      official_site_iframe = find('iframe[id=officialSite]')
      Capybara.within_frame official_site_iframe do
        expect(page).to have_content(/Ruby [3-9]\.[0-9] リファレンスマニュアル/)
      end
    end

    it '「分かっている」 or 「分からなかった」のラベルが表示されること' do
      expect(page).to have_selector '.method-item', text: 'zip'
      expect(page).to have_content '分からなかった'
    end
  end

  describe '一覧画面で検索を行う場合' do
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
        choose '分かっている'
        choose 'Array'
        click_on '検索'
        expect(page).to_not have_content 'zip'
      end
    end
  end

  describe '編集画面にアクセスした場合', js: true do
    before do
      expect(page).to have_selector '.method-item', text: 'zip'
      click_on '✏️'
    end
    it 'ユーザーはメソッドを編集できること' do
      fill_in 'メモ', with: 'メモを変更しました'
      click_on '更新する'
      expect(page).to have_content '更新が完了しました😊'
      expect(page).to have_selector '.method-item', text: 'zip'
      expect(page).to have_content 'メモを変更しました'
    end

    it 'メソッドを削除できること' do
      click_button '削除する'
      expect do
        expect(accept_confirm).to eq '削除してよろしいですか？'
        expect(page).to have_content '削除が完了しました'
      end.to change { UserRubyMethod.count }.by(-1)
    end
  end
end
