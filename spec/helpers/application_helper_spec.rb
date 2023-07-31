require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  let!(:user) { create(:user) }
  let!(:user_zip_method) { create(:user_zip_method, { user: }) }
  let!(:user_merge_method) { create(:user_merge_method, :remembered_true, { user: }) }

  before do
    allow(helper).to receive(:current_user).and_return(user)
  end

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
end
