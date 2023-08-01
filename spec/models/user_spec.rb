# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    subject(:user) { create(:user) }
    it { is_expected.to have_many(:user_ruby_methods).dependent(:destroy) }
    it { is_expected.to have_many(:challenged_ruby_methods).through(:user_ruby_methods).source(:ruby_method) }
  end

  describe '#validations' do
    subject(:user) { create(:user) }
    it { is_expected.to validate_uniqueness_of(:uid).scoped_to(:provider).case_insensitive }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:image) }
    it { is_expected.to allow_value(true).for(:admin) }
    it { is_expected.to allow_value(false).for(:admin) }
    it { is_expected.not_to allow_value(nil).for(:admin) }

    it 'ファクトリが有効であること' do
      expect(build(:user)).to be_valid
    end

    it '新規作成されたユーザーはデフォルトではadmin権限がfalseであること' do
      normal_user = create(:user)
      expect(normal_user.admin).to eq(false)
    end
  end

  describe '#find_for_github_oauth' do
    let(:user) { create(:user) }
    context 'DBにproviderとuidの組み合わせで登録されてない情報が渡ってくる場合' do
      it '新しいユーザーを作成すること' do
        # userインスタンスはDBに保存されていない
        new_user = build(:user)
        auth_hash = { provider: new_user.provider, uid: new_user.uid, info: { name: new_user.name, image: new_user.image } }
        expect { described_class.find_for_github_oauth(auth_hash) }.to change(described_class, :count).from(0).to(1)
      end
    end

    context 'すでにDBにproviderとuidの組み合わせが登録されている場合' do
      it '同じユーザー情報が返ってくること' do
        auth_hash = { provider: user.provider, uid: user.uid, info: { name: user.name, image: user.image } }
        expect(described_class.find_for_github_oauth(auth_hash)).to eq user
      end
    end
  end
end
