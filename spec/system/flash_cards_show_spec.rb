# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'FlashCards show', type: :system, js: true do
  describe 'フラッシュカードの最初の出題のテスト' do
    let!(:user) { create(:user) }
    let!(:zip_method_of_array) { create(:zip_method_of_array) }
    let!(:merge_method_of_hash) { create(:merge_method_of_hash) }

    before do
      login_as(user)
      visit flash_card_path
    end

    context '「分かっているので次へ」を押した場合' do
      it '次の問題が表示されること' do
        click_on '分かっているので次へ'
        expect(page).to have_content '分かっているので次へ'
        expect(page).to have_content '分からないので確認する'
      end
    end

    context '「分からないので確認する」を押した場合' do
      before do
        click_on('分からないので確認する')
      end

      it '公式サイトが表示されること' do
        official_site_iframe = find('iframe[id=officialSite]')
        Capybara.within_frame official_site_iframe do
          expect(page).to have_content(/Ruby [3-9]\.[0-9] リファレンスマニュアル/)
        end
      end

      it 'オンラインエディターが表示され、実行できること' do
        expect(page).to have_content '貼り付けたコードの最終行の戻り値を出力します'
        fill_in 'codeArea', with: "'ruby love'.upcase"
        click_on '出力する'
        sleep 4 # ruby.wasmの実行時間にラグが見られるので、sleepを挟む
        expect(page).to have_css('p', text: 'RUBY LOVE')
      end

      it '「次の問題へ」を押すと、次の問題が出題されること' do
        click_on '次の問題へ'
        expect(page).to have_content '分かっているので次へ'
        expect(page).to have_content '分からないので確認する'
      end

      it '公式サイトへ遷移するためのリンクが表示されること' do
        expect(page).to have_link '公式リファレンスへ', href: %r{^https://docs.ruby-lang.org/ja/latest/method.*}
      end

      it '「出題条件を変える」をクリックすると、設定画面へ遷移すること' do
        click_on '出題条件を変える'
        expect(page).to have_content 'フラッシュカード出題設定'
        expect(page).to have_content '挑戦してないメソッドから出題する'
        expect(page).to have_content '分からなかったメソッドから出題する'
        expect(page).to have_content '分かっているメソッドから出題する'
      end

      it '「メソッド一覧へ」をクリックすると、メソッド一覧画面へ遷移すること' do
        click_on 'メソッド一覧へ'
        expect(page).to have_selector 'h1', text: 'メソッド一覧'
      end
    end
  end

  describe 'メソッドにメモを書く場合' do
    let!(:user) { create(:user) }
    let!(:zip_method_of_array) { create(:zip_method_of_array) }
    let!(:user_merge_method) { create(:user_merge_method, { user: }) }

    before do
      login_as(user)
    end

    context '初めてメソッドにメモを書き込む場合' do
      it 'メモを取って保存することができる' do
        visit flash_card_path
        click_on('分からないので確認する')
        fill_in 'おぼえるためにメモを残そう', with: 'メモを書き込みました'
        click_on '保存する'
        expect(page).to have_content 'メモの保存が完了しました🎉'
        visit user_ruby_methods_path
        expect(page).to have_selector 'h1', text: 'メソッド一覧'
        expect(page).to have_content 'メモを書き込みました'
      end
    end

    context '同じメソッドにメモを書き込む場合' do
      before do
        visit new_flash_card_path
        choose '分からなかったメソッドから出題する'
        click_on 'START'
        expect(page).to have_content 'Hash'
        expect(page).to have_content 'merge'
      end

      it '前回のメモが表示されること' do
        click_on '前回のメモを見る'
        expect(page).to have_content 'レシーバーと引数のハッシュを合体させて、新しいハッシュを作成する'
      end

      it '前回のメモを更新することができること' do
        click_on('分からないので確認する')
        fill_in 'おぼえるためにメモを残そう', with: 'メモを更新しました'
        click_on '保存する'
        expect(page).to have_content 'メモの保存が完了しました🎉'
        visit user_ruby_methods_path
        expect(page).to have_selector 'h1', text: 'メソッド一覧'
        expect(page).to have_content 'メモを更新しました'
      end
    end
  end
end
