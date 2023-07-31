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

    it 'ファクトリが有効であること' do
      expect(build(:user)).to be_valid
    end
  end

  describe '#find_for_github_oauth' do
    let(:user) { create(:user) }

    it 'DBにユーザーが登録されてない(uidが無い)場合、新しいユーザーを作成すること' do
      # userインスタンスはDBに保存されていない
      new_user = build(:user)
      auth_hash = { provider: new_user.provider, uid: new_user.uid, info: { name: new_user.name, image: new_user.image } }
      expect { described_class.find_for_github_oauth(auth_hash) }.to change(described_class, :count).from(0).to(1)
    end

    it 'すでにユーザーのデータがDBに保存されている場合、同じユーザーが返ってくること' do
      auth_hash = { provider: user.provider, uid: user.uid, info: { name: user.name, image: user.image } }
      expect(described_class.find_for_github_oauth(auth_hash)).to eq user
    end
  end
end
