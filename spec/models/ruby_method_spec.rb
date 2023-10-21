# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RubyMethod, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:user_ruby_methods).dependent(:destroy) }
    it { is_expected.to belong_to(:ruby_module) }
  end

  describe '#validations' do
    let!(:zip_method_of_array) { create(:zip_method_of_array) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:ruby_module_id) }
    it { is_expected.to validate_presence_of(:official_url) }

    it 'ファクトリが有効であること' do
      expect(zip_method_of_array).to be_valid
    end
  end

  describe 'rubyのメソッドを作成する場合' do
    context '公式サイトに個別のページがある場合' do
      it '個別のページ用のURLが作成される' do
        match_method = create(:match_method_of_String)
        match_method.register_method_url
        expect(match_method.official_url).to eq('https://docs.ruby-lang.org/ja/latest/method/String/i/match.html')
      end
    end
    context '公式サイトに個別のページがない場合' do
      it '公式サイトの中でアンカーリンクとしてURLが作成される' do
        # rubocop:disable Naming/AsciiIdentifiers # match?メソッドと素直に書けないので一時的に無効化する
        # rubocop:disable Naming/VariableName
        match？_method = create(:match？_method_of_String)
        match？_method.register_method_url
        expect(match？_method.official_url).to eq('https://docs.ruby-lang.org/ja/latest/class/String.html#I_MATCH--3F')
        # rubocop:enable Naming/AsciiIdentifiers
        # rubocop:enable Naming/VariableName
      end
    end
  end
end
