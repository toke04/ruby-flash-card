# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserRubyMethodsHelper, type: :helper do
  describe 'textareaから保存されたメモを表示する場合' do
    context 'railsのtextareaから保存された場合' do
      let!(:posted_method_by_rails) { create(:user_upcase_method) }
      it '改行文字「\r\n」をbrタグに変換されること' do
        expect(helper.add_new_line(posted_method_by_rails.memo)).to eq('<p>string型のデータを大文字に変換します。<br>大文字と小文字両方が含まれていても問題ないです。</p>')
      end
    end
    context 'reactのtextareaから保存された場合' do
      let!(:posted_method_by_react) { create(:user_upcase_method, :react_textarea) }
      it '改行文字「\n」をbrタグに変換されること' do
        expect(helper.add_new_line(posted_method_by_react.memo)).to eq('<p>string型のデータを大文字に変換します。<br>大文字と小文字両方が含まれていても問題ないです。</p>')
      end
    end
  end

  describe 'ユーザーがフラッシュカードを解いた場合' do
    context '分からなかった場合' do
      let!(:user_zip_method) { create(:user_zip_method) }
      it '「分からなかった」と表示されること' do
        expect(helper.convert_remembered_word(user_zip_method)).to eq('分からなかった')
      end
    end
    context '分かっていた場合' do
      let!(:user_zip_method) { create(:user_zip_method, :remembered_true) }
      it '「分かっていた」と表示されること' do
        expect(helper.convert_remembered_word(user_zip_method)).to eq('分かっていた')
      end
    end
  end
end
