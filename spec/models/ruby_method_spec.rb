# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RubyMethod, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:user_ruby_methods).dependent(:destroy) }
    it { is_expected.to belong_to(:ruby_module) }
  end

  describe '#validations' do
    subject(:zip_method_of_array) { create(:zip_method_of_array) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:ruby_module_id) }
    it { is_expected.to validate_presence_of(:official_url) }

    it 'ファクトリが有効であること' do
      expect(build(:zip_method_of_array)).to be_valid
    end
  end
end
