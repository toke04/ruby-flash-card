# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FlashCardHelper, type: :helper do
  let!(:user) { create(:user) }
  let!(:upcase_method_of_String) { create(:upcase_method_of_String) }
  let!(:user_zip_method) { create(:user_zip_method, { user: }) }
  let!(:user_merge_method) { create(:user_merge_method, :remembered_true, { user: }) }

  before do
    allow(helper).to receive(:current_user).and_return(user)
  end

  it '挑戦していないメソッドの数が表示できること' do
    expect(helper.not_challenged_methods_count).to eq('1問')
  end

  it '分からなかったメソッドの数が表示できること' do
    expect(helper.not_remembered_methods_count).to eq('1問')
  end
  it '分かっていたメソッドの数が表示できること' do
    expect(helper.remembered_methods_count).to eq('1問')
  end
end
