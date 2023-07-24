# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserRubyMethod, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:ruby_method) }
  end

  describe '#validations' do
    it 'ファクトリが有効であること' do
      expect(create(:user_zip_method)).to be_valid
    end

    it 'memoが無くても、ファクトリが有効であること' do
      expect(create(:user_zip_method, memo: nil)).to be_valid
    end

    it 'デフォルトでrememberedにfalseが入ること' do
      user_zip_method = create(:user_zip_method)
      expect(user_zip_method.remembered).to eq false
    end
  end
end
